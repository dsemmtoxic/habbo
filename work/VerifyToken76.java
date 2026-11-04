import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken76 extends VerifyToken75 {
 static final String CACHE=PatchToken76.CACHE76;
 static class PerformanceVM extends QueueVM {
  final Obj cache=new Obj("loginpatch::AssetCache76");
  final Obj directory=new Obj("fake-cache-root");
  final Map<String,Obj> files=new HashMap<>();
  final List<Obj> streams=new ArrayList<>();
  int timerReads;
  PerformanceVM(SWF swf){
   super(swf);
   var queue=classes.get(HELPER);
   var klass=queue.abc().class_info.get(queue.index());
   execute(new Method(queue,queue.abc().findBody(klass.cinit_index)),scheduler);
   cache.put("_writing",new HashMap<>());
   cache.put("_count",0);
   cache.put("MAX_WRITES",8);
  }
  @Override Object lexical(Method m,Obj self,String name,int id){
   if(m.cls().logical().equals(CACHE)){
    if(cache.containsKey(name))return cache.get(name);
    if(Set.of("commit","abort").contains(name))return new Bound(self,name);
    if(Set.of("File","Event","IOErrorEvent","SecurityErrorEvent").contains(name))return new Ref(name);
   }
   if(name.equals("getTimer"))return new Ref(name);
   return super.lexical(m,self,name,id);
  }
  @Override Object get(Object receiver,Object key){
   if(receiver instanceof Obj o&&o.type.equals(cache.type)&&cache.containsKey(key))return cache.get(key);
   if(receiver instanceof Ref r){
    if(r.name().equals("File")&&key.equals("cacheDirectory"))return directory;
    if(Set.of("Event","IOErrorEvent","SecurityErrorEvent").contains(r.name()))return key;
   }
   return super.get(receiver,key);
  }
  @Override void set(Object receiver,Object key,Object value){
   if(receiver instanceof Obj o&&o.type.equals(cache.type)&&key.equals("_count"))receiver=cache;
   super.set(receiver,key,value);
  }
  Obj file(String path){
   return files.computeIfAbsent(path,key->{
    var f=new Obj("fake-cache-file");
    f.put("path",key);f.put("exists",false);f.put("size",0);
    f.put("parent",directory);
    return f;
   });
  }
  @Override Object construct(String type,List<Object> args){
   if(type.equals("FileStream")||type.equals("flash.filesystem::FileStream")){
    var stream=new Obj("fake-cache-stream");
    streams.add(stream);
    return stream;
   }
   return super.construct(type,args);
  }
  @Override Object call(Object receiver,String name,List<Object> args){
   if(receiver==globals&&name.equals("getTimer"))return ++timerReads;
   if(receiver instanceof Obj o&&o.type.equals(cache.type))return execute(method(CACHE,name),o,args.toArray());
   if(receiver==directory){
    if(name.equals("resolvePath"))return file(String.valueOf(args.get(0)));
    if(name.equals("createDirectory")){directory.put("exists",true);return null;}
   }
   if(receiver instanceof Obj o&&o.type.equals("fake-cache-stream")){
    switch(name){
     case "addEventListener" -> o.put(args.get(0),args.get(1));
     case "removeEventListener" -> o.remove(args.get(0));
     case "openAsync" -> o.put("destination",args.get(0));
     case "writeBytes" -> o.put("buffered",get(args.get(0),"length"));
     case "close" -> o.put("closed",true);
     default -> throw new AssertionError("Unexpected stream operation "+name);
    }
    return null;
   }
   if(receiver instanceof Obj o&&o.type.equals("fake-cache-file")){
    if(name.equals("moveTo")){
     var destination=(Obj)args.get(0);
     destination.put("exists",true);
     destination.put("size",o.get("size"));
     o.put("exists",false);
     return null;
    }
    if(name.equals("deleteFile")){o.put("exists",false);return null;}
   }
   return super.call(receiver,name,args);
  }
  void event(Obj stream,String name){
   var callback=(Bound)stream.get(name);
   check(callback!=null,"Expected registered file event "+name);
   call(callback.receiver(),callback.name(),Arrays.asList((Object)null));
  }
  void store(String path,Obj data,Obj loader){execute(method(CACHE,"store"),cache,path,data,loader);}
 }
 public static void main(String[] args)throws Exception{
  var vm=new PerformanceVM(new SWF(new FileInputStream(args[0]),false));
  check(num(vm.scheduler.get("MAX_VISUAL_LOADS"))==4,"Visual slot constant changed");
  for(int i=0;i<6;i++)vm.pending.add(vm.item("visual"+i,true));
  vm.pump();
  check(vm.active.size()==4&&vm.pending.size()==2,"Two slots were not reserved");
  for(int i=0;i<3;i++)vm.pending.add(vm.item("room"+i,false));
  vm.pump();
  check(vm.active.size()==6&&vm.started.subList(4,6).equals(List.of("room0","room1")),"Room reserve lost");
  ((Obj)vm.active.get(0)).put("ready",true);
  vm.pump();
  check(vm.started.get(6).equals("room2"),"Waiting room content lost priority on refill");

  var engine=new Obj("engine");
  engine.put("_-4kK",true);
  engine.put("_-0VS",new ArrayList<>());
  vm.execute(vm.method(PatchToken76.ENGINE76,"_-25i"),engine);
  check(!truth(engine.get("_-4kK"))&&vm.timerReads==1,"Furniture still skips an entire update");

  var loader=vm.item("asset",false);
  var data=new Obj("flash.utils::ByteArray");
  data.put("length",320);
  String path="avatar/body/100/asset.swf";
  vm.store(path,data,loader);
  vm.store(path,data,loader);
  check(vm.streams.size()==1,"Concurrent writes to one revision were not coalesced");
  var first=vm.streams.get(0);
  var target=vm.file("com.sulake.habbo/"+path);
  var temp=(Obj)first.get("destination");
  check(truth(first.get("closed"))&&!truth(target.get("exists"))&&temp!=target,"Cache exposed unfinished bytes");
  data.put("length",0);
  check(num(first.get("buffered"))==320,"Writing depended on a mutable parser buffer");
  loader.put("ready",true);
  temp.put("size",320);temp.put("exists",true);
  vm.event(first,"CLOSE");
  check(num(target.get("size"))==320&&num(vm.cache.get("_count"))==0,"Finished write was not published: size="+target.get("size")+", count="+vm.cache.get("_count"));

  data.put("length",400);
  vm.store(path,data,loader);
  var failed=vm.streams.get(1);
  temp.put("exists",true);
  vm.event(failed,"IO_ERROR");
  check(num(target.get("size"))==320&&!truth(temp.get("exists"))&&num(vm.cache.get("_count"))==0,
   "Failed writes damaged a prior cache entry or kept a slot");
  vm.store(path,data,loader);
  var invalid=vm.streams.get(2);
  loader.put("ready",false);
  temp.put("size",400);temp.put("exists",true);
  vm.event(invalid,"CLOSE");
  check(num(target.get("size"))==320&&!truth(temp.get("exists")),"Unparsed asset replaced valid cache");
  System.out.println("PASS: six shared downloads, four visual slots, two room slots, resumed furniture, and atomic cache publish with failure handling.");
 }
}

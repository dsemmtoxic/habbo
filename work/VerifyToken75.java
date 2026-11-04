import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken75 extends VerifyStartupCompatibility {
 static final String HELPER="loginpatch:RoomAssetQueue75";
 static final String LOADER=PatchToken75.LOADER75;
 static final String MANAGER=PatchToken75.FIGURES75;

 static class QueueVM extends VM {
  final Obj loaderClass=new Obj("_-44B::_-40J");
  final Obj scheduler=new Obj("loginpatch::RoomAssetQueue75");
  final List<Object> pending=new ArrayList<>(),active=new ArrayList<>();
  final List<String> started=new ArrayList<>();
  QueueVM(SWF swf){
   super(swf);
   loaderClass.put("_-2xv",pending);
   loaderClass.put("_-1a-",active);
   scheduler.put("_visual",new IdentityHashMap<>());
   scheduler.put("MAX_VISUAL_LOADS",3);
  }
  Obj item(String name,boolean visual){
   var loader=new Obj(loaderClass.type);
   loader.put("_iosCompatibilityMode",true);
   loader.put("_request",name);
   loader.put("_urlLoader",new Obj("fixture-resource-transport"));
   if(visual)execute(method(HELPER,"markVisual"),scheduler,loader);
   return loader;
  }
  void pump(){execute(method(LOADER,"_-1cx"),loaderClass);}
  @SuppressWarnings("unchecked") @Override Object call(Object receiver,String name,List<Object> args){
   if(receiver instanceof Ref ref&&ref.name().equals(scheduler.type))
    return execute(method(HELPER,name),scheduler,args.toArray());
   if(receiver instanceof List<?> list){
    if(name.equals("shift"))return ((List<Object>)list).remove(0);
    if(name.equals("splice")){
     var range=list.subList(num(args.get(0)),num(args.get(0))+num(args.get(1)));
     var removed=new ArrayList<>(range);
     range.clear();
     return removed;
    }
   }
   if(receiver instanceof Obj obj&&obj.type.equals("fixture-resource-transport")&&name.equals("load")){
    started.add(String.valueOf(args.get(0)));return null;
   }
   if(receiver instanceof Obj obj&&obj.type.equals("fixture-figure-library")&&name.equals("_-jQ")){
    started.add(String.valueOf(obj.get("id")));return null;
   }
   return super.call(receiver,name,args);
  }
 }

 public static void main(String[] args)throws Exception {
  var swf=new SWF(new FileInputStream(args[0]),false);
  var vm=new QueueVM(swf);
  var stale=vm.item("stale",false);
  stale.put("disposed",true);
  var cached=vm.item("already-ready",true);
  cached.put("ready",true);
  var v1=vm.item("v1",true);
  var r1=vm.item("floor",false);
  var r2=vm.item("furniture",false);
  var v2=vm.item("v2",true);
  var v3=vm.item("v3",true);
  var v4=vm.item("v4",true);
  vm.pending.addAll(List.of(v1,stale,r1,cached,v2,v3,r2,v4));
  vm.pump();
  check(vm.started.equals(List.of("floor","furniture","v1","v2")),"Priority or FIFO changed");
  r1.put("ready",true);
  r2.put("ready",true);
  vm.pump();
  check(vm.active.size()==3&&vm.pending.size()==1&&vm.pending.get(0)==v4,"Room slot was not reserved");
  var later=vm.item("late-furniture",false);
  vm.pending.add(later);
  vm.pump();
  check(vm.active.size()==4&&vm.started.equals(List.of("floor","furniture","v1","v2","v3","late-furniture")),
   "Room asset could not use the reserved slot");
  v1.put("disposed",true);
  vm.pump();
  check(vm.pending.isEmpty()&&vm.active.size()==4&&vm.started.get(6).equals("v4"),
   "Deferred avatar did not resume after a slot was released");
  vm.pump();
  check(vm.started.size()==7,"Pumping twice started a resource twice");

  var manager=new Obj("_-3fm::_-1in");
  var figures=new ArrayList<Object>();
  var running=new ArrayList<Object>();
  manager.put("_-4-E",figures);
  manager.put("_-31R",running);
  for(int i=0;i<6;i++){
   var library=new Obj("fixture-figure-library");library.put("id","figure-"+i);figures.add(library);
  }
  vm.execute(vm.method(MANAGER,"_-W"),manager);
  check(running.size()==4&&figures.size()==2,"Figure manager retained the two-library cap");
  System.out.println("PASS: saved AVM2 schedules room and furniture first, reserves a room slot, and resumes queued figures.");
 }
}

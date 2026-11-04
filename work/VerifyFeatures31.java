import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;
// Reproduce the reported 1069 at the actual saved RoomEngine initialize hook.
// Class member lookups retain their AVM2 namespaces; world/XML construction,
// rendering and event delivery remain explicit native-service boundaries.
class VerifyFeatures31 extends VerifyFeatures30 {
 static class VM31 extends VM30 {
  final Obj entryEngine,entryEvents=new Obj("entry-events-boundary"),world=new Obj("room-world-boundary");
  boolean available=true;int initialized;
  VM31(SWF s)throws Exception{super(s);entryEngine=new Obj(rawType(PatchFeatures23.ENGINE23));entryEngine.put("_-182",true);entryEngine.put("_-1YP",cacheMap(new LinkedHashMap<>()));entryEngine.put("events",entryEvents);}
  @Override Object lexical(Method m,Obj self,String n,int index){if(self==entryEngine&&n.equals("events"))return entryEvents;return super.lexical(m,self,n,index);}
  @Override Object get(Object r,Object key){if(r==entryEngine&&key.equals("events"))return entryEvents;return super.get(r,key);}
  static String namespace(ABC a,int index){var ns=a.constants.getNamespace(index);return ns.kind+":"+ns.getRawName(a.constants);}
  @Override void validatePropertyCall(Method method,Object receiver,int index){
   if(!(receiver instanceof Ref r)||!r.name().startsWith("loginpatch::")||!raw.containsKey(r.name()))return;
   var a=method.cls().abc();var mn=a.constants.getMultiname(index);String name=AuditStartup.name(a,index);var namespaces=new HashSet<String>();
   if(mn.namespace_index!=0)namespaces.add(namespace(a,mn.namespace_index));
   if(mn.namespace_set_index!=0)for(int ns:a.constants.getNamespaceSet(mn.namespace_set_index).namespaces)namespaces.add(namespace(a,ns));
   var cls=raw.get(r.name());
   for(var t:cls.abc().class_info.get(cls.index()).static_traits.traits){if(!name.equals(AuditStartup.name(cls.abc(),t.name_index)))continue;var trait=cls.abc().constants.getMultiname(t.name_index);if(namespaces.contains(namespace(cls.abc(),trait.namespace_index)))return;}
   throw new FixtureError("1069: no static member "+mn.toString(a.constants,null)+" on "+r.name());
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Ref ref&&ref.name().equals("::Logger")&&n.equals("log"))return null;
   if(r==entryEngine){
    if(n.equals("_-2vx"))return 0;
    if(n.equals("_-1MT"))return String.valueOf(a.get(0));
    if(n.equals("_-2Fx"))return "";
    if(n.equals("_-48g"))return world;
    if(n.equals("_-nk"))return available?areaRoom:null;
   }
   if(r==entryEvents&&n.equals("dispatchEvent")){initialized++;return null;}
   return super.call(r,n,a);
  }
  void enter(int room,boolean geometry){execute(method(PatchFeatures23.ENGINE23,"_-4El"),entryEngine,room,geometry?new Obj("room-xml-boundary"):null);}
 }
 static void roomEntry(SWF old,SWF now)throws Exception{
  var broken=new VM31(old);broken.nativePlanes(12,12);boolean failed=false;
  try{broken.enter(12345,true);}catch(FixtureError e){check(e.getMessage().contains("1069")&&e.getMessage().contains("http://adobe.com/AS3/2006/builtin")&&e.getMessage().contains("apply"),"Different old-room failure: "+e);failed=true;}
  check(failed,"Teste30 namespace collision was not reproduced");
  var v=new VM31(now);v.nativePlanes(12,12);v.enter(12345,true);check(v.initialized==1&&v.holes.isEmpty(),"Ordinary room entry did not finish cleanly");
  v.enter(12345,false);v.available=false;v.enter(12345,true);v.available=true;
  v.helper("initAreaHide30",1930);v.helper("bindRoom23",v.entryEngine,12345);double full=topArea(v);
  var floor=new Packet().b(false).i(-1).s("000000000000\r".repeat(12)).i(1);floor.bytes.write(areaPacket(88,true,1,1,3,2,false).bytes());parser(v,PatchFeatures22.FLOOR_MAP22,floor.bytes());
  v.enter(12345,true);check(Math.abs(topArea(v)-full+6)<.001,"Room entry no longer applies the active hider");
  v.area("incoming",new AccountReader(1930,areaPacket(88,false,1,1,3,2,false).bytes()));check(Math.abs(topArea(v)-full)<.001,"Hider OFF does not restore room geometry");
  v.helper("dropRoom23",v.entryEngine,12345);v.helper("bindRoom23",v.entryEngine,12346);v.enter(12346,true);check(Math.abs(topArea(v)-full)<.001,"Previous room hider leaks into next room");
  System.out.println("PASS: Namespace-aware execution reproduces Teste30 #1069 at the saved native RoomEngine initialization hook. Teste31 completes ordinary, early/null-geometry, unavailable-object, enabled-hider, OFF and next-room paths. Native world/XML allocation, event delivery, GPU and Android remain boundaries.");
 }
 public static void main(String[]args)throws Exception{var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO30.swf"),false);var now=new SWF(new FileInputStream(args[0]),false);roomEntry(old,now);smoothRight30(now);areas30(now);avatars30(new SWF(new FileInputStream("work/HabboTablet_LoginSSO29.swf"),false),now);areaUi30(now);System.out.println("PASS: Teste31 focused checks complete.");}
}

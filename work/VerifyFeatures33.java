import java.io.*;import java.util.*;import java.nio.file.*;import com.jpexs.decompiler.flash.SWF;
// Execute the saved AVM2. XML serialization, asset providers and device/GPU
// allocation are explicit boundaries, not a substitute for an Android test.
class VerifyFeatures33 extends VerifyFeatures32 {
 static final String LIB="com.sulake.habbo.avatar:AvatarAssetDownloadLibrary",MAN=PatchFeatures23.AVATAR23,RENDER="com.sulake.habbo.avatar:AvatarRenderManager";
 static class XmlBoundary extends RuntimeException {}
 static class VM33 extends VM32 {
  final Obj provider,legacy,tiles=new Obj("_-3MC::_-24h");final Map<String,Obj> assets=new LinkedHashMap<>();
  final Map<String,Obj> partSets=new LinkedHashMap<>();boolean roomHandler;int disposed;Obj handlerFloor;
  VM33(SWF s)throws Exception{super(s);for(String owner:List.of(LIB,MAN,RENDER))nativeTypes.add(rawType(owner));provider=new Obj(rawType("com.sulake.core.assets:AssetLibraryCollection"));legacy=new Obj(rawType("com.sulake.habbo.room.utils:LegacyWallGeometry"));}
  @Override boolean own(String t){return super.own(t)||t.equals("loginpatch::RoomGeometry33");}
  @Override Object call(Object r,String n,List<Object>a){
   if(roomHandler&&r==e){if(n.equals("_-2J-"))return legacy;if(n.equals("_-3-C"))return tiles;}
   if(roomHandler&&r==legacy){if(n.equals("initialize")||n.equals("_-1yQ"))return true;}
   if(roomHandler&&r==handlerFloor&&n.equals("_-0k5"))throw new XmlBoundary();
   if(r==provider){if(n.equals("_-3CQ"))return assets.get(String.valueOf(a.get(0)));if(n.equals("_-3tE")){assets.values().remove(a.get(0));return null;}}
   if(r instanceof Obj o&&o.type.equals("avatar-asset-boundary")&&n.equals("dispose")){disposed++;o.put("disposed",true);return null;}
   if(r instanceof Obj o&&o.type.equals("figure-boundary")){if(n.equals("_-1QS"))return o.get("parts");if(n.equals("_-mo"))return 1;}
   if(r instanceof Obj o&&o.type.equals("figure-sets-boundary")&&n.equals("_-3il"))return partSets.get(a.get(0));
   if(r instanceof Obj o&&o.type.equals("figure-type-boundary")&&n.equals("_-4n6"))return o.get("set");
   return super.call(r,n,a);
  }
  Obj library(String name,boolean mandatory){var o=allocate(rawType(LIB));o.put("_state",2);o.put("_-2OQ",mandatory);o.put("_-3Br",name);o.put("_-1el","fixture/"+name+"/revision1.swf");o.put("_assets",provider);var asset=new Obj("avatar-asset-boundary");asset.put("name",name);assets.put(String.valueOf(o.get("_-1el")),asset);return o;}
  Obj downloadManager(Map<Object,Object> libraries){var m=allocate(rawType(MAN));m.put("_-3AL",libraries);m.put("_-1Fc",true);var structure=new Obj("avatar-structure-boundary");structure.put("_-4f4",new Obj("figure-sets-boundary"));m.put("_-0Ra",structure);m.put("_-b",new HashMap<Object,Object>());return m;}
  Obj figure(Obj manager,String name,List<Obj> libraries){var parts=new ArrayList<Object>();var map=(Map<Object,Object>)manager.get("_-b");for(int i=0;i<libraries.size();i++){var p=new Obj("figure-part-boundary");String key=name+"-"+i;p.put("_-2pc",key);parts.add(p);map.put(key,List.of(libraries.get(i)));}var set=new Obj("figure-set-boundary");set.put("_-0S-",parts);var type=new Obj("figure-type-boundary");type.put("set",set);partSets.put(name,type);var f=new Obj("figure-boundary");f.put("parts",List.of(name));return f;}
  boolean ready(Obj m,Obj f){return truth(call(m,"_-0VM",List.of(f)));}
  void leave(Obj manager){var renderer=allocate(rawType(RENDER));renderer.put("_-oK",manager);call(renderer,"_-25Q",List.of());}
  Obj room(String text)throws Exception{
   var parsed=parser(this,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(3).s(text).bytes());handlerFloor=(Obj)construct(rawType(PLAN),List.of());roomHandler=true;
   var handler=new Obj(rawType(PatchFeatures23.HANDLER23));handler.put("_-1WY",e);handler.put("_-45Q",12345);handler.put("_-1fh",handlerFloor);
   var ev=new Obj(classes.values().stream().filter(c->c.logical().endsWith(":FloorHeightMapMessageEvent")).findFirst().orElseThrow().raw());ev.put("parser",parsed);
   boolean stopped=false;try{execute(method(PatchFeatures23.HANDLER23,"_-4IZ"),handler,ev);}catch(XmlBoundary expected){stopped=true;}check(stopped,"Did not reach native room geometry/XML boundary");roomHandler=false;return handlerFloor;
  }
 }
 static String map(boolean island,boolean leftDoor,boolean topDoor){var rows=new ArrayList<String>();for(int y=0;y<10;y++){var row=new StringBuilder("x".repeat(12));if(y>=1&&y<=6)for(int x=4;x<=9;x++)row.setCharAt(x,'0');if(island&&y==8)row.setCharAt(1,'0');if(leftDoor&&y==3)row.setCharAt(3,'0');if(topDoor&&y==0)row.setCharAt(6,'0');rows.add(row.toString());}return String.join("\r",rows)+"\r";}
 static List<Object> heights(String text){var rows=new ArrayList<Object>();for(String row:text.split("\r")){var r=new ArrayList<Object>();for(char c:row.toCharArray())r.add(c=='x'?-110:Character.digit(c,36));rows.add(r);}return rows;}
 static Object entrance(VM33 v,String text){return v.call(new Ref(v.rawType(PLAN)),"_-3Vo",List.of(heights(text)));}
 static void doors(SWF old,SWF now)throws Exception{
  var before=new VM33(old);var after=new VM33(now);String island=map(true,false,false);Object p=entrance(before,island);check(p instanceof Obj&&num(((Obj)p).get("x"))==1&&num(((Obj)p).get("y"))==8,"Old parser did not identify isolated tile as entrance");check(entrance(after,island)==null,"Isolated tile remains an entrance");
  var a=before.room(island);var b=after.room(island);double raised=number(before.call(a,"_-4-t",List.of(1,8)));check(raised>0,"Old native handler did not raise isolated tile: "+raised);check(number(after.call(b,"_-4-t",List.of(1,8)))==0,"Isolated tile still raised to door/wall height");
  for(boolean top:List.of(false,true)){var v=new VM33(now);String text=map(true,!top,top);var f=v.room(text);int x=top?6:3,y=top?0:3;check(number(v.call(f,"_-4-t",List.of(x,y)))>0,"Real entrance lost: "+top);check(number(v.call(f,"_-4-t",List.of(1,8)))==0,"Isolated tile overwrites real entrance: "+top);if(!top){var point=(Obj)entrance(v,text);check(num(point.get("x"))==3&&num(point.get("y"))==3,"Valid left entrance lost");}}
  // An invalid earlier candidate must not prevent finding a later real door.
  var rows=heights(map(false,true,false));((List<Object>)rows.get(1)).set(1,0);var v=new VM33(now);var point=(Obj)v.call(new Ref(v.rawType(PLAN)),"_-3Vo",List.of(rows));check(num(point.get("x"))==3&&num(point.get("y"))==3,"Invalid early island prevents finding real entrance");
  System.out.println("PASS: Teste32 reproduces the isolated tile door and raises its height. Saved Teste33 native RoomMessageHandler and RoomPlaneParser keep the island flat, preserve connected 90/180-degree entrances and skip an earlier invalid island. Native XML serialization/rendering remain boundaries.");
 }
 static void hiders(SWF old,SWF now)throws Exception{
  for(var s:List.of(old,now)){var v=new VM33(s);v.helper("initClient23",2500);v.helper("initAreaHide30",1930);v.helper("bindRoom23",v.e,12345);
   var self=located("conf_area_hide",77,3,3);var other=located("conf_area_hide_blue",78,4,4);var outside=located("conf_area_hide",79,8,8);var chair=located("ordinary_chair",80,3,3);var ctl=located("conf_invis_control",81,3,3);
   for(var o:List.of(self,other,outside)){var model=(Obj)o.get("model");model.put("furniture_real_room_object",1);model.put("furniture_data",new ArrayList<>(List.of(0,2,2,4,4,0,1,0)));}
   v.flagObjects.addAll(List.of(self,other,outside,chair,ctl));for(var o:v.flagObjects)v.helper("applyVisibility23",o,v.e,12345);var sprite=sprite32();
   v.area("incoming",new AccountReader(1930,areaPacket(77,true,2,2,4,4,false).bytes()));check(alpha(v,chair,sprite)==0,"Area no longer hides ordinary furniture");check(alpha(v,self,sprite)==(s==old?0:192)&&alpha(v,other,sprite)==(s==old?0:192),"Self/other hider exclusion not reproduced/fixed");
   if(s==old)continue;
   v.area("incoming",new AccountReader(1930,areaPacket(78,true,1,1,8,8,false).bytes()));v.area("incoming",new AccountReader(1930,areaPacket(79,true,2,2,4,4,true).bytes()));for(var o:List.of(self,other,outside,ctl)){check(alpha(v,o,sprite)==192,"Hider/controller hidden by overlapping/inverted area");check(num(v.helper("spriteCapture23",128,o,sprite))==128,"Visible hider is not clickable");}
   var model=(Obj)self.get("model");var data=(List<Object>)model.get("furniture_data");data.set(5,1);v.area("syncObject",self);
   for(boolean on:List.of(true,false,true,false)){v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(on).bytes()),v.connection);check(alpha(v,self,sprite)==(on?0:192),"Controller hider opt-in lost");check(alpha(v,other,sprite)==192&&alpha(v,ctl,sprite)==192,"Controller hides opted-out hider/controller");}
  }
  System.out.println("PASS: Teste32 reproduces hiders hiding themselves/each other. Teste33 keeps all hiders rendered and clickable under normal, overlapping and inverted areas, while the controller still toggles only opted-in hiders immediately.");
 }
 static void crowdedCache(SWF old,SWF now)throws Exception{
  for(var s:List.of(old,now)){var v=new VM33(s);var libraries=new LinkedHashMap<Object,Object>();var all=new ArrayList<Obj>();for(int i=0;i<200;i++){var lib=v.library("outfit-"+i,false);libraries.put("outfit-"+i,lib);all.add(lib);}var m=v.downloadManager(libraries);var figures=new ArrayList<Obj>();for(int i=0;i<40;i++)figures.add(v.figure(m,"figure"+i,all.subList(i*5,i*5+5)));
   for(var f:figures)check(v.ready(m,f),"Warm figure did not start ready");v.leave(m);int ready=0;for(var f:figures)if(v.ready(m,f))ready++;
   if(s==old){check(v.disposed==136&&ready<40,"Old 64-library eviction not reproduced: "+v.disposed+"/"+ready);System.out.println("REPRODUCED Teste32: 200 loaded dependencies -> "+v.disposed+" native asset disposals; only "+ready+"/40 figures immediately ready after reentry.");}
   else{check(v.disposed==0&&ready==40,"New cache discards warm room dependencies");v.leave(m);check(v.disposed==0,"Second reentry discards touched assets");v.now+=600001;v.leave(m);check(v.disposed==200,"Unused avatar dependencies never expire");}
  }
  System.out.println("PASS: Actual native renderer purge, asset-library state transitions and figure dependency readiness retain 200 recently used libraries for 40 fixture figures across two room exits; all 40 remain ready without a missing-library request. Ten-minute expiry still disposes all unused dependencies. Network/GPU timing is not simulated.");
 }
 static void cacheLimits(SWF now)throws Exception{
  for(int[] tier:List.of(new int[]{64,256},new int[]{400,256},new int[]{512,128},new int[]{768,64},new int[]{1024,0})){
   var v=new VM33(now);v.memory=tier[0]*1048576.;var libraries=new LinkedHashMap<Object,Object>();var all=new ArrayList<Obj>();for(int i=0;i<300;i++){var lib=v.library("limit-"+i,false);libraries.put("l"+i,lib);all.add(lib);v.now+=2;v.cache("touchAvatar",lib);}var protectedLib=v.library("mandatory",true);libraries.put("mandatory",protectedLib);var pending=v.library("pending",false);pending.put("_state",1);libraries.put("pending",pending);var m=v.downloadManager(libraries);v.leave(m);
   long kept=all.stream().filter(l->truth(v.get(l,"_-2nx"))).count();check(kept==tier[1],"Avatar tier capacity incorrect: "+tier[0]+" -> "+kept);check(truth(v.get(protectedLib,"_-2nx"))&&num(pending.get("_state"))==1,"Mandatory or loading library was purged");
   if(tier[1]>0){check(truth(v.get(all.get(299),"_-2nx"))&&!truth(v.get(all.get(0),"_-2nx")),"LRU kept old dependencies over recent ones");v.cache("force",true);v.leave(m);check(all.stream().noneMatch(l->truth(v.get(l,"_-2nx"))),"Forced cleanup retains ordinary dependencies");v.cache("force",false);}
  }
  System.out.println("PASS: Five simulated memory levels bound the avatar LRU to 256/128/64/0 libraries, retain newest dependencies, preserve mandatory and loading libraries, and permit explicit forced cleanup. Furniture cache policy remains unchanged.");
 }
 public static void main(String[]a)throws Exception{var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO32.swf"),false);var now=new SWF(new FileInputStream(a[0]),false);hiders(old,now);doors(old,now);crowdedCache(old,now);cacheLimits(now);System.out.println("PASS: Teste33 focused checks complete. Physical Android/live hotel not tested.");}
}

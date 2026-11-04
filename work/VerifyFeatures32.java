import java.io.*;import java.util.*;import java.nio.file.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures32 extends VerifyFeatures31 {
 static class VM32 extends VM31 {
  final List<Obj> wallObjects=new ArrayList<>();int loginReturns,alerts;
  VM32(SWF s)throws Exception{super(s);}
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Ref f&&f.name().equals("Math")&&n.equals("atan2"))return Math.atan2(number(a.get(0)),number(a.get(1)));
   if(r instanceof Obj o&&o.type.equals("offline-controller")){if(n.equals("handleLoginFailedShowDefaultView")){loginReturns++;return null;}if(n.equals("alert")){alerts++;return null;}}
   if(r==e&&num(a.isEmpty()?0:a.get(a.size()-1))==20){if(n.equals("_-2vx"))return wallObjects.size();if(n.equals("_-2Fe"))return wallObjects.get(num(a.get(1)));}
   if(r instanceof Obj o&&o.type.equals("visual-object")&&n.equals("getLocation"))return o.get("location");
   if(r instanceof Obj o&&o.type.equals("visual-object")&&n.equals("setState")){o.put("state",a.get(0));return true;}
   if(r instanceof Obj o&&o.type.equals("visual-object")&&n.equals("getId"))return o.get("id");
   if(r==floor&&n.equals("_-4-t")){int x=num(a.get(0)),y=num(a.get(1));if(x==4&&y==4)return 110;if(x==5&&y==5)return 100;if(x==6&&y==6)return 3;return 0;}
   if(r instanceof Obj o&&o.type.equals("floor-logic-double")&&n.equals("_-329")){if(probe!=null)helper("areaTileHit",probe.get("x"),probe.get("y"),probe.getOrDefault("z",0),a.get(2));return probe!=null;}
   return super.call(r,n,a);
  }
 }
 static Obj located(String type,int id,int x,int y){var o=visualObject();o.put("furnitype",type);o.put("id",id);o.put("location",new Obj("location"));((Obj)o.get("location")).put("x",x);((Obj)o.get("location")).put("y",y);((Obj)o.get("location")).put("z",0);return o;}
 static Obj sprite32(){var s=new Obj("visual-sprite");s.put("tag","");var im=new Obj("final-gpu-image-boundary");im.put("_-F5",128);s.put("image",im);return s;}
 static int alpha(VM32 v,Obj o,Obj sprite){return num(v.helper("spriteAlpha23",192,o,sprite));}
 static void visibility32(SWF old,SWF now)throws Exception{
  var v=new VM32(now);v.helper("initClient23",2500);v.helper("initAreaHide30",1930);v.helper("bindRoom23",v.e,12345);
  var hider=located("conf_area_hide",77,9,9);var hm=(Obj)hider.get("model");hm.put("furniture_real_room_object",1);var data=new ArrayList<Object>(List.of(0,2,2,3,3,1,1,0));hm.put("furniture_data",data);
  var inside=located("ordinary_chair",1,3,3);var outside=located("ordinary_chair",2,8,8);var controller=located("conf_invis_control",3,3,3);var wall=located("wall_picture",4,3,3);v.flagObjects.addAll(List.of(inside,outside,controller,hider));v.wallObjects.add(wall);v.helper("applyVisibility23",hider,v.e,12345);v.helper("applyWallVisibility32",wall,v.e,12345);
  var sprite=sprite32();var vis=new Obj(v.rawType(PatchFeatures23.FV23));v.helper("visibilityChanged23",vis,inside);
  for(boolean on:List.of(true,false,true,false)){
   v.area("incoming",new AccountReader(1930,areaPacket(77,on,2,2,3,3,false).bytes()));
   check(alpha(v,inside,sprite)==(on?0:192),"Area furniture waits for reentry");check(num(v.helper("spriteCapture23",128,inside,sprite))==(on?256:128),"Area furniture capture not immediate");
   check(alpha(v,wall,sprite)==(on?0:192),"Wall-items setting ignored");check(alpha(v,outside,sprite)==192&&alpha(v,controller,sprite)==192,"Unselected furniture/controller hidden");check(truth(v.helper("visibilityChanged23",vis,inside)),"Area change does not invalidate GPU/native model cache");
  }
  for(boolean on:List.of(true,false,true,false)){
   v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(on).bytes()),v.connection);
   check(alpha(v,hider,sprite)==(on?0:192),"Controller does not immediately hide opted-in hider");check(alpha(v,controller,sprite)==192&&alpha(v,outside,sprite)==192,"Hider option affects unrelated furniture");
  }
  v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(true).bytes()),v.connection);data.set(5,0);v.area("syncObject",hider);check(alpha(v,hider,sprite)==192,"Opt-out hider remains hidden");data.set(5,1);v.area("syncObject",hider);check(alpha(v,hider,sprite)==0,"Enabling option waits for room reentry");
  data.set(6,0);v.area("syncObject",hider);v.area("incoming",new AccountReader(1930,areaPacket(77,true,2,2,3,3,false).bytes()));check(alpha(v,wall,sprite)==192&&alpha(v,inside,sprite)==0,"Wall opt-out affected floor furniture");((Obj)inside.get("location")).put("x",8);check(alpha(v,inside,sprite)==192,"Moved furniture remains hidden outside area");
  var prior=new VM32(old);prior.helper("initClient23",2500);prior.helper("initAreaHide30",1930);prior.helper("bindRoom23",prior.e,12345);var oldChair=located("ordinary_chair",1,3,3);prior.flagObjects.add(oldChair);prior.helper("applyVisibility23",oldChair,prior.e,12345);prior.area("incoming",new AccountReader(1930,areaPacket(77,true,2,2,3,3,false).bytes()));check(alpha(prior,oldChair,sprite32())==192,"Old missing live furniture hiding was not reproduced");
  System.out.println("PASS: Teste31 reproduces missing live furniture hiding. Four ON/OFF cycles hide/restore all layers, GPU alpha and hit testing immediately, preserve outside furniture and invisible controller, respect wall-items opt-out and motion, and make the hider-only invisibility option reactive.");
 }
 static Obj vector(VM32 v,double x,double y,double z){return (Obj)v.construct("_-0AB::Vector3d",List.of(x,y,z));}
 static Obj plane(VM32 v,int type,Obj a,Obj l,Obj r){return (Obj)v.construct(v.rawType("com.sulake.habbo.room.object:RoomPlaneData"),Arrays.asList(type,a,l,r,null));}
 static void geometry32(SWF now)throws Exception{
  var v=new VM32(now);v.nativePlanes(12,12);v.helper("initAreaHide30",1930);v.helper("bindRoom23",v.engine,12345);v.area("incoming",new AccountReader(1930,areaPacket(77,true,0,0,5,12,false).bytes()));double area=topArea(v);
  var planes=(List<Object>)v.call(v.parserPlanes,"_-2us",List.of());var hiddenRim=plane(v,1,vector(v,-.5,.5,-.03),vector(v,5,0,0),vector(v,0,0,.03));var hiddenCap=plane(v,2,vector(v,-.7,.5,0),vector(v,.2,0,0),vector(v,0,9,0));planes.add(hiddenRim);planes.add(hiddenCap);v.area("clipRoomPlanes32",v.parserPlanes);check(!planes.contains(hiddenRim)&&!planes.contains(hiddenCap),"Hidden floor rim/wall cap retained");
  for(int i=0;i<num(v.get(v.parserPlanes,"_-3uW"));i++){var p=(Obj)v.call(v.parserPlanes,"_-1Ae",List.of(i));var l=(Obj)v.call(v.parserPlanes,"_-0-F",List.of(i));var r=(Obj)v.call(v.parserPlanes,"_-1wo",List.of(i));double x=number(v.get(p,"x"))+.5*(number(v.get(l,"x"))+number(v.get(r,"x")));check(x>=4.5-1e-6,"Visible plane remains wholly inside hidden prism");}
  check(area>0,"Clipping removed the unselected floor");v.area("incoming",new AccountReader(1930,areaPacket(77,false,0,0,5,12,false).bytes()));check(topArea(v)>area,"Disabling does not rebuild original floor");
  System.out.println("PASS: Native managed-mask callbacks bind the correct plane parser. Rebuilt geometry clips floor thickness and wall caps as well as top faces; hidden rim/cap fixtures are removed, visible floor remains, and OFF restores it.");
 }
 static void selection32(SWF old,SWF now)throws Exception{
  for(var s:List.of(old,now)){var v=new VM32(s);v.statics.put("_modernInfo",new Obj("modern-info"));((Obj)v.statics.get("_modernInfo")).put("ints",new ArrayList<>(List.of(3,3,2,2)));v.helper("beginArea",v.uiObject("_-2xS::LayoutGroup"));int count=((List<?>)((Obj)v.statics.get("_areaLayer")).get("children")).size();check(count==(s==old?4:3),"Void-cell phantom height not reproduced/corrected: "+count);
   if(s==now){v.probe=new Obj("hit");v.probe.put("x",4);v.probe.put("y",4);v.probe.put("z",0);check(v.helper("probeFloor",0,0)==null,"Void cell selectable");v.probe.put("x",3);v.probe.put("y",3);v.probe.put("z",2);check(v.helper("probeFloor",0,0)==null,"Vertical floor side selectable");v.probe.put("x",6);v.probe.put("y",6);v.probe.put("z",3);check(v.helper("probeFloor",0,0)!=null,"Raised floor top not selectable");}v.helper("endArea");}
  System.out.println("PASS: Teste31 draws a phantom quad at the absolute 110-height void sentinel. Teste32 excludes void/hidden cells and side-plane hits while preserving raised-floor selection and per-tile drawing.");
 }
 static void offline32(SWF now)throws Exception{
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})){
   var v=new VM32(now);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);var controller=new Obj("offline-controller");v.statics.put("_controller",controller);v.statics.put("_attempt",7);v.statics.put("_disconnectReason",-3);v.statics.put("_coreErrorId",0);v.helper("showQueuedFailure",7,"A conexão foi encerrada");var state=(Obj)v.statics.get("_offline32");check(state!=null&&v.alerts==0,"Network drop still shows diagnostic alert");check(((Obj)state.get("title")).get("text").equals("Sem acesso à internet"),"Offline title missing");var c=(Obj)state.get("card");check(number(c.get("x"))>=0&&number(c.get("y"))>=0&&number(c.get("width"))<=size[0]&&number(c.get("height"))<=size[1],"Offline card outside screen");v.helper("showQueuedFailure",7,"repeat");check(((List<?>)v.stage.get("children")).size()==1,"Duplicate offline screens");v.helper("offlineBack32",(Object)null);check(v.loginReturns==1&&v.statics.get("_offline32")==null&&((List<?>)v.stage.get("children")).isEmpty(),"Offline login action leaves overlay");v.statics.put("_coreErrorId",1069);v.helper("showQueuedFailure",7,"internal");check(v.alerts==1&&v.statics.get("_offline32")==null,"Real internal error mislabeled as offline");
  }
  var v=new VM32(now);for(String language:List.of("pt","en","de","fr","es","it","nl","fi","tr")){var ui=(Map<?,?>)v.call(new Ref("loginpatch::LocaleData21"),"ui",List.of(language));for(String key:List.of("Ocultar este mobi com o Controlador de mobis invisíveis","Sem acesso à internet","Voltar para o login"))check(ui.get(key) instanceof String str&&!str.isEmpty(),"Missing translation: "+language+"/"+key);}
  System.out.println("PASS: Reason -3 gets one custom offline screen with a working login return at three resolutions, while error 1069 retains its diagnostic. Correct hider-only wording and offline copy exist in all nine supported languages.");
 }
 public static void main(String[]args)throws Exception{var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO31.swf"),false);var now=new SWF(new FileInputStream(args[0]),false);visibility32(old,now);geometry32(now);selection32(old,now);offline32(now);roomEntry(new SWF(new FileInputStream("work/HabboTablet_LoginSSO30.swf"),false),now);areas30(now);areaUi30(now);smoothRight30(now);System.out.println("PASS: Teste32 focused checks complete. Android/GPU event delivery and live hotel remain explicit boundaries.");}
}

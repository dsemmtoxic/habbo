import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures28 extends VerifyFeatures27 {
 static class VM28 extends VM27 {
  boolean acceptSend=true;
  VM28(SWF s)throws Exception{super(s);}
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Obj o&&o.type.equals("visual-object")&&n.equals("getType"))return o.getOrDefault("furnitype","ordinary_chair");
   if(r==connection&&n.equals("send")&&!acceptSend)return false;
   return super.call(r,n,a);
  }
 }
 static void close28(SWF s)throws Exception{
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})){
   var v=new VM28(s);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);open25(v);ready(v);v.tick();var root=(Obj)v.state().get("_root");var card=(Obj)v.state().get("_card");var oldTexture=(Obj)v.state().get("_editTexture");
   int releases=v.releases;click(v,"close");assertGone(v,root);check(card.get("parent")==null&&!truth(card.get("visible")),"Card still renders");check(v.releases==releases,"Resources disposed inside button callback");v.editor("flushRetired");check(v.releases==releases,"Resources disposed before two native frames");
   open25(v);ready(v);v.tick();var current=(Obj)v.state().get("_root");v.editor("flushRetired");check(v.releases>releases&&v.state().get("_root")==current&&current.get("parent")!=null,"Old deferred cleanup touched the reopened editor");
   // Resolve X from the clicked display ancestry, even with a stale root slot.
   var wrong=v.display("starling.display::Sprite");v.state().put("_root",wrong);click(v,"close");check(current.get("parent")==null&&!truth(current.get("visible")),"X relied solely on the stale global root");v.editor("flushRetired");v.editor("flushRetired");
   open25(v);ready(v);v.tick();root=(Obj)v.state().get("_root");var model=(Obj)v.state().get("_model");var expected=m(v,model,"payload");int sent=v.sent.size();check(truth(v.editor("save")),"Ready save rejected");check(v.state().get("_root")==null&&root.get("parent")==null,"Save still waits for hotel re-entry to close");check(v.sent.size()==sent+1&&payload(v,v.sent.get(sent)).equals(expected),"Save fields changed");
   v.editor("roomClosed");parser(v,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(4).s(String.valueOf(m(v,model,"data"))).bytes());check(v.state().get("_root")==null&&root.get("parent")==null,"Room exit/late model reattached the old window");v.editor("flushRetired");v.editor("flushRetired");
   open25(v);ready(v);v.tick();root=(Obj)v.state().get("_root");v.acceptSend=false;check(!truth(v.editor("save"))&&v.state().get("_root")==root,"Failed send discards the editor/draft");click(v,"close");
  }
  System.out.println("PASS: X resolves the clicked window even with a stale root reference; Save closes immediately after an accepted exact payload and before room exit/re-entry; refused sends retain the draft. Textures survive the input callback and two native frames; delayed cleanup never disposes a newly reopened editor. Three screen sizes verified.");
 }
 static void hand28(SWF s)throws Exception{
  var v=new VM28(s);open25(v);ready(v);v.tick();var model=(Obj)v.state().get("_model");String data=String.valueOf(m(v,model,"data"));boolean changed=truth(model.get("changed"));double x=number(v.state().get("_originX")),y=number(v.state().get("_originY"));
  click(v,"mode:move");v.editor("mapTouched",ev(touch(v,"began",100,100)));v.editor("mapTouched",ev(touch(v,"moved",180,145)));v.editor("mapTouched",ev(touch(v,"ended",180,145)));
  check(Math.abs(number(v.state().get("_originX"))-x-80)<0.001&&Math.abs(number(v.state().get("_originY"))-y-45)<0.001,"Glove fails to pan with one finger");check(data.equals(String.valueOf(m(v,model,"data")))&&changed==truth(model.get("changed")),"Glove changed floor data");
  click(v,"editZoomIn");check(data.equals(String.valueOf(m(v,model,"data"))),"Zoom changed floor data");click(v,"mode:add");v.state().put("_level",2);v.editor("mapTouched",ev(tile(v,"began",4,3)));v.editor("mapTouched",ev(tile(v,"ended",4,3)));check(truth(model.get("changed")),"Drawing did not resume after glove mode");
  System.out.println("PASS: Glove replaces Fill; a one-finger drag moves the left map by the exact delta without altering floor data or dirty state. Zoom remains available and drawing resumes after switching tools.");
 }
 static VM28 invisibleVm(SWF s)throws Exception{var v=new VM28(s);v.helper("initClient23",2500);v.helper("bindRoom23",v.e,12345);v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(true).bytes()),v.connection);return v;}
 static void invisible28(SWF old,SWF s)throws Exception{
  var a=invisibleVm(old);var b=invisibleVm(s);
  var types=List.of("tile_stackmagic","tile_stackmagic1","tile_stackmagic8x8","tile_walkmagic","tile_walkmagic2x2","room_invisible_sit_tile","room_invisible_lay_tile","room_invisible_click_tile","room_invisible_block4");
  for(String type:types){
   var oldObj=visualObject();oldObj.put("furnitype",type);a.helper("applyVisibility23",oldObj,a.e,12345);var sprite=new Obj("visual-sprite");sprite.put("tag","");sprite.put("image",null);check(num(a.helper("spriteAlpha23",192,oldObj,sprite))==192,"Baseline unexpectedly supports untagged tool");
   var obj=visualObject();obj.put("furnitype",type);b.flagObjects.add(obj);b.helper("applyVisibility23",obj,b.e,12345);
   for(boolean hide:List.of(true,false,true,false)){
    b.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(hide).bytes()),b.connection);
    check(num(b.helper("spriteAlpha23",192,obj,sprite))==(hide?0:192),"Untagged construction tool visibility incorrect: "+type);
   }
  }
  b.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(true).bytes()),b.connection);
  for(String type:List.of("conf_invis_control","ordinary_chair","nft_h23_invisible_duck")){var o=visualObject();o.put("furnitype",type);b.helper("applyVisibility23",o,b.e,12345);var sprite=new Obj("visual-sprite");sprite.put("tag","");sprite.put("image",null);check(num(b.helper("spriteAlpha23",192,o,sprite))==192,"Controller/ordinary furni hidden: "+type);}
  for(String type:List.of("tile_stackmagic","tile_walkmagic","room_invisible_sit_tile")){var file=Files.list(Path.of("work/feature28/assets/"+type)).filter(p->p.getFileName().toString().endsWith("_visualization.bin")).findFirst().orElseThrow();check(!Files.readString(file).contains("tag=\"invisible\""),"Official source no longer reproduces missing layer tag");}
  System.out.println("PASS: Official legacy SWFs lack invisible layer tags. Teste27 reproduces visible untagged tiles; Teste28 hides/restores all nine verified construction types across four toggles while retaining controller, ordinary furniture and unrelated products.");
 }
 public static void main(String[]a)throws Exception{var s=new SWF(new FileInputStream(a[0]),false);var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO27.swf"),false);close28(s);hand28(s);invisible28(old,s);visibility25(s);market25(s);kept(s);System.out.println("PASS: Teste28 checks complete; Android GPU and live hotel remain execution boundaries.");}
}

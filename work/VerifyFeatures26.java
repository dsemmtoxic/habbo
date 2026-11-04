import java.io.*;import java.nio.file.*;import java.util.*;import java.awt.image.BufferedImage;import javax.imageio.ImageIO;
import com.jpexs.decompiler.flash.SWF;

// Executes the real saved AVM2 texture upload guard, native popup manager,
// native removeFromParent and native room-plane geometry. GPU transfers,
// display-list event delivery, Flash drawing, Android and the hotel are boundaries.
class VerifyFeatures26 extends VerifyFeatures25 {
 static final String TEXTURE="starling.textures:ConcreteTexture",POP="_-u8:_-g2";
 static class VM26 extends VM25 {
  Obj starling,pop;boolean failRelease=false,failUnsubscribe=false;int releases=0,uploads=0;
  final Set<Obj> ownedTextures=Collections.newSetFromMap(new IdentityHashMap<>());
  VM26(SWF s)throws Exception {
   super(s);starling=new Obj("native-starling-boundary");starling.put("stage",stage);starling.put("nativeStage",nativeStage);starling.put("isRendering",true);
   pop=allocate(rawType(POP));pop.put("_-0Bj",new ArrayList<>());pop.put("_-0A3",stage);pop.put("_-2wZ",new ASDictionary());pop.put("_-1Z4",new ASDictionary());pop.put("_-3eO",new ArrayList<>());pop.put("_-0Ii",false);
  }
  @Override int instructionBudget(){return 2000000;}
  @Override Object lexical(Method m,Obj self,String n,int index){
   if(n.equals("Starling"))return new Ref("starling.core::Starling");
   if(n.equals("trace"))return new Ref("trace");
   if(m.cls().logical().equals(TEXTURE)&&n.equals("Texture"))return new Ref("flash.display3D.textures::Texture");
   if(m.cls().logical().equals("starling.display:DisplayObject")&&n.equals("mParent"))return self.get("parent");
   if(m.cls().logical().equals(TEXTURE)&&n.equals("onContextCreated"))return new Bound(self,n);
   return super.lexical(m,self,n,index);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref&&ref.name().equals("starling.core::Starling")){if(k.equals("current")&&starling!=null)return starling;if(k.equals("handleLostContext"))return false;}
   if(r instanceof Ref ref&&ref.name().equals("starling.utils::SystemUtil")&&k.equals("isDesktop"))return false;
   if(r==stage&&k.equals("stage"))return stage;
   if(r instanceof Obj o&&o.type.equals("stage3d-rectangle-boundary"))return o.containsKey(k)?o.get(k):new Bound(o,String.valueOf(k));
   return super.get(r,k);
  }
  @Override Object construct(String t,List<Object>a){var o=super.construct(t,a);if(t.equals("starling.display::Image")&&o instanceof Obj im){im.put("texture",a.get(0));im.put("width",get(a.get(0),"width"));im.put("height",get(a.get(0),"height"));}return o;}
  @Override Object invokeSuper(Method m,Obj self,String n,List<Object>a){
   if(m.cls().logical().equals(TEXTURE)&&n.equals("dispose"))return execute(method("starling.textures:Texture","dispose"),self,a.toArray());
   return super.invokeSuper(m,self,n,a);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(n.equals("trace"))return null;
   if(r instanceof Ref ref&&ref.name().equals("starling.textures::Texture")&&n.equals("fromBitmapData")){
    var data=(Obj)a.get(0);var tx=allocate(rawType(TEXTURE));var base=new Obj("stage3d-rectangle-boundary");tx.put("mBase",base);tx.put("mWidth",get(data,"width"));tx.put("mHeight",get(data,"height"));tx.put("mScale",1);tx.put("mMipMapping",false);ownedTextures.add(tx);
    execute(method(TEXTURE,"uploadBitmapData"),tx,data);return tx;
   }
   if(r instanceof Ref ref&&ref.name().equals("_-u8::_-1OE")&&Set.of("_-3Dk","_-4gZ","_-Kk").contains(n))return execute(method(POP,n),pop,a.toArray());
   if(r==stage&&n.equals("addChild")){var child=(Obj)a.get(0);((List<Object>)stage.get("children")).add(child);child.put("parent",stage);return child;}
   if(r instanceof Obj o&&(scene(o.type)||ui(o.type))&&n.equals("removeFromParent"))return execute(method("starling.display:DisplayObject","removeFromParent"),o,a.toArray());
   if(r instanceof Obj parent&&n.equals("removeChild")&&parent.get("children") instanceof List list){
    var child=(Obj)a.get(0);list.remove(child);child.put("parent",null);
    if(((List<?>)pop.get("_-0Bj")).stream().anyMatch(x->x==child))execute(method(POP,"_-0GW"),pop,eventFor(child));
    if(a.size()>1&&truth(a.get(1)))call(child,"dispose",List.of());return child;
   }
   if(r instanceof Obj o&&o.type.equals("stage3d-rectangle-boundary")){
    if(n.equals("uploadFromBitmapData")){o.put("gpu-image",((Obj)a.get(0)).get("image"));uploads++;return null;}
    if(n.equals("dispose")){releases++;if(failRelease)throw new FixtureError("simulated GPU resource release failure");o.put("disposed",true);return null;}
   }
   if(r==connection&&n.equals("removeMessageEvent")&&failUnsubscribe)throw new FixtureError("simulated disconnected consumer removal");
   if(r instanceof Obj o&&ownedTextures.contains(o)&&n.equals("uploadBitmapData"))return execute(method(TEXTURE,n),o,a.toArray());
   if(r instanceof Obj o&&ownedTextures.contains(o)&&n.equals("dispose"))return execute(method(TEXTURE,n),o,a.toArray());
   if(r instanceof Obj o&&(scene(o.type)||ui(o.type))&&n.equals("dispose")){o.put("disposed",true);return null;}
   return super.call(r,n,a);
  }
  BufferedImage gpu(String slot){var tx=(Obj)state().get(slot);return tx==null?null:(BufferedImage)((Obj)tx.get("mBase")).get("gpu-image");}
  void tick(){now+=500;editor("frame",(Object)null);}
 }
 static void ready(VM26 v)throws Exception{v.incoming(ENTRY_EVENT,new Packet().i(1).i(1).i(2).bytes());v.incoming(OCC_EVENT,new Packet().i(1).i(2).i(2).bytes());}
 static void assertGone(VM26 v,Obj root){check(v.state().get("_root")==null&&root.get("parent")==null&&!truth(root.get("visible"))&&!truth(root.get("touchable")),"Window remains visible/attached after close");check(((List<?>)v.pop.get("_-0Bj")).isEmpty(),"Popup-manager membership leaked");check(!truth(v.state().get("_closing")),"Close guard remains locked");}
 static void reproduce(SWF old)throws Exception {
  var v=new VM26(old);open25(v);v.starling.put("isRendering",false);ready(v);check(pixels((Obj)v.state().get("_editData"))>30000&&v.gpu("_editTexture")==null,"Native upload guard did not reproduce CPU image / black GPU panel");v.starling.put("isRendering",true);v.tick();check(v.gpu("_editTexture")==null&&v.gpu("_previewTexture")!=null,"Baseline does not reproduce black map with working preview");
  var root=(Obj)v.state().get("_root");v.failRelease=true;boolean stopped=false;try{v.editor("close");}catch(FixtureError e){stopped=true;}check(stopped&&root.get("parent")!=null,"Baseline GPU cleanup did not leave the old popup attached");
  var same=new VM26(old);open25(same);ready(same);same.tick();check(truth(same.editor("save")),"Baseline cannot save fixture");parser(same,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(4).s("xxxxxxx\rx00000x\rx00000x\rx00000x\rxxxxxxx\r").bytes());check(same.state().get("_root")!=null,"Baseline unexpectedly closes on successful same-room model reload");
  System.out.println("PASS: Teste25 reproduces a black left GPU panel with nonblack CPU pixels using native uploadBitmapData's paused-rendering guard; the right preview still uploads. Native resource teardown can strand the old popup, and an accepted same-room model reload leaves its window open.");
 }
 static void lifecycle(SWF s)throws Exception {
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})){
   var v=new VM26(s);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);open25(v);var root=(Obj)v.state().get("_root");v.starling.put("isRendering",false);ready(v);v.tick();check(v.state().get("_editTexture")==null&&truth(v.state().get("_editDirty")),"Paused renderer consumes map's pending upload");v.starling.put("isRendering",true);v.tick();check(v.gpu("_editTexture")!=null&&v.gpu("_previewTexture")!=null,"Panels were never uploaded to the GPU boundary");check(pixels((Obj)v.state().get("_editData"))>30000,"Empty map");
   var before=v.gpu("_editTexture");v.starling.put("isRendering",false);v.state().put("_level",3);v.editor("mapTouched",ev(tile(v,"began",4,3)));v.editor("mapTouched",ev(tile(v,"ended",4,3)));click(v,"editZoomIn");v.tick();check(v.gpu("_editTexture")==before&&truth(v.state().get("_editDirty")),"A paused edit replaces the valid GPU image with an empty one");v.starling.put("isRendering",true);v.tick();check(v.gpu("_editTexture")!=before&&!truth(v.state().get("_editDirty")),"Resume did not show pending touch/zoom changes");
   var model=(Obj)v.state().get("_model");check(truth(m(v,model,"blocked",2,2)),"Occupied tile protection lost");int sent=v.sent.size();check(truth(v.editor("save"))&&v.sent.size()==sent+1&&payload(v,v.sent.get(sent)).equals(m(v,model,"payload")),"Native save fields changed");check(!truth(v.editor("save")),"Duplicate save");parser(v,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(4).s(String.valueOf(m(v,model,"data"))).bytes());assertGone(v,root);check(((Map<?,?>)v.registry.get("_-17M")).isEmpty(),"Floor consumers not removed");v.editor("close");v.editor("roomClosed");check(num(v.e.get("_-0Y"))==12345&&v.rooms.isEmpty(),"Close modified live room/canvas");
   // Freshly reopened editor must attach a fresh image and close through X,
   // even after edits and after the current popup manager loses membership.
   open25(v);ready(v);v.tick();root=(Obj)v.state().get("_root");click(v,"wallThicker");((List<?>)v.pop.get("_-0Bj")).clear();v.failRelease=true;v.failUnsubscribe=true;click(v,"close");assertGone(v,root);
  }
  System.out.println("PASS: Deferred map/direction/toolbar uploads survive paused network callbacks, touch/zoom and resume at three landscape sizes. Native popup/removeFromParent detach before resource release; X, same-room save acknowledgement, repeated close and reopen clear the window even with missing membership and teardown failures; exact save and occupied protection retained.");
 }
 static Obj roomModel(VM26 v){return model(v,"xxxxxxxxxxxx\rx000000xxxxx\rx000000xxxxx\rx000000xxxxx\rx000000xxxxx\rxxxxxxxxxxxx\rxxxxxxx0000x\rxxxxxxx0000x\rxxxxxxxxxxxx\r");}
 static void preview(SWF old,SWF s)throws Exception {
  var a=new VM26(old);var b=new VM26(s);var ma=roomModel(a);var mb=roomModel(b);ma.put("wallHeight",4);mb.put("wallHeight",4);ma.put("wallThickness",1);mb.put("wallThickness",1);ma.put("floorThickness",1);mb.put("floorThickness",1);
  var aa=(List<?>)a.call(new Ref("loginpatch::FloorPreview25"),"geometry",List.of(ma));var bb=(List<?>)b.call(new Ref("loginpatch::FloorPreview25"),"geometry",List.of(mb));check(bb.size()<aa.size(),"Hidden walls still leave their caps/strips");
  int vertical=0,horizontal=0;for(Object item:bb){var p=(Obj)item;if(num(p.get("type"))==2){var points=(List<Obj>)p.get("points");double dz=points.stream().mapToDouble(x->number(x.get("z"))).max().orElse(0)-points.stream().mapToDouble(x->number(x.get("z"))).min().orElse(0);if(dz>3)vertical++;else horizontal++;}}
  check(vertical>=2&&horizontal>0,"Legitimate back walls/caps were removed");
  var oldImage=(Obj)a.call(new Ref("loginpatch::FloorPreview25"),"render",List.of(ma,512,329));var fixed=(Obj)b.call(new Ref("loginpatch::FloorPreview25"),"render",List.of(mb,512,329));check(pixels(fixed)>5000,"Preview blank");ImageIO.write((BufferedImage)oldImage.get("image"),"png",Path.of("work/feature26/preview-before.png").toFile());ImageIO.write((BufferedImage)fixed.get("image"),"png",Path.of("work/feature26/preview-after.png").toFile());
  // Stepped floor and four thickness choices must still render; no real room.
  for(int thick=-2;thick<=1;thick++){mb.put("wallThickness",thick);mb.put("floorThickness",thick);m(b,mb,"draw",3,3,"add",2);var im=(Obj)b.call(new Ref("loginpatch::FloorPreview25"),"render",List.of(mb,512,329));check(pixels(im)>5000,"Thickness/raised floor became black");}
  System.out.println("PASS: Native secondary normals cull caps and vertical strips belonging to hidden front walls while keeping visible back walls, real caps, disconnected floors and raised sections; all four floor/wall thicknesses render.");
 }
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var old=new SWF(new FileInputStream("work/base25.swf"),false);reproduce(old);lifecycle(s);preview(old,s);visibility25(s);market25(s);kept(s);System.out.println("PASS: Teste26 verification complete (saved AVM2; Flash drawing, GPU transfers, display-list events, Android and network boundaries).");
 }
}

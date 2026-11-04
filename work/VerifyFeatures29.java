import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures29 extends VerifyFeatures28 {
 static class VM29 extends VM28 {
  int nativeRemovals=0;
  VM29(SWF s)throws Exception{super(s);}
  boolean displayObject(Object x){return x instanceof Obj o&&(o==stage||scene(o.type)||ui(o.type));}
  @Override Object lexical(Method m,Obj self,String n,int index){
   if(m.cls().logical().startsWith("starling.display:")){
    if(n.equals("mChildren"))return self.get("children");if(n.equals("mParent"))return self.get("parent");
    if(Set.of("getChildIndex","removeChildAt","spliceChildren","setParent").contains(n))return new Bound(self,n);
    if(n.equals("numChildren"))return ((List<?>)self.get("children")).size();if(n.equals("stage"))return null;
   }
   return super.lexical(m,self,n,index);
  }
  @Override Object get(Object r,Object k){if(displayObject(r)){
   var o=(Obj)r;if(k.equals("numChildren"))return ((List<?>)o.get("children")).size();if(k.equals("mChildren"))return o.get("children");if(k.equals("mParent"))return o.get("parent");
  }return super.get(r,k);}
  @Override void set(Object r,Object k,Object val){if(displayObject(r)&&k.equals("mParent")){((Obj)r).put("parent",val);return;}super.set(r,k,val);}
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Obj ev&&n.equals("stopImmediatePropagation")){ev.put("propagationStopped",true);return null;}
   if(displayObject(r)){
    var o=(Obj)r;
    if(n.equals("getChildAt"))return ((List<?>)o.get("children")).get(num(a.get(0)));
    if(Set.of("removeChildren","removeChild","removeChildAt","getChildIndex","spliceChildren").contains(n)){nativeRemovals++;return execute(method("starling.display:DisplayObjectContainer",n),o,a.toArray());}
    if(n.equals("setParent"))return execute(method("starling.display:DisplayObject",n),o,a.toArray());
    if(n.equals("dispatchEventWith")||n.equals("broadcastEventWith"))return null; // Explicit event-delivery boundary.
    if(n.equals("readjustSize")){var tx=(Obj)o.get("texture");o.put("width",get(tx,"width"));o.put("height",get(tx,"height"));return null;}
   }
   return super.call(r,n,a);
  }
 }
 static void emptyAndGone(VM29 v,Obj root){check(root.get("parent")==null&&!truth(root.get("visible"))&&!truth(root.get("touchable"))&&num(root.get("alpha"))==0&&((List<?>)root.get("children")).isEmpty(),"Editor retains visible content or display-list membership");}
 static void close29(SWF s)throws Exception{
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})){
   var v=new VM29(s);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);open25(v);ready(v);v.tick();var root=(Obj)v.state().get("_root");var card=(Obj)v.state().get("_card");int freed=v.releases;
   click(v,"close");emptyAndGone(v,root);check(card.get("parent")==null,"Card remains attached to removed root");check(v.releases==freed,"GPU resources released inside event callback");v.editor("flushRetired");v.editor("flushRetired");check(v.releases>freed,"Deferred resources not released");
   open25(v);ready(v);v.tick();root=(Obj)v.state().get("_root");var orphan=v.display("starling.display::Sprite");orphan.put("name","floorPlanEditor28");var q=v.display("starling.display::Quad");v.call(orphan,"addChild",List.of(q));v.call(v.stage,"addChild",List.of(orphan));
   click(v,"close");emptyAndGone(v,root);emptyAndGone(v,orphan);check(((List<?>)v.stage.get("children")).isEmpty(),"Old named editor survives close");
   open25(v);ready(v);v.tick();root=(Obj)v.state().get("_root");var model=(Obj)v.state().get("_model");var expected=m(v,model,"payload");check(truth(v.editor("save")),"Save rejected");emptyAndGone(v,root);check(payload(v,v.sent.get(v.sent.size()-1)).equals(expected),"Native save fields changed");v.editor("roomClosed");parser(v,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(-1).s("xxxx\rx00x\rxxxx\r").bytes());check(v.state().get("_root")==null&&((List<?>)v.stage.get("children")).isEmpty(),"Late room packets reattached editor");
   check(v.nativeRemovals>10,"Native removal path was bypassed");
  }
  System.out.println("PASS: Saved native Starling removeChildren/removeChild/removeChildAt/getChildIndex/setParent/spliceChildren execute during closure; X and accepted Save leave an empty, invisible, detached root at three resolutions. A second old named layer is removed too. GPU resources remain alive until two native frames. Display event delivery and Android GPU are explicit boundaries.");
 }
 static void orphanReproduction(SWF old,SWF now)throws Exception{
  var a=new VM29(old);open25(a);ready(a);a.tick();var root=(Obj)a.state().get("_root");var orphan=a.display("starling.display::Sprite");orphan.put("name","floorPlanEditor28");a.call(a.stage,"addChild",List.of(orphan));click(a,"close");check(orphan.get("parent")==a.stage&&truth(orphan.get("visible")),"Old version unexpectedly cleans an orphan layer");
  System.out.println("PASS: Teste28 reproduces an untouched second stage layer after close; Teste29 sweeps all named editor layers. This is a reproduced lifecycle failure mode, not proof of the device's original orphan-creation trigger.");
 }
 static void smooth29(SWF old,SWF now)throws Exception{
  var a=new VM29(old);open25(a);ready(a);a.tick();click(a,"mode:move");a.editor("mapTouched",ev(touch(a,"began",100,100)));int oldUploads=a.uploads;for(int i=1;i<=120;i++){a.editor("mapTouched",ev(touch(a,"moved",100+i*.5,100+i*.25)));a.now+=16;a.editor("frame",(Object)null);}check(a.uploads-oldUploads>=8,"Old raster/upload throttling not reproduced");
  var v=new VM29(now);open25(v);ready(v);v.tick();click(v,"mode:move");var model=(Obj)v.state().get("_model");var data=m(v,model,"data");boolean changed=truth(model.get("changed"));var tx=v.state().get("_editTexture");var bitmap=v.state().get("_editData");var image=(Obj)v.state().get("_editImage");double x=number(image.get("x")),y=number(image.get("y"));int uploads=v.uploads;int freed=v.releases;
  v.editor("mapTouched",ev(touch(v,"began",100,100)));for(int i=1;i<=120;i++){v.editor("mapTouched",ev(touch(v,"moved",100+i*.5,100+i*.25)));check(Math.abs(number(image.get("x"))-x-i*.5)<.001&&Math.abs(number(image.get("y"))-y-i*.25)<.001,"Movement waits for a throttled frame");v.now+=16;v.editor("frame",(Object)null);}
  v.editor("mapTouched",ev(touch(v,"ended",160,130)));check(v.state().get("_editTexture")==tx&&v.state().get("_editData")==bitmap&&v.uploads==uploads&&v.releases==freed,"Panning rebuilds or uploads the map");check(data.equals(m(v,model,"data"))&&changed==truth(model.get("changed")),"Panning changes floors");
  click(v,"editZoomIn");check(v.state().get("_editTexture")==tx&&!truth(v.state().get("_editDirty")),"Zoom rebuilds the bitmap");check(Math.abs(number(image.get("scaleX"))-number(v.state().get("_zoom")))<.001,"Zoom not applied immediately");
  click(v,"mode:add");v.state().put("_level",3);v.editor("mapTouched",ev(tile(v,"began",4,3)));v.editor("mapTouched",ev(tile(v,"ended",4,3)));v.now+=16;v.editor("frame",(Object)null);check(v.state().get("_editTexture")!=tx&&num(m(v,model,"getHeight",4,3))==3,"Drawing does not refresh cached map on next frame");check(pixels((Obj)v.state().get("_editData"))>5000&&pixels((Obj)v.state().get("_previewData"))>5000,"Panels blank");
  check(((Obj)v.state().get("_editPanel")).get("clipRect")!=null,"Panned map is not clipped to left panel");
  System.out.println("PASS: Old drag repeatedly uploads rasterized maps; 120 new drag samples at 16 ms update image position immediately with zero bitmap/texture allocations, GPU uploads or disposal. Zoom transforms the same image; floor data and dirty state remain exact. Editing rebuilds once on the next frame, and both panels remain nonblack.");
 }
 public static void main(String[]a)throws Exception{var s=new SWF(new FileInputStream(a[0]),false);var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO28.swf"),false);orphanReproduction(old,s);close29(s);smooth29(old,s);invisible28(new SWF(new FileInputStream("work/HabboTablet_LoginSSO27.swf"),false),s);create27(s);visibility25(s);market25(s);kept(s);System.out.println("PASS: Teste29 checks complete. No physical Android or live hotel execution was performed.");}
}

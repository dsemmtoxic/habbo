import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures27 extends VerifyFeatures26 {
 static class VM27 extends VM26 {
  final Obj textureCache=new Obj("texture-cache-boundary");
  VM27(SWF s)throws Exception{super(s);}
  @Override Object execute(Method m,Obj self,Object...a){try{return super.execute(m,self,a);}catch(NullPointerException e){String name="";for(var tr:m.cls().inst().instance_traits.traits)if(tr instanceof com.jpexs.decompiler.flash.abc.types.traits.TraitMethodGetterSetter mt&&mt.method_info==m.body().method_info)name=AuditStartup.name(m.cls().abc(),tr.name_index);throw new AssertionError("Missing fixture while executing "+m.cls().logical()+"."+name,e);}}
  @Override Object get(Object r,Object k){if(r instanceof Ref f&&f.name().equals("_-0zo::_-1Tv")&&k.equals("_-0R5"))return textureCache;if(r instanceof Obj o&&o.type.equals("final-gpu-image-boundary")&&k.equals("_-3uV"))return new Bound(o,"_-3uV");return super.get(r,k);}
  @Override Object call(Object r,String n,List<Object>a){
   if(r==textureCache&&n.equals("_-4nG"))return new Obj("cached-texture-boundary");
   if(r instanceof Obj o&&o.type.equals("final-gpu-image-boundary")&&n.equals("_-3uV"))return execute(method("com.sulake.habbo.room.object.image:SortableImage",n),o,a.toArray());
   if(r instanceof Obj o&&o.type.equals(rawType(PatchFeatures23.NAV23))&&n.equals("_-3Be"))return execute(method(PatchFeatures23.NAV23,n),o,a.toArray());
   return super.call(r,n,a);
  }
 }
 static void closing27(SWF old,SWF s)throws Exception{
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})){
   var v=new VM27(s);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);
   for(int attempt=0;attempt<3;attempt++){
    open25(v);ready(v);v.tick();var root=(Obj)v.state().get("_root");check(root.type.equals("starling.display::Sprite")&&((Obj)v.state().get("_card")).type.equals("starling.display::Sprite"),"Editor still depends on Feathers popup/layout containers");check(v.gpu("_editTexture")!=null&&v.gpu("_previewTexture")!=null,"Functional panels regressed");
    var buttons=(Map<?,?>)v.state().get("_buttons");for(var item:buttons.values()){String action=String.valueOf(((Map<?,?>)item).get("action"));check(!Set.of("wallThicker","wallThinner","floorThicker","floorThinner").contains(action),"Thickness arrows still exist");}
    var model=(Obj)v.state().get("_model");for(String action:List.of("wallThickness","floorThickness")){String field=action.equals("wallThickness")?"wallThickness":"floorThickness";int initial=num(model.get(field));var values=new HashSet<Integer>();for(int i=0;i<4;i++){click(v,action);values.add(num(model.get(field)));}check(values.size()==4&&num(model.get(field))==initial,"Thickness tap no longer cycles all four values");}
    if(attempt==0){v.failRelease=true;v.failUnsubscribe=true;click(v,"close");v.failRelease=false;v.failUnsubscribe=false;}
    else if(attempt==1){check(truth(v.editor("save")),"Save rejected ready draft");parser(v,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(4).s(String.valueOf(m(v,model,"data"))).bytes());}
    else {((List<?>)v.pop.get("_-0Bj")).clear();click(v,"close");}
    assertGone(v,root);check(v.state().get("_card")==null&&v.state().get("_model")==null,"Closed editor retains draft/card");v.editor("close");
   }
  }
  System.out.println("PASS: The editor owns plain Starling containers and closes through X/save acknowledgement, repeated close and reopen, with release errors and missing popup membership, at three screen sizes. Both panels still upload; thickness uses full-width tap cycling without arrows.");
 }
 static void create27(SWF s)throws Exception{
  var v=new VM27(s);var nav=new Obj(v.rawType(PatchFeatures23.NAV23));var comm=new Obj("navigator-comm");comm.put("connection",new Obj("fixture-connection"));nav.put("_-nE",comm);var controller=new Obj(v.rawType("com.sulake.habbo.tablet.navigator:NavigatorViewController"));controller.put("_navigator",nav);
  v.execute(v.method("com.sulake.habbo.tablet.navigator:NavigatorViewController","_-0P3"),controller);
  check(v.sent.size()==1&&v.sent.get(0).type.equals("loginpatch::CanCreateRoomRequest23")&&payload(v,v.sent.get(0)).isEmpty(),"Create button did not reach permission request");
  var b=v.method(PatchFeatures23.NAV23,"_-3Be").body();var lookups=b.getCode().code.stream().filter(i->(i.getBytes()[0]&255)==0x5d).map(i->AuditStartup.q(v.method(PatchFeatures23.NAV23,"_-3Be").cls().abc(),i.operands[0])).toList();
  check(lookups.equals(List.of("loginpatch::CanCreateRoomRequest23")),"Native lexical lookup still targets the old navigator query");
  creation(v,new SWF(new FileInputStream("work/plus.swf"),false));
  System.out.println("PASS: Actual Create button reaches the corrected composer lookup and registered empty permission request; native allowed/denied reply handling and the original room-creation form/serializer are preserved.");
 }
 static void invisible27(SWF old,SWF s)throws Exception{
  var base=new VM27(old);base.helper("initClient23",2500);base.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(true).bytes()),base.connection);base.helper("bindRoom23",base.e,12345);var original=visualObject();base.helper("applyVisibility23",original,base.e,12345);check(num(((Obj)original.get("model")).get("furniture_invisible_layer"))==0,"Baseline did not lose an early configuration packet");
  var v=new VM27(s);v.helper("initClient23",2500);v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(true).bytes()),v.connection);v.helper("bindRoom23",v.e,12345);var object=visualObject();v.helper("applyVisibility23",object,v.e,12345);var model=(Obj)object.get("model");check(num(model.get("furniture_invisible_layer"))==1,"Early room configuration was dropped");
  var vis=new Obj(v.rawType(PatchFeatures23.FV23));vis.put("_-3Cd",object);vis.put("_-4hc",2048);vis.put("_-1xk",false);vis.put("_-0VG",false);vis.put("_-113",false);
  var image=new Obj("final-gpu-image-boundary");image.put("name","tile_stackmagic_64_a_0_0");image.put("alpha",1.0);image.put("_-F5",128);
  var sprite=new Obj("visual-sprite");sprite.put("image",image);sprite.put("tag","invisible");sprite.put("alpha",192);sprite.put("_-F5",128);
  var graphic=new Obj("graphic-boundary");graphic.put("width",64);graphic.put("_-3HL","tile_stackmagic_64_a_0_0");
  for(boolean hide:List.of(true,false,true,false,true)){
   v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(hide).bytes()),v.connection);
   // Exercise authoritative room -> model synchronization without a successful
   // enumeration and after a model reconstruction, then execute the native GPU
   // method using its cached-texture branch rather than the former GPU stub.
   model.put("furniture_invisible_layer",0);v.helper("visibilityChanged23",vis,object);
   check(num(model.get("furniture_invisible_layer"))==(hide?1:0),"Tracked room state did not reach the reconstructed model");
   image.put("alpha",1.0);image.put("_-F5",128);v.execute(v.method(PatchFeatures23.FV23,"updateSpriteGPU"),vis,"tile",graphic,sprite,1,0);
   check(Math.abs(number(image.get("alpha"))-(hide?0:192.0/256))<0.00001&&num(image.get("_-F5"))==(hide?256:128),"Final native GPU image/capture state is incorrect");
  }
  sprite.put("tag","ordinary");image.put("alpha",0.75);v.execute(v.method(PatchFeatures23.FV23,"updateSpriteGPU"),vis,"tile",graphic,sprite,1,0);check(number(image.get("alpha"))==0.75,"Ordinary furniture was changed");
  v.helper("dropRoom23",v.e,12345);v.helper("visibilityChanged23",vis,object);check(num(model.get("furniture_invisible_layer"))==0,"Room state leaked after leaving");
  System.out.println("PASS: Early configuration packets survive room binding; tracked furniture re-applies room visibility even without enumeration and after model replacement. The saved native GPU routine hides/restores invisible-tagged layers and hit testing through five toggles; ordinary layers and room cleanup remain correct.");
 }
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var old=new SWF(new FileInputStream("work/HabboTablet_LoginSSO26.swf"),false);
  if(a.length>1){invisible27(old,s);return;}
  closing27(old,s);create27(s);invisible27(old,s);visibility25(s);market25(s);kept(s);
  System.out.println("PASS: Teste27 complete. Android GPU, display event delivery and the live hotel remain execution boundaries.");
 }
}

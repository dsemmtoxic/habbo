import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class VerifyFeatures16 extends VerifyFeatures15 {
 static final String NAV="com.sulake.habbo.tablet.navigator:NavigatorViewController",HMENU="com.sulake.habbo.hmenu:HMenu";
 static class CheckedVM extends ReleaseVM {
  CheckedVM(SWF s){super(s);}
  @Override Object lexical(Method m,Obj self,String n,int i){if(n.equals("Array")||n.equals("Object"))return new Ref(n);if(m.cls().logical().equals(HMENU)&&n.equals("_-0wY"))return new Bound(self,n);return super.lexical(m,self,n,i);}
  boolean collection(String t){return t.startsWith("_-1Ab::");}
  @Override boolean ui(String t){return super.ui(t)||t.startsWith("_-2LX::")||t.equals("_-4Fj::_-Bx");}
  Method setter(String type,String name){var c=raw.get(type);while(c!=null){for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==3&&AuditStartup.name(c.abc(),t.name_index).equals(name))return new Method(c,c.abc().findBody(m.method_info));c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}throw new AssertionError("Missing setter "+type+"."+name);}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("flash.geom::Rectangle")){var o=new Obj(t);for(int i=0;i<4;i++)o.put(List.of("x","y","width","height").get(i),a.get(i));return o;}
   if(collection(t)){
    var o=new Obj(t);
    if(t.equals("_-1Ab::_-nO")){
     // Native menu storage is supplied as a mutable array at the UI boundary;
     // insertion/getters and the real ArrayCollectionAccessor run unchanged.
     o.put("_-0SL",a.isEmpty()?new ArrayList<>():a.get(0));o.put("_-2jC",new Obj("_-1Ab::_-Jd"));
    }
    return o;
   }
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref&&ref.name().equals("_-2LX::_-0Yb")&&k.equals("_-1ur"))return 400;
   if(r instanceof Ref ref&&(ref.name().equals("_-1N-::_-2mJ")||ref.name().equals("::HitchTheme"))&&k.equals("_-17E"))return new Bound(r,"_-17E");
   if(r instanceof Obj o&&collection(o.type)){
    var c=raw.get(o.type);var getter=find(c,String.valueOf(k),true);if(getter!=null)return execute(getter,o);
    if(find(c,String.valueOf(k),false)!=null)return new Bound(o,String.valueOf(k));
    check(prop(o.type,String.valueOf(k)),"1069: Missing collection property "+k);return o.get(k);
   }
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object v){
   if(r instanceof Obj o&&collection(o.type)&&k.equals("data")){execute(setter(o.type,"data"),o,v);return;}
   if(r instanceof Obj o&&o.type.equals("_-3l1::_-3Az")&&k.equals("_-2Et")){execute(setter(o.type,"_-2Et"),o,v);return;}
   super.set(r,k,v);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(n.equals("Array")||n.equals("Object"))return a.get(0);
   if(n.equals("getDefinitionByName")&&a.get(0).equals("flash.geom::Rectangle"))return new Ref("flash.geom::Rectangle");
   if(r instanceof List list&&n.equals("splice")){int at=num(a.get(0)),remove=num(a.get(1));var removed=new ArrayList<>();for(int i=0;i<remove;i++)removed.add(list.remove(at));for(int i=2;i<a.size();i++)list.add(at+i-2,a.get(i));return removed;}
   if(r instanceof Ref ref&&(ref.name().equals("_-1N-::_-2mJ")||ref.name().equals("::HitchTheme"))&&n.equals("_-17E"))return (num(a.get(0))|1)-1;
   if(r instanceof Ref ref&&ref.name().equals("_-2YJ::_-bQ")){var c=raw.get(ref.name());return execute(method(c.logical(),n),staticObject(ref.name()),a.toArray());}
   if(r instanceof Obj o){
    if(o.type.equals("_-2LX::_-0Yb")&&n.equals("_-4TS")){check(prop(o.type,n),"Missing tabmenu animation");return null;}
    if(collection(o.type)){
     if(n.equals("dispatchEventWith")){calls.add("collection-event:"+a.get(0));return null;}
     var m=find(raw.get(o.type),n,false);if(m==null)throw new FixtureError("1069: Missing native collection method "+n);return execute(m,o,a.toArray());
    }
    if(o.type.equals(rawType(NAV))&&Set.of("_-0oZ","_-1xs").contains(n)){check(prop(o.type,n),"Unknown native navigation render callback");calls.add("native-nav-render:"+n);return null;}
    if(o.type.equals("fixture-tabmenu")&&n.equals("invalidate")){check(prop("_-2LX::_-0Yb",n),"Missing tabmenu method");return null;}
    if(o.type.equals("_-4Fj::_-Bx")&&n.equals("_-0Zf")){check(prop(o.type,n),"Missing native H-menu close");o.put("closed",true);return null;}
    if(o.type.equals("_-3l1::_-3Az")&&n.equals("_-4WN")){check(prop(o.type,n),"Missing lens invalidation");o.put("invalidated",true);return null;}
   }
   return super.call(r,n,a);
  }
 }
 static Obj menuContext(CheckedVM vm){
  var nav=new Obj(vm.rawType(NAV));nav.put("_-3lo",fixed(vm,1440,720));var service=new Obj("fixture-navigator");var data=new Obj("Object");data.put("visibleCategories",new ArrayList<>());service.put("data",data);nav.put("_navigator",service);nav.put("_-0Ix",new Obj("fixture-tabmenu"));return nav;
 }
 @SuppressWarnings("unchecked") static void testNativeNavigator(SWF before,SWF after){
  var broken=new CheckedVM(before);boolean reproduced=false;try{broken.execute(broken.method(NAV,"_-1Lq"),menuContext(broken));}catch(FixtureError e){check(e.getMessage().contains("addItemAt"),"Different old failure: "+e);reproduced=true;}check(reproduced,"Reported startup failure was not reproduced");
  var vm=new CheckedVM(after);var nav=menuContext(vm);vm.execute(vm.method(NAV,"_-1Lq"),nav);var menu=(Obj)nav.get("_-0Ix");var provider=(Obj)menu.get("dataProvider");int length=num(vm.get(provider,"length"));check(length==6,"Navigator menu lost an entry: "+length);var items=new ArrayList<Obj>();for(int i=0;i<length;i++)items.add((Obj)vm.call(provider,"getItemAt",List.of(i)));
  check(vm.get(items.get(1),"label").equals("Todos os quartos"),"Room label incorrect");check(vm.get(items.get(2),"label").equals("Quartos com meus amigos"),"Friend rooms not below All rooms");var request=(Obj)vm.get(items.get(2),"_-Ud");check(request.type.equals("_-0It::_-0Ro")&&payload(vm,request).isEmpty(),"Friend room search changed");
  check(vm.calls.contains("collection-event:addItem"),"Actual ListCollection insertion did not execute");
  System.out.println("PASS: Reproduced Teste15 startup #1069 in the actual native NavigatorViewController; corrected native ListCollection insertion executes and preserves six entries, labels and exact friend-room request.");
 }
 @SuppressWarnings("unchecked") static void testMenuToggle(CheckedVM vm){
  vm.statics.put("_portraitEnabled",false);vm.helper("enableOrientation",vm.nativeStage);check(Boolean.FALSE.equals(vm.nativeStage.get("autoOrients"))&&vm.nativeStage.get("aspectRatio").equals("landscape"),"Startup is not locked horizontal");
  var menu=vm.uiObject("_-4Fj::_-Bx");var ui=new Obj("fixture-ui");var session=new Obj("fixture-session");session.put("_-1XO",new ArrayList<>(List.of("account")));ui.put("sessionDataManager",session);menu.put("_-33k",ui);menu.put("_icon",vm.uiObject("_-2xS::_-1aX"));
  vm.execute(vm.method(HMENU,"_-45c"),menu);var panel=(Obj)menu.get("_-0Ix");var provider=(Obj)panel.get("dataProvider");int n=num(vm.get(provider,"length"));var help=(Obj)vm.call(provider,"getItemAt",List.of(1));var entry=(Obj)vm.call(provider,"getItemAt",List.of(2));check(vm.get(help,"label").equals("${toolbar.help}"),"Original Help moved");check(vm.get(entry,"label").equals("Modo vertical: ativar")&&num(vm.get(entry,"id"))==16016,"Toggle not immediately below Help");
  var event=new Obj("event-double");event.put("data",entry);vm.execute(vm.method(HMENU,"_-0wY"),menu,event);check(Boolean.TRUE.equals(vm.statics.get("_portraitEnabled"))&&vm.nativeStage.get("aspectRatio").equals("portrait")&&Boolean.FALSE.equals(vm.nativeStage.get("autoOrients")),"Menu does not enable manual portrait");check(Boolean.TRUE.equals(menu.get("closed")),"Menu did not close");check(Boolean.TRUE.equals(((Obj)vm.preferences.get("data")).get("portrait")),"Portrait preference not saved");
  vm.execute(vm.method(HMENU,"_-45c"),menu);panel=(Obj)menu.get("_-0Ix");provider=(Obj)panel.get("dataProvider");entry=(Obj)vm.call(provider,"getItemAt",List.of(2));check(vm.get(entry,"label").equals("Modo vertical: desativar"),"Toggle state label stale");event.put("data",entry);vm.execute(vm.method(HMENU,"_-0wY"),menu,event);check(Boolean.FALSE.equals(vm.statics.get("_portraitEnabled"))&&vm.nativeStage.get("aspectRatio").equals("landscape"),"Menu does not return horizontal");
  System.out.println("PASS: Actual H-menu construction places mode below Help; native selection callback toggles portrait/horizontal, updates the label, saves preference and keeps sensor rotation disabled.");
 }
 static void testUniformViewports(CheckedVM vm){
  for(boolean portrait:new boolean[]{false,true})for(int[] size:new int[][]{{2340,1080},{2400,1080},{1080,2340},{720,1600},{1440,2560}}){
   vm.statics.put("_portraitEnabled",portrait);var root=new Obj("fixture-root");var stage=new Obj("fixture-stage");stage.put("stageWidth",size[0]);stage.put("stageHeight",size[1]);var starling=new Obj("fixture-starling");var render=new Obj("fixture-stage");starling.put("stage",render);starling.put("viewPort",new Obj("fixture-viewport"));var proxy=new Obj("fixture-proxy");var view=new Obj("fixture-view3d");root.put("stage",stage);root.put("_starling",starling);root.put("_stage3DProxy",proxy);root.put("_view3D",view);
   vm.execute(vm.method(":HabboTabletMain","onStageResize"),root,new Obj("fixture-event"));var rect=(Obj)starling.get("viewPort");double w=((Number)render.get("stageWidth")).doubleValue(),h=((Number)render.get("stageHeight")).doubleValue();eq(((Number)rect.get("width")).doubleValue(),size[0],"Viewport width");eq(((Number)rect.get("height")).doubleValue(),size[1],"Viewport height");eq(w/size[0],h/size[1],"Nonuniform display scaling");check(!portrait||size[1]<=size[0]||w>=1280,"Portrait UI not given enough logical width");
   var lens=new Obj("_-3l1::_-3Az");lens.put("_-3qM",200.0);var camera=new Obj("fixture-camera");camera.put("_-5w",lens);view.put("camera",camera);var desktop=new Obj("fixture-room-desktop");desktop.put("_view3D",view);desktop.put("_-4bV",fixed(vm,1,1));desktop.put("_-3Rd",null);vm.execute(vm.method(DESKTOP,"_-0yk"),desktop,(int)w,(int)h);eq(((Number)vm.get(lens,"_-2Et")).doubleValue(),((int)h)/(32*Math.sqrt(2)),"3D lens does not match logical canvas");check(Boolean.TRUE.equals(lens.get("invalidated")),"Lens matrix did not refresh");
  }
  vm.helper("fitOrientationViewport",(Object)null,null);System.out.println("PASS: Actual native resize callback keeps physical back buffer and viewport, applies identical X/Y scaling over ten viewport cases, fits tablet UI width and refreshes the real orthographic lens setter.");
 }
 static void testPortraitControls(CheckedVM vm){
  vm.statics.put("_portraitEnabled",true);testPortraitLayout(vm);vm.statics.put("_portraitEnabled",false);
 }
 @SuppressWarnings("unchecked") static void testPortraitLayout(CheckedVM vm){
  var toolbar=new Obj("fixture-toolbar");var root=fixed(vm,1280,120);toolbar.put("view",root);toolbar.put("disposed",false);var ui=new Obj("fixture-ui");ui.put("events",new Obj("fixture-events"));toolbar.put("habboUI",ui);var items=new Obj("Object");toolbar.put("_-2NJ",items);var order=new ArrayList<>(List.of("ME_MENU","WHATS_NEW","NAVIGATOR","CHAT","CATALOG","INVENTORY","FRIENDS"));for(String id:order){var item=new Obj("Object");item.put("view",fixed(vm,id.equals("CHAT")?400:id.equals("ME_MENU")?140:110,id.equals("CHAT")?64:120));items.put(id,item);}
  for(int width:new int[]{1280,1440}){vm.stage.put("stageWidth",width);vm.stage.put("stageHeight",width*2);check(Boolean.TRUE.equals(vm.helper("responsiveToolbar",toolbar,items,order,new Bound(toolbar,"_-3Fa"))),"Portrait controls not active");double previousEnd=0;for(String id:order){var view=(Obj)((Obj)items.get(id)).get("view");double sx=((Number)view.get("scaleX")).doubleValue(),sy=((Number)view.get("scaleY")).doubleValue();eq(sx,sy,"Icon stretched "+id);if(id.equals("CHAT")){eq(((Number)view.get("width")).doubleValue(),width-32,"Chat width");continue;}double x=((Number)view.get("x")).doubleValue();check(x>=previousEnd,"Overlapping icons "+id);previousEnd=x+(id.equals("ME_MENU")?140:110)*sx;check(previousEnd<=width,"Icon outside portrait");}}
  vm.statics.put("_portraitEnabled",false);check(Boolean.FALSE.equals(vm.helper("responsiveToolbar",toolbar,items,order,new Bound(toolbar,"_-3Fa"))),"Horizontal switch does not restore native layout");vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);
  System.out.println("PASS: Portrait controls have evenly spaced main icons, preserve each icon's aspect ratio and place chat above; disabling portrait restores native layout.");
 }
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var before=new SWF(new FileInputStream("work/feature16/before.swf"),false);var vm=new CheckedVM(s);testNativeNavigator(before,s);testMenuToggle(vm);testUniformViewports(vm);testPortraitControls(vm);
  var regression=new ReleaseVM(s);var p=new SWF(new FileInputStream("work/plus.swf"),false);var oracle=new WiredVM(p);testNewWire(regression,oracle);testDefinitions(regression,oracle);testNativeWiredEntry(regression);testNativeMovement(regression);testArea(regression);testLiveHeight(regression);testFriends(regression);testSmallNames(regression);testRemovedCommands(regression);testHistory(regression,p);
 }
}

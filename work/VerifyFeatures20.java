import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;

// Executes shipped AVM2. Renderer, clipboard and network remain explicit doubles.
class VerifyFeatures20 extends VerifyFeatures19 {
 static class VM20 extends VM19 {
  final List<List<Object>> renderedColors=new ArrayList<>();
  VM20(SWF s){super(s);}
  @Override boolean ui(String t){return super.ui(t)||t.equals(rawType(PatchFeatures20.PREVIEW_IMAGE))||t.equals(rawType(PatchFeatures20.PREVIEW_BASE));}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(ui(self.type)&&!self.containsKey(n)){
    var c=raw.get(self.type);while(c!=null){for(var t:c.inst().instance_traits.traits)if(t instanceof com.jpexs.decompiler.flash.abc.types.traits.TraitMethodGetterSetter method&&method.kindType==1&&AuditStartup.name(c.abc(),t.name_index).equals(n))return new Bound(self,n);c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}
   }
   return super.lexical(m,self,n,i);
  }
  @Override Object invokeSuper(Method m,Obj self,String name,List<Object>a){
   if(m.cls().logical().equals(PatchOldLogin.SCREEN)&&Set.of("initializeHandler","onAddedToStage").contains(name))return execute(method(PatchOldLogin.BASE,name),self,a.toArray());
   return super.invokeSuper(m,self,name,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&o.type.equals("fixture-color-engine")&&k.equals("_-1LW"))return new Bound(o,String.valueOf(k));
   if(r instanceof Ref ref&&ref.name().equals("::HitchTheme"))return new Bound(r,String.valueOf(k));
   if(r instanceof Ref ref&&Set.of("_-1N-::_-2mJ","_-309::_-4dL","_-1Qj::_-4j8").contains(ref.name()))return new Bound(r,String.valueOf(k));
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object value){
   if(r instanceof Obj o&&o.type.equals(rawType("com.sulake.habbo.tablet.catalog.viewer:CatalogProduct"))&&k.equals("_-2XU")){execute(method("com.sulake.habbo.tablet.catalog.viewer:CatalogProduct","_-2XU"),o,value);return;}
   super.set(r,k,value);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Number value&&n.equals("toString"))return a.isEmpty()?String.valueOf(value.intValue()):Integer.toString(value.intValue(),num(a.get(0)));
   if(r instanceof List<?> list&&n.equals("indexOf")){for(int i=0;i<list.size();i++)if(equal(list.get(i),a.get(0)))return i;return -1;}
   if(r instanceof Ref ref&&ref.name().equals("_-1N-::_-2mJ")&&n.equals("_-17E"))return number(a.get(0))*dpi/4.;
   if(r instanceof Ref ref&&ref.name().equals("_-1Qj::_-4j8")&&n.equals("_-0Af"))return helper("classicCurrencyIcon",a.get(0));
   if(r instanceof Ref ref&&ref.name().equals("_-309::_-4dL"))return execute(method("com.sulake.habbo.utils:FriendlyTime",n),new Obj(ref.name()),a.toArray());
   if(r instanceof Ref ref&&ref.name().equals("_-2YJ::_-0iF")&&n.equals("_-3r2"))return uiObject("_-2xS::LayoutGroup");
   if(r instanceof Ref ref&&ref.name().equals("_-2YJ::_-3Rm")&&n.equals("_-1Jh"))return null;
   if(r instanceof Ref ref&&ref.name().equals("::HitchTheme")&&n.equals("_-1bL")){var o=uiObject("_-2xS::_-1aX");o.put("source",call(r,"getTexture",a));o.put("width",40);o.put("height",40);return o;}
   if(r instanceof Ref ref&&ref.name().equals("_-2YJ::_-bQ")){
    var o=uiObject("_-0iC::_-BX");o.put("args",a);return o;
   }
   if(r instanceof Ref ref&&ref.name().equals("::HitchTheme")&&n.equals("_-oc"))return true;
   if(r instanceof Obj o){
    if(o.type.equals("palette-config")&&n.equals("getProperty"))return o.get(a.get(0));
    if(o.type.equals("fixture-color-engine")&&n.equals("_-1LW")){renderedColors.add(new ArrayList<>(a));var result=new Obj("render-result");result.put("data",construct("flash.display::BitmapData",List.of(32,32,true,0)));result.put("id",renderedColors.size());return result;}
    if(o.type.equals(rawType(PatchFeatures20.PREVIEW_IMAGE))&&n.equals("_-Mp")){valid(o,n);o.put("rendered",a.get(0));return null;}
    if(o.type.equals("fixture-ui19")){if(n.equals("getBoolean"))return a.get(0).equals("seasonalcurrencyindicator.enabled");if(n.equals("getInteger"))return 0;if(n.equals("getProperty"))return null;}
    if(o.type.equals("fixture-localization")&&n.equals("_-1Nz")){calls.add("duration:"+a.get(0));return a.get(3)+" dias";}
    if(o.type.equals("fixture-catalog19")&&n.equals("_-1tD")){for(var key:new ArrayList<>(((Map<?,?>)statics.get("_purseBars")).keySet()))helper("updateClassicPurse",key);return null;}
    if(ui(o.type)&&n.equals("scrollToPosition")){valid(o,n);o.put("horizontalScrollPosition",a.get(0));o.put("verticalScrollPosition",a.get(1));return null;}
    if(ui(o.type)&&n.equals("readjustLayout")){valid(o,n);return null;}
    if(o.type.equals(rawType(PURSE19))&&Set.of("_-Z8","_-1tD").contains(n))return execute(method(PURSE19,n),o,a.toArray());
   }
   return super.call(r,n,a);
  }
 }
 @SuppressWarnings("unchecked") static void login20(VM20 vm)throws Exception{
  for(int[] size:List.of(new int[]{1536,709},new int[]{1440,720},new int[]{2400,1080},new int[]{1280,800},new int[]{960,540})){
   vm.stage.put("stageWidth",size[0]);vm.stage.put("stageHeight",size[1]);var ctrl=new Obj("fixture-login-controller19");ctrl.put("environment.id","pt");var view=new Obj("fixture-login-view19");
   var screen=vm.uiObject(vm.rawType(PatchOldLogin.SCREEN));screen.put("_controller",ctrl);screen.put("_-ZU",view);
   vm.execute(vm.method(PatchOldLogin.SCREEN,"initializeHandler"),screen,eventFor(screen));
   vm.execute(vm.method(PatchOldLogin.SCREEN,"onAddedToStage"),screen,eventFor(screen));
   var states=(Map<Object,Obj>)vm.statics.get("_tokenScreens");var st=states.get(screen);check(st!=null,"No login state");
   var container=(Obj)st.get("container");var root=(Obj)st.get("root");var card=(Obj)st.get("card");var flag=(Obj)st.get("country");
   check(((List<?>)root.get("children")).size()==(st.containsKey("version")?4:2)&&((List<?>)container.get("children")).size()==1,"Legacy login fields/footer remain");
   check(Math.abs(number(card.get("x"))+number(card.get("width"))/2-size[0]/2.)<=.5,"Login not centered");
   check(number(card.get("y"))>(st.containsKey("version")?0:size[1]*.2)&&number(card.get("y"))+number(card.get("height"))<size[1]-30,"Login vertically off screen");
   check(number(flag.get("y"))>0&&number(flag.get("x"))+number(flag.get("width"))<size[0],"Hotel corner button clipped");
   check(flag.get("defaultIcon")==st.get("icon")&&((Obj)st.get("icon")).get("source")!=null&&flag.get("label").equals("BR ▾"),"Country flag missing");
   for(String key:List.of("title","instructions","login","website")){
    var item=(Obj)st.get(key);check(number(item.get("x"))+number(item.get("width"))<=number(card.get("width")),"Card content clipped: "+key);
   }
   vm.helper("tokenHotelAction",eventFor(flag));vm.clipboard="";vm.helper("tokenLoginAction",eventFor((Obj)st.get("login")));check(vm.calls.stream().anyMatch(x->x.startsWith("alert:")),"Empty clipboard no feedback");
   vm.helper("disposeTokenLogin",screen);check(!states.containsKey(screen),"Login state leaked");
  }
  var login=vm.uiObject(vm.rawType(PatchOldLogin.SCREEN));var loading=vm.uiObject("_-32p::_-0Mw");
  for(String name:List.of("loadingScreen","loginScreen","environmentSelect","loginScreen")){
   vm.helper("syncLoginPresentation",name,login,loading);check(truth(loading.get("visible"))==name.equals("loadingScreen"),"Spinner visible outside loading");check(truth(login.get("visible"))==name.equals("loginScreen"),"Login visibility incorrect");
  }
  for(String hotel:List.of("pt","en","fr")){vm.loginData.put("environment",hotel);vm.loginData.put("autologin",true);vm.loginData.put("password","obsolete");vm.execute(vm.method(UTILS19,"_-2eQ"),vm.staticObject("_-309::_-2Yt"));check(hotel.equals(vm.loginData.get("environment"))&&vm.loginData.get("password")==null,"Saved hotel or token persistence regression");}
  vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);
  System.out.println("PASS: Full native login initialization/onAdded invokes one centered card and an independent visible flag at five landscape sizes; no input/footer; spinner only in connection state; remembered hotels preserved.");
 }
 @SuppressWarnings("unchecked") static void currencies20(VM20 vm)throws Exception{
  var ui=makeUi(vm);ui.put("localization",new Obj("fixture-localization"));var catalog=(Obj)ui.get("catalog");var purse=(Obj)catalog.get("purse");purse.put("_-0nU",33);
  var widget=vm.uiObject(vm.rawType(PURSE19));widget.put("_-33k",ui);vm.execute(vm.method(PURSE19,"createView"),widget);vm.call(widget,"dispatchEventWith",List.of("addedToStage"));
  check(vm.sent.get(vm.sent.size()-1).type.equals("loginpatch::CreditsInfoPayload"),"Credits query removed");
  check(((Obj)widget.get("_-3cA")).get("text").equals("33 dias")&&((Obj)widget.get("_-tY")).get("text").equals("16"),"Native HC/BC durations not restored");
  check(vm.calls.contains("duration:friendlytime.days"),"HC no longer uses native localization");
  var state=(Obj)((Map<?,?>)vm.statics.get("_purseBars")).get(widget);check(state!=null,"Native purse not tracked");
  var seasonal=(Obj)state.get("seasonal");check(Boolean.FALSE.equals(((Obj)seasonal.get("parent")).get("visible")),"Duckets duplicated in seasonal slot");
  check(((Obj)state.get("credit")).get("text").equals("…"),"Unknown credit falsely shown as zero");
  String parser=msg("parser.inventory.purse:CreditBalanceParser");var balance=(Obj)vm.construct(vm.rawType(parser),List.of());vm.execute(vm.method(parser,"parse"),balance,new Reader(new Packet().s("9.0").bytes()));
  var event=new Obj(vm.rawType(msg("incoming.inventory.purse:CreditBalanceEvent")));event.put("parser",balance);catalog.put("_-38H",purse);catalog.put("events",new Obj("fixture-balance-events19"));vm.execute(vm.method(CATALOG,"_-3ly"),catalog,event);vm.execute(vm.method(PURSE19,"_-1tD"),widget);
  check(((Obj)state.get("credit")).get("text").equals("9"),"Actual credits not reflected");
  var points=(Map<Integer,Integer>)purse.get("points");points.put(101,45);points.put(105,7);vm.helper("updateClassicPurse",widget);
  check(truth(((Obj)seasonal.get("parent")).get("visible"))&&seasonal.get("text").equals("45"),"Seasonal currency omitted");
  var extra=(Map<String,Obj>)state.get("extras");check(extra.get("points:105")!=null&&((Obj)extra.get("points:105").get("label")).get("text").equals("7"),"Second seasonal currency omitted");
  vm.helper("initCurrencyProtocol",3177,920);vm.helper("interceptAccountPacket",new AccountReader(3177,new Packet().i(25).bytes()),((Obj)ui.get("communication")).get("connection"));
  check(((Obj)extra.get("silver").get("label")).get("text").equals("25"),"Real silver balance omitted");
  points.remove(101);points.remove(105);vm.helper("updateClassicPurse",widget);check(!truth(((Obj)extra.get("points:105").get("cell")).get("visible")),"Stale seasonal balance retained");
  vm.helper("clearPurseBar",widget);vm.helper("resetAccountState");
  System.out.println("PASS: Original native purse construction, localized HC duration and native BC value restored; typed credit query and real 9.0 balance retained; duplicate Duckets hidden; distinct seasonal/silver values update and stale balances disappear.");
 }
 static Obj colorOffer(VM20 vm,String name){
  var product=new Obj(vm.rawType("com.sulake.habbo.tablet.catalog.viewer:CatalogProduct"));product.put("_-2sm","s");product.put("_-1KZ",18800);product.put("_-0qP","");var furni=new Obj("furniture-data");furni.put("_-uZ",name);product.put("_-03H",furni);var offer=new Obj("color-offer");offer.put("product",product);offer.put("offerId",29830);offer.put("pageId",24);return offer;
 }
 @SuppressWarnings("unchecked") static void palette20(VM20 vm)throws Exception{
  var config=new Obj("palette-config");var defaults=(Map<String,String>)vm.statics.get("_recolorDefaults");int families=0,items=0;
  for(String mapping:String.valueOf(vm.statics.get("_recolorMapping")).split(";")){
   var bits=mapping.split("=");families++;
   for(String name:bits[1].split(",")){
    var palette=(Obj)vm.helper("recolorPalette",config,name);var colors=(List<?>)palette.get("colors");check(palette.get("name").equals(bits[0]),"Wrong material palette");check(colors.size()==defaults.get(bits[0]).split(",").length,"Palette truncated");
    var offer=colorOffer(vm,name);check(truth(vm.helper("isRecolorableOffer",offer)),"Recolorable furniture not recognized");
    for(var color:List.of(colors.get(0),colors.get(colors.size()-1))){var product=(Obj)offer.get("product");String rgb=String.valueOf(vm.helper("recolorRGB",color));vm.set(product,"_-2XU",rgb);check(vm.get(product,"_-2XU").equals(rgb),"Native product setter lost RGB");var data=(Obj)vm.helper("recolorStuffData",product);check(data!=null,"Missing placement stuff data");var map=(Obj)data.get("_-0SL");var components=rgb.split(",");for(int i=0;i<3;i++)check(vm.call(map,"getValue",List.of(List.of("r","g","b").get(i))).equals(components[i]),"Wrong RGB component");}
    items++;
   }
  }
  check(items==69&&families==12,"Unexpected official palette coverage");
  var ordinary=colorOffer(vm,"chair");check(!truth(vm.helper("isRecolorableOffer",ordinary))&&vm.helper("recolorStuffData",ordinary.get("product"))==null,"Ordinary furniture modified");
  config.put("recolorable_bc.palette.default","112233,AABBCC");var configured=(Obj)vm.helper("recolorPalette",config,"bc_block_0_recolorable");check(((List<?>)configured.get("colors")).size()==2,"Live hotel palette ignored");config.remove("recolorable_bc.palette.default");
  var content=vm.uiObject(vm.rawType(PatchFeatures20.PREVIEW_BASE));var host=vm.uiObject("_-2xS::LayoutGroup");host.put("height",640);var image=vm.uiObject(vm.rawType(PatchFeatures20.PREVIEW_IMAGE));image.put("width",420);image.put("height",380);image.put("layoutData",vm.uiObject("_-0iC::_-BX"));
  var glow=(Obj)vm.construct("starling.display::Quad",List.of(420,380,0xffffff));vm.call(image,"addChild",List.of(glow));vm.call(image,"addChild",List.of(vm.uiObject("_-2xS::_-1aX")));
  var preview=new Obj("color-preview");preview.put("catalog",config);preview.put("roomEngine",new Obj("fixture-color-engine"));image.put("_-ZD",preview);vm.call(host,"addChild",List.of(image));var offer=colorOffer(vm,"bc_block_0_recolorable");
  vm.helper("showFurniturePalette",content,host,image,preview,offer);var state=(Obj)((Map<?,?>)vm.statics.get("_recolorViews")).get(content);check(state!=null,"Missing palette view");var buttons=(List<Obj>)state.get("buttons");check(buttons.size()==69,"Colour swatches omitted");var scroll=(Obj)state.get("scroll");check(scroll.get("verticalScrollPolicy").equals("on")&&scroll.get("scrollBarDisplayMode").equals("fixed"),"Palette scrollbar absent");
  var last=buttons.get(buttons.size()-1);vm.helper("chooseFurnitureColor",eventFor((Obj)last.get("button")));String rgb=String.valueOf(vm.helper("recolorRGB",last.get("color")));check(vm.get(offer.get("product"),"_-2XU").equals(rgb),"Swatch did not update actual product");check(vm.helper("furniturePurchaseParameters",content).equals(rgb),"Purchase colour omitted");
  var rendered=vm.renderedColors.get(vm.renderedColors.size()-1);check(rendered.size()==9&&num(rendered.get(0))==18800&&rendered.get(8)!=null,"Native preview lacks real RGB data");
  var placement=(Obj)vm.construct("_-1Dj::_-0Ho",List.of(24,29830,rgb,4,7,2));check(payload(vm,placement).equals(List.of(24,29830,rgb,4,7,2,false)),"BC placement colour differs from native current payload");
  vm.helper("showFurniturePalette",content,host,image,preview,ordinary);check(!((Map<?,?>)vm.statics.get("_recolorViews")).containsKey(content)&&((Map<?,?>)vm.statics.get("_recolorSwatches")).isEmpty(),"Palette listeners/colour leak between offers");
  var object=new Obj("fixture-object");object.put("furnitype","bc_block_0_recolorable");var model=new Obj("fixture-color-model");var map=new Obj("fixture-color-map");map.put("r","18");map.put("g","52");map.put("b","86");model.put("data",map);object.put("model",model);check(num(vm.helper("recolorLayer",object,"recolorable"))==0x123456,"Room furniture RGB renders white");
  System.out.println("PASS: All 69 official furniture classes / 12 palettes, live settings, native RGB product setter, MapStuffData, 69 swatches with a fixed scrollbar, preview callback, real BC placement payload and room colour layer verified; ordinary offers and cleanup remain safe.");
 }
 static void wired20(VM20 vm)throws Exception{
  var definition=info("effect",123,3);definition.put("ids",new ArrayList<>(List.of(10)));definition.put("ids2",new ArrayList<>(List.of(20)));vm.statics.put("_modernInfo",definition);vm.statics.put("_modernControl",new Obj(vm.rawType(CONTROL)));vm.statics.put("_wiredEditor",new Obj("fixture-editor"));
  vm.helper("chooseWiredFurniture",0);check(vm.calls.contains("select-furni")&&!truth(vm.helper("wiredFurniturePicking")),"Old native selector not restored");
  vm.helper("chooseWiredFurniture",1);check(definition.get("ids").equals(List.of(10))&&definition.get("ids2").equals(List.of(20)),"Selection groups mixed");
  var move=(Obj)vm.construct("_-3eU::_-1Iq",List.of(3,5));check(!truth(vm.helper("blockTyping",move)),"One-tap picker still locks movement");vm.helper("wiredClosed");
  System.out.println("PASS: Both furniture groups open the previous native Wired selector, with no one-tap picker or movement override.");
 }
 public static void main(String[]a)throws Exception{
  var swf=new SWF(new FileInputStream(a[0]),false);var plus=new SWF(new FileInputStream("work/plus.swf"),false);var vm=new VM20(swf);login20(vm);currencies20(vm);palette20(vm);wired20(vm);
  var kept=new VM20(swf);verifyHeads(kept);verifyEarnings(kept);verifyMenu(swf);outline(kept);events(kept);catalog(kept);income(kept,plus);regression(swf,plus);
 }
}

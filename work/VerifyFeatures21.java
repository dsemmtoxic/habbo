import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.types.traits.*;
class VerifyFeatures21 extends VerifyFeatures20 {
 static class VM21 extends VM20 {
  final List<List<Object>> placements=new ArrayList<>();final List<String> closed=new ArrayList<>();boolean allowPlacement=true;
  VM21(SWF s){super(s);}
  @Override Obj uiObject(String type){
   var o=super.uiObject(type);if(type.equals("_-2xS::Button")){
    var selector=new Obj("fixture-skin-selector");var theme=new Obj("fixture-green-theme");var green=display("starling.display::Quad");green.put("color",0x32b500);green.put("width",44);green.put("height",44);theme.put("skin",green);selector.put("defaultValue",green);o.put("_-2FA",selector);o.put("_-6F",new Bound(theme,"updateValue"));o.put("_-R-","up");o.put("_-2Bf",Double.NaN);o.put("_-43",Double.NaN);
   }return o;
  }
  @Override void set(Object r,Object key,Object value){
   if(r instanceof Obj o&&o.type.equals("_-2xS::Button")&&Set.of("stateToSkinFunction","defaultSkin","downSkin").contains(key)){
    var c=raw.get(o.type);for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==3&&AuditStartup.name(c.abc(),t.name_index).equals(key)){o.put(key,value);execute(new Method(c,c.abc().findBody(m.method_info)),o,value);return;}
   }
   super.set(r,key,value);
  }
  @Override Object lexical(Method m,Obj self,String name,int i){
   if(m.cls().logical().equals(BUTTONS)&&name.equals("_-1bj"))return new Bound(self,name);
   if(m.cls().logical().equals(CATALOG)&&Set.of("_-0Lc","_-0x5","_-4lU").contains(name))return new Bound(self,name);
   return super.lexical(m,self,name,i);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::LocaleData21"))return new Bound(r,String.valueOf(k));
   if(r instanceof Obj o&&o.type.equals("fixture-place-engine")&&k.equals("_-1Tl"))return new Bound(o,String.valueOf(k));
   if(r instanceof Obj o&&o.type.equals("fixture-ui21")&&Set.of("getBoolean","getProperty","getInteger").contains(k))return new Bound(o,String.valueOf(k));
   return super.get(r,k);
  }
  @Override Object call(Object r,String name,List<Object>a){
   if(r instanceof String&&name.equals("toString"))return r;
   if(name.equals("DisplayObject")||name.equals("starling.display::DisplayObject"))return a.get(0);
   if(r instanceof java.util.regex.Pattern p&&name.equals("exec")&&p.matcher("").groupCount()>0){var m=p.matcher(String.valueOf(a.get(0)));if(!m.find())return null;var out=new ArrayList<Object>();for(int i=0;i<=m.groupCount();i++)out.add(m.group(i));return out;}
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::LocaleData21"))return execute(method("loginpatch:LocaleData21",name),staticObject(ref.name()),a.toArray());
   if(r instanceof Obj o){
    if(o.type.equals("fixture-green-theme")&&name.equals("updateValue"))return o.get("skin");
    if(o.type.equals("fixture-skin-selector")){if(name.equals("getValueForState"))return o.get(a.get(0));if(name.equals("setValueForState")){o.put(a.get(1),a.get(0));return null;}if(name.equals("updateValue")){var button=(Obj)a.get(0);return o.getOrDefault(button.get("_-R-"),o.get("defaultValue"));}}
    if(ui(o.type)&&name.equals("invalidate"))return null;
    if(ui(o.type)&&name.equals("removeChild")){((List<?>)o.get("children")).remove(a.get(0));((Obj)a.get(0)).put("parent",null);return a.get(0);}
    if(o.type.equals("fixture-ui21")){if(name.equals("getBoolean"))return !Boolean.FALSE.equals(o.get(a.get(0)));if(name.equals("getProperty"))return o.get(a.get(0));if(name.equals("getInteger"))return num(o.get(a.get(0)));}
    if(o.type.equals("fixture-place-engine")&&name.equals("_-1Tl")){placements.add(new ArrayList<>(a));return true;}
    if(o.type.equals("fixture-place-events")&&name.equals("dispatchEvent")){closed.add(String.valueOf(((Obj)a.get(0)).get("type")));return null;}
    if(o.type.equals(rawType(CATALOG))){
     if(name.equals("_-0Lc"))return execute(method(CATALOG,name),o,a.toArray());
     if(name.equals("getBoolean"))return a.get(0).equals("catalog.drag_and_drop")&&allowPlacement;
     if(name.equals("_-0x5"))return execute(method(CATALOG,name),o,a.toArray());
     if(name.equals("_-4lU")){calls.add("placement-hook");return null;}
     if(name.equals("_-3Yy")){closed.add("catalog");return null;}
    }
   }
   return super.call(r,name,a);
  }
 }
 static Obj ui21(VM21 vm){
  var ui=makeUi(vm);var changed=new Obj("fixture-ui21");changed.putAll(ui);changed.put("localization",new Obj("fixture-localization"));changed.put("seasonalcurrencyindicator.enabled",true);changed.put("seasonalcurrencyindicator.active","101,104");changed.put("seasonalcurrencyindicator.currency","101,104");changed.put("seasonalcurrency.id.101","stars");changed.put("seasonalcurrency.id.104","letter");return changed;
 }
 @SuppressWarnings("unchecked") static void cleanup21(VM21 vm){
  for(int mode:List.of(0,1,2)){
   vm.statics.put("_modernInfo",mode==0?null:info("effect",77,0));vm.statics.put("_pickLabels",new ArrayList<>(List.of(vm.uiObject("_-2xS::_-Fk"),vm.uiObject("_-2xS::_-Fk"))));
   vm.helper("wiredClosed");vm.helper("endFurniturePicking");vm.helper("endRoomEditors");
   check(vm.statics.get("_modernInfo")==null&&((List<?>)vm.statics.get("_pickLabels")).isEmpty(),"Stale Wired labels remain");
  }
  System.out.println("PASS: Reproduced cleanup paths before/after Wired views, repeated close and room-editor cleanup; no null definition dereference or stale labels survive.");
 }
 @SuppressWarnings("unchecked") static void purse21(VM21 vm)throws Exception{
  var ui=ui21(vm);var catalog=(Obj)ui.get("catalog");var purse=(Obj)catalog.get("purse");purse.put("_-0nU",33);var points=(Map<Integer,Integer>)purse.get("points");for(int i:List.of(1,2,3,4,6,8,101,102,103,104,105))points.put(i,0);points.put(101,42);
  check(vm.helper("activeSeasonalTypes",ui).equals(List.of(101,104)),"Comma-separated active currencies were not parsed");
  var widget=vm.uiObject(vm.rawType(PURSE19));widget.put("_-33k",ui);vm.execute(vm.method(PURSE19,"createView"),widget);var state=(Obj)((Map<?,?>)vm.statics.get("_purseBars")).get(widget);var label=(Obj)state.get("seasonal");
  check(label.get("text").equals("42"),"Primary active seasonal balance incorrect");check(((Obj)((Obj)state.get("seasonalIcon")).get("source")).get("name").equals("purse_seasonal3"),"Stars use an obsolete fish icon");
  var extras=(Map<String,Obj>)state.get("extras");check(extras.size()==1&&extras.containsKey("silver"),"Obsolete points or extra currencies are still displayed");
  check(((Obj)extras.get("silver").get("label")).get("text").equals("…"),"Unknown silver falsely displayed as zero");
  vm.sent.clear();vm.helper("requestCredits",catalog,true);check(vm.sent.size()==2&&vm.sent.get(0).type.equals("loginpatch::CreditsInfoPayload")&&vm.sent.get(1).type.equals("loginpatch::SilverInfoPayload")&&payload(vm,vm.sent.get(1)).isEmpty(),"Missing typed silver query");
  vm.helper("initCurrencyProtocol",3177,920);vm.helper("interceptAccountPacket",new AccountReader(3177,new Packet().i(0).bytes()),((Obj)ui.get("communication")).get("connection"));check(((Obj)extras.get("silver").get("label")).get("text").equals("0"),"Actual zero silver omitted");
  vm.helper("interceptAccountPacket",new AccountReader(3177,new Packet().i(25).bytes()),((Obj)ui.get("communication")).get("connection"));check(((Obj)extras.get("silver").get("label")).get("text").equals("25"),"Silver update not displayed");
  ui.put("seasonalcurrencyindicator.active","103");ui.put("seasonalcurrency.id.103","clouds");points.put(103,9);vm.helper("updateClassicPurse",widget);check(label.get("text").equals("9"),"Changed seasonal configuration ignored");
  vm.helper("clearPurseBar",widget);vm.helper("resetAccountState");System.out.println("PASS: Active list 101,104 parsed as a list; only the primary active seasonal balance and real silver appear; obsolete zero/nonzero points hidden; stars icon, silver query/zero/update and configuration changes verified.");
 }
 static void placement21(VM21 vm)throws Exception{
  var catalog=new Obj(vm.rawType(CATALOG));catalog.put("_-AC",10);catalog.put("_-01a",100);catalog.put("_-0Oh",100000);catalog.put("_-0ce",vm.now);
  var rights=new Obj("room-rights");rights.put("_-0lf",true);rights.put("_-1pT",false);catalog.put("_-22-",rights);catalog.put("_-3ue",rights);var engine=new Obj("fixture-place-engine");catalog.put("_roomEngine",engine);
  for(String furni:List.of("chair","bc_block_0_recolorable"))for(boolean many:List.of(false,true)){
   var offer=colorOffer(vm,furni);vm.set(offer.get("product"),"_-2XU",furni.equals("chair")?"":"18,52,86");vm.execute(vm.method(CATALOG,"_-09A"),catalog,null,offer,"BUILDERS_CLUB",many);
   var args=vm.placements.get(vm.placements.size()-1);check(args.size()==7&&args.get(0).equals("catalog")&&args.get(1).equals(many)&&num(args.get(2))==-29830&&num(args.get(3))==10,"Placement receiver/argument alignment broken");
   check((args.get(6)!=null)==!furni.equals("chair"),"Colour stuff data applied to wrong furniture");check(catalog.get("_-105")==offer&&truth(catalog.get("_-2He")),"Native placement never becomes active");
  }
  var preview=new Obj("placement-preview");preview.put("catalog",catalog);preview.put("_-1Gs",colorOffer(vm,"bc_block_0_recolorable"));vm.set(((Obj)preview.get("_-1Gs")).get("product"),"_-2XU","255,0,0");var buttons=vm.uiObject(vm.rawType(BUTTONS));buttons.put("_-ZD",preview);var one=vm.uiObject("_-2xS::Button");var many=vm.uiObject("_-2xS::Button");buttons.put("_-gb",one);buttons.put("_-3ro",many);
  for(var target:List.of(one,many)){var e=eventFor(target);e.put("target",target);vm.execute(vm.method(BUTTONS,"_-4-u"),buttons,e);}check(vm.closed.size()==2&&vm.placements.size()==6,"Native place-one/place-many button chain failed");
  int before=vm.placements.size();rights.put("_-0lf",false);vm.execute(vm.method(CATALOG,"_-09A"),catalog,null,colorOffer(vm,"chair"),"BUILDERS_CLUB",false);check(vm.placements.size()==before,"Room-owner check bypassed");rights.put("_-0lf",true);catalog.put("_-AC",100);vm.execute(vm.method(CATALOG,"_-09A"),catalog,null,colorOffer(vm,"chair"),"BUILDERS_CLUB",true);check(vm.placements.size()==before,"Membership limit bypassed");
  System.out.println("PASS: Saved native catalog placement method sends all seven arguments to the actual engine receiver for ordinary/recolorable furniture and one/many modes; insertion becomes active and rights/limit checks remain enforced.");
 }
 @SuppressWarnings("unchecked") static void swatches21(VM21 vm)throws Exception{
  var content=vm.uiObject(vm.rawType(PatchFeatures20.PREVIEW_BASE));var host=vm.uiObject("_-2xS::LayoutGroup");host.put("height",640);var image=vm.uiObject(vm.rawType(PatchFeatures20.PREVIEW_IMAGE));image.put("width",420);image.put("height",380);image.put("layoutData",vm.uiObject("_-0iC::_-BX"));vm.call(image,"addChild",List.of(vm.construct("starling.display::Quad",List.of(420,380,0xffffff))));vm.call(image,"addChild",List.of(vm.uiObject("_-2xS::_-1aX")));var preview=new Obj("color-preview");preview.put("catalog",new Obj("palette-config"));preview.put("roomEngine",new Obj("fixture-color-engine"));image.put("_-ZD",preview);vm.call(host,"addChild",List.of(image));var offer=colorOffer(vm,"bc_block_0_recolorable");
  vm.helper("showFurniturePalette",content,host,image,preview,offer);var st=(Obj)((Map<?,?>)vm.statics.get("_recolorViews")).get(content);var rows=(List<Obj>)st.get("buttons");check(rows.size()==69&&number(((Obj)st.get("panel")).get("width"))>600,"Palette not wider");
  for(var row:rows){var b=(Obj)row.get("button");var skin=(Obj)row.get("skin");var lateTheme=new Obj("fixture-green-theme");lateTheme.put("skin",vm.display("starling.display::Quad"));vm.set(b,"stateToSkinFunction",new Bound(lateTheme,"updateValue"));var listener=(Bound)b.get("listener:addedToStage");check(listener!=null,"No post-initialization swatch hook");vm.call(listener.receiver(),listener.name(),List.of(eventFor(b)));for(String state:List.of("up","down")){b.put("_-R-",state);vm.execute(vm.method(vm.raw.get(b.type).logical(),"_-39g"),b);check(b.get("_-1tm")==skin,"Native button renders green theme instead of custom colour");}var face=(Obj)((List<?>)skin.get("children")).get(0);check(num(face.get("color"))==num(row.get("color")),"Swatch colour differs from actual palette");}
  for(int[] dims:List.of(new int[]{1536,709},new int[]{2400,1080},new int[]{960,540})){vm.stage.put("stageWidth",dims[0]);vm.stage.put("stageHeight",dims[1]);host.put("height",dims[1]-60);vm.helper("layoutFurniturePalette",content);var panel=(Obj)st.get("panel");check(number(panel.get("x"))+number(panel.get("width"))<=dims[0]*.55&&number(panel.get("y"))+number(panel.get("height"))<dims[1],"Palette clips outside viewport");}
  vm.helper("chooseFurnitureColor",eventFor((Obj)rows.get(50).get("button")));check(vm.get(offer.get("product"),"_-2XU").equals(vm.helper("recolorRGB",rows.get(50).get("color"))),"Colour choice no longer reaches placement");vm.helper("clearFurniturePalette",content);vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);
  System.out.println("PASS: All 69 swatches render their RGB faces through the saved native button skin selector in up/down states, without the green theme; wider palette fits three viewports, scrolls and updates the placement colour.");
 }
 static void languages21(VM21 vm)throws Exception{
  var controller=new Obj("fixture-login-controller19");controller.put("localization",new Obj("fixture-localization"));
  for(String lang:List.of("en","de","fr","es","it","nl","fi","tr","pt")){
   vm.helper("selectHotelLanguage",controller,lang);String caption=String.valueOf(vm.helper("localText","Entrar com código"));check(lang.equals("pt")==caption.equals("Entrar com código"),"Login remains Portuguese in "+lang);
   check(lang.equals("pt")==String.valueOf(vm.helper("localText","Cor do mobi")).equals("Cor do mobi"),"Colour picker remains Portuguese in "+lang);
   if(!lang.equals("pt"))check(!vm.helper("localText","Lucros").equals("Lucros"),"Earnings remains Portuguese in "+lang);
   var translated=vm.helper("tr","wiredfurni.params.action.sign.1","");var dictionaries=(Obj)vm.call(new Ref("loginpatch::LocaleData21"),"wired",List.of(lang));check(Objects.equals(translated,dictionaries.get("wiredfurni.params.action.sign.1")),"Wired ignores selected hotel language");
  }
  System.out.println("PASS: Login, palette, Earnings and official Wired captions switch across all nine hotels, including return to Portuguese.");
 }
 static void reproduce20()throws Exception{
  var old=new VM21(new SWF(new FileInputStream("work/base20.swf"),false));old.statics.put("_modernInfo",null);old.statics.put("_pickLabels",new ArrayList<>(List.of(old.uiObject("_-2xS::_-Fk"))));boolean failed=false;
  try{old.helper("endFurniturePicking");}catch(NullPointerException e){failed=true;}check(failed,"Teste20 cleanup failure no longer reproduced");
  failed=false;try{placement21(old);}catch(AssertionError e){check(e.getMessage().contains("_-1Tl"),"Unexpected Teste20 placement failure: "+e.getMessage());failed=true;}check(failed,"Teste20 wrong placement receiver no longer reproduced");
  System.out.println("PASS: Teste20 baseline reproduces both the null Wired cleanup and misaligned placement receiver before applying the fixes.");
 }
 public static void main(String[]a)throws Exception{
  reproduce20();var s=new SWF(new FileInputStream(a[0]),false);var vm=new VM21(s);cleanup21(vm);placement21(vm);purse21(vm);swatches21(vm);languages21(vm);
  var prior=new VM21(s);login20(prior);palette20(prior);wired20(prior);
  var plus=new SWF(new FileInputStream("work/plus.swf"),false);var kept=new VM21(s);verifyHeads(kept);verifyEarnings(kept);verifyMenu(s);outline(kept);events(kept);catalog(kept);income(kept,plus);regression(s,plus);
 }
}

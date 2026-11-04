import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures13 extends VerifyFeatures12 {
 static class ASDictionary extends AbstractMap<Object,Object> {
  final Map<Object,Object> objects=new IdentityHashMap<>(),values=new LinkedHashMap<>();
  Map<Object,Object> map(Object k){return k instanceof Obj?objects:values;}
  public Object get(Object k){return map(k).get(k);} public Object put(Object k,Object v){return map(k).put(k,v);}
  public Object remove(Object k){return map(k).remove(k);}
  public Set<Entry<Object,Object>> entrySet(){return new AbstractSet<Entry<Object,Object>>(){public int size(){return objects.size()+values.size();}public Iterator<Entry<Object,Object>> iterator(){var out=new ArrayList<Entry<Object,Object>>(objects.entrySet());out.addAll(values.entrySet());return out.iterator();}};}
 }
 static class EditorVM extends FeaturesVM {
  final Obj engine=new Obj("room-engine-double"),canvas=new Obj("canvas-double"),geometry=new Obj("geometry-double"),floor=new Obj("floor-double");
  final Map<Integer,Obj> furniture=new LinkedHashMap<>();final List<List<Object>> popups=new ArrayList<>();
  final List<List<Object>> updates=new ArrayList<>();Obj probe;
  EditorVM(SWF s){super(s);engine.put("_-0Y",12345);canvas.put("disposed",false);canvas.put("roomEngine",engine);canvas.put("width",1440);canvas.put("height",720);canvas.put("_-1Gf",720);canvas.put("_-1cn",360);canvas.put("geometry",geometry);geometry.put("_-9l",1);canvas.put("canvas",display("starling.display::Sprite"));canvas.put("_-2ne",display("starling.display::Sprite"));canvas.put("roomObject",new Obj("room-object-double"));statics.put("_roomEngine",engine);statics.put("_roomCanvas",canvas);}
  boolean scene(String t){return t.startsWith("starling.display::");}
  Obj display(String t){check(raw.containsKey(t),"Missing display class "+t);var o=new Obj(t);o.put("children",new ArrayList<>());o.put("x",0);o.put("y",0);o.put("width",0);o.put("height",0);o.put("visible",true);o.put("touchable",true);return o;}
  void valid(Obj o,Object k){if(scene(o.type)||ui(o.type))check(prop(o.type,String.valueOf(k)),"Invalid native property "+o.type+"."+k);}
  @Override Object lexical(Method m,Obj self,String n,int i){if(n.equals("Timer"))return new Ref("Timer");return super.lexical(m,self,n,i);}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("Dictionary"))return new ASDictionary();
   if(scene(t)){var o=display(t);if(t.endsWith("::Quad")){o.put("width",a.get(0));o.put("height",a.get(1));o.put("color",a.size()>2?a.get(2):0xffffff);}return o;}
   if(t.equals("flash.geom::Point")||t.equals("flash.geom::Matrix")||t.equals("_-0AB::Vector3d")){var o=new Obj(t);if(t.endsWith("Matrix")){o.put("matrix",new ArrayList<>(a));}else{for(int j=0;j<3;j++)o.put(List.of("x","y","z").get(j),a.size()>j?a.get(j):0);}return o;}
   if(t.equals("Timer")){var o=new Obj("fixture-timer");o.put("interval",a.get(0));o.put("running",false);return o;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o){
    if(o.type.equals("_-0AB::Vector3d") && Set.of("x","y","z").contains(k))return o.get(k);
    if(o==canvas){check(prop(rawType("com.sulake.room.renderer:RoomSpriteCanvas3d"),String.valueOf(k)),"Invalid canvas API "+k);return o.containsKey(k)?o.get(k):new Bound(o,String.valueOf(k));}
    if(o==engine){check(prop(rawType("com.sulake.habbo.room:RoomEngine"),String.valueOf(k)),"Invalid engine API "+k);return o.containsKey(k)?o.get(k):new Bound(o,String.valueOf(k));}
    if(o.type.equals("floor-logic-double") && k.equals("_-329"))return new Bound(o,"_-329");
    if(o==geometry || o==floor)return o.containsKey(k)?o.get(k):new Bound(o,String.valueOf(k));
    if(scene(o.type)){valid(o,k);return o.get(k);}
    if(ui(o.type)&&k.equals("textEditorProperties")){valid(o,k);return o.computeIfAbsent(k,x->new Obj("editor-properties"));}
   }
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object v){if(r instanceof Obj o)valid(o,k);super.set(r,k,v);}
  @SuppressWarnings("unchecked") Object child(Obj o,String n,List<Object>a){
   valid(o,n);var children=(List<Object>)o.get("children");
   if(n.equals("addChild")||n.equals("addChildAt")){var c=(Obj)a.get(0);Object old=c.get("parent");if(old instanceof Obj p)((List<Object>)p.get("children")).remove(c);if(n.equals("addChildAt"))children.add(num(a.get(1)),c);else children.add(c);c.put("parent",o);if(scene(o.type)){double x=((Number)c.getOrDefault("x",0)).doubleValue(),y=((Number)c.getOrDefault("y",0)).doubleValue();o.put("width",Math.max(((Number)o.getOrDefault("width",0)).doubleValue(),x+((Number)c.getOrDefault("width",0)).doubleValue()));o.put("height",Math.max(((Number)o.getOrDefault("height",0)).doubleValue(),y+((Number)c.getOrDefault("height",0)).doubleValue()));}return c;}
   if(n.equals("removeFromParent")){if(o.get("parent") instanceof Obj p)((List<Object>)p.get("children")).remove(o);o.put("parent",null);return null;}
   if(n.equals("removeChildren")){children.clear();return null;}
   if(n.equals("addEventListener")){check(a.get(1) instanceof Bound,"Unbound callback "+a);o.put("listener:"+a.get(0),a.get(1));return null;}
   if(n.equals("globalToLocal")){var p=(Obj)a.get(0);var q=new Obj("flash.geom::Point");q.put("x",((Number)p.get("x")).doubleValue()-100);q.put("y",((Number)p.get("y")).doubleValue()-50);return q;}
   if(n.equals("dispatchEventWith")){var b=(Bound)o.get("listener:"+a.get(0));return call(b.receiver(),b.name(),List.of(new Obj("event-double")));}
   throw new AssertionError("Unhandled display/UI method "+n);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof List list&&n.equals("shift"))return list.isEmpty()?null:list.remove(0);
   if(n.equals("getDefinitionByName")&&Set.of("flash.geom::Point","flash.geom::Matrix").contains(String.valueOf(a.get(0))))return new Ref(String.valueOf(a.get(0)));
   if(r instanceof Number x&&n.equals("toFixed"))return String.format(Locale.ROOT,"%."+num(a.get(0))+"f",x.doubleValue());
   if(r instanceof String s&&n.equals("charAt"))return String.valueOf(s.charAt(num(a.get(0))));
   if(r instanceof Ref ref){
    if(ref.name().equals("Math")&&n.equals("abs"))return Math.abs(((Number)a.get(0)).doubleValue());
    if(ref.name().equals("_-2YJ::_-0iF")&&n.equals("_-4fM")){var o=uiObject("_-2xS::LayoutGroup");o.put("layout",uiObject("_-0iC::_-0q9"));return o;}
    if(ref.name().equals("_-u8::_-1OE")&&(n.equals("_-3Dk")||n.equals("_-4gZ"))){popups.add(new ArrayList<>(a));calls.add(n);return null;}
   }
   if(r instanceof Obj o){
    if((scene(o.type)||ui(o.type))&&Set.of("addChild","addChildAt","removeFromParent","removeChildren","addEventListener","globalToLocal","dispatchEventWith").contains(n))return child(o,n,a);
    if(o==engine){
     check(prop(rawType("com.sulake.habbo.room:RoomEngine"),n),"Invalid engine method "+n);
     switch(n){case "_-2vx":return num(a.get(1))==10?furniture.size():0;case "_-2Fe":return new ArrayList<>(furniture.values()).get(num(a.get(1)));case "_-2J-":return floor;case "_-46h":return furniture.get(num(a.get(1)));case "_-2Zf":calls.add("end-move-context");return null;case "_-0ex":{updates.add(new ArrayList<>(a));var obj=furniture.get(num(a.get(1)));obj.put("location",a.get(2));return true;}default:throw new AssertionError("Unhandled engine API "+n);}
    }
    if(o==geometry){check(prop(rawType("com.sulake.room.utils:RoomGeometry"),n),"Invalid geometry API "+n);if(n.equals("_-49b")){var v=(Obj)a.get(0);double x=((Number)v.get("x")).doubleValue(),y=((Number)v.get("y")).doubleValue(),z=((Number)v.get("z")).doubleValue();var p=new Obj("flash.geom::Point");p.put("x",(x-y)*32);p.put("y",(x+y)*16-z*32);return p;}}
    if(o==floor&&n.equals("_-4-t"))return num(a.get(0))==4&&num(a.get(1))==4?-1:0;
    if(o.type.equals("room-object-double")&&n.equals("getEventHandler"))return new Obj("floor-logic-double");
    if(o.type.equals("floor-logic-double")&&n.equals("_-329")){check(prop(rawType("com.sulake.habbo.room.object.logic.room:RoomLogic"),n),"Invalid floor probe");if(probe!=null)helper("areaTileHit",probe.get("x"),probe.get("y"),0,a.get(2));return probe!=null;}
    if(o.type.equals("furni-double"))return switch(n){case "getId"->o.get("id");case "getType"->o.get("furnitype");case "getLocation"->o.get("location");case "getDirection"->o.get("direction");case "getModel","getModelController"->o.get("model");default->super.call(r,n,a);};
    if(o.type.equals("model-double")){if(n.equals("getNumber"))return o.get(a.get(0));if(n.equals("setNumber")){o.put(a.get(0),a.get(1));return null;}}
    if(o.type.equals("touch-event-double")){if(n.equals("stopImmediatePropagation")){o.put("stopped",true);return null;}if(n.equals("getTouch"))return o.get("touch");}
    if(o.type.equals("touch-double")&&n.equals("getLocation"))return o.get("location");
   }
   return super.call(r,n,a);
  }
  Obj furni(int id,String type,double z,double alpha){var obj=new Obj("furni-double");obj.put("id",id);obj.put("furnitype",type);obj.put("location",construct("_-0AB::Vector3d",List.of(3,5,z)));obj.put("direction",construct("_-0AB::Vector3d",List.of(0,0,0)));var m=new Obj("model-double");m.put("furniture_alpha_multiplier",alpha);obj.put("model",m);furniture.put(id,obj);return obj;}
  double height(int id){return ((Number)((Obj)furniture.get(id).get("location")).get("z")).doubleValue();}
 }
 static void eq(double a,double b,String why){check(Math.abs(a-b)<0.00001,why+": "+a+" != "+b);}
 static Obj event(String phase,int id){var touch=new Obj("touch-double");touch.put("phase",phase);touch.put("id",id);touch.put("globalX",800);touch.put("globalY",500);var e=new Obj("touch-event-double");e.put("touch",touch);return e;}
 static void testLiveHeight(EditorVM vm)throws Exception{
  var conn=new Obj("fixture-connection");vm.statics.put("_activeConnection",conn);var obj=vm.furni(12345678,"tile_stackmagic",2.37,1);var logic=new Obj("logic");logic.put("object",obj);
  check(Boolean.TRUE.equals(vm.helper("openStackHeight",logic)),"Tile did not open");check(vm.calls.contains("end-move-context"),"Move context still can restore original Z");
  check(vm.popups.get(vm.popups.size()-1).subList(1,3).equals(List.of(false,false)),"Height panel is modal or centered");
  var field=(Obj)vm.statics.get("_heightField");check(field.get("text").equals("2.37"),"Initial decimal height lost: "+field.get("text"));
  field.put("text","4.22");vm.helper("heightTextChanged",(Object)null);eq(vm.height(12345678),4.22,"Typed height not previewed");vm.helper("flushHeight",(Object)null);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,422)),"Decimal units wrong");
  field.put("text","5,47");vm.helper("heightTextChanged",(Object)null);eq(vm.height(12345678),5.47,"Comma decimal not accepted");vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(422).bytes()));eq(vm.height(12345678),5.47,"Stale ACK overwrote preview");check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,547)),"Pending height not coalesced after ACK");
  vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(547).bytes()));check(field.get("text").equals("5.47"),"Server height not reflected");
  int before=vm.sent.size();field.put("text",".");vm.helper("heightTextChanged",(Object)null);vm.helper("flushHeight",(Object)null);check(vm.sent.size()==before,"Incomplete decimal sent");field.put("text","81");vm.helper("heightTextChanged",(Object)null);eq(vm.height(12345678),5.47,"Out of range preview accepted");field.put("text","5.47");
  var ruler=(Obj)vm.statics.get("_heightRuler");var drag=event("ended",9);var touch=(Obj)drag.get("touch");var location=new Obj("point");location.put("x",20);location.put("y",((Number)ruler.get("height")).doubleValue()/2);touch.put("location",location);vm.helper("heightRulerTouch",drag);eq(vm.height(12345678),5,"Ruler drag did not preview height");vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(500).bytes()));
  field.put("text","6.11");vm.helper("heightTextChanged",(Object)null);vm.helper("flushHeight",(Object)null);vm.now+=700;field.put("text","6.22");vm.helper("heightTextChanged",(Object)null);vm.helper("flushHeight",(Object)null);vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(611).bytes()));eq(vm.height(12345678),6.22,"Delayed ACK after send timeout undid newest height");vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(622).bytes()));
  vm.helper("heightFocusIn",(Object)null);field.put("text","6.");vm.helper("heightTextChanged",(Object)null);vm.helper("flushHeight",(Object)null);vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(600).bytes()));check(field.get("text").equals("6."),"ACK rewrote an unfinished decimal while typing");field.put("text","6.25");vm.helper("heightTextChanged",(Object)null);vm.helper("flushHeight",(Object)null);vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(625).bytes()));vm.helper("heightFocusOut",(Object)null);check(field.get("text").equals("6.25"),"Blur failed to normalize decimal");
  vm.helper("floorHeight",(Object)null);eq(vm.height(12345678),0,"Floor did not update live");vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(0).bytes()));
  vm.helper("aboveHeight",(Object)null);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,-100)),"Stack-top sentinel wrong");vm.helper("closeHeight",(Object)null);vm.helper("receiveStackHeight",new Reader(new Packet().i(12345678).i(722).bytes()));eq(vm.height(12345678),7.22,"Stack-top response did not move tile after editor close");
  vm.helper("closeHeight",(Object)null);eq(vm.height(12345678),7.22,"Closing editor restored floor");check(vm.statics.get("_heightPopup")==null,"Popup not removed");
  System.out.println("PASS: Nonmodal side height editor accepts dot/comma, previews exact hundredths, reconciles/coalesces ACKs, rejects invalid values, floor/top work, and closing retains tile Z.");
 }
 @SuppressWarnings("unchecked") static void testArea(EditorVM vm){
  vm.furni(1,"chair",0,0.6);vm.furni(2,"table",0,1);var info=info("selector",23,7);info.put("ints",new ArrayList<>(List.of(1,2,3,4)));vm.statics.put("_modernInfo",info);vm.statics.put("_editorRoom",12345);
  vm.helper("beginArea",vm.uiObject("_-2xS::LayoutGroup"));eq(((Number)((Obj)vm.furniture.get(1).get("model")).get("furniture_alpha_multiplier")).doubleValue(),0.072,"Furniture not ghosted");
  var layer=(Obj)vm.statics.get("_areaLayer");check(!((List<?>)layer.get("children")).isEmpty(),"Saved area not drawn");
  vm.helper("startArea",(Object)null);vm.probe=new Obj("hit");vm.probe.put("x",6);vm.probe.put("y",8);var e=event("began",3);vm.helper("areaTouch",e);check(Boolean.TRUE.equals(e.get("stopped")),"Area drag leaks to room gestures");
  vm.probe.put("x",2);vm.probe.put("y",3);vm.helper("areaTouch",event("moved",3));check(((List<?>)info.get("ints")).stream().map(VerifyStartupCompatibility::num).toList().equals(List.of(2,3,5,6)),"Reverse drag failed inclusive rectangle: "+info.get("ints"));
  vm.helper("areaTouch",event("ended",3));check(Boolean.FALSE.equals(vm.statics.get("_areaSelecting")),"Selection did not finish");check(((List<?>)layer.get("children")).size()==29,"Floor highlight did not skip hole");
  check(Boolean.FALSE.equals(((Obj)vm.statics.get("_areaShield")).get("touchable")),"Room remained blocked after selection");
  vm.furni(3,"new chair",0,1);vm.now+=300;vm.helper("ghostFurniture");eq(((Number)((Obj)vm.furniture.get(3).get("model")).get("furniture_alpha_multiplier")).doubleValue(),0.12,"New furniture not ghosted");
  vm.helper("clearArea",(Object)null);check(info.get("ints").equals(List.of(0,0,0,0)),"Clear did not reset selection");
  vm.helper("endArea");eq(((Number)((Obj)vm.furniture.get(1).get("model")).get("furniture_alpha_multiplier")).doubleValue(),0.6,"Original opacity not restored");eq(((Number)((Obj)vm.furniture.get(3).get("model")).get("furniture_alpha_multiplier")).doubleValue(),1,"New object opacity not restored");
  System.out.println("PASS: Area editor fades existing/new furniture, probes native floor planes, consumes drag without walking, draws per-tile highlight excluding holes, supports reverse drags/clear, and restores original opacity.");
 }
 @SuppressWarnings("unchecked") static void testLabels(EditorVM vm){
  var schema=(Map<String,Obj>)vm.statics.get("_wiredSchema");
  for(String key:List.of("trigger:16","condition:32","selector:9")){
   var desc=(Obj)((List<?>)schema.get(key).get("params")).get(0);var options=(List<Obj>)desc.get("options");check(options.size()==11,"Missing actions "+key);
   for(var o:options){String label=String.valueOf(vm.helper("tr",o.get("label"),""));check(!label.contains("${")&&!label.matches("\\d+"),"Unresolved action label "+label);}
  }
  check(vm.helper("tr","wiredfurni.params.action.0","").equals("Acenar"),"Wrong wave translation");check(vm.helper("tr","wiredfurni.params.action.1","").equals("Mandar um beijo"),"Wrong blow translation");
  check(((List<?>)vm.helper("actionExtraOptions",10)).size()==19&&((List<?>)vm.helper("actionExtraOptions",11)).size()==5,"Sign/dance filters absent");
  System.out.println("PASS: Trigger, condition and selector action lists use localized names with exact 0–11 wire ids; all sign/dance extra filters have named options and protocol values.");
 }
 @SuppressWarnings("unchecked") static void testActionChanges(EditorVM vm){
  for(String key:List.of("trigger:16","condition:32","selector:9")){
   var parts=key.split(":");var info=info(parts[0],98765,Integer.parseInt(parts[1]));info.put("ints",new ArrayList<>(List.of(0)));info.put("variables",new ArrayList<>());vm.statics.put("_pendingWired",info);((Map<Object,Object>)vm.statics.get("_wiredById")).put(info.get("id"),info);
   var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,parts[0]));var service=new Obj("fixture-service");service.put("localization",new Obj("fixture-localization"));var ed=new Obj("fixture-editor");
   vm.helper("modernWired",data,service,vm.uiObject("_-2xS::_-4Mu"),vm.uiObject("_-2xS::Button"),null,ed);
   var picker=(Obj)vm.statics.get("_actionPicker");picker.put("selectedIndex",9);vm.helper("actionChanged",(Object)null);var extra=(Obj)vm.statics.get("_actionExtra");extra.put("selectedIndex",18);vm.helper("saveModernWired");check(num(((List<?>)info.get("ints")).get(0))==10&&info.get("text").equals("17"),"Sign selection encoded incorrectly: "+key);
   picker.put("selectedIndex",10);vm.helper("actionChanged",(Object)null);extra.put("selectedIndex",2);vm.helper("saveModernWired");check(num(((List<?>)info.get("ints")).get(0))==11&&info.get("text").equals("dance 2"),"Dance selection encoded incorrectly: "+key);
   picker.put("selectedIndex",1);vm.helper("actionChanged",(Object)null);vm.helper("saveModernWired");check(num(((List<?>)info.get("ints")).get(0))==1&&info.get("text").equals(""),"Changing to blow retained incompatible extra: "+key);
   vm.helper("wiredClosed");
  }
  System.out.println("PASS: Actual action pickers change between signs, dances and ordinary actions, save exact extra strings, clear incompatible extras, and keep all three Wired categories distinct.");
 }
 static void testPanel(EditorVM vm){
  var content=vm.uiObject("_-2xS::LayoutGroup");vm.statics.put("_modernContent",content);var save=vm.uiObject("_-2xS::Button");save.put("listener:triggered",new Bound(vm.statics,"panelSaveDouble"));
  vm.helper("presentWiredPanel",content,save);check(vm.popups.get(vm.popups.size()-1).subList(1,3).equals(List.of(false,false)),"Wired panel blocks/dims room");
  var ev=new Obj("event");ev.put("type","WIRED_OPEN_REQUEST");check(Boolean.TRUE.equals(vm.helper("wiredUiEvent",ev)),"Native fullscreen Wired screen not intercepted");ev.put("type","WIRED_OPEN_STUFF_SELECTOR_REQUEST");check(Boolean.FALSE.equals(vm.helper("wiredUiEvent",ev)),"Native furni selector blocked");check(Boolean.FALSE.equals(((Obj)vm.statics.get("_wiredPopup")).get("visible")),"Panel hides furniture selector");
  vm.helper("wiredClosed");check(vm.statics.get("_wiredPopup")==null&&vm.statics.get("_modernInfo")==null,"Close leaked Wired state");
  System.out.println("PASS: Wired side panel keeps room desktop active, uses no modal overlay, yields to native furniture selection and cleans up on close.");
 }
 public static void main(String[]a)throws Exception{
  var swf=new SWF(new FileInputStream(a[0]),false);var vm=new EditorVM(swf);var oracle=new WiredVM(new SWF(new FileInputStream("work/plus.swf"),false));
  testNewWire(vm,oracle);testDefinitions(vm,oracle);testLabels(vm);testArea(vm);testLiveHeight(vm);testPanel(vm);testActionChanges(vm);
  // Generic schema regression uses the actual UI bytecode and validates all
  // old native property names, with room/editor services supplied as doubles.
  vm.statics.put("_roomCanvas",null);vm.statics.put("_roomEngine",null);testEditors(vm);testContext(vm);
 }
}

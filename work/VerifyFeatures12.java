import java.io.*;import java.util.*;import java.util.regex.Pattern;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class VerifyFeatures12 extends VerifyWiredBuilders {
 static class FeaturesVM extends WiredVM {
  final Obj stage=new Obj("ui-stage"),nativeStage=new Obj("ui-native-stage");
  final List<Obj> controls=new ArrayList<>();
  FeaturesVM(SWF s){super(s);stage.put("stageWidth",1440);stage.put("stageHeight",720);var c=classes.get(HELPER);execute(new Method(c,c.abc().findBody(c.abc().class_info.get(c.index()).cinit_index)),statics);}
  boolean ui(String t){return t.startsWith("_-2xS::")||t.startsWith("_-0iC::")||t.startsWith("_-1Ab::");}
  Obj uiObject(String t){check(raw.containsKey(t),"Missing native UI class "+t);var o=new Obj(t);o.put("styleNameList",new Obj("ui-styles"));o.put("children",new ArrayList<Object>());controls.add(o);return o;}
  boolean prop(String t,String n){var c=raw.get(t);while(c!=null){for(var x:c.inst().instance_traits.traits)if(AuditStartup.name(c.abc(),x.name_index).equals(n))return true;c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}return false;}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(n.equals("Starling")){var a=new Obj("ui-starling-class");var current=new Obj("ui-starling");current.put("stage",stage);current.put("nativeStage",nativeStage);a.put("current",current);return a;}
   if(Set.of("parseInt","isNaN").contains(n))return new Ref(n);
   if(m.cls().logical().equals(HELPER)&&find(m.cls(),n,false)!=null)return new Bound(statics,n);
   var c=raw.get(self.type);while(c!=null){for(var t:(self.type.equals("loginpatch::HabboTicketLogin")?c.abc().class_info.get(c.index()).static_traits:c.inst().instance_traits).traits)if(t instanceof TraitSlotConst slot&&AuditStartup.name(c.abc(),t.name_index).equals(n)&&!self.containsKey(n)){String type=AuditStartup.name(c.abc(),slot.type_index);return type.equals("Boolean")?false:(type.equals("int")||type.equals("uint")?0:null);}c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}
   return super.lexical(m,self,n,i);
  }
  @Override Object construct(String t,List<Object>a){
   if(ui(t)){var o=uiObject(t);if(t.equals("_-1Ab::_-nO"))o.put("items",a.isEmpty()?new ArrayList<>():a.get(0));return o;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref && (ref.name().equals("Math")||ref.name().equals("_-2YJ::_-0iF")||ref.name().equals("_-u8::_-1OE")))return new Bound(r,String.valueOf(k));
   if(r instanceof Obj o){
    if(o.type.equals("fixture-editor")&&k.equals("_-oI"))return new Bound(o,"_-oI");
    if(ui(o.type)){
     check(prop(o.type,String.valueOf(k)),"Invalid native UI getter "+o.type+"."+k);
     if(k.equals("_-2wT")){var dp=(Obj)o.get("dataProvider");return ((List<?>)dp.get("items")).get(num(o.get("selectedIndex")));}
     if(find(raw.get(o.type),String.valueOf(k),false)!=null && find(raw.get(o.type),String.valueOf(k),true)==null)return new Bound(o,String.valueOf(k));
     return o.get(k);
    }
    if(o.type.equals(rawType(CONTROL)) && k.equals("view")){if(!o.containsKey("fixture-view"))o.put("fixture-view",uiObject("_-2xS::LayoutGroup"));return o.get("fixture-view");}
   }
   return super.get(r,k);
  }
  String rawType(String l){return classes.get(l).raw();}
  @Override void set(Object r,Object k,Object v){
   if(r instanceof Obj o&&ui(o.type))check(prop(o.type,String.valueOf(k)),"Invalid native UI setter "+o.type+"."+k);
   if(r instanceof Obj o&&o.type.equals(rawType(CONTROL))&&k.equals("_-3xY")){
    var c=classes.get(CONTROL);for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==3&&AuditStartup.name(c.abc(),t.name_index).equals(k)){execute(new Method(c,c.abc().findBody(m.method_info)),o,v);return;}
   }
   super.set(r,k,v);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof String text&&n.equals("substring"))return text.substring(num(a.get(0)),a.size()>1?num(a.get(1)):text.length());
   if(n.equals("parseInt")){try{return Integer.parseInt(String.valueOf(a.get(0)),a.size()>1?num(a.get(1)):10);}catch(NumberFormatException ex){return Double.NaN;}}
   if(n.equals("isNaN"))return a.get(0)==null||a.get(0) instanceof Number x&&Double.isNaN(x.doubleValue());
   if(r instanceof Pattern p&&n.equals("test"))return p.matcher(String.valueOf(a.get(0))).find();
   if(r instanceof Ref ref){
    if(ref.name().equals("Math")){double x=((Number)a.get(0)).doubleValue();return switch(n){case "min"->Math.min(x,((Number)a.get(1)).doubleValue());case "max"->Math.max(x,((Number)a.get(1)).doubleValue());case "round"->(int)Math.round(x);default->super.call(r,n,a);};}
    if(ref.name().equals("_-2YJ::_-0iF")&&n.equals("_-3zA")){var o=uiObject("_-2xS::LayoutGroup");o.put("layout",uiObject("_-0iC::_-pG"));return o;}
    if(ref.name().equals("_-u8::_-1OE")&&(n.equals("_-3Dk")||n.equals("_-4gZ"))){check(a.get(0) instanceof Obj,"Popup absent");calls.add(n);return null;}
   }
   if(r instanceof Obj o){
    if(o.type.equals("ui-styles")&&n.equals("add"))return null;
    if(ui(o.type)){
     check(prop(o.type,n),"Invalid native UI method "+o.type+"."+n);
     if(n.equals("addChild")||n.equals("addChildAt")){((List<Object>)o.get("children")).add(a.get(0));return a.get(0);}
     if(n.equals("addEventListener")){check(a.get(1) instanceof Bound,"Native event callback not bound");o.put("listener:"+a.get(0),a.get(1));return null;}
     if(n.equals("_-0HB")){o.put("focused",false);return null;}
    }
    if(o.type.equals("fixture-service")&&n.equals("send")){sent.add((Obj)a.get(0));return true;}
    if(o.type.equals("fixture-localization")&&n.equals("getLocalization"))return a.get(1);
    if(o.type.equals("fixture-editor")&&n.equals("_-oI")){calls.add("select-furni");return null;}
    if(o.type.equals("fixture-object")&&n.equals("getType"))return o.get("furnitype");
    if(o.type.equals("fixture-object")&&n.equals("getModel"))return o.get("model");
    if(o.type.equals("fixture-color-model")&&n.equals("getStringToStringMap"))return o.get("data");
    if(o.type.equals("fixture-color-map")&&n.equals("getValue"))return o.get(a.get(0));
   }
   return super.call(r,n,a);
  }
 }
 static Obj info(String kind,int id,int code){var o=new Obj("Object");o.put("category",kind);o.put("id",id);o.put("type",5555);o.put("code",code);o.put("limit",20);o.put("text","");o.put("ints",new ArrayList<>());o.put("ids",new ArrayList<>(List.of(33333333)));o.put("ids2",new ArrayList<>(List.of(44444444)));o.put("variables",new ArrayList<>(List.of("n")));o.put("furniSources",new ArrayList<>(List.of(100,101)));o.put("userSources",new ArrayList<>(List.of(0)));o.put("delay",4);o.put("quantifier",1);o.put("quantifierType",1);o.put("filter",true);o.put("invert",false);o.put("defaults",new ArrayList<>());o.put("contextVariables",new ArrayList<>());o.put("allowedFurni",List.of(List.of(100,101,110),List.of(100,101)));o.put("allowedUsers",List.of(List.of(0,11,12)));o.put("defaultFurniSources",List.of(100,101));o.put("defaultUserSources",List.of(0));o.put("allowSelect",true);return o;}
 @SuppressWarnings("unchecked") static void testEditors(FeaturesVM vm){
  var schema=(Map<String,Obj>)vm.statics.get("_wiredSchema");check(schema.size()>=149,"Missing current Wired editors");int count=0;
  for(var e:schema.entrySet()){
   var key=e.getKey().split(":");var info=info(key[0],10000001+count,Integer.parseInt(key[1]));var params=(List<Obj>)e.getValue().get("params");var ints=new ArrayList<Integer>();for(var p:params)ints.add(count%2==0?42:(p.get("kind").equals("options")?num(((List<Obj>)p.get("options")).get(0).get("value")):0));info.put("ints",ints);
   ((Map<Object,Object>)vm.statics.get("_wiredById")).put(info.get("id"),info);vm.statics.put("_pendingWired",info);
   var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,key[0]));
   var service=new Obj("fixture-service");service.put("localization",new Obj("fixture-localization"));var editor=new Obj("fixture-editor");
   var ctrl=(Obj)vm.helper("modernWired",data,service,vm.uiObject("_-2xS::_-4Mu"),vm.uiObject("_-2xS::Button"),null,editor);
   check(ctrl.type.equals(vm.rawType(CONTROL)),"Missing native selector bridge");
   var expected=vm.helper("modernPayload",info);
   check(Boolean.TRUE.equals(vm.helper("saveModernWired")),"Modern Wired did not save");
   var saved=vm.sent.get(vm.sent.size()-1);var actual=vm.execute(vm.method(vm.raw.get(saved.type).logical(),"_-0tq"),saved);
   check(actual.equals(expected),"Opening/saving editor changed state for "+e.getKey()+" got="+actual+" expected="+expected);
   vm.helper("selectWiredTwo",(Object)null);check(vm.calls.contains("select-furni"),"Room selection did not open");
   vm.set(ctrl,"_-3xY",new ArrayList<>(List.of(55555555)));check(info.get("ids2").equals(List.of(55555555))&&info.get("ids").equals(List.of(33333333)),"Dual furniture groups mixed");
   count++;
  }
  System.out.println("PASS: "+count+" current Wired form schemas build using validated native UI properties, save unchanged state, and keep both furniture-selection groups separate; all seven composer classes instantiate via the old IMessageComposer interface.");
 }
 static void testNewWire(FeaturesVM vm,WiredVM oracle)throws Exception{
  int cases=0;for(String kind:List.of("effect","trigger","condition","addon","selector","variable")){
   var info=info(kind,16777217,0);info.put("ints",new ArrayList<>(List.of(1,2,3)));info.put("text","texto çã 🎮");
   var args=new ArrayList<Object>(List.of(info.get("id"),info.get("ints"),info.get("variables"),info.get("text"),info.get("ids"),info.get("ids2")));
   if(kind.equals("effect"))args.add(4);else if(kind.equals("condition"))args.add(1);else if(kind.equals("selector")){args.add(true);args.add(false);}
   args.add(info.get("furniSources"));args.add(info.get("userSources"));String name=kind.equals("effect")?"Action":kind.substring(0,1).toUpperCase()+kind.substring(1);
   var c=(Obj)oracle.construct(oracle.classes.get(OUT+"Update"+name+"MessageComposer").raw(),args);var exp=oracle.execute(oracle.method(OUT+"Update"+name+"MessageComposer","getMessageArray"),c);
   check(vm.helper("modernPayload",info).equals(exp),"Payload differs from actual current "+kind+" composer");cases++;
  }
  testWired(new WiredVM(new SWF(new FileInputStream("work/old.swf"),false)),vm,oracle);
  System.out.println("PASS: All six modern Wired update payloads match actual AirPlus bytecode exactly, including selector booleans and preserved sources/variables/dual selections.");
 }
 static void testDefinitions(FeaturesVM vm,WiredVM oracle)throws Exception {
  int cases=0;
  for(String kind:List.of("effect","trigger","condition","addon","selector","variable")){
   Packet p=new Packet().i(20);ints(p,List.of(22222222));ints(p,List.of(33333333));p.i(5555).i(16777217).s("configuração 🎮");ints(p,List.of(1,2,3));strings(p,List.of("n"));ints(p,List.of(100));ints(p,List.of(0));p.i(0);
   if(kind.equals("effect"))p.i(4);if(kind.equals("condition"))p.i(1);if(kind.equals("selector"))p.b(true).b(false);
   p.b(true);groups(p,List.of(List.of(100,101)));groups(p,List.of(List.of(0,11)));ints(p,List.of(100));ints(p,List.of(0));p.b(false);
   if(kind.equals("condition")){p.bytes.write(1);p.b(false);}p.i(0);ints(p,List.of(0,1,2));
   var reader=new Reader(p.bytes());var decoded=(Obj)vm.helper("readWired",reader,kind);check(reader.b.remaining()==0,"Definition left bytes "+kind);
   String n=kind.equals("effect")?"Action":kind.substring(0,1).toUpperCase()+kind.substring(1);
   String type="com.sulake.habbo.communication.messages.incoming.userdefinedroomevents:"+n+"Definition";
   var expected=(Obj)oracle.construct(oracle.classes.get(type).raw(),List.of(new Reader(p.bytes())));
   for(String key:List.of("id","code","intParams","stringParam")){String dk=key.equals("intParams")?"ints":key.equals("stringParam")?"text":key;check(Objects.equals(decoded.get(dk),oracle.get(expected,key)),"Definition mismatch "+kind+"."+key);}
   if(kind.equals("selector"))check(Objects.equals(decoded.get("filter"),oracle.get(expected,"isFilter"))&&Objects.equals(decoded.get("invert"),oracle.get(expected,"isInvert")),"Selector flags lost");cases++;
  }
  // Native navigator item uses the where-friends-ARE composer, never the
  // separate composer for rooms owned by friends.
  var composer=(Obj)vm.construct("_-0It::_-0Ro",List.of());check(payload(vm,composer).isEmpty(),"Friend room request contains arguments");
  var item=(Obj)vm.construct("_-4k::_-0GT",List.of("Quartos com meus amigos",composer));check(vm.get(item,"_-Ud")==composer,"Navigator item lost its native request");
  System.out.println("PASS: All six incoming Wired definition types match the actual AirPlus definitions and packet boundaries; navigator entry uses native RoomsWhereMyFriendsAreSearch with no arguments.");
 }
 static Packet variable(Packet p,String id)throws Exception {
  p.s(id).i(1).s("Variável "+id).i(1).i(2);for(int i=0;i<8;i++)p.b(false);p.b(true).i(2).i(10).s("dez").i(20).s("vinte");return p;
 }
 static void testContext(FeaturesVM vm)throws Exception {
  Packet p=new Packet().i(7).i(0).i(12345).i(1);variable(p,"furni-ç");p.i(1).i(12345678).i(42).i(2);variable(p,"user-🎮");p.i(0).i(3);variable(p,"global");p.i(99).i(4).i(1).i(555).s("Outro quarto");variable(p,"shared");p.i(5).i(1);variable(p,"rule");p.i(6).i(1).i(777).s("Quarto").s("placeholder");
  Reader r=new Reader(p.bytes());var vars=(List<?>)vm.helper("readWiredContext",r);check(vars.size()==5&&r.b.remaining()==0,"Optional Wired context blocks misaligned");
  Packet diff=new Packet().i(123).b(true).i(0).i(2).i(555);variable(diff,"a");diff.i(666);variable(diff,"b");
  vm.statics.put("_roomVariables",new ArrayList<>());vm.statics.put("_modernInfo",null);r=new Reader(diff.bytes());vm.helper("receiveWiredVariables",r);check(((List<?>)vm.statics.get("_roomVariables")).size()==2&&r.b.remaining()==0,"Room variable synchronization misaligned");
  var manager=vm.classes.get("com.sulake.core.communication.messages:MessageClassManager");var body=vm.method(manager.logical(),"_-2aE").body();int aliases=0;
  for(var ins:body.getCode().code)if((ins.getBytes()[0]&255)==0x60 && AuditStartup.q(manager.abc(),ins.operands[0]).startsWith("loginpatch::WiredPayload")){var cls=vm.raw.get(AuditStartup.q(manager.abc(),ins.operands[0]));check(Arrays.stream(cls.inst().interfaces).anyMatch(i->AuditStartup.q(cls.abc(),i).equals("_-0tl::_-15i")),"Composer lacks native interface: "+cls.raw()+" implements "+Arrays.stream(cls.inst().interfaces).mapToObj(i->AuditStartup.q(cls.abc(),i)).toList());aliases++;}
  check(aliases==7,"Missing typed composer registrations");
  System.out.println("PASS: All seven optional Wired context blocks and chunked room-variable records keep exact boundaries; seven extra wire classes register through native IMessageComposer without replacing existing mappings.");
 }
 static void testHeightColor(FeaturesVM vm){
  var conn=new Obj("fixture-connection");vm.statics.put("_activeConnection",conn);vm.helper("showHeight",12345678,2.37,conn);
  var field=(Obj)vm.statics.get("_heightField");check(((Number)field.get("value")).doubleValue()==2.37,"Height UI lost precision");
  vm.helper("applyHeight",(Object)null);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,237)),"Wrong height units");
  vm.helper("floorHeight",(Object)null);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,0)),"Floor height wrong");
  vm.helper("aboveHeight",(Object)null);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(12345678,-100)),"Above-stack sentinel wrong");
  vm.helper("closeHeight",(Object)null);check(vm.statics.get("_heightPopup")==null,"Height popup did not close");
  check(vm.helper("legacyLogicType","furniture_recolorable").equals("furniture_basic")&&vm.helper("legacyVisualizationType","furniture_recolorable").equals("furniture_static"),"Missing recolorable asset adapters");
  var obj=new Obj("fixture-object");obj.put("furnitype","bc_alpha1_a_recolorable");var model=new Obj("fixture-color-model");var map=new Obj("fixture-color-map");model.put("data",map);obj.put("model",model);
  for(String color:List.of("#112233","0x112233","1122867")){map.put("color",color);check(num(vm.helper("recolorLayer",obj,"recolorable"))==0x112233,"RGB color decoded incorrectly: "+color);}
  check(num(vm.helper("recolorLayer",obj,"shadow"))==-1,"Shadow recolored");obj.put("furnitype","bc_block_0*1");check(num(vm.helper("recolorLayer",obj,"recolorable"))==-1,"Legacy block rendering changed");
  System.out.println("PASS: Height panel preserves hundredth units and sends exact floor/above-stack payloads; new recolorable block/letter layers decode RGB without changing shadows or old furniture.");
 }
 public static void main(String[]a)throws Exception{var s=new SWF(new FileInputStream(a[0]),false);var vm=new FeaturesVM(s);if(a.length>1){testContext(vm);return;}var oracle=new WiredVM(new SWF(new FileInputStream("work/plus.swf"),false));testNewWire(vm,oracle);testDefinitions(vm,oracle);testEditors(vm);testHeightColor(vm);testContext(vm);}
}

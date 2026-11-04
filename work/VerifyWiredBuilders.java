import java.io.*;
import java.nio.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.types.traits.*;

class VerifyWiredBuilders extends VerifyInventoryCommands {
 static final String WIRED="com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.data:";
 static final String PARSERS="com.sulake.habbo.communication.messages.parser.userdefinedroomevents:";
 static final String OUT="com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents:";
 static final String CONTROL="com.sulake.habbo.roomevents.userdefinedroomevents:WiredCtrl";
 static final String VIEW="com.sulake.habbo.roomevents.userdefinedroomevents:UserDefinedRoomEventsCtrl";
 static final String CATALOG="com.sulake.habbo.tablet.catalog:HabboTabletCatalog";
 static final String BUTTONS="com.sulake.habbo.tablet.catalog.preview.elements:CatalogPreviewButtons";
 static class WiredVM extends FixtureVM {
  final Map<String,Obj> staticObjects=new HashMap<>();
  boolean stubControls=false;
  WiredVM(SWF swf){super(swf);statics.put("_wiredById",new HashMap<Object,Object>());statics.put("_builderRefresh",new IdentityHashMap<Object,Object>());statics.put("_wiredEditor",null);statics.put("_received",new ArrayList<Object>());}
  @Override Method find(AuditStartup.Cls c,String name,boolean getter){
   while(c!=null){var result=super.find(c,name,getter);if(result!=null)return result;c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}return null;
  }
  @Override void constructSuper(Method m,Obj self,List<Object> args){
   var c=raw.get(AuditStartup.q(m.cls().abc(),m.cls().inst().super_index));if(c!=null)execute(method(c.logical(),"<init>"),self,args.toArray());
  }
  Obj staticObject(String type){
   var existing=staticObjects.get(type);if(existing!=null)return existing;var cls=raw.get(type);check(cls!=null,"Unknown static class "+type);var result=new Obj(type);staticObjects.put(type,result);
   for(var trait:cls.abc().class_info.get(cls.index()).static_traits.traits)if(trait instanceof TraitSlotConst slot){
    Object value=switch(slot.value_kind){case 3->cls.abc().constants.getInt(slot.value_index);case 4->cls.abc().constants.getUInt(slot.value_index);case 6->cls.abc().constants.getDouble(slot.value_index);case 1->cls.abc().constants.getString(slot.value_index);case 10->false;case 11->true;default->AuditStartup.name(cls.abc(),slot.type_index).equals("int")?0:null;};
    result.put(AuditStartup.name(cls.abc(),trait.name_index),value);
   }
   var init=cls.abc().findBody(cls.abc().class_info.get(cls.index()).cinit_index);if(init!=null)execute(new Method(cls,init),result);return result;
  }
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(Set.of("loginpatch:RoomVisual60","loginpatch:RoomChat59","loginpatch:BuildersPalette59").contains(m.cls().logical()))for(var t:m.cls().abc().class_info.get(m.cls().index()).static_traits.traits)if(t instanceof TraitMethodGetterSetter&&n.equals(AuditStartup.name(m.cls().abc(),t.name_index)))return new Bound(new Ref(m.cls().raw()),n);
   return super.lexical(m,self,n,i);
  }
  static boolean byte59(Object r){return r instanceof Obj o&&(o.type.equals("chat-bytes59")||o.type.equals("native-bytes42")||o.type.equals("auth-bytes35")||o.type.equals("flash.utils::ByteArray"));}
  static byte[] data59(Obj o){if(o.get("bytes") instanceof java.io.ByteArrayOutputStream b)return b.toByteArray();if(o.get("wire42")instanceof List<?> l){byte[] b=new byte[l.size()];for(int i=0;i<b.length;i++)b[i]=(byte)num(l.get(i));return b;}return new byte[0];}
  @Override Object get(Object r,Object k){
   if(byte59(r)){var o=(Obj)r;if(k.equals("length"))return data59(o).length;if(k.equals("bytesAvailable"))return data59(o).length-num(o.get("position"));}

   if(r instanceof Reader reader&&k.equals("readByte"))return new Bound(r,"readByte");
   if(r instanceof Ref ref&&raw.containsKey(ref.name()))return staticObject(ref.name()).get(k);
   return super.get(r,k);
  }
  @Override Object construct(String type,List<Object> args){
   if(type.equals("flash.utils::ByteArray")||type.equals("ByteArray")){var o=new Obj("chat-bytes59");o.put("bytes",new java.io.ByteArrayOutputStream());o.put("position",0);return o;}

   var c=raw.get(type);if(stubControls&&c!=null&&c.logical().startsWith("com.sulake.habbo.roomevents.userdefinedroomevents")){var control=new Obj(type);control.put("data",args.isEmpty()?null:args.get(0));return control;}
   return super.construct(type,args);
  }
  @SuppressWarnings("unchecked") @Override void set(Object r,Object key,Object value){
   if(r instanceof List<?> l){var list=(List<Object>)l;int index=num(key);while(list.size()<=index)list.add(null);list.set(index,value);return;}
   super.set(r,key,value);
  }
  @Override Object call(Object r,String n,List<Object> args){
   if(r instanceof Ref f&&Set.of("loginpatch::RoomVisual60","loginpatch::RoomChat59","loginpatch::BuildersPalette59").contains(f.name()))return execute(method(raw.get(f.name()).logical(),n),staticObject(f.name()),args.toArray());
   if(r instanceof Map<?,?>m&&n.equals("hasOwnProperty"))return m.containsKey(args.get(0));
   if(r instanceof Reader reader&&n.equals("readByte")){if(reader.b.remaining()<1)throw new FixtureError("EOFError");return (int)reader.b.get();}
   if(byte59(r)){
    var o=(Obj)r;if(o.type.equals("chat-bytes59")&&n.equals("writeByte")){((java.io.ByteArrayOutputStream)o.get("bytes")).write(num(args.get(0)));return null;}
    if(Set.of("readInt","readShort","readUnsignedByte","readUTF").contains(n)){
     byte[] data=data59(o);int at=num(o.get("position"));int size=n.equals("readInt")?4:n.equals("readUnsignedByte")?1:2;if(at+size>data.length)throw new FixtureError("EOFError");
     var b=java.nio.ByteBuffer.wrap(data).order(java.nio.ByteOrder.BIG_ENDIAN);Object value;
     if(n.equals("readInt"))value=b.getInt(at);else if(n.equals("readShort"))value=(int)b.getShort(at);else if(n.equals("readUnsignedByte"))value=Byte.toUnsignedInt(data[at]);else{int len=Short.toUnsignedInt(b.getShort(at));if(at+2+len>data.length)throw new FixtureError("EOFError");size=2+len;value=new String(data,at+2,len,java.nio.charset.StandardCharsets.UTF_8);}o.put("position",at+size);return value;
    }
   }

   if(r instanceof Ref ref&&ref.name().equals("loginpatch::NativeAir42"))return execute(method("loginpatch:NativeAir42",n),staticObject(ref.name()),args.toArray());
   if(r instanceof Reader reader&&n.equals("readByte"))return (int)reader.b.get();
   if(r instanceof List<?> list&&n.equals("indexOf"))return list.indexOf(args.get(0));
   if(r instanceof Ref ref&&ref.name().equals("Math")&&n.equals("max"))return Math.max(((Number)args.get(0)).doubleValue(),((Number)args.get(1)).doubleValue());
   if(r instanceof Obj o){
    if(o.type.equals("fixture-wired-editor")&&n.equals("close")){o.put("closed",true);calls.add("close-wired");return null;}
    if(classes.containsKey(CATALOG)&&o.type.equals(classes.get(CATALOG).raw())){
     if(n.equals("send")){sent.add((Obj)args.get(0));return null;}
     if(n.equals("_-1PA")||n.equals("_-1tD")){calls.add("catalog-refresh:"+n);return null;}
    }
   }
   return super.call(r,n,args);
  }
 }
 static String part(String kind){return kind.equals("effect")?"Action":kind.equals("trigger")?"Trigger":"Condition";}
 static Packet ints(Packet p,List<?> list)throws Exception{p.i(list.size());for(Object v:list)p.i(num(v));return p;}
 static Packet strings(Packet p,List<?> list)throws Exception{p.i(list.size());for(Object v:list)p.s(String.valueOf(v));return p;}
 static Packet groups(Packet p,List<List<Integer>> groups)throws Exception{p.i(groups.size());for(var g:groups)ints(p,g);return p;}
 static record Definition(String kind,int id,int code,int delay,int quantifier,List<Integer> ints,List<Integer> ids,List<Integer> ids2,List<String> vars,List<Integer> fs,List<Integer> us,String text,byte[] bytes){}
 static Definition fixture(String kind,int mode,int selected)throws Exception{
  int id=16777217+(kind.equals("effect")?0:kind.equals("trigger")?1000:2000)+mode*100+selected;int code=kind.equals("effect")?7:0,delay=mode==2?53:4,quantifier=mode==2?7:0;
  var values=List.of(1,42,999);var ids=selected==0?List.<Integer>of():List.of(22222222,33333333);var ids2=mode==0?List.<Integer>of():List.of(44444444);
  var vars=mode==0?List.<String>of():List.of("ref:123","variável-🎮");var fs=mode==0?List.of(100):List.of(110,101);var us=mode==0?List.of(0):List.of(11,12);String text="Configuração çã\n🎮";
  var p=new Packet().i(20);ints(p,ids);ints(p,ids2);p.i(5555).i(id).s(text);ints(p,values);strings(p,vars);ints(p,fs);ints(p,us);p.i(code);
  if(kind.equals("effect"))p.i(delay);if(kind.equals("condition"))p.i(quantifier);
  p.b(mode!=0);groups(p,List.of(List.of(100,101,110),List.of(101)));groups(p,List.of(List.of(0,11,12)));ints(p,List.of(100,101));ints(p,List.of(0));p.b(mode==2);
  if(kind.equals("condition"))p.bytes.write(mode==0?0:1);if(kind.equals("condition"))p.b(mode==1);
  p.i(0); // Current WiredContext with no optional blocks.
  ints(p,List.of(2,3)); // Current default parameter suffix.
  return new Definition(kind,id,code,delay,quantifier,values,ids,ids2,vars,fs,us,text,p.bytes());
 }
 static Obj parse(WiredVM vm,Definition def,boolean current)throws Exception{
  String name=PARSERS+"WiredFurni"+part(def.kind)+"MessageParser";var parser=new Obj(vm.classes.get(name).raw());var reader=new Reader(def.bytes);
  check(Boolean.TRUE.equals(vm.execute(vm.method(name,"parse"),parser,reader)),"Wired parser returned false");check(reader.b.remaining()==0,"Wired parser left bytes unread");
  return (Obj)vm.get(parser,current?"def":"data");
 }
 static void testWired(WiredVM old,WiredVM now,WiredVM oracle)throws Exception{
  int cases=0,reproduced=0;
  for(String kind:List.of("effect","trigger","condition"))for(int mode=0;mode<3;mode++)for(int selected:new int[]{0,2}){
   var d=fixture(kind,mode,selected);var actual=parse(now,d,false);var expected=parse(oracle,d,true);
   for(String key:List.of("id","code","stringParam","intParams"))check(Objects.equals(now.get(actual,key),oracle.get(expected,key)),"Wrong common Wired field "+key);
   check(now.get(actual,"_-3XJ").equals(oracle.get(expected,"furniLimit"))&&now.get(actual,"_-5W").equals(oracle.get(expected,"stuffIds")),"Wired furniture selection differs");
   if(kind.equals("effect"))check(now.get(actual,"_-2F4").equals(oracle.get(expected,"delayInPulses")),"Delay differs");
   boolean failed=false;try{parse(old,d,false);}catch(BufferUnderflowException|IllegalArgumentException|AssertionError e){failed=true;}check(failed,"Original Wired format did not fail");reproduced++;
   var base=new Obj(now.classes.get(CONTROL).raw());base.put("_-0SL",actual);
   Object keep=now.execute(now.method(CONTROL,"getIntParams"),base);check(keep.equals(d.ints)&&keep!=now.get(actual,"intParams"),"Generic Wired controls dropped or exposed parameter storage");check(now.execute(now.method(CONTROL,"getStringParam"),base).equals(d.text),"Generic Wired controls lost existing text");
   List<Integer> edited=List.of(8,9),full=List.of(8,9,999);String updated="Texto alterado çã 🎮";
   String out=OUT+"Update"+part(kind)+"MessageComposer";int newDelay=d.delay+2;
   var oldArgs=new ArrayList<Object>(List.of(d.id,edited,updated,d.ids));if(kind.equals("effect"))oldArgs.add(newDelay);oldArgs.add(0);
   var composer=(Obj)now.construct(now.classes.get(out).raw(),oldArgs);Object first=now.execute(now.method(out,"_-0tq"),composer),again=now.execute(now.method(out,"_-0tq"),composer);
   var currentArgs=new ArrayList<Object>(List.of(d.id,full,d.vars,updated,d.ids,d.ids2));if(!kind.equals("trigger"))currentArgs.add(kind.equals("effect")?newDelay:d.quantifier);currentArgs.add(d.fs);currentArgs.add(d.us);
   var reference=(Obj)oracle.construct(oracle.classes.get(out).raw(),currentArgs);Object target=oracle.execute(oracle.method(out,"getMessageArray"),reference);
   check(first.equals(target)&&again.equals(target),"Wired save differs from actual AirPlus composer: "+kind+" mode="+mode+" got="+first+" expected="+target);
   check(Boolean.FALSE.equals(now.helper("blockWiredSave",composer)),"Valid observed Wired save blocked");
   cases++;
  }
  check(((Number)now.helper("wiredDelayMaximum",16777217+200)).doubleValue()==26.5,"A longer current action delay would be clamped by the old slider");
  for(String kind:List.of("effect","trigger","condition")){
   String out=OUT+"Update"+part(kind)+"MessageComposer";var a=new ArrayList<Object>(List.of(99999999,List.of(1),"",List.of()));if(kind.equals("effect"))a.add(0);a.add(0);var composer=(Obj)now.construct(now.classes.get(out).raw(),a);
   check(Boolean.TRUE.equals(now.helper("blockWiredSave",composer)),"Unobserved Wired save was not blocked");
   for(String send:List.of("send","_-El"))check(Boolean.FALSE.equals(now.execute(now.method("com.sulake.core.communication.connection:SocketConnection",send),new Obj("fixture-connection"),composer)),"Wired guard sent an incomplete save");
  }
  System.out.println("PASS: "+cases+" actual action/trigger/condition parser and save fixtures match the provided AirPlus constructors/composers, including selected furniture, second selections, variables, input sources, quantifiers, Unicode and advanced parameters. Reproduced "+reproduced+" original failures; repeated serialization is stable and both send paths reject incomplete saves.");
 }
 static void testUnsupported(WiredVM vm){
  String[] factories={"_-3ns::_-h4","_-071::_-PF","_-4kO::_-A4"};String[] kinds={"effect","trigger","condition"};int checked=0;
  var editor=new Obj("fixture-wired-editor");vm.stubControls=true;
  for(int k=0;k<3;k++){
   var cls=vm.raw.get(factories[k]);var statics=vm.staticObject(factories[k]);
   for(int code=0;code<45;code++){
    var data=new Obj("fixture-definition");data.put("category",kinds[k]);data.put("code",code);Object controller=vm.execute(vm.method(cls.logical(),"make"),statics,data);
    boolean blocked=Boolean.TRUE.equals(vm.helper("unsupportedWired",data,editor));check(blocked==(controller==null),"Legacy editor availability mismatch: "+kinds[k]+" "+code);checked++;
    if(blocked){editor.put("closed",false);vm.execute(vm.method(VIEW,"_-26m"),editor,data);check(Boolean.TRUE.equals(editor.get("closed")),"Unknown Wired code reached the null controller");}
   }
  }
  vm.stubControls=false;vm.helper("rememberWiredEditor",editor);
  for(int header:new int[]{16,2772,444}){editor.put("closed",false);vm.helper("received",header);check(Boolean.TRUE.equals(editor.get("closed")),"Modern-only Wired event left a blank editor open");}
  System.out.println("PASS: "+checked+" editor availability cases agree with the actual original factory bytecode; unsupported codes and addon/selector/variable events close the pending editor with a local message, preserving the game session.");
 }
 static Obj catalog(WiredVM vm){
  var cat=new Obj(vm.classes.get(CATALOG).raw());cat.put("_-AC",-1);cat.put("_-01a",250);cat.put("_-SI",5000);cat.put("_-0Oh",3600);cat.put("_-0ce",vm.now);cat.put("_-4KT",null);
  var room=new Obj("fixture-builder-room");room.put("_-0lf",true);room.put("_-1pT",false);cat.put("_-3ue",room);return cat;
 }
 static void testBuilders(WiredVM vm)throws Exception{
  var cat=catalog(vm);var offer=new Obj("fixture-offer");var ctx=new Obj("fixture-preview-context");ctx.put("catalog",cat);ctx.put("_-1Gs",offer);var buttons=new Obj(vm.classes.get(BUTTONS).raw());buttons.put("_-ZD",ctx);
  check(num(vm.execute(vm.method(CATALOG,"_-0x5"),cat,offer))==2,"Original unknown-count branch did not report limit reached");
  vm.sent.clear();vm.notices.clear();check(Boolean.FALSE.equals(vm.execute(vm.method(BUTTONS,"_-1bj"),buttons)),"Pending limit allowed a placement");
  check(vm.sent.size()==1&&vm.sent.get(0).type.equals("_-1Dj::_-3oJ")&&vm.notices.get(vm.notices.size()-1).contains("Atualizando"),"Pending BC count did not refresh separately from a real limit");
  check(payload(vm,vm.sent.get(0)).isEmpty(),"BC count query payload must be empty");vm.helper("builderLimitPending",cat);check(vm.sent.size()==1,"BC query refresh was not coalesced");
  for(int[] status:new int[][]{{3600,250,5000,3700},{0,500,5000,100},{120,10,100,120}}){
   String name=msg("parser.catalog:BuildersClubSubscriptionStatusMessageParser");var parser=new Obj(vm.classes.get(name).raw());var reader=new Reader(new Packet().i(status[0]).i(status[1]).i(status[2]).i(status[3]).bytes());vm.execute(vm.method(name,"parse"),parser,reader);check(reader.b.remaining()==0,"BC status left unread bytes");
   var e=new Obj("fixture-status-event");e.put("parser",parser);vm.execute(vm.method(CATALOG,"_-1yv"),cat,e);check(num(cat.get("_-01a"))==status[1]&&num(cat.get("_-SI"))==status[2],"Subscription limits were not taken from server");
  }
  cat.put("_-01a",250);cat.put("_-0Oh",3600);cat.put("_-0ce",vm.now);
  String count=msg("parser.catalog:BuildersClubFurniCountMessageParser");var parser=new Obj(vm.classes.get(count).raw());
  for(int used:new int[]{0,20,249,250,999}){
   vm.execute(vm.method(count,"parse"),parser,new Reader(new Packet().i(used).bytes()));var event=new Obj("fixture-count-event");event.put("parser",parser);vm.execute(vm.method(CATALOG,"_-Ng"),cat,event);
   check(num(cat.get("_-AC"))==used,"BC furniture count callback lost the server value");check(Boolean.FALSE.equals(vm.helper("builderLimitPending",cat)),"Loaded BC count still pending");
   int result=num(vm.execute(vm.method(CATALOG,"_-0x5"),cat,offer));check(result==(used<250?0:2),"BC count comparison changed actual limits");if(used<250)check(Boolean.TRUE.equals(vm.execute(vm.method(BUTTONS,"_-1bj"),buttons)),"Valid BC placement stayed blocked");
  }
  var previous=CompareProtocol.read("work/Test10.swf","_-0cq::_-0z0");var now=CompareProtocol.read("work/HabboTablet_LoginSSO.swf","_-0cq::_-0z0");
  var oldOut=previous.entrySet().stream().filter(e->e.getKey().endsWith("::_-26i")).findFirst().get().getValue();var newOut=now.entrySet().stream().filter(e->e.getKey().endsWith("::_-26i")).findFirst().get().getValue();
  check(!oldOut.containsValue("_-1Dj::_-3oJ")&&"_-1Dj::_-3oJ".equals(newOut.get(3047)),"Missing BC query registration regression");
  System.out.println("PASS: Reproduced the original false BC limit from an unknown count; the preview now requests and waits for the count. Actual server-status/count parsers update the catalog; 0/20/249 of 250 allow placement, 250/999 remain blocked. Query 3047 is restored without changing account limits.");
 }
 public static void main(String[] args)throws Exception{
  var now=new WiredVM(new SWF(new FileInputStream(args[1]),false));
  if(args.length>3){testUnsupported(now);testBuilders(now);return;}
  var old=new WiredVM(new SWF(new FileInputStream(args[0]),false));var oracle=new WiredVM(new SWF(new FileInputStream(args[2]),false));
  testWired(old,now,oracle);testUnsupported(now);testBuilders(now);
 }
}

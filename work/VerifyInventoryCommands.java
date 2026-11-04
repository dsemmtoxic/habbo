import java.io.*;
import java.util.*;
import java.util.regex.Pattern;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.types.traits.*;

// Execute the APK's actual parser, item constructors, commands and hooks.
// Network, timers and unchanged stuff-data parsing use bounded local fixtures.
class VerifyInventoryCommands extends VerifyStartupCompatibility {
 static final String HELPER="loginpatch:HabboTicketLogin";
 static final String ITEMS=msg("incoming.inventory.furni:FurniData");
 static final String UPDATE=msg("parser.inventory.furni:FurniListAddOrUpdateParser");
 static final String FULL=msg("parser.inventory.furni:FurniListParser");
 static final String COMMANDS="com.sulake.habbo.chat.input:ChatCommands";
 static class FixtureVM extends VM {
  int now=10000;boolean sendSucceeds=true;
  final List<Obj> sent=new ArrayList<>();final List<String> notices=new ArrayList<>();
  FixtureVM(SWF swf){super(swf);statics.put("_controller",new Obj("fixture-alert"));statics.put("_commandContext",null);statics.put("_antiIdleTimer",null);statics.put("_antiIdle",false);statics.put("_tradeBlocked",false);statics.put("_tradeOpen",false);statics.put("_typingVisible",true);statics.put("_nextCommandPing",1500000000);statics.put("_pendingCommandPing",-1);statics.put("_commandPingStarted",0);statics.put("_lastCommandPing",-1000);}
  Method find(AuditStartup.Cls c,String n,boolean getter){
   var ts=new ArrayList<Trait>();ts.addAll(c.inst().instance_traits.traits);ts.addAll(c.abc().class_info.get(c.index()).static_traits.traits);
   for(var t:ts)if(t instanceof TraitMethodGetterSetter mt&&AuditStartup.name(c.abc(),t.name_index).equals(n)&&(!getter||mt.kindType==2))return new Method(c,c.abc().findBody(mt.method_info));return null;
  }
  @Override Object lexical(Method m,Obj self,String name,int i){
   if(Set.of("RegExp","Class","getTimer","getDefinitionByName","TimerEvent").contains(name))return new Ref(name);
   if(name.equals("commandAntiIdle")||name.equals("commandPingTimeout"))return new Bound(statics,name);
   var f=find(m.cls(),name,true);if(f!=null)return execute(f,self);
   return super.lexical(m,self,name,i);
  }
  @Override Object get(Object r,Object k){
   String key=String.valueOf(k);
   if(r instanceof String s&&key.equals("length"))return s.length();
   if(r instanceof Ref ref&&ref.name().equals("TimerEvent")&&key.equals("TIMER"))return "timer";
   if(r instanceof Obj o){
    var c=raw.get(o.type);if(c!=null){var f=find(c,key,true);if(f!=null)return execute(f,o);if(find(c,key,false)!=null)return new Bound(o,key);}
    if(o.type.equals("fixture-session")&&Set.of("_-30L","_-2uA").contains(key))return new Bound(o,key);
    if(o.type.equals("fixture-users")&&key.equals("_-1Z1"))return new Bound(o,key);
   }
   return super.get(r,k);
  }
  @Override Object construct(String t,List<Object> args){
   if(t.equals("RegExp"))return Pattern.compile(String.valueOf(args.get(0)));
   if(t.equals("Timer")){var timer=new Obj("fixture-timer");timer.put("interval",args.get(0));timer.put("running",false);return timer;}
   if(t.endsWith("::Map"))return new Obj("fixture-map");
   return super.construct(t,args);
  }
  @Override Object call(Object r,String n,List<Object> args){
   if(n.equals("getTimer"))return now;
   if(n.equals("getDefinitionByName")){String q=String.valueOf(args.get(0));check(raw.containsKey(q),"Missing runtime composer "+q);return new Ref(q);}
   if(n.equals("setTimeout")){check(args.get(0) instanceof Bound,"Timeout lost its function binding");calls.add("timeout:"+args.get(1)+":"+args.get(2));return 1;}
   if(r instanceof String s)return switch(n){
    case "replace"->args.get(0) instanceof Pattern p?p.matcher(s).replaceAll(String.valueOf(args.get(1))):s.replace(String.valueOf(args.get(0)),String.valueOf(args.get(1)));
    case "indexOf"->s.indexOf(String.valueOf(args.get(0)));
    case "substr"->{int start=num(args.get(0));if(start<0)start=Math.max(0,s.length()+start);int end=args.size()>1?Math.min(s.length(),start+num(args.get(1))):s.length();yield s.substring(Math.min(start,s.length()),Math.max(Math.min(start,s.length()),end));}
    case "toLowerCase"->s.toLowerCase(Locale.ROOT);case "toUpperCase"->s.toUpperCase(Locale.ROOT);
    case "split"->new ArrayList<>(Arrays.asList(s.split(Pattern.quote(String.valueOf(args.get(0))),-1)));
    default->super.call(r,n,args);
   };
   if(r instanceof Ref ref&&(n.equals("_-1nQ")||n.equals("parseStuffData"))){
    // Both unchanged furniture constructors delegate exactly this one field.
    // A legacy string is stuff-data type 0: int discriminator + UTF string.
    var input=(Reader)args.get(0);check(input.integer()==0,"Fixture stuff-data kind mismatch");var data=new Obj("fixture-stuff");data.put("value",input.string());return data;
   }
   if(r instanceof Obj o){
    if(o.type.equals("fixture-map")&&n.equals("add")){o.put(args.get(0),args.get(1));return null;}
    if(o.type.equals("fixture-alert")&&n.equals("alert")){notices.add(String.valueOf(args.get(1)));return null;}
    if(o.type.equals("fixture-connection")&&n.equals("send")){sent.add((Obj)args.get(0));return sendSucceeds;}
    if(o.type.equals("fixture-session-manager")&&n.equals("getSession")){check(num(args.get(0))==12345,"Commands targeted wrong room");return o.get("session");}
    if(o.type.equals("fixture-users")&&n.equals("_-1Z1"))return o.get("users");
    if(o.type.equals("fixture-session")&&n.equals("_-30L")){calls.add("typing:"+args.get(0));var c=(Obj)construct("_-1pz::_-3hM",List.of());sent.add(c);return null;}
    if(o.type.equals("fixture-session")&&n.equals("_-2uA")){check(num(args.get(0))==0,"Unexpected anti-idle action");calls.add("anti-idle");return null;}
    if(o.type.equals("fixture-timer")){if(n.equals("start")||n.equals("stop")){o.put("running",n.equals("start"));return null;}if(n.equals("addEventListener")){check(args.get(1) instanceof Bound,"Timer lost its function binding");return null;}}
    if(n.equals("getParser"))return o.get("parser");
    var c=raw.get(o.type);if(c!=null){var f=find(c,n,false);if(f!=null)return execute(f,o,args.toArray());}
   }
   return super.call(r,n,args);
  }
  Object helper(String name,Object...args){return execute(method(HELPER,name),statics,args);}
 }
 static Packet item(Packet p,int id,String type,int expiration)throws Exception{
  p.i(id).s(type).i(id+1000).i(id+2000).i(1).i(0).s("dados çã 🎮 "+id).b(true).b(false).b(true).b(false).i(expiration).b(expiration>0).i(76543);
  if(type.equals("S"))p.s("slot-"+id).i(42);return p;
 }
 static void testInventory(FixtureVM old,FixtureVM now,FixtureVM oracle)throws Exception{
  int cases=0,reproduced=0;
  for(int count:new int[]{0,1,2,10})for(int mode=0;mode<3;mode++){
   var packet=new Packet().i(count);for(int i=0;i<count;i++)item(packet,16777217+i,(i+mode)%2==0?"S":"I",mode==2?1000:-1);packet.i(0x12345678);
   var reader=new Reader(packet.bytes());var parser=new Obj(now.classes.get(UPDATE).raw());check(Boolean.TRUE.equals(now.execute(now.method(UPDATE,"parse"),parser,reader)),"Updated inventory parse false");
   check(reader.integer()==0x12345678&&reader.b.remaining()==0,"Inventory update lost its record boundary");
   var list=(List<?>)parser.get("_-3OJ");check(list.size()==count,"Wrong inventory update size");
   var oracleReader=new Reader(packet.bytes());var oracleParser=new Obj(oracle.classes.get(msg("parser.inventory.furni:UnknownHabboCommunicationMessagesParserInventoryFurni1")).raw());
   oracle.execute(oracle.method(msg("parser.inventory.furni:UnknownHabboCommunicationMessagesParserInventoryFurni1"),"parse"),oracleParser,oracleReader);
   check(oracleReader.integer()==0x12345678&&oracleReader.b.remaining()==0,"AirPlus oracle consumed different item boundaries");
   var expected=(List<?>)oracleParser.get("UnknownVarFromUnknownHabboCommunicationMessagesParserInventoryFurni1_Vector_1");check(expected.size()==count,"Oracle update size");
   for(int i=0;i<count;i++){
    var got=(Obj)list.get(i);var want=(Obj)expected.get(i);for(String[] pair:new String[][]{{"_-1qR","_itemId"},{"_-3vp","_itemType"},{"_-0JT","_roomItemId"},{"_-1xC","_itemTypeId"},{"_-40c","_category"},{"_-4HY","_secondsToExpiration"},{"_-1wZ","_isRented"},{"_-4Gz","_flatId"}})check(Objects.equals(got.get(pair[0]),want.get(pair[1])),"Furniture field mismatch "+Arrays.toString(pair));
   }
   boolean failed=false;try{var r=new Reader(packet.bytes());old.execute(old.method(UPDATE,"parse"),new Obj(old.classes.get(UPDATE).raw()),r);failed=r.b.remaining()!=4;}catch(java.nio.BufferUnderflowException|IllegalArgumentException|AssertionError e){failed=true;}
   check(failed,"Original count mismatch was not reproduced");reproduced++;cases++;
   // Loading the full inventory shares the same item constructor. Mix wall and
   // floor items in one fragment and ensure both paths retain every item ID.
   var full=new Packet().i(4).i(2).i(count);for(int i=0;i<count;i++)item(full,16777217+i,(i+mode)%2==0?"S":"I",mode==2?1000:-1);full.i(0x12345678);
   var fullReader=new Reader(full.bytes());var fullParser=new Obj(now.classes.get(FULL).raw());now.execute(now.method(FULL,"parse"),fullParser,fullReader);check(fullReader.integer()==0x12345678&&fullReader.b.remaining()==0,"Full inventory boundary changed");check(((Map<?,?>)fullParser.get("_-EG")).size()==count,"Full inventory dropped or duplicated an item");cases++;
  }
  var truncated=new Reader(new Packet().i(1).i(16777217).bytes());boolean rejected=false;try{now.execute(now.method(UPDATE,"parse"),new Obj(now.classes.get(UPDATE).raw()),truncated);}catch(java.nio.BufferUnderflowException e){rejected=true;}check(rejected,"Truncated inventory was silently accepted");
  System.out.println("PASS: "+cases+" update/full-inventory fixtures preserve all item IDs and record boundaries for empty, single and batch updates, mixed floor/wall items, UTF data and rental branches; actual AirPlus oracle agrees. Reproduced "+reproduced+" original failures; truncated packets still fail.");
 }
 static Obj context(FixtureVM vm){
  var users=new Obj("fixture-users");var avatars=new ArrayList<Obj>();
  for(int i=0;i<2;i++){var u=new Obj("fixture-avatar");u.put("type",1);u.put("name",i==0?"TesteUm":"Teste.Dois");u.put("figure","hr-100-61.hd-180-1.ch-210-66.lg-270-82.sh-290-80");u.put("_-0lT",i==0?"M":"F");avatars.add(u);}users.put("users",avatars);
  var session=new Obj("fixture-session");session.put("disposed",false);session.put("state","RSE_STARTED");session.put("_-2gp",users);
  var manager=new Obj("fixture-session-manager");manager.put("session",session);var engine=new Obj("fixture-engine");engine.put("_-0Y",12345);
  var connection=new Obj("fixture-connection");var communication=new Obj("fixture-communication");communication.put("connection",connection);
  var context=new Obj("fixture-context");context.put("disposed",false);context.put("roomEngine",engine);context.put("_-4Ej",manager);context.put("communication",communication);return context;
 }
 static List<?> payload(FixtureVM vm,Obj composer){return (List<?>)vm.execute(vm.method(vm.raw.get(composer.type).logical(),"_-0tq"),composer);}
 static void command(FixtureVM vm,Obj context,String text){
  var owner=new Obj(vm.classes.get(COMMANDS).raw());owner.put("_-4Fr",context);
  var input=new Obj("fixture-input");input.put("text",text);
  var view=new Obj(vm.classes.get("com.sulake.habbo.chat.input:ChatInput").raw());view.put("_-02y",input);view.put("_-4AT",owner);
  check(Boolean.TRUE.equals(vm.execute(vm.method("com.sulake.habbo.chat.input:ChatInput","_-1gs"),view)),"Input command was not consumed");check(input.get("text").equals(""),"Command was not cleared from input");
 }
 static void testCommands(FixtureVM vm)throws Exception{
  var ctx=context(vm);var connection=(Obj)((Obj)ctx.get("communication")).get("connection");
  for(String s:Arrays.asList(null,"olá",":inventado",":pingar",":afkk"))check(Boolean.FALSE.equals(vm.helper("runCommand",s,ctx)),"Normal chat was consumed");
  command(vm,ctx," :TyPiNg ");check(vm.sent.size()==1&&vm.sent.get(0).type.equals("_-1pz::_-3hM"),"Typing off must send one cancellation");
  check(Boolean.TRUE.equals(vm.helper("blockTyping",new Obj("_-1pz::_-dy")))&&Boolean.FALSE.equals(vm.helper("blockTyping",new Obj("_-1pz::_-3hM"))),"Typing guard blocked wrong packet");
  for(String name:List.of("send","_-El"))check(Boolean.TRUE.equals(vm.execute(vm.method("com.sulake.core.communication.connection:SocketConnection",name),connection,new Obj("_-1pz::_-dy"))),"Socket did not consume disabled typing safely");
  command(vm,ctx,":typing");check(Boolean.FALSE.equals(vm.helper("blockTyping",new Obj("_-1pz::_-dy"))),"Typing toggle did not restore normal behavior");
  vm.sent.clear();command(vm,ctx,":clonar testE.dOis");check(vm.sent.size()==1&&vm.sent.get(0).type.equals("_-2t1::_-0Nq")&&payload(vm,vm.sent.get(0)).equals(List.of("F","hr-100-61.hd-180-1.ch-210-66.lg-270-82.sh-290-80")),"Clone failed or changed sex/figure: "+vm.sent+" notices="+vm.notices);
  command(vm,ctx,":clone TesteUm");check(vm.sent.size()==2&&payload(vm,vm.sent.get(1)).get(0).equals("M"),"Clone alias failed");
  for(String s:List.of(":clonar",":clonar Ausente"))command(vm,ctx,s);check(vm.sent.size()==2,"Missing nick sent an invalid appearance");
  vm.sent.clear();command(vm,ctx,":afk");check(Boolean.TRUE.equals(vm.statics.get("_antiIdle"))&&Boolean.TRUE.equals(((Obj)vm.statics.get("_antiIdleTimer")).get("running")),"Anti idle was not started");vm.helper("commandAntiIdle",(Object)null);check(vm.calls.contains("anti-idle"),"Anti-idle sent no activity");
  vm.calls.clear();command(vm,ctx,":afk");vm.helper("commandAntiIdle",(Object)null);check(!vm.calls.contains("anti-idle"),"Disabled anti-idle still acted");
  command(vm,ctx,":tradeblock");check(vm.sent.isEmpty(),"Toggle closed a nonexistent trade");
  var incoming=new Obj(vm.classes.get("com.sulake.habbo.tablet.inventory:IncomingMessages").raw());incoming.put("_-2kU",ctx.get("communication"));
  vm.execute(vm.method("com.sulake.habbo.tablet.inventory:IncomingMessages","_-0tL"),incoming,new Obj("_-2bf::_-1A1"));check(vm.sent.size()==1&&vm.sent.get(0).type.equals("_-LI::_-28E")&&payload(vm,vm.sent.get(0)).isEmpty(),"Blocked trade entered UI or sent wrong close payload");
  command(vm,ctx,":tradeblock");check(Boolean.FALSE.equals(vm.helper("blockTrade",ctx.get("communication"))),"Trade unblock still rejected a trade");command(vm,ctx,":tradeblock");check(vm.sent.size()==2,"Enabling block did not close an existing trade");
  vm.helper("commandTradeState",new Obj("_-2bf::_-3dE"));check(Boolean.FALSE.equals(vm.statics.get("_tradeOpen")),"Closed trade retained open state");
  vm.sent.clear();vm.notices.clear();command(vm,ctx,":ping");check(vm.sent.size()==1&&vm.sent.get(0).type.equals("_-ET::_-4NH"),"Ping packet mismatch");int id=num(payload(vm,vm.sent.get(0)).get(0));check(id>=1500000000,"Ping ID collided with normal tracker");command(vm,ctx,":ping");check(vm.sent.size()==1,"Concurrent ping was sent");
  vm.now+=137;var parser=new Obj("fixture-latency-parser");parser.put("requestId",id);var event=new Obj("fixture-latency-event");event.put("parser",parser);var tracker=new Obj(vm.classes.get("com.sulake.habbo.tracking:LatencyTracker").raw());tracker.put("_-o-",null);tracker.put("_-4KX",null);
  vm.execute(vm.method("com.sulake.habbo.tracking:LatencyTracker","onPingResponse"),tracker,event);check(vm.notices.contains("Ping: 137 ms")&&num(vm.statics.get("_pendingCommandPing"))==-1,"Ping response failed");
  int notices=vm.notices.size();vm.helper("commandPingTimeout",id);check(vm.notices.size()==notices,"Completed ping showed a stale timeout");check(Boolean.FALSE.equals(vm.helper("commandPingResponse",123)),"Natural latency reply was consumed");
  vm.now+=2000;command(vm,ctx,":ping");int timedOut=num(vm.statics.get("_pendingCommandPing"));vm.helper("commandPingTimeout",timedOut);check(num(vm.statics.get("_pendingCommandPing"))==-1&&vm.notices.get(vm.notices.size()-1).contains("5 segundos"),"Timeout did not release ping");
  vm.now+=6000;vm.sendSucceeds=false;command(vm,ctx,":ping");check(num(vm.statics.get("_pendingCommandPing"))==-1,"Failed send left ping pending");vm.sendSucceeds=true;
  command(vm,ctx,":comandos");check(vm.notices.get(vm.notices.size()-1).contains(":clonar <nick>"),"Command help unavailable");
  vm.helper("resetCommands");check(Boolean.FALSE.equals(vm.statics.get("_antiIdle"))&&Boolean.FALSE.equals(vm.statics.get("_tradeBlocked"))&&Boolean.TRUE.equals(vm.statics.get("_typingVisible"))&&vm.statics.get("_commandContext")==null,"Connection reset retained commands/timer context");
  var manager=(Obj)ctx.get("_-4Ej");manager.put("session",null);int before=vm.sent.size();command(vm,ctx,":clonar TesteUm");check(vm.sent.size()==before,"No-room command sent a packet");
  System.out.println("PASS: All five commands and aliases execute through the actual chat-input callback, clear input and send only the intended composers. Tested case-insensitive clone lookup, missing users/rooms, both typing socket paths, trade acceptance/blocking, AFK on/off, ping success/concurrency/timeout/send failure and connection cleanup.");
 }
 public static void main(String[] args)throws Exception{
  if(args.length==1){testCommands(new FixtureVM(new SWF(new FileInputStream(args[0]),false)));return;}
  var old=new FixtureVM(new SWF(new FileInputStream(args[0]),false));var now=new FixtureVM(new SWF(new FileInputStream(args[1]),false));var oracle=new FixtureVM(new SWF(new FileInputStream(args[2]),false));
  testInventory(old,now,oracle);testCommands(now);
 }
}

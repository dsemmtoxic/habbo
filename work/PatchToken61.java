import java.io.*;import java.nio.file.*;import java.security.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.abc.avm2.instructions.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken61 extends PatchOldLogin {
 static final String LOGIN="loginpatch:HabboTicketLogin",DESKTOP="com.sulake.habbo.ui:RoomDesktop",MESSAGE="com.sulake.habbo.messenger:ConversationMessage",RENDERER="com.sulake.habbo.messenger.view:ConversationMessageItemRenderer",PLAN="com.sulake.habbo.room.object:RoomPlaneParser";
 static int helper(String n){return rawClass("loginpatch::"+n);}
 static int stat(String owner,String n){var i=instance(owner);int at=abc.instance_info.indexOf(i);for(var t:abc.class_info.get(at).static_traits.traits)if(n.equals(AuditStartup.name(abc,t.name_index)))return t.name_index;throw new IllegalStateException("Static member missing "+owner+" "+n);}
 static MethodBody smethod(String owner,String n){int q=stat(owner,n),at=abc.instance_info.indexOf(instance(owner));for(var t:abc.class_info.get(at).static_traits.traits)if(t.name_index==q&&t instanceof TraitMethodGetterSetter m)return abc.findBody(m.method_info);throw new IllegalStateException(n);}
 static void prefix(MethodBody body,Code code,int stack)throws Exception{
  byte[] bytes=body.getCodeBytes();if(bytes[0]!=(byte)0xd0||bytes[1]!=(byte)0x30)throw new IllegalStateException("Unexpected prologue");
  for(var e:body.exceptions){if(e.start<2||e.end<2||e.target<2)throw new IllegalStateException("Exception crosses prologue");e.start+=code.bytes().length;e.end+=code.bytes().length;e.target+=code.bytes().length;}
  var out=new ByteArrayOutputStream();out.write(bytes,0,2);out.write(code.bytes());out.write(bytes,2,bytes.length-2);body.setCodeBytes(out.toByteArray());body.max_stack=Math.max(stack,body.max_stack);body.getCode();body.setModified();
 }
 static void returns(MethodBody body,Code code,int stack)throws Exception{for(int at=body.getCode().code.size()-1;at>=0;at--)if((body.getCode().code.get(at).getBytes()[0]&255)==0x47)insertInclusive(body,at,code,stack);}
 static void constants(MethodBody body,Map<Integer,Integer> values){int count=0;for(int i=0;i<body.getCode().code.size();i++){var op=body.getCode().code.get(i);if((op.getBytes()[0]&255)==0x25&&values.containsKey(op.operands[0])){body.replaceInstruction(i,new AVM2Instruction(0,0x25,new int[]{values.get(op.operands[0])}));count++;}}if(count!=values.size())throw new IllegalStateException("Unexpected timer constants "+count);body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();}
 static void chat()throws Exception{
  int h=helper("Console61");var request=smethod(LOGIN,"requestConsoleHistory");constants(request,Map.of(4000,350,10000,5000));
  prefix(request,new Code().op(0x60,h).op(0xd1).op(0xd2).op(0x60,stat(LOGIN,"requestConsoleHistory")).op(0x4f,publicName("track"),3),4);
  var timeout=smethod(LOGIN,"consoleHistoryTimeout");constants(timeout,Map.of(9900,4900));returns(timeout,new Code().op(0x60,h).op(0xd1).op(0xd2).op(0x4f,publicName("timeout"),2),3);
  var scroll=smethod(LOGIN,"consoleHistoryScrolled");scroll.setCodeBytes(new Code().op(0xd0).op(0x30).op(0x60,h).op(0xd1).op(0x4f,publicName("scrolled"),1).op(0x47).bytes());scroll.max_stack=2;scroll.exceptions=new ABCException[0];scroll.getCode();scroll.setModified();
  var receive=smethod(LOGIN,"receiveConsoleHistory");if(receive.getCode().code.stream().noneMatch(x->(x.getBytes()[0]&255)==0x6d&&x.operands[0]==2))throw new IllegalStateException("History activation peer slot changed");
  returns(receive,new Code().op(0x60,h).op(0xd2).op(0x6c,2).op(0x4f,publicName("received"),1),3);
  for(String name:List.of("rememberMessenger","resetAccountState"))prefix(smethod(LOGIN,name),new Code().op(0x60,h).op(0x4f,publicName("reset"),0),1);
  prefix(smethod(LOGIN,"consoleConversationRemoved"),new Code().op(0x60,h).op(0xd1).op(0x4f,publicName("release"),1),2);
  returns(constructor(MESSAGE),new Code().op(0x60,h).op(0xd0).op(0x62,4).op(0x4f,publicName("stamp"),2),3);
  var renderer=method(RENDERER,"commitData");int at=callIndex(renderer,"message",1);if((renderer.getCode().code.get(at-1).getBytes()[0]&255)!=0xd1)throw new IllegalStateException("Message receiver changed");
  insertInclusive(renderer,at-1,new Code().op(0x60,h),3);at=callIndex(renderer,"message",1);renderer.replaceInstruction(at,new AVM2Instruction(0,0x46,new int[]{publicName("text"),1}));renderer.setCodeBytes(renderer.getCode().getBytes());renderer.getCode();renderer.setModified();
 }
 static void room()throws Exception{
  // Preserve the actual entrance/mask in RoomMessageHandler. This separate
  // detector creates a special one-tile entrance floor instead of normal floor.
  var entrance=smethod(PLAN,"_-3Vo");entrance.setCodeBytes(new Code().op(0xd0).op(0x30).op(0x20).op(0x48).bytes());entrance.max_stack=1;entrance.exceptions=new ABCException[0];entrance.getCode();entrance.setModified();
  int h=helper("RoomAppearance61");
  // HabboUI forwards RETWE requests to this Boolean callback. The separate
  // _-34L listener receives RETWE_OPEN_WIDGET, not background-color requests.
  observe(DESKTOP,"_-0KM",new Code().op(0x60,h).op(0xd0).op(0xd1).op(0x46,publicName("request"),2).op(0x2a).branch(0x12,1).op(0x48).op(0x29),3);
  var color=new Code().op(0x60,h).op(0xd0).field(DESKTOP,"_view3D").field(DESKTOP,"_-2UG").op(0x4f,publicName("color"),3);
  returns(method(DESKTOP,"_-YU"),color,4);beforeReturn(method(DESKTOP,"_-1oc"),color,4);
  observe(DESKTOP,"dispose",new Code().op(0x60,h).op(0xd0).op(0x4f,publicName("release"),1),2);
 }
 public static void main(String[]a)throws Exception{
  byte[] input=Files.readAllBytes(Path.of(a[0]));String sha=HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input));if(!sha.equals("de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901"))throw new IllegalArgumentException("Exact original Teste33 SWF required");
  var s=new SWF(new ByteArrayInputStream(input),false);abc=s.getAbcList().get(1).getABC();SWF.initPlayer();
  for(String name:List.of("Console61","RoomAppearance61")){var index=new AbcIndexing(s,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,s.getDocumentClass());}
  chat();room();for(var tag:s.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  ((Tag)s.getAbcList().get(1)).setModified(true);try(var out=new FileOutputStream(a[1])){s.saveTo(out);}System.out.println("PASS: exact original Teste33 patched; token login retained, entrance floor normalized, console scheduling/dates and Toner UI/background hooks installed.");
 }
}

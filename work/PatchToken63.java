import java.io.*;import java.nio.file.*;import java.security.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.tags.Tag;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
class PatchToken63 extends PatchToken62 {
 static final String CANVAS="com.sulake.room.renderer:RoomSpriteCanvas3d",RVIZ="com.sulake.habbo.room.object.visualization.room:RoomVisualization",EVENTS="com.sulake.habbo.room:RoomObjectEventHandler",CHAT_EVENTS="com.sulake.habbo.chat.discussion.data:ChatEventHandler",DIMMER="com.sulake.habbo.room.object.logic.furniture:FurnitureRoomDimmerLogic",PRESETS="com.sulake.habbo.communication.messages.parser.room.furniture:RoomDimmerPresetsMessageParser";
 static String logicalRaw(String raw){for(var c:AuditStartup.classes(swf).values())if(c.raw().equals(raw))return c.logical();throw new IllegalStateException("Missing "+raw);}
 static MethodBody method63(String owner,String name){var c=AuditStartup.classes(swf).get(owner);for(var tr:c.inst().instance_traits.traits)if(tr instanceof TraitMethodGetterSetter m&&name.equals(AuditStartup.name(c.abc(),tr.name_index)))return c.abc().findBody(m.method_info);throw new IllegalStateException(owner+"."+name);}
 static MethodBody addMethod(String owner,String name,Code code,int stack,int regs,int[]params,boolean isStatic,MethodBody template,int kind){
  var info=new MethodInfo(params,0,abc.constants.getStringId(name,true),0,new ValueKind[0],new int[0]);int index=abc.method_info.size();abc.method_info.add(info);var body=new MethodBody(abc,new Traits(),code.bytes(),new ABCException[0]);body.method_info=index;body.max_stack=stack;body.max_regs=regs;body.init_scope_depth=template.init_scope_depth;body.max_scope_depth=body.init_scope_depth+1;abc.bodies.add(body);
  var tr=new TraitMethodGetterSetter();tr.name_index=publicName(name);tr.kindType=kind;tr.disp_id=0;tr.method_info=index;var inst=AuditStartup.classes(swf).get(owner).inst();(isStatic?abc.class_info.get(abc.instance_info.indexOf(inst)).static_traits:inst.instance_traits).traits.add(tr);body.getCode();body.setModified();return body;
 }
 static void returnsValue(MethodBody body,Code code,int stack)throws Exception {for(int i=body.getCode().code.size()-1;i>=0;i--)if((body.getCode().code.get(i).getBytes()[0]&255)==0x48)insertInclusive(body,i,code,stack);}
 static void publicAccess(){
  var code=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0x4f,stat(LOGIN,"loadSocialPreferences"),0);
  for(String n:List.of("_antiIdle","_typingVisible","_tradeBlocked","_friendHighlightEnabled"))code.op(0x60,stat(LOGIN,n));
  code.op(0x56,4).op(0x48);addMethod(LOGIN,"commandStates63",code,4,1,new int[0],true,smethod(LOGIN,"runCommand"),1);
  addMethod(LOGIN,"bindCommandContext63",new Code().op(0xd0).op(0x30).op(0x5e,stat(LOGIN,"_commandContext")).op(0xd1).op(0x61,stat(LOGIN,"_commandContext")).op(0x47),2,2,new int[]{0},true,smethod(LOGIN,"runCommand"),1);
  var theme=AuditStartup.classes(swf).get(":HitchTheme");abc=theme.abc();String owner=theme.logical();
  int q=rawClass(theme.raw());var themeTraits=abc.class_info.get(theme.index()).static_traits.traits;var names=new HashMap<String,TraitMethodGetterSetter>();for(var tr:themeTraits)if(tr instanceof TraitMethodGetterSetter m)names.put(AuditStartup.name(abc,tr.name_index),m);code=new Code().op(0xd0).op(0x30).op(0x60,q).op(0x60,q).op(0xd1).op(0x46,names.get("createScale9Textures").name_index,1).op(0x46,names.get("createScale9Image").name_index,1).op(0x48);
  addMethod(owner,"skin63",code,3,2,new int[]{0},true,abc.findBody(names.get("getTexture").method_info),1);abc=swf.getAbcList().get(1).getABC();
 }
 static void geometry()throws Exception {
  // The 3D canvas has its own PNG entrance image and avatar clip. Use the
  // native cleanup branch; retain door coordinates and the original wall trace.
  var door=method(CANVAS,"_-1Ie");int matches=0;
  for(int i=door.getCode().code.size()-1;i>=0;i--){var ins=door.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x61&&AuditStartup.name(abc,ins.operands[0]).equals("_-1Kj")){insertInclusive(door,i,new Code().op(0x29).op(0x27),2);matches++;}}
  if(matches!=1)throw new IllegalStateException("Door image switch changed: "+matches);
 }
 static void commands()throws Exception {
  int h=helper("ClientSettings63");
  prefix(smethod(LOGIN,"runCommand"),new Code().op(0x60,h).op(0xd1).op(0xd2).op(0x46,publicName("beforeCommand"),2).branch(0x12,2).op(0x26).op(0x48),3);
  returnsValue(smethod(LOGIN,"runCommand"),new Code().op(0x60,h).op(0xd1).op(0xd2).op(0x4f,publicName("afterCommand"),2),4);
  prefix(smethod(LOGIN,"commandNotice"),new Code().op(0x60,h).op(0x46,publicName("quiet"),0).branch(0x12,1).op(0x47),1);
  returns(smethod(LOGIN,"resetCommands"),new Code().op(0x60,h).op(0x4f,publicName("reset"),0),1);
  observe(CHAT_EVENTS,"_-1nD",handled(new Code().op(0x60,h).op(0xd1).op(0x46,publicName("muted"),1)),2);
 }
 static int propertyIn(MethodBody b,String name){for(var ins:b.getCode().code){int op=ins.getBytes()[0]&255;if((op==0x66||op==0x61||op==0x60)&&name.equals(AuditStartup.name(abc,ins.operands[0])))return ins.operands[0];}throw new IllegalStateException(name);}
 static void lighting()throws Exception {
  int h=helper("RoomLighting63");var yes=new Code().op(0x26).op(0x48);
  observe(EVENTS,"_-0dX",new Code().op(0x60,h).field(EVENTS,"_roomEngine").op(0xd1).op(0xd2).op(0xd3).op(0x46,publicName("onUse"),4).branch(0x12,yes.bytes().length).op(0x26).op(0x48),5);
  observe(EVENTS,"_-2rx",new Code().op(0x60,h).field(EVENTS,"_roomEngine").op(0xd1).op(0xd2).op(0x4f,publicName("engineDimmer"),3),4);
  observe(DIMMER,"_-1k2",new Code().op(0x60,h).op(0xd0).op(0x66,publicName("object")).op(0xd1).op(0x4f,publicName("legacy"),2),3);
  String factory=logicalRaw("_-112::_-2m4");returnsValue(method(factory,"createImage"),new Code().op(0x60,h).field(factory,"_-27L").op(0xd1).op(0xd2).op(0x4f,publicName("track"),3),5);
  // Same native rebatch operation used by the canvas; no room/furniture removal.
  var nativeRefresh=method(CANVAS,"_-05s");var refresh=addMethod(CANVAS,"refreshLighting63",new Code(),nativeRefresh.max_stack,nativeRefresh.max_regs,new int[0],false,nativeRefresh,1);refresh.setCodeBytes(nativeRefresh.getCodeBytes().clone());refresh.getCode();refresh.setModified();
  returns(method(CANVAS,"render"),new Code().op(0x60,h).op(0xd0).op(0x4f,publicName("frame"),1),2);
  getter(RVIZ,"lightingObject63",new Code().op(0xd0).op(0x30).op(0xd0).op(0x66,propertyIn(method(RVIZ,"update"),"_-3Cd")).op(0x48),1,method(RVIZ,"update"));
  for(String[]pair:new String[][]{{"lightingPlanes63","_-1P2"},{"lightingIndexes63","_-0Uv"}})getter(RVIZ,pair[0],new Code().op(0xd0).op(0x30).field(RVIZ,pair[1]).op(0x48),1,method(RVIZ,"update"));
  returnsValue(method(RVIZ,"update"),new Code().op(0x60,h).op(0xd0).op(0x4f,publicName("planes"),1),3);
  returnsValue(method(PRESETS,"parse"),new Code().op(0x60,h).op(0xd0).op(0xd1).op(0x4f,publicName("presets"),2),4);
  // Preserve the original native composer classes/headers, substituting only
  // payloads explicitly created by the new lighting editor. Match Plus exactly.
  for(String raw:List.of("_-26z::_-57","_-26z::_-1cO","_-26z::_-05v")){
   var body=method63(logicalRaw(raw),"_-0tq");for(int i=body.getCode().code.size()-1;i>=0;i--)if((body.getCode().code.get(i).getBytes()[0]&255)==0x48){int temp=body.max_regs;body.max_regs++;insertInclusive(body,i,new Code().op(0x63,temp).op(0x60,h).op(0xd0).op(0x62,temp).op(0x46,publicName("payload"),2),3);}
  }
  String registry="com.sulake.habbo.communication:HabboMessages";var ci=abc.class_info.get(abc.instance_info.indexOf(instance(registry)));var cinit=abc.findBody(ci.cinit_index);
  var append=new Code();for(String[]pair:new String[][]{{"3237","_-26z::_-57"},{"905","_-26z::_-1cO"}})append.op(0x60,stat(registry,"_-26i")).op(0x25,Integer.parseInt(pair[0])).op(0x60,rawClass(pair[1])).op(0x61,abc.constants.getMultinameId(Multiname.createMultinameL(false,abc.constants.getNamespaceSetId(new int[]{abc.constants.getNamespaceId(Namespace.KIND_PACKAGE,"",0,true)},true)),true));
  returns(cinit,append,3);
 }
 public static void main(String[]a)throws Exception {
  byte[] input=Files.readAllBytes(Path.of(a[0]));if(!HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)).equals("de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901"))throw new IllegalArgumentException("Exact original33 required");
  swf=new SWF(new ByteArrayInputStream(input),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  var original=smethod(PLAN,"_-3Vo");byte[] trace=original.getCodeBytes().clone();int stack=original.max_stack,regs=original.max_regs,scope=original.max_scope_depth;var exceptions=original.exceptions.clone();
  publicAccess();
  for(String name:List.of("Console61","ClientTheme63","ClientSettings63","RoomAppearance61","RoomLighting63","Login62")){var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());}
  chat();room62();login62();backgroundAccess();
  original=smethod(PLAN,"_-3Vo");original.setCodeBytes(trace);original.max_stack=stack;original.max_regs=regs;original.max_scope_depth=scope;original.exceptions=exceptions;original.getCode();original.setModified();
  geometry();commands();lighting();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}
  try(var out=new FileOutputStream(a[1])){swf.saveTo(out);}System.out.println("PASS:63 built from exact33: original wall tracing, canvas door cleanup, native lighting editors/rendering, full login/theme and persistent command settings. Device validation pending.");
 }
}

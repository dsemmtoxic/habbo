import java.io.*;import java.nio.file.*;import java.security.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken62 extends PatchToken61 {
 static final String CORE="com.sulake.core.runtime:CoreComponentContext",GRADIENT="com.sulake.habbo.common:BackgroundGradientRenderer",LOGIC="com.sulake.habbo.room.object.logic.room:RoomLogic",MASK="com.sulake.habbo.room.messages:RoomObjectRoomMaskUpdateMessage",HUI="com.sulake.habbo.ui:HabboUI",MAINVIEW="com.sulake.habbo.ui:MainViewManager";
 static SWF swf;
 static void getter(String owner,String name,Code code,int stack,MethodBody template){
  var info=new MethodInfo(new int[0],0,abc.constants.getStringId(name,true),0,new ValueKind[0],new int[0]);
  int index=abc.method_info.size();abc.method_info.add(info);
  var body=new MethodBody(abc,new Traits(),code.bytes(),new ABCException[0]);body.method_info=index;body.max_stack=stack;body.max_regs=1;body.init_scope_depth=template.init_scope_depth;body.max_scope_depth=body.init_scope_depth+1;abc.bodies.add(body);
  var trait=new TraitMethodGetterSetter();trait.name_index=publicName(name);trait.kindType=2;trait.disp_id=0;trait.method_info=index;instance(owner).instance_traits.traits.add(trait);body.getCode();body.setModified();
 }
 static void backgroundAccess(){
  abc=AuditStartup.classes(swf).get(CORE).abc();
  getter(CORE,"roomBackgroundRenderer62",new Code().op(0xd0).op(0x30).field(CORE,"_-YO").op(0x48),1,method(CORE,"_-357"));
  abc=AuditStartup.classes(swf).get(GRADIENT).abc();
  getter(GRADIENT,"roomBackgroundState62",new Code().op(0xd0).op(0x30).field(GRADIENT,"_-3-b").field(GRADIENT,"_-0t").field(GRADIENT,"_-1ux").op(0x56,3).op(0x48),3,method(GRADIENT,"colors"));
  abc=swf.getAbcList().get(1).getABC();
 }
 static void room62()throws Exception{
  room();
  var mounted=method(DESKTOP,"_-1oc");int at=callIndex(mounted,"color",1);mounted.getCode().code.get(at).operands[0]=publicName("mount");mounted.setCodeBytes(mounted.getCode().getBytes());mounted.getCode();mounted.setModified();
  observe(HUI,"_-4P7",new Code().op(0x60,helper("RoomAppearance61")).field(HUI,"_-3x9").op(0xd1).op(0x46,publicName("roomColor"),2).branch(0x12,1).op(0x47),3);
  // Suppress the visual entrance hole only. The room engine still records the
  // server entrance coordinates; furniture/window masks keep their native path.
  var entranceId=new Code().op(0xd1).op(0x66,member(MASK,"_-4VP")).op(0x2c,abc.constants.getStringId("door_",true)).op(0x46,publicName("indexOf"),1).op(0x24,0).branch(0x14,1).op(0x47);
  var guard=new Code().op(0xd1).op(0x66,member(MASK,"_-0K3")).op(0x2c,abc.constants.getStringId("door",true)).branch(0x14,entranceId.bytes().length);guard.out.write(entranceId.bytes());observe(LOGIC,"_-3uS",guard,2);
  returns(method(MAINVIEW,"_-38x"),new Code().op(0x60,helper("RoomAppearance61")).op(0xd1).op(0x4f,publicName("viewChanged"),1),2);
 }
 static Code loginDelegate(String name,String dictionary){return new Code().op(0x60,helper("Login62")).op(0xd1).op(0x60,stat(LOGIN,dictionary)).op(0x4f,publicName(name),2);}
 static void login62()throws Exception{
  for(String[] spec:new String[][]{{"layoutTokenLogin","layout","_tokenScreens"},{"tokenLoginAction","submit","_tokenActions"}}){var body=smethod(LOGIN,spec[0]);body.setCodeBytes(new Code().op(0xd0).op(0x30).bytes());var out=new ByteArrayOutputStream();out.write(new byte[]{(byte)0xd0,0x30});out.write(loginDelegate(spec[1],spec[2]).bytes());out.write(0x47);body.setCodeBytes(out.toByteArray());body.max_stack=3;body.exceptions=new ABCException[0];body.getCode();body.setModified();}
  prefix(smethod(LOGIN,"disposeTokenLogin"),loginDelegate("release","_tokenScreens"),3);
 }
 public static void main(String[]a)throws Exception{
  byte[] input=Files.readAllBytes(Path.of(a[0]));if(!HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)).equals("de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901"))throw new IllegalArgumentException("Exact original Teste33 SWF required");
  swf=new SWF(new ByteArrayInputStream(input),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  for(String name:List.of("Console61","RoomAppearance61","Login62")){var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());}
  chat();room62();login62();backgroundAccess();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}
  try(var out=new FileOutputStream(a[1])){swf.saveTo(out);}
  System.out.println("PASS: exact33/token; console61 retained; actual native background renderer, early/live Toner state, visual door mask and login presentation62 installed.");
 }
}

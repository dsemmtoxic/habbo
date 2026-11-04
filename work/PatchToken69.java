import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken69 extends PatchToken68 {
 static final String TOUCH69="com.sulake.room.renderer:RoomTouchHandler",OBJECT69="com.sulake.habbo.room:RoomObjectEventHandler",LATENCY69="com.sulake.habbo.tracking:LatencyTracker",DETAILVIEW69="com.sulake.habbo.tablet.navigator:RoomDetailsView";
 static void clickProtocol69()throws Exception {
  var data=instance("loginpatch:UserClick69");data.interfaces=new int[]{rawClass("_-0tl::_-15i")};
  for(var t:data.instance_traits.traits)if(t instanceof TraitMethodGetterSetter&&AuditStartup.name(abc,t.name_index).equals("messageArray"))t.name_index=publicName("_-0tq");
  int header=currentTables(new SWF(new FileInputStream("work/plus.swf"),false)).get("_composers").get("com.sulake.habbo.communication.messages.outgoing.room:ClickCharacterComposer");if(header!=2515)throw new IllegalStateException("Reference user-click header changed");
  for(var table:CompareProtocol.read("work/HabboTablet_Token68_Base33.swf","_-0cq::_-0z0").values())if(table.containsKey(header))throw new IllegalStateException("Click header already mapped: "+table.get(header));
  var add=new Code().op(0xd0).op(0x25,header).op(0x60,rawClass("loginpatch::UserClick69")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
  var guarded=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,add.bytes().length);guarded.out.writeBytes(add.bytes());var manager=method(MESSAGE_CLASSES,"_-2aE");insertInclusive(manager,manager.getCode().code.size()-1,guarded,4);
 }
 static void avatar69()throws Exception {
  var tap=method(TOUCH69,"_-1Hy");int at=-1;for(int i=0;i<tap.getCode().code.size();i++)if((tap.getCode().code.get(i).getBytes()[0]&255)==0xd6){at=i+1;break;}if(at<0)throw new IllegalStateException("Tap hit vector missing");insertInclusive(tap,at,new Code().op(0x60,helper("Avatar69")).op(0xd2).op(0x4f,publicName("filterHits"),1),2);
  var hold=method(TOUCH69,"_-01v");at=-1;for(int i=0;i<hold.getCode().code.size();i++)if((hold.getCode().code.get(i).getBytes()[0]&255)==0xd7){at=i+1;break;}if(at<0)throw new IllegalStateException("Long-press session boundary missing");insertInclusive(hold,at,new Code().op(0x60,helper("Avatar69")).op(0x62,4).field(TOUCH69,"_-0zB").op(0x66,publicName("desktop")).op(0xd2).op(0xd3).op(0x46,publicName("longPress"),4).branch(0x12,1).op(0x47),5);
  prefix(method(OBJECT69,"_-1bd"),new Code().op(0x60,helper("Avatar69")).op(0xd1).field(OBJECT69,"_roomEngine").op(0x46,publicName("ignore"),2).branch(0x12,2).op(0x27).op(0x48),3);
  var menu=method(PEER,"_-0G7");at=-1;for(int i=0;i<menu.getCode().code.size();i++){var ins=menu.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x46&&AuditStartup.name(abc,ins.operands[0]).equals("_-00q")){at=i-1;break;}}if(at<0)throw new IllegalStateException("Trade menu boundary missing");insertInclusive(menu,at,new Code().op(0x60,helper("Avatar69")).op(0xd1).op(0x4f,publicName("menu"),1),2);
  prefix(method(PEER,"_-0wY"),new Code().op(0x60,helper("Avatar69")).op(0xd1).field(PEER,"_-33k").field(PEER,"_-RY").op(0x46,publicName("action"),3).branch(0x12,1).op(0x47),4);
 }
 static void ping69()throws Exception {
  prefix(smethod(LOGIN,"runCommand"),new Code().op(0x60,helper("Ping69")).op(0xd1).op(0xd2).op(0x46,publicName("run"),2).branch(0x12,2).op(0x26).op(0x48),3);
  prefix(method(LATENCY69,"onPingResponse"),new Code().op(0x60,helper("Ping69")).op(0xd1).op(0x46,publicName("response"),1).branch(0x12,1).op(0x47),2);
  prefix(smethod(LOGIN,"resetAccountState"),new Code().op(0x60,helper("Ping69")).op(0x4f,publicName("reset"),0),1);
 }
 static void market69()throws Exception {
  addMethod(MARKET25,"marketCount69",new Code().op(0xd0).op(0x30).op(0xd0).field(MARKET25,"_-3lm").op(0x66,publicName("length")).op(0x61,member(MARKET25,"_-158")).op(0x47),2,1,new int[0],false,method(MARKET25,"_-xE"),1);
  prefix(method(MARKET_VIEW25,"_-qu"),new Code().op(0x60,helper("Market68")).field(MARKET_VIEW25,"_-44h").op(0x27).op(0x4f,publicName("filter"),2),3);
  prefix(method(MARKET_VIEW25,"dispose"),new Code().op(0x60,helper("Market68")).op(0xd0).op(0x4f,publicName("releaseView"),1),2);
 }
 static void promotionSpace69() {
  var c=instance(DETAILVIEW69);int ci=abc.instance_info.indexOf(c);var init=abc.findBody(abc.class_info.get(ci).cinit_index);int changes=0;
  for(int i=0;i<init.getCode().code.size();i++){var ins=init.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x25&&ins.operands[0]==350){init.replaceInstruction(i,new com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction(0,0x25,new int[]{390}));changes++;}}
  if(changes!=1)throw new IllegalStateException("Fixed pager height boundary differs: "+changes);init.setCodeBytes(init.getCode().getBytes());init.getCode();init.setModified();
 }
 public static void main(String[]args)throws Exception {
  PatchToken68.main(args);swf=new SWF(new FileInputStream(args[1]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  for(String name:List.of("UserClick69","Avatar69","Ping69")){var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());System.out.println("Compiled "+name);}
  clickProtocol69();avatar69();ping69();market69();promotionSpace69();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}System.out.println("PASS:69 built from exact33; one-row event details, only active own offers, measured private/public ping and explicit avatar click.");
 }
}

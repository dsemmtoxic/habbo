import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.abc.avm2.instructions.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken70 extends PatchToken69 {
 static final String INPUT70="com.sulake.habbo.chat.input:ChatInput",HISTORY70="com.sulake.habbo.chat.history:ChatHistoryItemRenderer",ITEM70="com.sulake.habbo.chat.discussion.data:ChatItem",SLOT70="com.sulake.habbo.profile.avatar.slot:BadgesSlot",SELECT70="com.sulake.habbo.profile.avatar.slot:BadgeSelector";
 static void style70()throws Exception {
  var template=method(INPUT70,"_-1P1");
  for(String[]p:new String[][]{{"chatStyleItems70","_-Uo"},{"chatStyleDisposed70","_disposed"}})getter(INPUT70,p[0],new Code().op(0xd0).op(0x30).field(INPUT70,p[1]).op(0x48),1,template);
  getter(INPUT70,"chatCurrentStyle70",new Code().op(0xd0).op(0x30).op(0xd0).op(0x46,member(INPUT70,"_-7I"),0).op(0x48),1,template);
  addMethod(INPUT70,"chatPickStyle70",new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0x4f,member(INPUT70,"_-1-y"),1).op(0xd0).op(0x4f,member(INPUT70,"_-0S7"),0).op(0x47),2,2,new int[]{publicName("Object")},false,template,1);
  replaceBody(template,new Code().op(0xd0).op(0x30).op(0x60,helper("ChatStyles70")).op(0xd0).op(0x4f,publicName("open"),1).op(0x47),2);
  prefix(method(INPUT70,"dispose"),new Code().op(0x60,helper("ChatStyles70")).op(0xd0).op(0x4f,publicName("release"),1),2);
 }
 static void history70()throws Exception {
  returns(constructor(ITEM70),new Code().op(0x60,helper("RoomHistory70")).op(0xd0).op(0x4f,publicName("stamp"),1),2);
  var body=method(HISTORY70,"commitData");returns(body,new Code().op(0x60,helper("RoomHistory70")).op(0xd0).op(0xd0).op(0x66,namedReference(body,"_-0SL")).field(HISTORY70,"_-1vz").op(0x4f,publicName("decorate"),3),4);
  // This renderer inherits dispose; add an override that releases our column
  // and still invokes the original Feathers base implementation.
  var dispose=addMethod(HISTORY70,"dispose",new Code().op(0xd0).op(0x30).op(0x60,helper("RoomHistory70")).op(0xd0).op(0x4f,publicName("release"),1).op(0xd0).op(0x4e,publicName("dispose"),0).op(0x47),2,1,new int[0],false,body,1);
  abc.method_info.get(dispose.method_info).ret_type=publicName("void");
  for(var t:instance(HISTORY70).instance_traits.traits)if(t instanceof TraitMethodGetterSetter&&AuditStartup.name(abc,t.name_index).equals("dispose"))t.kindFlags|=2;
 }
 static void roomUse70()throws Exception {
  var template=method(TOUCH69,"_-1FL");
  for(String[]p:new String[][]{{"tapCanvas70","_-0zB"},{"tapBlocked70","_-0Gh"},{"singleTapGesture70","_-3nS"}})getter(TOUCH69,p[0],new Code().op(0xd0).op(0x30).field(TOUCH69,p[1]).op(0x48),1,template);
  addMethod(TOUCH69,"tapObjects70",new Code().op(0xd0).op(0x30).op(0xd0).field(TOUCH69,"_-1QM").op(0xd1).op(0x46,publicName("globalToLocal"),1).op(0x46,member(TOUCH69,"_-3My"),1).op(0x48),3,2,new int[]{publicName("Object")},false,template,1);
  prefix(template,new Code().op(0x60,helper("RoomUse70")).op(0xd0).op(0xd1).op(0x46,publicName("singleTap"),2).branch(0x12,1).op(0x47),3);
  var configure=new Code().op(0x60,helper("RoomUse70")).op(0xd0).op(0x4f,publicName("gesture"),1);returns(constructor(TOUCH69),configure,2);returns(method(TOUCH69,"_-0PU"),configure,2);
  prefix(method(TOUCH69,"dispose"),new Code().op(0x60,helper("RoomUse70")).op(0xd0).op(0x4f,publicName("release"),1),2);
  prefix(method(DESKTOP,"useObject"),new Code().op(0x60,helper("RoomUse70")).op(0xd0).op(0xd1).op(0x46,publicName("present"),2).branch(0x12,1).op(0x47),3);
 }
 static void badgeProtocol70()throws Exception {
  var data=instance("loginpatch:BadgesQuery70");data.interfaces=new int[]{rawClass("_-0tl::_-15i")};for(var t:data.instance_traits.traits)if(t instanceof TraitMethodGetterSetter&&AuditStartup.name(abc,t.name_index).equals("messageArray"))t.name_index=publicName("_-0tq");
  int header=currentTables(new SWF(new FileInputStream("work/plus.swf"),false)).get("_composers").get("com.sulake.habbo.communication.messages.outgoing.inventory.badges:GetBadgesComposer");if(header!=1505)throw new IllegalStateException("Reference badge request differs");
  for(var table:CompareProtocol.read("work/HabboTablet_Token69_Base33.swf","_-0cq::_-0z0").entrySet())if(!table.getKey().endsWith("::_-0up")&&table.getValue().containsKey(header))throw new IllegalStateException("Badge query header collision "+table.getValue().get(header));
  var add=new Code().op(0xd0).op(0x25,header).op(0x60,rawClass("loginpatch::BadgesQuery70")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);var guard=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,add.bytes().length);guard.out.writeBytes(add.bytes());var registry=method(MESSAGE_CLASSES,"_-2aE");insertInclusive(registry,registry.getCode().code.size()-1,guard,4);
 }
 static void badges70()throws Exception {
  var update=method(SLOT70,"_-41D");for(String[]p:new String[][]{{"badgeManager70","_-32n"},{"badgeCommunication70","_communication"},{"badgeEditable70","_-4HD"}})getter(SLOT70,p[0],new Code().op(0xd0).op(0x30).field(SLOT70,p[1]).op(0x48),1,update);
  addMethod(SLOT70,"badgeInfo70",new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0xd2).op(0xd3).op(0x4f,member(SLOT70,"_-3vw"),3).op(0x47),4,4,new int[]{publicName("String"),publicName("Object"),publicName("Boolean")},false,update,1);
  returns(update,new Code().op(0x60,helper("Badges70")).op(0xd0).op(0xd2).op(0x4f,publicName("prepare"),2),3);
  replaceBody(method(SLOT70,"_-4Bl"),new Code().op(0xd0).op(0x30).op(0x60,helper("Badges70")).op(0xd0).op(0xd1).field(SLOT70,"_-0yC").op(0x4f,publicName("touch"),3).op(0x47),4);
  prefix(method(SLOT70,"dispose"),new Code().op(0x60,helper("Badges70")).op(0xd0).op(0x4f,publicName("releaseSlot"),1),2);
  var open=method(SELECT70,"_-4AP");getter(SELECT70,"badgeSlot70",new Code().op(0xd0).op(0x30).field(SELECT70,"_-3Uc").op(0x48),1,open);
  prefix(open,new Code().op(0x60,helper("Badges70")).op(0xd0).op(0xd1).op(0xd2).op(0x46,publicName("wait"),3).branch(0x12,1).op(0x47),4);
  prefix(method(SELECT70,"dispose"),new Code().op(0x60,helper("Badges70")).op(0xd0).op(0x4f,publicName("releaseSelector"),1),2);
  var select=method(SELECT70,"_-3yA");int field=member(SELECT70,"_-2ER");int removed=0;
  for(int i=0;i<select.getCode().code.size();i++){var ins=select.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x61&&ins.operands[0]==field){if(i<3||(select.getCode().code.get(i-3).getBytes()[0]&255)!=0x26)throw new IllegalStateException("Badge dirty assignment differs");for(int j=i-3;j<=i;j++)select.replaceInstruction(j,new AVM2Instruction(0,0x02,new int[0]));removed++;}}
  if(removed!=1)throw new IllegalStateException("Expected one late badge dirty assignment");select.setCodeBytes(select.getCode().getBytes());select.getCode();int at=-1;for(int i=0;i<select.getCode().code.size();i++){var ins=select.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x60&&ins.operands[0]==member(SELECT70,"_-3U")){at=i;break;}}if(at<0)throw new IllegalStateException("Badge close boundary absent");insertInclusive(select,at,new Code().op(0xd0).op(0x26).op(0x61,field),2);
 }
 public static void main(String[]args)throws Exception {
  PatchToken69.main(args);swf=new SWF(new FileInputStream(args[1]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  for(String name:List.of("BadgesQuery70","ChatStyles70","RoomHistory70","RoomUse70","Badges70")){var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());System.out.println("Compiled "+name);}
  style70();history70();roomUse70();badgeProtocol70();badges70();
  var reset=new Code();for(String name:List.of("RoomHistory70","RoomUse70","Badges70"))reset.op(0x60,helper(name)).op(0x4f,publicName("reset"),0);reset.op(0x60,helper("ChatStyles70")).op(0x20).op(0x4f,publicName("close"),1);prefix(smethod(LOGIN,"resetAccountState"),reset,2);
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}System.out.println("PASS:70 built from exact33; bounded modal style selector, history date/time column, compact event duration, owned badge loading/saving, single-tap DC and visitor present reading.");
 }
}

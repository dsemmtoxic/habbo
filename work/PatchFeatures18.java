import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;
import com.jpexs.decompiler.flash.abc.avm2.instructions.*;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.tags.Tag;

// Incremental patch: input is Teste17 with its helper script replaced, retaining
// all existing protocol, editor, login, console and fullscreen corrections.
class PatchFeatures18 extends PatchOldLogin {
 static final String EVENT="com.sulake.habbo.tablet.catalog.viewer.controller.page.legacy:RoomEventPageViewController";
 static final String HMENU="com.sulake.habbo.hmenu:HMenu";
 static final String BUBBLE="com.sulake.habbo.chat.discussion.viewer.visualization:Bubble";
 static final String TOUCH="com.sulake.room.renderer:RoomTouchHandler";
 static void atReturns(MethodBody body,Code code,int max)throws Exception {
  for(int i=body.getCode().code.size()-1;i>=0;i--){int op=body.getCode().code.get(i).getBytes()[0]&255;
   if(op==0x47||op==0x48){body.setCodeBytes(body.getCode().getBytes());body.getCode();insertInclusive(body,i,code,max);}
  }
 }
 static void eventPickers()throws Exception {
  Code refresh=new Code().op(0x60,helperName()).op(0xd0).field(EVENT,"_-3lo").field(EVENT,"_-0If").field(EVENT,"_-ea").field(EVENT,"_-3HX").op(0x4f,publicName("refreshEventSelectors"),5);
  for(String name:List.of("view","_-1ff","_-IR"))atReturns(method(EVENT,name),refresh,8);
  for(String name:List.of("_-1ff","_-IR"))observe(EVENT,name,new Code().field(EVENT,"_-3lo").branch(0x11,1).op(0x47),1);
  atReturns(method(EVENT,"view"),new Code().op(0x60,helperName()).field(EVENT,"_-3HX").op(0x4f,publicName("requestEventLists"),1),8);
  var request=method(CATALOG,"_-0KD");request.setCodeBytes(new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd0).op(0x4f,publicName("requestEventLists"),1).op(0x47).bytes());request.max_stack=2;request.getCode();request.setModified();
  beforeReturn(method(CATALOG,"_-60"),new Code().op(0x60,helperName()).op(0xd0).field(CATALOG,"_-2gB").op(0x4f,publicName("eventCategoriesArrived"),2),3);
 }
 static void bubbles()throws Exception {
  observe(BUBBLE,"_-2ZE",handled(new Code().op(0x60,helperName()).field(BUBBLE,"_-47m").field(BUBBLE,"_-2Ov").field(BUBBLE,"_-ze").op(0x46,publicName("positionChatIcon"),3)),4);
 }
 static void catalog()throws Exception {
  Code save=new Code().op(0x60,helperName()).op(0xd0).field(CATALOG_VIEW,"_-2Zi").field(CATALOG_VIEW,"_-vR").op(0x4f,publicName("rememberCatalogPosition"),3);
  observe(CATALOG_VIEW,"removeFromParent",save,4);
  observe(CATALOG_VIEW,"_-bK",save,4);
  Code restore=new Code().op(0x60,helperName()).op(0xd0).field(CATALOG_VIEW,"_-2Zi").op(0x4f,publicName("catalogTypeChanged"),2);
  // Only the actual type-change return, not the early same-type return.
  beforeReturn(method(CATALOG_VIEW,"_-bK"),restore,3);
  beforeReturn(method(CATALOG_VIEW,"onAddedToStage"),restore,3);
  observe(CATALOG_VIEW,"_-1uy",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("catalogPageChosen"),1),2);
  beforeReturn(method(CATALOG_VIEW,"_-0fb"),new Code().op(0x60,helperName()).op(0xd0).field(CATALOG_VIEW,"_-2Zi").op(0xd1).op(0x4f,publicName("rememberCatalogPage"),3),4);
  observe(CATALOG,"_-Hx",handled(new Code().op(0x60,helperName()).op(0xd0).field(CATALOG,"_-2gB").op(0xd1).op(0x46,publicName("catalogLink"),3)),4);
  observe(CATALOG_VIEW,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("clearCatalogHistory"),1),2);
  // The BC menu must survive a temporary removal while placing furniture.
  var body=method(CATALOG_VIEW,"removeFromParent");int changed=0;
  for(int i=0;i<body.getCode().code.size();i++){
   var ins=body.getCode().code.get(i);int op=ins.getBytes()[0]&255;
   if((op==0x4f||op==0x46)&&"reset".equals(abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index))){
    if(op!=0x4f||ins.operands[1]!=0)throw new IllegalStateException("Unexpected catalog reset call");
    body.replaceInstruction(i,new AVM2Instruction(0,0x29,new int[0]));changed++;
   }
  }
  if(changed!=1)throw new IllegalStateException("Expected one BC-removal reset");body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
 }
 static void furniture()throws Exception {
  int canvas=member(TOUCH,"_-0zB"),container=member(TOUCH,"_-1QM"),hitTest=member(TOUCH,"_-3My");
  Code active=new Code().op(0x60,helperName()).op(0x46,publicName("wiredFurniturePicking"),0);
  // Use the existing native pixel/depth hit test, with its actual namespaces.
  Code choose=new Code().op(0x60,helperName()).op(0xd0).op(0x66,canvas)
   .op(0xd0).op(0xd0).op(0x66,container).op(0xd1).op(0x66,publicName("target")).op(0x66,publicName("location"))
   .op(0x46,publicName("globalToLocal"),1).op(0x46,hitTest,1).op(0x4f,publicName("wiredFurnitureTap"),2).op(0x47);
  Code prefix=new Code();prefix.out.writeBytes(active.bytes());prefix.branch(0x12,choose.bytes().length);prefix.out.writeBytes(choose.bytes());
  observe(TOUCH,"_-1FL",prefix,6);
  for(String name:List.of("_-4VQ","_-01v","_-2W3"))observe(TOUCH,name,handled(new Code().op(0x60,helperName()).op(0x46,publicName("wiredFurniturePicking"),0)),1);
 }
 static void hmenu()throws Exception {
  var body=method(HMENU,"_-45c");int at=-1,push=-1;
  for(int i=0;i<body.getCode().code.size();i++){
   var ins=body.getCode().code.get(i);
   if((ins.getBytes()[0]&255)==0x2c&&"${toolbar.logout}".equals(abc.constants.getString(ins.operands[0]))){
    for(int j=i-1;j>=0;j--)if((body.getCode().code.get(j).getBytes()[0]&255)==0xd1){at=j;break;}
    for(int j=i+1;j<body.getCode().code.size();j++){var x=body.getCode().code.get(j);int op=x.getBytes()[0]&255;if((op==0x46||op==0x4f)&&"push".equals(abc.constants.getString(abc.constants.getMultiname(x.operands[0]).name_index))){push=x.operands[0];break;}}
   }
  }
  if(at<0||push<0)throw new IllegalStateException("Missing native logout menu boundary");
  Code items=new Code();String[] labels={"Privacidade","Lucros"};
  for(int i=0;i<labels.length;i++)items.op(0xd1).op(0x60,rawClass("_-1R8::_-1e8")).op(0x2c,abc.constants.getStringId(labels[i],true)).op(0x20).op(0x20).op(0x20).op(0x25,18001+i).op(0x42,5).op(0x4f,push,1);
  insertInclusive(body,at,items,7);
  observe(HMENU,"_-0wY",handled(new Code().op(0x60,helperName()).op(0xd0).field(HMENU,"_-33k").op(0xd1).op(0x66,publicName("data")).op(0x46,publicName("featureMenuSelected"),3)),4);
 }
 static void income(SWF swf,SWF plus)throws Exception {
  var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);
  for(String name:List.of("IncomeStatusPayload","IncomeClaimPayload","EventCategoriesPayload","RoomAdInfoPayload")){
   ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
   abc.instance_info.stream().filter(c->qname(abc,c.name_index).equals("loginpatch::"+name)).findFirst().orElseThrow().interfaces=new int[]{rawClass("_-0tl::_-15i")};
  }
  var tables=currentTables(plus);var out=tables.get("_composers");var in=tables.get("_events");String pkg="com.sulake.habbo.communication.messages.";
  int status=out.get(pkg+"outgoing.vault:IncomeRewardStatusMessageComposer"),claim=out.get(pkg+"outgoing.vault:IncomeRewardClaimMessageComposer");
  Code aliases=new Code().op(0xd0).op(0x25,status).op(0x60,rawClass("loginpatch::IncomeStatusPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2)
   .op(0xd0).op(0x25,claim).op(0x60,rawClass("loginpatch::IncomeClaimPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2)
   .op(0x60,helperName()).op(0x25,in.get(pkg+"incoming.vault:IncomeRewardStatusMessageEvent")).op(0x25,in.get(pkg+"incoming.vault:IncomeRewardClaimResponseMessageEvent")).op(0x25,in.get(pkg+"incoming.vault:IncomeRewardNotificationMessageEvent")).op(0x25,claim).op(0x4f,publicName("initAccountProtocol"),4);
  aliases.op(0xd0).op(0x25,out.get(pkg+"outgoing.navigator:GetUserEventCatsMessageComposer")).op(0x60,rawClass("loginpatch::EventCategoriesPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2)
   .op(0xd0).op(0x25,out.get(pkg+"outgoing.catalog:GetRoomAdPurchaseInfoComposer")).op(0x60,rawClass("loginpatch::RoomAdInfoPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
  Code guarded=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,aliases.bytes().length);guarded.out.writeBytes(aliases.bytes());
  insertInclusive(method(MESSAGE_CLASSES,"_-2aE"),method(MESSAGE_CLASSES,"_-2aE").getCode().code.size()-1,guarded,5);
  // This verified current composer contains a BYTE, unsupported by the old
  // encoder. Only this registered header is serialized through this branch.
  Code encoded=new Code().op(0x60,helperName()).op(0xd1).op(0xd2).op(0x46,publicName("encodeIncomeClaim"),2).op(0x2a).branch(0x12,1).op(0x48).op(0x29);
  observe(WIRE,"encode",encoded,3);
  System.out.println("Income: request="+status+", claim="+claim+" (single-byte category)");
 }
 public static void main(String[]args)throws Exception {
  SWF swf=new SWF(new FileInputStream(args[0]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  bubbles();eventPickers();catalog();furniture();hmenu();income(swf,new SWF(new FileInputStream(args[2]),false));
  for(var body:abc.bodies)body.getCode().checkValidOffsets(body);
  ((Tag)swf.getAbcList().get(1)).setModified(true);
  try(var file=new FileOutputStream(args[1])){swf.saveTo(file);}
  System.out.println("Saved incremental Teste18 SWF: "+args[1]);
 }
}

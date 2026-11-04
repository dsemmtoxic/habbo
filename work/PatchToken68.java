import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;import com.jpexs.decompiler.flash.abc.avm2.instructions.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken68 extends PatchToken67 {
 static final String NAV21=PatchFeatures21.NAV21,MARKET25=PatchFeatures25.MARKET25,MARKET_VIEW25=PatchFeatures25.MARKET_VIEW25,MARKET_ROW25=PatchFeatures25.MARKET_ROW25;
 static int namedReference(MethodBody body,String name){return PatchFeatures23.namedReference(body,name);}
 static final String GUEST68="com.sulake.habbo.communication.messages.incoming.navigator:GuestRoomData",SEARCH68="com.sulake.habbo.communication.messages.incoming.navigator:GuestRoomSearchResultData",ROW68="com.sulake.habbo.tablet.navigator:RoomListItemRenderer",DETAILS68="com.sulake.habbo.tablet.navigator:RoomDetailsRenderer",NAVDATA68="com.sulake.habbo.tablet.navigator:NavigatorData",LOCAL68="com.sulake.core.localization:Localization";
 static MethodBody kindMethod(String owner,String name,int kind){for(var t:instance(owner).instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==kind&&AuditStartup.name(abc,t.name_index).equals(name))return abc.findBody(m.method_info);throw new IllegalStateException(owner+" "+name+" kind "+kind);}
 static void replaceBody(MethodBody body,Code code,int stack){body.setCodeBytes(code.bytes());body.max_stack=stack;body.exceptions=new ABCException[0];body.getCode();body.setModified();}
 static void wrapValues(MethodBody body,String helper,String function)throws Exception {for(int i=body.getCode().code.size()-1;i>=0;i--)if((body.getCode().code.get(i).getBytes()[0]&255)==0x48)insertInclusive(body,i,new Code().op(0x60,helper(helper)).op(0x2b).op(0x46,publicName(function),1),body.max_stack+1);}
 static void text68()throws Exception {
  prefix(smethod(LOGIN,"selectHotelLanguage"),new Code().op(0x60,helper("Text68")).op(0xd2).op(0x4f,publicName("select"),1),2);
  wrapValues(smethod(LOGIN,"localText"),"Text68","get");wrapValues(smethod(LOGIN,"tr"),"Text68","clean");wrapValues(method(LOCAL68,"_-WP"),"Text68","clean");
  prefix(smethod(LOGIN,"commandNotice"),new Code().op(0x60,helper("Text68")).op(0xd1).op(0x46,publicName("clean"),1).op(0xd5),2);
  var clean=new Code();for(int arg:List.of(1,2))clean.op(0x60,helper("Text68")).op(0x62,arg).op(0x46,publicName("get"),1).op(0x63,arg);prefix(method(DEMO,"alert"),clean,2);
 }
 static void mask68()throws Exception {
  var template=method(CANVAS,"render");
  for(String[] pair:new String[][]{{"entryLayer68","_-1Mx"},{"entryOffsetX68","_wd2"},{"entryOffsetY68","_ht2"},{"entryEnabled68","_-1Kj"}})getter(CANVAS,pair[0],new Code().op(0xd0).op(0x30).field(CANVAS,pair[1]).op(0x48),1,template);
  getter(CANVAS,"entryView68",new Code().op(0xd0).op(0x30).field(CANVAS,"_-1xX").op(0x2a).branch(0x11,3).op(0x29).op(0x20).op(0x48).op(0x46,propertyCall(template,"_-Eq"),0).op(0x48),2,template);
  getter(PLANE,"entryDisposed68",new Code().op(0xd0).op(0x30).field(PLANE,"_disposed").op(0x48),1,method(PLANE,"dispose"));
  returns(template,new Code().op(0x60,helper("Entrance68")).op(0xd0).op(0x4f,publicName("update"),1),2);
  prefix(method(CANVAS,"dispose"),new Code().op(0x60,helper("Entrance68")).op(0xd0).op(0x4f,publicName("release"),1),2);
 }
 static void navigator68()throws Exception {
  var body=method(NAV21,"_-1Lq");int fav=rawClass("_-0It::_-4NY"),friends=rawClass("_-0It::_-0Ro");int a=0,b=0,c=0,d=0;
  for(int i=body.getCode().code.size()-1;i>=0;i--){var ins=body.getCode().code.get(i);int op=ins.getBytes()[0]&255;
   if((op==0x5d||op==0x60||op==0x4a)&&ins.operands[0]==fav){int[] values=ins.operands.clone();values[0]=friends;body.replaceInstruction(i,new AVM2Instruction(0,op,values));a++;}
   else if((op==0x5d||op==0x60||op==0x4a)&&ins.operands[0]==friends){int[] values=ins.operands.clone();values[0]=fav;body.replaceInstruction(i,new AVM2Instruction(0,op,values));b++;}
   else if(op==0x2c){String value=abc.constants.getString(ins.operands[0]);
    if(value.equals("${navigator.navibutton.6}")){body.replaceInstruction(i,new AVM2Instruction(0,0x2c,new int[]{abc.constants.getStringId("Quartos com amigos",true)}));c++;}
    else if(value.equals("Quartos com meus amigos")){body.replaceInstruction(i,new AVM2Instruction(0,0x2c,new int[]{abc.constants.getStringId("${navigator.navibutton.6}",true)}));d++;}
   }else if((op==0x4f||op==0x46)&&AuditStartup.name(abc,ins.operands[0]).equals("_-0Fc")){var old=body.getCode().code.get(i-1);if((old.getBytes()[0]&255)!=0x24||old.operands[0]!=2)throw new IllegalStateException("Unexpected old friends menu index");body.replaceInstruction(i-1,new AVM2Instruction(0,0x24,new int[]{3}));}
  }
  if(a!=2||b!=1||c!=1||d!=1)throw new IllegalStateException("Unexpected navigation substitutions "+List.of(a,b,c,d));body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
  for(int i=0;i<body.getCode().code.size();i++){var ins=body.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x2c&&abc.constants.getString(ins.operands[0]).equals("Quartos com amigos")){insertInclusive(body,i+1,new Code().op(0x60,helper("Text68")).op(0x2b).op(0x46,publicName("get"),1),body.max_stack+1);break;}}
 }
 static void promotions68()throws Exception {
  returns(constructor(GUEST68),new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0x4f,publicName("capture"),1),2);
  returns(method(GUEST68,"update"),new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0xd1).op(0x4f,publicName("capture"),2),3);
  returns(constructor(SEARCH68),new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0x4f,publicName("search"),1),2);
  var row=method(ROW68,"commitData");returns(row,new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0x66,namedReference(row,"_-0SL")).field(ROW68,"_-2Sy").op(0x4f,publicName("listTitle"),2),3);
  var details=method(DETAILS68,"commitData");returns(details,new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0xd0).op(0x66,namedReference(details,"_-0SL")).field(DETAILS68,"_-1Ur").op(0x66,publicName("parent")).op(0x4f,publicName("details"),3),4);
  prefix(method(DETAILS68,"dispose"),new Code().op(0x60,helper("RoomUI68")).op(0xd0).op(0x4f,publicName("release"),1),2);
  returns(kindMethod(NAVDATA68,"_-1Sf",3),new Code().op(0x60,helper("RoomUI68")).op(0xd1).op(0xd0).op(0x66,member(NAVDATA68,"_-06v")).op(0x4f,publicName("roomEvent"),2),3);
  prefix(smethod(LOGIN,"resetAccountState"),new Code().op(0x60,helper("RoomUI68")).op(0x4f,publicName("reset"),0),1);
 }
 static void market68()throws Exception {
  getter(MARKET_VIEW25,"marketLogic68",new Code().op(0xd0).op(0x30).field(MARKET_VIEW25,"_-44h").op(0x48),1,method(MARKET_VIEW25,"_-3WO"));
  var row=method(MARKET_ROW25,"commitData");returns(row,new Code().op(0x60,helper("Market68")).field(MARKET_ROW25,"_-3xH").op(0xd0).op(0x66,namedReference(row,"_-0SL")).field(MARKET_ROW25,"_controller").op(0xd0).op(0x66,member(MARKET_ROW25,"_-3Ui")).op(0x4f,publicName("bind"),4),5);
  prefix(method(MARKET_ROW25,"dispose"),new Code().op(0x60,helper("Market68")).field(MARKET_ROW25,"_-3xH").op(0x4f,publicName("release"),1),2);
  returns(method(MARKET25,"_-3vm"),new Code().op(0x60,helper("Market68")).op(0xd0).op(0xd1).op(0x4f,publicName("result"),2),3);
  var refresh=new Code().op(0xd0).op(0x30).op(0xd0).field(MARKET25,"_-3lm").op(0x66,publicName("length")).op(0x61,member(MARKET25,"_-158")).field(MARKET25,"_-2rI").op(0x2a).branch(0x11,2).op(0x29).op(0x47).op(0x4f,publicName("_-4If"),0).op(0x47);
  addMethod(MARKET25,"marketRefresh68",refresh,2,1,new int[0],false,method(MARKET25,"_-xE"),1);
  returns(method(MARKET25,"_-xE"),new Code().op(0x60,helper("Market68")).op(0xd0).op(0x4f,publicName("filter"),1),2);
  prefix(method(MARKET25,"dispose"),new Code().op(0x60,helper("Market68")).op(0xd0).op(0x4f,publicName("disposeLogic"),1),2);
  var describe=new Code().op(0x60,helper("Market68")).op(0xd0).field(MARKET_VIEW25,"_-0nm").field(MARKET_VIEW25,"_-1U3").field(MARKET_VIEW25,"_-2bK").op(0x4f,publicName("describe"),4);
  returns(method(MARKET_VIEW25,"_-qu"),describe,5);var build=method(MARKET_VIEW25,"_-3cm");for(int i=build.getCode().code.size()-1;i>=0;i--)if((build.getCode().code.get(i).getBytes()[0]&255)==0x48)insertInclusive(build,i,describe,6);
 }
 public static void main(String[]args)throws Exception {
  PatchToken67.main(args);swf=new SWF(new FileInputStream(args[1]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  for(String name:List.of("Text68","DoorQuad68","Entrance68","RoomUI68","Market68")){String code=Files.readString(Path.of("work/"+name+".as"));if(name.equals("Text68"))code=code.replace("__TEXT68_ROWS__",Files.readString(Path.of("work/texts68.json")));var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(code,abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());System.out.println("Compiled "+name);}
  text68();mask68();navigator68();promotions68();market68();for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}
  System.out.println("PASS:68 built from exact33 with projected door stencil, localized login/navigation, safe display glyphs, promotion metadata/countdown and direct own-offer return binding; earnings instructions replace the redundant redeem button.");
 }
}

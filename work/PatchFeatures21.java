import java.io.*;import java.nio.file.*;import java.util.*;import java.nio.charset.StandardCharsets;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.avm2.instructions.*;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.tags.*;
import com.jpexs.helpers.ByteArrayRange;

class PatchFeatures21 extends PatchFeatures20 {
 static final String NAV21="com.sulake.habbo.tablet.navigator:NavigatorViewController";
 static void placement21()throws Exception{
  restore(new SWF(new FileInputStream("work/base19.swf"),false),CATALOG,"_-09A");
  var body=method(CATALOG,"_-09A");int at=callIndex(body,"_-1Tl",1);
  insertInclusive(body,at,new Code().op(0x60,helperName()).op(0x62,5).op(0x46,publicName("recolorStuffData"),1),body.max_stack+2);
  at=callIndex(body,"_-1Tl",1);var old=body.getCode().code.get(at);
  if(old.operands[1]!=6)throw new IllegalStateException("Expected six native placement arguments before fix");
  // replaceInstruction updates the saved byte array; mutating a decoded operand
  // before insertInclusive in Teste20 left six arguments in the saved SWF.
  body.replaceInstruction(at,new AVM2Instruction(0,0x46,new int[]{old.operands[0],7}));
  body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
 }
 static void caption21(String owner,String method,Set<String> names)throws Exception{
  var body=method(owner,method);
  for(int i=0;i<body.getCode().code.size();i++){
   var ins=body.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x2c&&names.contains(abc.constants.getString(ins.operands[0]))){
    var add=new Code().op(0x60,helperName()).op(0x2b).op(0x46,publicName("localText"),1);insertInclusive(body,i+1,add,body.max_stack+1);i+=3;
   }
  }
 }
 static void locale21(SWF swf)throws Exception{
  for(String n:List.of("_-4DM","applyLocalizationEnvironment"))observe(DEMO,n,new Code().op(0x60,helperName()).op(0xd0).op(0xd1).op(0x4f,publicName("selectHotelLanguage"),2),3);
  caption21(HMENU,"_-45c",Set.of("Lucros"));caption21(NAV21,"_-1Lq",Set.of("Todos os quartos","Quartos com meus amigos"));
  int configs=0;for(var tag:swf.getTags())if(tag instanceof DefineBinaryDataTag bin){
   var value=new String(bin.binaryData.getRangeData(),StandardCharsets.UTF_8);
   if(value.contains("localization.1=en")&&value.contains("localization.1.url=")){
    var properties=new LinkedHashMap<String,String>();for(String line:value.split("\\r?\\n")){int split=line.indexOf('=');if(split>0)properties.put(line.substring(0,split),line.substring(split+1));}
    var rebuilt=new StringBuilder("# Supported hotel localizations; current HTTPS endpoints.\n");int at=0;
    for(String lang:List.of("en","fi","de","fr","nl","pt","es","it","tr")){
     String prefix=null;for(int i=1;i<=13;i++)if(lang.equals(properties.get("localization."+i))){prefix="localization."+i;break;}if(prefix==null)throw new IllegalStateException("Missing hotel locale "+lang);
     String target="localization."+(++at);String domain=lang.equals("en")?"com":lang.equals("pt")?"com.br":lang.equals("tr")?"com.tr":lang;
     rebuilt.append(target+"="+lang+"\n"+target+".code="+properties.get(prefix+".code")+"\n"+target+".name="+properties.get(prefix+".name")+"\n"+target+".url=https://www.habbo."+domain+"/gamedata/external_flash_texts/1\n");
    }
    bin.setDataBytes(new ByteArrayRange(rebuilt.toString().getBytes(StandardCharsets.UTF_8)));bin.setModified(true);configs++;
   }
  }if(configs!=1)throw new IllegalStateException("Expected one hotel localization configuration");
 }
 static void assets21(SWF swf)throws Exception{
  var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);
  for(String name:List.of("SilverInfoPayload","LocaleData21")){
   ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
   if(name.equals("SilverInfoPayload"))abc.instance_info.stream().filter(c->qname(abc,c.name_index).equals("loginpatch::"+name)).findFirst().orElseThrow().interfaces=new int[]{rawClass("_-0tl::_-15i")};
  }
  var tables=currentTables(new SWF(new FileInputStream("work/plus.swf"),false));int silver=tables.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.nft:GetSilverMessageComposer");
  if(silver!=3332)throw new IllegalStateException("Silver query differs from the inspected reference");
  var alias=new Code().op(0xd0).op(0x25,silver).op(0x60,rawClass("loginpatch::SilverInfoPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2);
  var guarded=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,alias.bytes().length);guarded.out.writeBytes(alias.bytes());var manager=method(MESSAGE_CLASSES,"_-2aE");insertInclusive(manager,manager.getCode().code.size()-1,guarded,4);
 }
 public static void main(String[]a)throws Exception{
  var swf=new SWF(new FileInputStream(a[0]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();placement21();locale21(swf);assets21(swf);
  for(var body:abc.bodies)body.getCode().checkValidOffsets(body);((Tag)swf.getAbcList().get(1)).setModified(true);try(var out=new FileOutputStream(a[1])){swf.saveTo(out);}System.out.println("Saved Teste21: "+a[1]);
 }
}

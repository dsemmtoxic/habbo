import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;
import com.jpexs.decompiler.flash.abc.avm2.instructions.*;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.tags.*;

// Input is the verified Teste18 SWF. Never re-run the original base patch.
class PatchFeatures19 extends PatchFeatures18 {
 static final String UTILS="com.sulake.habbo.utils:CommunicationUtils";
 static final String PURSE="com.sulake.habbo.purse:PurseWidget";
 static MethodBody staticMethod(String owner,String name){
  var inst=instance(owner);int ci=abc.instance_info.indexOf(inst);
  for(var trait:abc.class_info.get(ci).static_traits.traits)if(trait instanceof TraitMethodGetterSetter m&&name.equals(abc.constants.getString(abc.constants.getMultiname(trait.name_index).name_index)))return abc.findBody(m.method_info);
  throw new IllegalStateException("Missing static method "+owner+"."+name);
 }
 static void login19()throws Exception{
  // Clear credentials exactly as before, retaining only the selected hotel.
  var body=staticMethod(UTILS,"_-2eQ");var code=body.getCode().code;int count=0;
  for(int i=1;i+2<code.size();i++)if((code.get(i).getBytes()[0]&255)==0x2c&&"environment".equals(abc.constants.getString(code.get(i).operands[0]))){
   if((code.get(i-1).getBytes()[0]&255)!=0x5d||(code.get(i+1).getBytes()[0]&255)!=0x20||(code.get(i+2).getBytes()[0]&255)!=0x4f)throw new IllegalStateException("Unexpected stored environment clear");
   for(int j=i-1;j<=i+2;j++)body.replaceInstruction(j,new AVM2Instruction(0,0x02,new int[0]));count++;
  }
  if(count!=1)throw new IllegalStateException("Expected one environment reset");body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
  beforeReturn(method(SCREEN,"initializeHandler"),new Code().op(0x60,helperName()).op(0xd0).field(BASE,"_-ZU").field(SCREEN,"_icon").op(0x4f,publicName("decorateLogin"),3),4);
 }
 static void heads19()throws Exception{
  replace(BUBBLE,"_-2PC",new Code().op(0xd0).op(0x30).op(0x60,helperName()).field(BUBBLE,"_-4Fr").op(0xd1).op(0xd2).op(0xd3).op(0xd0).op(0x4f,publicName("cacheChatFace"),5).op(0x47),6);
  var body=method(BUBBLE,"_-0ov");int count=0;
  for(var ins:body.getCode().code)if((ins.getBytes()[0]&255)==0x2c&&"chat_bubble_face_".equals(abc.constants.getString(ins.operands[0]))){ins.operands[0]=abc.constants.getStringId("chat_bubble_portrait19_",true);count++;}
  if(count!=1)throw new IllegalStateException("Missing face cache namespace");body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
 }
 static void menu19()throws Exception{
  var body=method(HMENU,"_-45c");var list=body.getCode().code;int count=0;
  for(int i=2;i<list.size();i++)if((list.get(i).getBytes()[0]&255)==0x2c&&"Privacidade".equals(abc.constants.getString(list.get(i).operands[0]))){
   if((list.get(i-2).getBytes()[0]&255)!=0xd1||(list.get(i-1).getBytes()[0]&255)!=0x60)throw new IllegalStateException("Privacy item boundary");
   int end=i;while(end<list.size()&&(list.get(end).getBytes()[0]&255)!=0x4f)end++;
   if(end>=list.size())throw new IllegalStateException("Missing push boundary");
   for(int j=i-2;j<=end;j++)body.replaceInstruction(j,new AVM2Instruction(0,0x02,new int[0]));count++;
  }
  if(count!=1)throw new IllegalStateException("Expected one Privacy item");body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
 }
 static void purse19()throws Exception{
  for(String name:List.of("createView","onAddedToStage","_-1tD")){
   String helper=name.equals("createView")?"createPurseBar":name.equals("onAddedToStage")?"purseBarAdded":"updatePurseBar";
   var code=new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd0);
   if(!name.equals("_-1tD"))code.field(PURSE,"_-33k");
   code.op(0x4f,publicName(helper),name.equals("_-1tD")?1:2);
   if(name.equals("createView"))code.op(0xd0).op(0x2c,abc.constants.getStringId("addedToStage",true)).op(0xd0).op(0x66,member(PURSE,"onAddedToStage")).op(0x4f,publicName("addEventListener"),2);
   code.op(0x47);replace(PURSE,name,code,3);
  }
  observe(PURSE,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("clearPurseBar"),1),2);
  for(String name:List.of("init","_-29a"))beforeReturn(method(CATALOG,name),new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("requestCredits"),1),2);
  observe(CATALOG,"_-3ly",new Code().op(0x60,helperName()).field(CATALOG,"_-38H").op(0x4f,publicName("creditsArrived"),1),2);
 }
 static void assets19(SWF swf,SWF plus)throws Exception{
  var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);
  for(String name:List.of("CreditsInfoPayload","UiAtlas19")){
   ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
   if(name.equals("CreditsInfoPayload"))abc.instance_info.stream().filter(c->qname(abc,c.name_index).equals("loginpatch::"+name)).findFirst().orElseThrow().interfaces=new int[]{rawClass("_-0tl::_-15i")};
  }
  var bitmap=new DefineBitsJPEG2Tag(swf);bitmap.characterID=swf.getNextCharacterId();bitmap.setImage(Files.readAllBytes(Path.of("work/UiAtlas19.png")));bitmap.setModified(true);
  var main=(Tag)swf.getAbcList().get(1);swf.addTag(swf.indexOfTag(main),bitmap);
  var binding=new SymbolClassTag(swf);binding.tags.add(bitmap.characterID);binding.names.add("loginpatch.UiAtlas19");binding.setModified(true);swf.addTag(swf.indexOfTag(main)+1,binding);
  var tables=currentTables(plus);String pkg="com.sulake.habbo.communication.messages.";
  int credits=tables.get("_composers").get(pkg+"outgoing.inventory.purse:GetCreditsInfoComposer");
  int silver=tables.get("_events").get(pkg+"incoming.collectibles:SilverBalanceMessageEvent");int emerald=tables.get("_events").get(pkg+"incoming.collectibles:EmeraldBalanceMessageEvent");
  Code aliases=new Code().op(0xd0).op(0x25,credits).op(0x60,rawClass("loginpatch::CreditsInfoPayload")).op(0x4f,member(MESSAGE_CLASSES,"_-3aS"),2)
   .op(0x60,helperName()).op(0x25,silver).op(0x25,emerald).op(0x4f,publicName("initCurrencyProtocol"),2);
  Code guarded=new Code().op(0xd1).op(0xb2,rawClass("_-0cq::_-0z0")).branch(0x12,aliases.bytes().length);guarded.out.writeBytes(aliases.bytes());
  var manager=method(MESSAGE_CLASSES,"_-2aE");insertInclusive(manager,manager.getCode().code.size()-1,guarded,4);
  System.out.println("Credit query="+credits+"; silver="+silver+"; emerald="+emerald);
 }
 public static void main(String[]a)throws Exception{
  var swf=new SWF(new FileInputStream(a[0]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  login19();heads19();menu19();purse19();assets19(swf,new SWF(new FileInputStream(a[2]),false));
  for(var body:abc.bodies)try{body.getCode().checkValidOffsets(body);}catch(Exception ex){
   for(int ci=0;ci<abc.instance_info.size();ci++){
    var ts=new ArrayList<Trait>(abc.instance_info.get(ci).instance_traits.traits);ts.addAll(abc.class_info.get(ci).static_traits.traits);
    for(var t:ts)if(t instanceof TraitMethodGetterSetter m&&m.method_info==body.method_info)System.err.println("Invalid method: "+qname(abc,abc.instance_info.get(ci).name_index)+"."+abc.constants.getString(abc.constants.getMultiname(t.name_index).name_index));
   }
   System.err.println("Invalid method_info="+body.method_info);Files.writeString(Path.of("work/feature19/invalid-body.txt"),body.getCode().toASMSource(abc));throw ex;
  }
  ((Tag)swf.getAbcList().get(1)).setModified(true);try(var f=new FileOutputStream(a[1])){swf.saveTo(f);}
  System.out.println("Saved Teste19: "+a[1]);
 }
}

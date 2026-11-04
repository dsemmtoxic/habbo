import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;
import com.jpexs.decompiler.flash.abc.avm2.instructions.*;
import com.jpexs.decompiler.flash.tags.*;

class PatchFeatures20 extends PatchFeatures19 {
 static final String LOGIN_VIEW="com.sulake.habbo.communication.demo.view:LoginView";
 static final String PREVIEW_BASIC="com.sulake.habbo.tablet.catalog.preview.content:CatalogPreviewBasicContent";
 static final String PREVIEW_BASE="com.sulake.habbo.tablet.catalog.preview.content:CatalogPreviewContentBase";
 static final String PREVIEW_IMAGE="com.sulake.habbo.tablet.catalog.preview.content.image:CatalogPreviewImage";
 static MethodBody sourceMethod(SWF source,String owner,String name){
  var c=AuditStartup.classes(source).get(owner);if(c==null)throw new IllegalStateException(owner);
  for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&AuditStartup.name(c.abc(),t.name_index).equals(name))return c.abc().findBody(m.method_info);
  throw new IllegalStateException(owner+"."+name);
 }
 static void restore(SWF source,String owner,String name)throws Exception{
  var origin=sourceMethod(source,owner,name);var src=AuditStartup.classes(source).get(owner).abc();var target=method(owner,name);
  for(var ins:origin.getCode().code){int op=ins.getBytes()[0]&255;
   if(Set.of(0x04,0x05,0x45,0x46,0x4a,0x4c,0x4e,0x4f,0x59,0x5d,0x5e,0x5f,0x60,0x61,0x66,0x68,0x6a,0x80,0x86,0xb2).contains(op)&&!qname(src,ins.operands[0]).equals(qname(abc,ins.operands[0])))throw new IllegalStateException("Constant pool mismatch "+owner+"."+name);
   if(op==0x2c&&!src.constants.getString(ins.operands[0]).equals(abc.constants.getString(ins.operands[0])))throw new IllegalStateException("String pool mismatch");
  }
  target.setCodeBytes(origin.getCodeBytes());target.max_stack=origin.max_stack;target.max_regs=origin.max_regs;target.init_scope_depth=origin.init_scope_depth;target.max_scope_depth=origin.max_scope_depth;
  target.exceptions=Arrays.stream(origin.exceptions).map(e->e.clone()).toArray(ABCException[]::new);target.getCode();target.setModified();
  System.out.println("Restored native "+owner+"."+name);
 }
 static void login20()throws Exception{
  Code init=new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0x4e,member(BASE,"initializeHandler"),1)
   .op(0x60,helperName()).op(0xd0).field(BASE,"_-2SS").field(BASE,"_controller").field(BASE,"_-ZU").op(0x46,publicName("buildTokenLogin"),4).op(0xd6);
  for(String[] entry:new String[][]{{"_-2W-","input"},{"_-3Gd","password"},{"_-1NE","remember"},{"_-P6","login"},{"_-0sU","website"},{"_icon","icon"},{"_-0ya","title"},{"_-3Nt","instructions"}})
   init.op(0xd0).op(0xd2).op(0x66,publicName(entry[1])).op(0x61,member(SCREEN,entry[0]));
  init.op(0xd0).op(0x26).op(0x61,member(BASE,"_-iK")).op(0x47);replace(SCREEN,"initializeHandler",init,5);
  replace(SCREEN,"onAddedToStage",new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1).op(0x4e,member(BASE,"onAddedToStage"),1)
   .op(0x60,helperName()).op(0xd0).op(0x4f,publicName("layoutTokenLogin"),1).op(0x47),2);
  observe(SCREEN,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("disposeTokenLogin"),1),2);
  atReturns(method(LOGIN_VIEW,"showScreen"),new Code().op(0x60,helperName()).op(0xd1).field(LOGIN_VIEW,"_-4i2").field(LOGIN_VIEW,"_loadingScreen").op(0x4f,publicName("syncLoginPresentation"),3),4);
 }
 static void purse20(SWF classic)throws Exception{
  for(String name:List.of("createView","onAddedToStage","_-1tD","dispose"))restore(classic,PURSE,name);
  beforeReturn(method(PURSE,"createView"),new Code().op(0x60,helperName()).op(0xd0).field(PURSE,"_-33k").field(PURSE,"_-0FD").field(PURSE,"_-3hg").field(PURSE,"_-06D").field(PURSE,"_-3un").op(0x4f,publicName("trackClassicPurse"),6),7);
  beforeReturn(method(PURSE,"_-1tD"),new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("updateClassicPurse"),1),2);
  var duration=method(PURSE,"_-1tD");int formats=0;
  for(int i=0;i<duration.getCode().code.size();i++){
   var ins=duration.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x46&&abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index).equals("_-2Hp")){duration.replaceInstruction(i,new AVM2Instruction(0,0x46,new int[]{publicName("_-4nr"),ins.operands[1]}));formats++;}
  }
  if(formats!=2)throw new IllegalStateException("Missing native HC duration formatter");duration.setCodeBytes(duration.getCode().getBytes());duration.getCode();duration.setModified();
  beforeReturn(method(PURSE,"onAddedToStage"),new Code().op(0x60,helperName()).field(PURSE,"_-33k").op(0x66,publicName("catalog")).op(0x4f,publicName("requestCredits"),1),2);
  observe(PURSE,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("clearPurseBar"),1),2);
 }
 static void wired20(SWF classic)throws Exception{
  for(String name:List.of("_-1FL","_-4VQ","_-01v","_-2W3"))restore(classic,TOUCH,name);
 }
 static void palette20()throws Exception{
  observe(PREVIEW_BASE,"showOffer",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("clearFurniturePalette"),1),2);
  beforeReturn(method(PREVIEW_BASE,"showOffer"),new Code().op(0x60,helperName()).op(0xd0).field(PREVIEW_BASE,"_-51").field(PREVIEW_BASE,"_-1Fo").field(PREVIEW_BASE,"preview").op(0xd1).op(0x4f,publicName("showFurniturePalette"),5),6);
  beforeReturn(method(PREVIEW_BASE,"draw"),new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("layoutFurniturePalette"),1),2);
  observe(PREVIEW_BASE,"dispose",new Code().op(0x60,helperName()).op(0xd0).op(0x4f,publicName("clearFurniturePalette"),1),2);
  replace(PREVIEW_BASE,"getPurchaseParameters",new Code().op(0xd0).op(0x30).op(0x60,helperName()).op(0xd0).op(0x46,publicName("furniturePurchaseParameters"),1).op(0x48),2);
  // Only recolorable floor furniture takes the new RGB MapStuffData path.
  var image=method(PREVIEW_IMAGE,"_-45x");
  Code result=new Code().op(0xd0).op(0x60,helperName()).field(PREVIEW_IMAGE,"_-ZD").op(0xd1).op(0xd0).op(0x46,publicName("recolorPreviewResult"),3).op(0x61,member(PREVIEW_IMAGE,"_-1qC"))
   .op(0xd0).op(0x66,member(PREVIEW_IMAGE,"_-1qC")).op(0x66,publicName("data")).op(0x48);
  Code guard=new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("isRecolorableOffer"),1).branch(0x12,result.bytes().length);guard.out.writeBytes(result.bytes());observe(PREVIEW_IMAGE,"_-45x",guard,5);
  var place=method(CATALOG,"_-09A");int count=0;
  for(int i=0;i<place.getCode().code.size();i++){
   var ins=place.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x46&&abc.constants.getString(abc.constants.getMultiname(ins.operands[0]).name_index).equals("_-1Tl")){
    if(ins.operands[1]!=6)throw new IllegalStateException("Unexpected native placement arguments");ins.operands[1]=7;
    insertInclusive(place,i,new Code().op(0x60,helperName()).op(0x62,5).op(0x46,publicName("recolorStuffData"),1),place.max_stack+2);count++;break;
   }
  }
  if(count!=1)throw new IllegalStateException("Missing placement preview call");
 }
 public static void main(String[]args)throws Exception{
  var swf=new SWF(new FileInputStream(args[0]),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  login20();purse20(new SWF(new FileInputStream("work/base18.swf"),false));wired20(new SWF(new FileInputStream("work/base17.swf"),false));palette20();
  for(var body:abc.bodies)body.getCode().checkValidOffsets(body);
  ((Tag)swf.getAbcList().get(1)).setModified(true);try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}
  System.out.println("Saved Teste20 SWF: "+args[1]);
 }
}

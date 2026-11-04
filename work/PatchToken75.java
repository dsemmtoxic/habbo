import java.io.*;
import java.nio.file.*;
import java.security.MessageDigest;
import java.util.HexFormat;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.abc.types.MethodBody;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken75 extends PatchToken74 {
 static final String BASE_SHA75="b384342f1bbe9290a86e4cb2573e723731dbdda951798e72586c172d6d598d02";
 static final String LOADER75="com.sulake.core.utils:LibraryLoader";
 static final String FIGURES75="com.sulake.habbo.avatar:AvatarAssetDownloadManager";
 static final String FIGURE_LIBRARY75="com.sulake.habbo.avatar:AvatarAssetDownloadLibrary";
 static final String EFFECT_LIBRARY75="com.sulake.habbo.avatar:EffectAssetDownloadLibrary";

 public static void main(String[] args) {
  try{patch75(Path.of(args[0]),Path.of(args[1]));}
  catch(Throwable failure){failure.printStackTrace(System.err);System.exit(1);}
 }

 static void patch75(Path base,Path target)throws Exception {
  byte[] input=Files.readAllBytes(base);
  if(!BASE_SHA75.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input))))
   throw new IllegalArgumentException("Expected exact Teste74 SWF");
  swf=new SWF(new ByteArrayInputStream(input),false);
  abc=swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());
  index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/RoomAssetQueue75.as")),abc,index,
    "RoomAssetQueue75.as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
  int helper=helper("RoomAssetQueue75");
  mark75(FIGURE_LIBRARY75,helper);
  mark75(EFFECT_LIBRARY75,helper);

  var pump=smethod(LOADER75,"_-1cx");
  cap75(pump);
  int shift=callIndex(pump,"shift",1);
  var code=pump.getCode().code;
  int pending=stat(LOADER75,"_-2xv");
  if((code.get(shift-1).getBytes()[0]&255)!=0x60||code.get(shift-1).operands[0]!=pending||
     (code.get(shift+4).getBytes()[0]&255)!=0xd5)
   throw new IllegalStateException("Shared loader dequeue layout changed");
  for(int at=shift-1;at<=shift;at++)pump.replaceInstruction(at,new AVM2Instruction(0,0x02,new int[0]));
  sync75(pump);
  // A null result means there is no eligible job. Leave the pending visuals queued.
  insertInclusive(pump,shift+5,new Code().op(0xd1).branch(0x11,1).op(0x47),pump.max_stack);
  insertInclusive(pump,shift-1,new Code().op(0x60,helper).op(0x60,pending)
    .op(0x60,stat(LOADER75,"_-1a-")).op(0x46,publicName("take"),2),3);
  cap75(method(FIGURES75,"_-W"));

  for(var tag:swf.getAbcList()){
   for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
   ((Tag)tag).setModified(true);
  }
  try(var out=Files.newOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste75 prioritizes room assets, reserves a slot, and allows four shared downloads.");
 }

 static void mark75(String owner,int helper)throws Exception {
  var body=method(owner,"_-jQ");
  int at=callIndex(body,"load",1);
  if((body.getCode().code.get(at).getBytes()[0]&255)!=0x4f)
   throw new IllegalStateException("Unexpected native visual loader call "+owner);
  insertInclusive(body,at,new Code().op(0x60,helper).op(0xd2).op(0x4f,publicName("markVisual"),1),
    body.max_stack+2);
 }

 static void cap75(MethodBody body) {
  var code=body.getCode().code;
  int cap=-1;
  for(int i=0;i<code.size()-1;i++){
   var ins=code.get(i);
   if((ins.getBytes()[0]&255)==0x24&&ins.operands[0]==2&&(code.get(i+1).getBytes()[0]&255)==0xad){
    if(cap!=-1)throw new IllegalStateException("Ambiguous concurrency limit");
    cap=i;
   }
  }
  if(cap<0)throw new IllegalStateException("Expected concurrency limit missing");
  body.replaceInstruction(cap,new AVM2Instruction(0,0x24,new int[]{4}));
  sync75(body);
 }

 static void sync75(MethodBody body){
  body.setCodeBytes(body.getCode().getBytes());
  body.getCode();
  body.setModified();
 }
}

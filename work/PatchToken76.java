import java.io.*;
import java.nio.file.*;
import java.security.MessageDigest;
import java.util.HexFormat;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.abc.types.MethodBody;
import com.jpexs.decompiler.flash.abc.types.traits.TraitSlotConst;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken76 extends PatchToken75 {
 static final String BASE_SHA76="feba16b3a45f5792768c7cca3cb9e558fbd32aaa246112c47258f1a13d597b7d";
 static final String QUEUE76="loginpatch:RoomAssetQueue75";
 static final String ENGINE76="com.sulake.habbo.room:RoomEngine";
 static final String CACHE76="loginpatch:AssetCache76";

 public static void main(String[] args) {
  try{patch76(Path.of(args[0]),Path.of(args[1]));}
  catch(Throwable failure){failure.printStackTrace(System.err);System.exit(1);}
 }

 static void patch76(Path base,Path target)throws Exception {
  byte[] input=Files.readAllBytes(base);
  if(!BASE_SHA76.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input))))
   throw new IllegalArgumentException("Expected exact Teste75 SWF");
  swf=new SWF(new ByteArrayInputStream(input),false);
  abc=swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());
  index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/AssetCache76.as")),abc,index,
    "AssetCache76.as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());

  byteBefore(smethod(LOADER75,"_-1cx"),4,6,0xad,1);
  byteBefore(method(FIGURES75,"_-W"),4,6,0xad,1);
  byteBefore(constructor(FIGURES75),100,50,0x24,1);

  var queue=instance(QUEUE76);
  var klass=abc.class_info.get(abc.instance_info.indexOf(queue));
  int cap=stat(QUEUE76,"MAX_VISUAL_LOADS");
  for(var trait:klass.static_traits.traits){
   if(trait.name_index==cap&&trait instanceof TraitSlotConst slot){
    if(slot.value_kind!=3||abc.constants.getInt(slot.value_index)!=3)
     throw new IllegalStateException("Unexpected visual reserve constant");
    slot.value_index=abc.constants.getIntId(4,true);
   }
  }
  byteBefore(abc.findBody(klass.cinit_index),3,4,0x68,1);

  var cache=method(LOADER75,"_-1S8");
  int old=callIndex(cache,"_-aw",1)-1;
  int path=member(LOADER75,"_-4Lt");
  var code=cache.getCode().code;
  // Reuse the native FileProxy/URLLoader/empty-data guards and byte buffer.
  for(int i=old;i<code.size()-1;i++)cache.replaceInstruction(i,new AVM2Instruction(0,0x02,new int[0]));
  sync75(cache);
  insertInclusive(cache,old,new Code().op(0x60,helper("AssetCache76")).op(0xd0)
    .op(0x46,path,0).op(0xd2).op(0xd0).op(0x4f,publicName("store"),3),4);

  var furniture=method(ENGINE76,"_-25i");
  byteBefore(furniture,5,4,0xa4,2);
  byteBefore(furniture,40,30,0xb0,2);
  var instructions=furniture.getCode().code;
  for(int i=0;i<instructions.size();i++){
   if((instructions.get(i).getBytes()[0]&255)==0x47){
    var previous=instructions.get(i-1);
    if((previous.getBytes()[0]&255)!=0x61||previous.operands[0]!=member(ENGINE76,"_-4kK"))
     throw new IllegalStateException("Expected the initial furniture skip");
    furniture.replaceInstruction(i,new AVM2Instruction(0,0x02,new int[0]));
    sync75(furniture);
    break;
   }
  }

  for(var tag:swf.getAbcList()){
   for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
   ((Tag)tag).setModified(true);
  }
  try(var out=Files.newOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste76 increases asset concurrency, buffers cache writes, and resumes furniture each update.");
 }

 static void byteBefore(MethodBody body,int before,int after,int nextOpcode,int expected){
  var code=body.getCode().code;
  int matched=0;
  for(int i=0;i<code.size()-1;i++){
   var ins=code.get(i);
   if((ins.getBytes()[0]&255)==0x24&&ins.operands[0]==before&&
      (code.get(i+1).getBytes()[0]&255)==nextOpcode){
    body.replaceInstruction(i,new AVM2Instruction(0,0x24,new int[]{after}));
    matched++;
   }
  }
  if(matched!=expected)throw new IllegalStateException("Unexpected number of byte literals: "+before+" ("+matched+")");
  sync75(body);
 }
}

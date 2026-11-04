import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.tags.*;
import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.types.traits.*;
class PatchFeatures27 extends PatchFeatures25 {
 static void createRoom()throws Exception {
  var b=method(NAV23,"_-3Be");int changed=0;
  for(var ins:b.getCode().code)if((ins.getBytes()[0]&255)==0x5d&&qname(abc,ins.operands[0]).equals("_-0It::_-075")){ins.operands[0]=rawClass("loginpatch::CanCreateRoomRequest23");changed++;}
  if(changed!=1)throw new IllegalStateException("Unexpected create-room lookup: "+changed);
  b.setCodeBytes(b.getCode().getBytes());b.getCode();b.setModified();
 }
 static void finalGpuVisibility()throws Exception {
  var b=method(FV23,"updateSpriteGPU");int object=namedReference(method(FV23,"updateModel"),"_-3Cd");
  var code=new Code().op(0x60,helperName()).op(0xd3).op(0x66,publicName("alpha")).op(0xd0).op(0x66,object).op(0xd3).op(0x46,publicName("spriteAlpha23"),3).op(0x29)
   .op(0x60,helperName()).op(0xd3).op(0x66,publicName("_-F5")).op(0xd0).op(0x66,object).op(0xd3).op(0x46,publicName("spriteCapture23"),3).op(0x29);
  atReturns(b,code,5);
 }
 public static void main(String[]a)throws Exception {
  var swf=new SWF(new FileInputStream(a[0]),false);abc=swf.getAbcList().get(1).getABC();
  createRoom();finalGpuVisibility();
  for(var b:abc.bodies)b.getCode().checkValidOffsets(b);((Tag)swf.getAbcList().get(1)).setModified(true);
  try(var out=new FileOutputStream(a[1])){swf.saveTo(out);}
  System.out.println("Saved Teste27: independent editor layer, create-room lexical lookup, final GPU invisible-layer synchronization.");
 }
}

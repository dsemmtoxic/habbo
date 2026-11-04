import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.tags.*;

class PatchFeatures24 extends PatchFeatures23 {
 static void isolatePreviewEvent(String name,String type)throws Exception {
  var body=method(ENGINE23,name);var code=body.getCode().code;
  int at=-1;
  for(int i=0;i<code.size();i++) {
   var ins=code.get(i);
   if((ins.getBytes()[0]&255)==0x2c&&abc.constants.getString(ins.operands[0]).equals(type)) {
    if(at>=0||i<2)throw new IllegalStateException("Unexpected event dispatch shape "+name);
    at=i-2;
   }
  }
  if(at<0||code.size()!=at+7)throw new IllegalStateException("Event is not the final operation "+name);
  var first=code.get(at);var last=code.get(at+5);
  if((first.getBytes()[0]&255)!=0x60||!AuditStartup.name(abc,first.operands[0]).equals("events")||
     (last.getBytes()[0]&255)!=0x4f||!AuditStartup.name(abc,last.operands[0]).equals("dispatchEvent")||
     (code.get(at+6).getBytes()[0]&255)!=0x47)throw new IllegalStateException("Changed event tail "+name);
  // Room creation/disposal has completed. Only the floor editor's private
  // preview omits the global live-room notification; all other ids pass through.
  var guard=handled(new Code().op(0x60,helperName()).op(0xd1).op(0x46,publicName("floorPreviewRoom"),1));
  insertInclusive(body,at,guard,Math.max(2,body.max_stack));
  System.out.println("Isolated "+type+" for the floor preview; native room operation remains intact.");
 }
 public static void main(String[]a)throws Exception {
  var s=new SWF(new FileInputStream(a[0]),false);abc=s.getAbcList().get(1).getABC();SWF.initPlayer();
  isolatePreviewEvent("_-4El","REE_INITIALIZED");isolatePreviewEvent("_-0C7","REE_DISPOSED");
  for(var b:abc.bodies)b.getCode().checkValidOffsets(b);
  ((Tag)s.getAbcList().get(1)).setModified(true);
  try(var out=new FileOutputStream(a[1])){s.saveTo(out);}
  System.out.println("Saved Teste24: "+a[1]);
 }
}

import java.io.FileInputStream;
import java.io.FileOutputStream;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken72 extends PatchToken71 {
 public static void main(String[] args)throws Exception {
  if(args.length==2)PatchToken71.main(args);
  finish72(args[args.length-1]);
 }
 static void finish72(String target)throws Exception {
  swf=new SWF(new FileInputStream(target),false);
  abc=swf.getAbcList().get(1).getABC();
  // In selection-first mode the double tap can win over the single tap.
  prefix(method(TOUCH69,"_-4VQ"),new Code()
   .op(0x60,helper("RoomUse70")).op(0xd0).op(0xd1)
   .op(0x46,publicName("readTap"),2).branch(0x12,1).op(0x47),3);
  for(var tag:swf.getAbcList()){
   for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
   ((Tag)tag).setModified(true);
  }
  try(var out=new FileOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste72 opens gift messages and trophy inscriptions from short tap, double tap and room widget requests.");
 }
}

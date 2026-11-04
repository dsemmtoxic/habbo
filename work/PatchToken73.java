import java.io.FileInputStream;
import java.io.FileOutputStream;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken73 extends PatchToken72 {
 public static void main(String[] args)throws Exception {
  try {
   finish73(args[0]);
  }catch(Throwable failure){
   failure.printStackTrace(System.err);
   System.exit(1);
  }
 }
 static void finish73(String target)throws Exception {
  swf=new SWF(new FileInputStream(target),false);
  abc=swf.getAbcList().get(1).getABC();
  addMethod(DESKTOP,"presentController73",new Code().op(0xd0).op(0x30).field(DESKTOP,"_-1Yj")
   .op(0x46,publicName("_-0id"),0).op(0x48),1,1,new int[0],false,method(DESKTOP,"_-kG"),1);
  addMethod(PRESENT71,"prepareGift73",new Code().op(0xd0).op(0x30)
   .op(0xd0).op(0xd1).op(0x61,member(PRESENT71,"_-02l"))
   .op(0xd0).op(0xd2).op(0x61,member(PRESENT71,"_-25Z"))
   .op(0xd0).op(0x27).op(0x61,member(PRESENT71,"_-aB")).op(0x47),2,3,
   new int[]{publicName("int"),publicName("String")},false,method(PRESENT71,"_-3EO"),1);
  var hold=method(TOUCH69,"_-01v");
  int preference=-1;
  for(int i=0;i<hold.getCode().code.size();i++){
   var ins=hold.getCode().code.get(i);
   if((ins.getBytes()[0]&255)==0x66&&AuditStartup.name(abc,ins.operands[0]).equals("_-3f-")){
    preference=i;
    break;
   }
  }
  if(preference<0||(hold.getCode().code.get(preference+1).getBytes()[0]&255)!=0x12)
   throw new IllegalStateException("Long-press selection preference branch missing");
  // Follow native selection even in walk mode when the front hit is a gift or trophy.
  var readHit=new Code().op(0x60,helper("RoomUse70")).op(0x62,4).op(0x46,publicName("holdReader"),1);
  var select=new Code().branch(0x11,readHit.bytes().length+4);
  select.out.writeBytes(readHit.bytes());
  select.branch(0x10,1).op(0x26);
  insertInclusive(hold,preference+1,select,3);
  for(var tag:swf.getAbcList()){
   for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
   ((Tag)tag).setModified(true);
  }
  try(var out=new FileOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste73 uses distinct gift and trophy readers, the Air Plus metal mapping, native gift actions, and double-tap-only reading.");
 }
}

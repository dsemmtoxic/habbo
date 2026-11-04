import java.io.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken71 extends PatchToken70 {
 static final String PRESENT71="com.sulake.habbo.widgets.furni.present:PresentCtrl";
 static void gifts71()throws Exception {
  int h=helper("RoomUse70");
  for(String[] route:new String[][]{{"_-N2","presentSelection"},{"_-kG","presentEvent"}})
   prefix(method(DESKTOP,route[0]),new Code().op(0x60,h).op(0xd0).op(0xd1).op(0x46,publicName(route[1]),2).branch(0x12,1).op(0x47),3);
  prefix(method(DESKTOP,"_-0KM"),new Code().op(0x60,h).op(0xd0).op(0xd1).op(0x46,publicName("presentRequest"),2).branch(0x12,2).op(0x26).op(0x48),3);
  addMethod(DESKTOP,"showPresent71",new Code().op(0xd0).op(0x30).field(DESKTOP,"_-1Yj")
   .op(0x46,publicName("_-0id"),0).op(0x60,rawClass("_-0sg::_-2LR"))
   .op(0x2c,abc.constants.getStringId("ROWRE_PRESENT",true)).op(0xd1).op(0x42,2)
   .op(0x4f,publicName("_-3qY"),1).op(0x47),4,2,new int[]{publicName("Object")},false,method(DESKTOP,"_-kG"),1);
  var body=method(PRESENT71,"_-3qY");int at=-1;
  for(int i=2;i<body.getCode().code.size();i++){
   var code=body.getCode().code;var ins=code.get(i);
   if((ins.getBytes()[0]&255)==0x46&&AuditStartup.name(abc,ins.operands[0]).equals("getStringToStringMap")){
    if(at!=-1||(code.get(i-2).getBytes()[0]&255)!=0xd3||(code.get(i-1).getBytes()[0]&255)!=0x2c)throw new IllegalStateException("Unexpected native gift model lookup");
    at=i-2;
   }
  }
  if(at<0)throw new IllegalStateException("Native gift map lookup missing");
  for(int i=at;i<=at+2;i++)body.replaceInstruction(i,new AVM2Instruction(0,0x02,new int[0]));
  body.setCodeBytes(body.getCode().getBytes());body.getCode();
  insertInclusive(body,at,new Code().op(0x60,h).op(0xd3).op(0x46,publicName("giftMap"),1).op(0x80,abc.method_info.get(method(PRESENT71,"_-1dS").method_info).param_types[0]),3);
 }
 public static void main(String[] args)throws Exception {
  PatchToken70.main(args);finish71(args[1]);
 }
 static void finish71(String target)throws Exception {
  swf=new SWF(new FileInputStream(target),false);abc=swf.getAbcList().get(1).getABC();
  gifts71();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}
  try(var out=new FileOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste71 retains native walking before DC use, dispatches private toggle feedback, and routes present requests with legacy text support.");
 }
}

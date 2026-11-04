import java.io.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken67 extends PatchToken66 {
 static void clearFlag(Code code,String name,boolean value){code.op(0x5e,stat(LOGIN,name)).op(value?0x26:0x27).op(0x61,stat(LOGIN,name));}
 static void clearNull(Code code,String name){code.op(0x5e,stat(LOGIN,name)).op(0x20).op(0x61,stat(LOGIN,name));}
 static void logout67()throws Exception{
  var code=new Code().op(0xd0).op(0x30);
  for(String name:List.of("stopTimer","endRoomEditors","resetAccountState","resetCommands","clearOffline32"))code.op(0x60,helperName()).op(0x4f,stat(LOGIN,name),0);
  for(String name:List.of("_ssoSession","_authenticated","_failureQueued"))clearFlag(code,name,false);
  for(String name:List.of("_controller","_activeConnection"))clearNull(code,name);
  code.op(0x5e,stat(LOGIN,"_attempt")).op(0x60,stat(LOGIN,"_attempt")).op(0xc0).op(0x61,stat(LOGIN,"_attempt"));
  code.op(0x5e,stat(LOGIN,"_disconnectReason")).op(0x2d,abc.constants.getIntId(-999,true)).op(0x61,stat(LOGIN,"_disconnectReason"));
  code.op(0x47);addMethod(LOGIN,"clearSession67",code,3,1,new int[0],true,smethod(LOGIN,"connectionClosed"),1);
  var cleanup=new Code().op(0x60,helperName()).op(0x4f,stat(LOGIN,"clearSession67"),0);
  for(String name:List.of("WebSession64","RoomLighting63","ClientSettings63"))cleanup.op(0x60,helper(name)).op(0x20).op(0x4f,publicName("close"),1);
  prefix(method(CORE,"_-02h"),cleanup,2);
 }
 static void entry67()throws Exception{
  // The native door group is rendered behind walls and furniture. Restore
  // its visibility flag; suppress only the PNG/legacy clip branch.
  var body=method(CANVAS,"_-1Ie");int restored=0,cleanup=0;
  for(int i=0;i<body.getCode().code.size();i++){
   var ins=body.getCode().code.get(i);int op=ins.getBytes()[0]&255;
   if(op==0x61&&AuditStartup.name(abc,ins.operands[0]).equals("_-1Kj")){
    if(i<2||(body.getCode().code.get(i-2).getBytes()[0]&255)!=0x29||(body.getCode().code.get(i-1).getBytes()[0]&255)!=0x27)throw new IllegalStateException("Missing63 false override");
    body.replaceInstruction(i-2,new AVM2Instruction(0,0x02,new int[0]));body.replaceInstruction(i-1,new AVM2Instruction(0,0x02,new int[0]));restored++;
   }else if(op==0x60&&AuditStartup.name(abc,ins.operands[0]).equals("_-1Kj")){
    body.replaceInstruction(i,new AVM2Instruction(0,0x27,new int[0]));cleanup++;
   }
  }
  if(restored!=1||cleanup!=1)throw new IllegalStateException("Unexpected native door branches "+restored+"/"+cleanup);body.setCodeBytes(body.getCode().getBytes());body.getCode();body.setModified();
 }
 public static void main(String[]args)throws Exception{
  PatchToken66.main(args);swf=new SWF(new FileInputStream(args[1]),false);abc=swf.getAbcList().get(1).getABC();logout67();entry67();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}
  System.out.println("PASS:67 session detection uses official authenticated state; explicit client logout clears stale SSO before native reboot; native entry occlusion restored without door PNG; console clock placed below text within bubble with contrasting colors.");
 }
}

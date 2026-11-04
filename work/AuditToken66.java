import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class AuditToken66 extends AuditToken65 {
 public static void main(String[]args)throws Exception{
  var previous=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var current=AuditStartup.classes(swf);check(previous.keySet().equals(current.keySet()),"Class inventory changed");int retained=0,changed=0;var expected=new HashSet<>(Set.of("S1:ensure","S1:layout"));
  for(var c:previous.values()){
   var a=methods(c);var b=methods(current.get(c.logical()));check(a.keySet().equals(b.keySet()),"Method inventory changed "+c.logical());
   for(var e:a.entrySet())if(normalized(e.getValue()).equals(normalized(b.get(e.getKey()))))retained++;else{check(c.logical().equals("loginpatch:Login62")&&expected.remove(e.getKey()),"Unrelated65 change "+c.logical()+" "+e.getKey());changed++;}
  }
  check(expected.isEmpty(),"Startup hotfix methods absent");check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Protocol changed");for(var abc:swf.getAbcList())for(var b:abc.getABC().bodies)b.getCode().checkValidOffsets(b);
  System.out.println("PASS: "+retained+" methods preserved from65; exactly "+changed+" Login62 presentation methods changed. Native initialization, authentication, browser session, lighting, console, door mesh, commands and protocol unchanged; offsets valid.");
 }
}

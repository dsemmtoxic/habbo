import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class AuditToken64 extends AuditToken62 {
 public static void main(String[]args)throws Exception {
  var previous=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var current=AuditStartup.classes(swf);var pristine=AuditStartup.classes(new SWF(new FileInputStream("work/HabboTablet_LoginSSO33.swf"),false));
  var names=new TreeSet<>(current.keySet());check(names.remove("loginpatch:WebSession64")&&names.equals(previous.keySet()),"Unrelated class inventory change");
  var helpers=Set.of("loginpatch:RoomLighting63","loginpatch:Console61","loginpatch:ClientTheme63","loginpatch:Login62");
  var expected=new TreeSet<>(Set.of(PatchToken61.RENDERER+"|I1:commitData",PatchToken62.LOGIC+"|I1:_-3uS",PatchToken61.LOGIN+"|S1:tokenWebsiteAction"));int retained=0,changed=0;
  for(var c:previous.values()){
   if(helpers.contains(c.logical()))continue;var old=methods(c);var now=methods(current.get(c.logical()));
   if(c.logical().equals(PatchToken61.RENDERER))for(String n:List.of("consoleText64","consoleBubble64")){var getter=now.remove("I2:"+n);check(getter!=null&&getter.contains("getproperty")&&!getter.contains("setproperty"),"Expected read-only messenger accessor");}
   check(old.keySet().equals(now.keySet()),"Method inventory differs: "+c.logical());
   for(var e:old.entrySet())if(normalized(e.getValue()).equals(normalized(now.get(e.getKey()))))retained++;else{String key=c.logical()+"|"+e.getKey();check(expected.remove(key),"Unrelated method change: "+key);changed++;}
  }
  check(expected.isEmpty(),"Expected scoped change missing: "+expected);
  var masks=methods(current.get(PatchToken62.LOGIC));var originalMasks=methods(pristine.get(PatchToken62.LOGIC));check(normalized(masks.get("I1:_-3uS")).equals(normalized(originalMasks.get("I1:_-3uS"))),"Door mask not exactly original33");
  check(methods(current.get(PatchToken61.PLAN)).equals(methods(pristine.get(PatchToken61.PLAN))),"Original wall/floor trace changed");
  check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Message header tables changed");for(var abc:swf.getAbcList())for(var b:abc.getABC().bodies)b.getCode().checkValidOffsets(b);
  System.out.println("PASS: "+retained+" existing non-helper methods preserved; exactly "+changed+" existing methods changed, two read-only getters and one browser helper added. Original33 door-mask handler and wall/floor tracing restored; native login/auth, protocol headers, all other gameplay and persistent commands preserved. AVM2 offsets valid.");
 }
}

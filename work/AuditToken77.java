import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken77 extends AuditToken76 {
 public static void main(String[] args)throws Exception{
  var base=new SWF(new FileInputStream(args[0]),false);
  var target=new SWF(new FileInputStream(args[1]),false);
  var old=AuditStartup.classes(base);
  var now=AuditStartup.classes(target);
  var added=new HashSet<>(now.keySet());
  added.removeAll(old.keySet());
  check(added.equals(Set.of("loginpatch:Avatar77")),"Unexpected class additions");
  var allowed=new HashSet<>(Set.of(
    PatchOldLogin.PEER+"|I1:setup",
    PatchOldLogin.PEER+"|I1:_-0wY",
    PatchToken77.LOGIN+"|S1:modernWiredContent"));
  for(var cls:old.values()){
   var before=methods(cls);
   var after=methods(now.get(cls.logical()));
   check(before.keySet().equals(after.keySet()),"Native method inventory changed: "+cls.logical());
   for(var entry:before.entrySet()){
    String name=entry.getKey();
    if(!normalized(entry.getValue()).equals(normalized(after.get(name))))
     check(allowed.remove(cls.logical()+"|"+name),"Unexpected change: "+cls.logical()+"|"+name);
   }
  }
  check(allowed.isEmpty(),"Expected method edits absent: "+allowed);
  System.out.println("PASS: only the native peer setup, peer action dispatch and Wired description changed.");
 }
}

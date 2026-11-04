import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken79 extends AuditToken76 {
 public static void main(String[] args) throws Exception {
  var before = AuditStartup.classes(new SWF(new FileInputStream(args[0]), false));
  var after = AuditStartup.classes(new SWF(new FileInputStream(args[1]), false));
  check(before.keySet().equals(after.keySet()), "Changed class inventory");
  var changed = new HashSet<String>();
  for (var cls : before.values()) {
   var left = methods(cls);
   var right = methods(after.get(cls.logical()));
   check(left.keySet().equals(right.keySet()), "Changed method inventory: " + cls.logical());
   for (var entry : left.entrySet()) {
    String previous = normalized(entry.getValue());
    String current = normalized(right.get(entry.getKey()));
    if (!previous.equals(current)) {
     changed.add(cls.logical() + "|" + entry.getKey());
     check(previous.replace("pushshort 2515", "pushshort 2936").equals(current),
       "Unexpected change in " + cls.logical() + "|" + entry.getKey());
    }
   }
  }
  check(changed.equals(Set.of(PatchOldLogin.MESSAGE_CLASSES + "|I1:_-2aE")), "Unexpected changes: " + changed);
  System.out.println("PASS: one changed instruction in the click composer registration.");
 }
}

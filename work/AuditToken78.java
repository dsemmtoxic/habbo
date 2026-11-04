import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken78 extends AuditToken76 {
 public static void main(String[] args) throws Exception {
  var before = AuditStartup.classes(new SWF(new FileInputStream(args[0]), false));
  var after = AuditStartup.classes(new SWF(new FileInputStream(args[1]), false));
  var added = new HashSet<>(after.keySet());
  added.removeAll(before.keySet());
  check(added.equals(Set.of("loginpatch:AvatarClick78")), "Unexpected new class");
  var changes = new HashSet<String>();
  for (var type : before.values()) {
   var left = methods(type);
   var right = methods(after.get(type.logical()));
   check(left.keySet().equals(right.keySet()), "Changed method inventory: " + type.logical());
   for (var entry : left.entrySet()) {
    if (!normalized(entry.getValue()).equals(normalized(right.get(entry.getKey())))) {
     changes.add(type.logical() + "|" + entry.getKey());
    }
   }
  }
  check(changes.equals(Set.of(PatchOldLogin.PEER + "|I1:setup", PatchOldLogin.PEER + "|I1:_-0wY")),
    "Unexpected bytecode change: " + changes);
  System.out.println("PASS: only peer setup and action dispatch changed, plus the scoped click helper.");
 }
}

import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken76 extends AuditToken75 {
 public static void main(String[] args)throws Exception{
  var base=new SWF(new FileInputStream(args[0]),false);
  var target=new SWF(new FileInputStream(args[1]),false);
  var old=AuditStartup.classes(base);
  var now=AuditStartup.classes(target);
  var added=new HashSet<>(now.keySet());
  added.removeAll(old.keySet());
  check(added.equals(Set.of(PatchToken76.CACHE76)),"Unexpected class additions");
  var allowed=new HashSet<>(Set.of(
    PatchToken75.LOADER75+"|S1:_-1cx",
    PatchToken75.FIGURES75+"|I1:_-W",
    PatchToken75.FIGURES75+"|constructor",
    PatchToken76.QUEUE76+"|initializer",
    PatchToken75.LOADER75+"|I1:_-1S8",
    PatchToken76.ENGINE76+"|I1:_-25i"));
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
  var writing=methods(now.get(PatchToken75.LOADER75)).get("I1:_-1S8");
  check(writing.contains("AssetCache76")&&!writing.contains("\"_-1z0\"")&&!writing.contains("\"_-12V\""),
    "Synchronous cache operations are still in the asset hot path");
  System.out.println("PASS: only the six expected scheduling and cache methods changed.");
 }
}

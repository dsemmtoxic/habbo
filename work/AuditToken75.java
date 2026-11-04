import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken75 extends AuditToken74 {
 public static void main(String[] args)throws Exception{
  var base=new SWF(new FileInputStream(args[0]),false);
  var target=new SWF(new FileInputStream(args[1]),false);
  var old=AuditStartup.classes(base);
  var now=AuditStartup.classes(target);
  var added=new HashSet<>(now.keySet());
  added.removeAll(old.keySet());
  check(added.equals(Set.of(VerifyToken75.HELPER)),"Unexpected class additions");
  var allowed=new HashSet<>(Set.of(
    PatchToken75.LOADER75+"|S1:_-1cx",
    PatchToken75.FIGURES75+"|I1:_-W",
    PatchToken75.FIGURE_LIBRARY75+"|I1:_-jQ",
    PatchToken75.EFFECT_LIBRARY75+"|I1:_-jQ"));
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
  for(String name:List.of(PatchToken75.FIGURE_LIBRARY75,PatchToken75.EFFECT_LIBRARY75)){
   var text=methods(now.get(name)).get("I1:_-jQ");
   check(text.contains("markVisual")&&text.indexOf("markVisual")<text.lastIndexOf("\"load\""),
    "Asset is not tagged before loading");
  }
  System.out.println("PASS: only the four expected loader methods changed; cache and failure paths are bytecode-equivalent.");
 }
}

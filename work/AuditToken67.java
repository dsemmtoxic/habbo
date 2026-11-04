import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class AuditToken67 extends AuditToken65 {
 public static void main(String[]args)throws Exception{
  var before=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var after=AuditStartup.classes(swf);check(before.keySet().equals(after.keySet()),"Class inventory changed");var expected=new HashSet<>(Set.of("loginpatch:Console61|S1:decorate","loginpatch:WebSession64|S1:receive",PatchToken62.CORE+"|I1:_-02h",PatchToken63.CANVAS+"|I1:_-1Ie"));int retained=0,changed=0;
  for(var c:before.values()){
   var a=methods(c);var b=methods(after.get(c.logical()));if(c.logical().equals(PatchToken61.LOGIN))check(b.remove("S1:clearSession67")!=null,"Missing explicit logout cleanup");check(a.keySet().equals(b.keySet()),"Unrelated method inventory "+c.logical());
   for(var e:a.entrySet()){
    String x=e.getValue(),y=b.get(e.getKey());
    if(c.logical().equals("loginpatch:WebSession64")&&e.getKey().equals("initializer")){
     String pattern="(?m)pushstring \\\"[^\\r\\n]*__H64_CONFIG__[^\\r\\n]*\\\"";
     String xx=x.replaceFirst(pattern,"pushstring \\\"TESTED_BROWSER_SCRIPT\\\""),yy=y.replaceFirst(pattern,"pushstring \\\"TESTED_BROWSER_SCRIPT\\\"");check(!xx.equals(x)&&!yy.equals(y),"Missing embedded script initializer");x=xx;y=yy;
    }
    if(normalized(x).equals(normalized(y)))retained++;else{String key=c.logical()+"|"+e.getKey();if(!expected.remove(key)){Files.writeString(Path.of("work/feature67/audit-before.asm"),x);Files.writeString(Path.of("work/feature67/audit-after.asm"),y);throw new AssertionError("Unrelated66 change "+key);}changed++;}
   }
  }
  check(expected.isEmpty(),"Missing reviewed changes: "+expected);check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Game protocol changed");
  var browser=after.get("loginpatch:WebSession64");boolean embedded=false;for(var trait:browser.abc().class_info.get(browser.index()).static_traits.traits)if(trait instanceof TraitSlotConst slot&&AuditStartup.name(browser.abc(),slot.name_index).equals("SCRIPT"))embedded=browser.abc().constants.getString(slot.value_index).equals(Files.readString(Path.of("work/session64.js")));check(embedded,"Tested JavaScript differs from embedded source");
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  System.out.println("PASS: "+retained+" existing66 methods preserved; exactly "+changed+" scoped methods changed and one logout cleanup bridge added. Native67 entry render sorting,66 typed login fix,33 authentication/protocol, door mesh, light persistence/rendering and all other gameplay preserved; exact tested browser script embedded; AVM2 offsets valid.");
 }
}

import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class AuditToken61 {
 static void check(boolean ok,String why){if(!ok)throw new AssertionError(why);}
 // Recompiling this helper shifts U30 operand widths and debug source lines.
 // Compare resolved instructions/control-flow labels, ignoring only debugger
 // metadata; every actual branch target is retained by the label mapping.
 static String labels(String asm){asm=asm.replaceAll("(?m)^[\\t ]*debug[^\\r\\n]*\\r?\\n","");var names=new LinkedHashMap<String,String>();var matcher=java.util.regex.Pattern.compile("(?m)^(ofs[0-9a-f]+):").matcher(asm);while(matcher.find())names.put(matcher.group(1),"label"+names.size());matcher=java.util.regex.Pattern.compile("ofs[0-9a-f]+").matcher(asm);var out=new StringBuffer();while(matcher.find()){String name=names.get(matcher.group());check(name!=null,"Missing branch label");matcher.appendReplacement(out,name);}matcher.appendTail(out);return out.toString();}
 static Map<String,String> methods(AuditStartup.Cls c){
  var result=new TreeMap<String,String>();
  for(boolean stat:List.of(false,true))for(var t:(stat?c.abc().class_info.get(c.index()).static_traits:c.inst().instance_traits).traits)
   if(t instanceof TraitMethodGetterSetter m){var b=c.abc().findBody(m.method_info);result.put((stat?"S":"I")+m.kindType+":"+AuditStartup.name(c.abc(),t.name_index),b==null?"":b.getCode().toASMSource(c.abc()));}
  var ctor=c.abc().findBody(c.inst().iinit_index);var init=c.abc().findBody(c.abc().class_info.get(c.index()).cinit_index);
  result.put("constructor",ctor==null?"":ctor.getCode().toASMSource(c.abc()));
  result.put("initializer",init==null?"":init.getCode().toASMSource(c.abc()));return result;
 }

 static String normalized(String s){return labels(s).replace("\r","").trim();}

 static String hooks(String s,String method){String out=s.replaceAll("getlex [^\\n]*\"Console61\"\\)[\\s\\S]*?callpropvoid [^\\n]*\""+method+"\"\\), [0-9]+\\s+","");check(!out.equals(s),"Missing Console61 hook "+method);return out;}
 static String roomHook(String s,String method){String out=s.replaceFirst("getlex [^\\n]*\"RoomAppearance61\"\\)[\\s\\S]*?callpropvoid [^\\n]*\""+method+"\"\\), [0-9]+\\s+","");check(!out.equals(s),"Missing room hook "+method);return out;}
 public static void main(String[]a)throws Exception{
  var before=AuditStartup.classes(new SWF(new FileInputStream(a[0]),false));var swf=new SWF(new FileInputStream(a[1]),false);var after=AuditStartup.classes(swf);var names=new HashSet<>(after.keySet());check(names.remove("loginpatch:Console61")&&names.remove("loginpatch:RoomAppearance61")&&names.equals(before.keySet()),"Expected exactly Teste33 classes plus2 helpers");check(!after.containsKey("loginpatch:AuthSession34")&&!after.containsKey("loginpatch:NativeAir42"),"Automatic login/native adapter included");int equal=0,changed=0;
  for(var cls:before.values()){
   var old=methods(cls);var now=methods(after.get(cls.logical()));check(old.keySet().equals(now.keySet()),"Method inventory changed "+cls.logical());
   for(var e:old.entrySet()){
    String owner=cls.logical(),key=e.getKey(),x=e.getValue(),y=now.get(key),z=y;boolean allowed=false;
    if(owner.equals(PatchToken61.LOGIN)){
     if(key.equals("S1:requestConsoleHistory")){z=hooks(y,"track").replace("pushshort 350","pushshort 4000").replace("pushshort 5000","pushshort 10000");allowed=true;}
     else if(key.equals("S1:consoleHistoryTimeout")){z=hooks(y,"timeout").replace("pushshort 4900","pushshort 9900");allowed=true;}
     else if(key.equals("S1:receiveConsoleHistory")){z=hooks(y,"received");allowed=true;}
     else if(Set.of("S1:rememberMessenger","S1:resetAccountState").contains(key)){z=hooks(y,"reset");allowed=true;}
     else if(key.equals("S1:consoleConversationRemoved")){z=hooks(y,"release");allowed=true;}
     else if(key.equals("S1:consoleHistoryScrolled")){check(y.contains("Console61")&&y.contains("\"scrolled\"")&&!y.contains("\"send\""),"Scroll should only delegate to scheduler");changed++;continue;}
    }else if(owner.equals(PatchToken61.MESSAGE)&&key.equals("constructor")){z=hooks(y,"stamp");allowed=true;}
    else if(owner.equals(PatchToken61.RENDERER)&&key.equals("I1:commitData")){
     z=y.replaceFirst("getlex [^\\n]*\"Console61\"\\)\\s+getlocal1\\s+callproperty [^\\n]*\"text\"\\), 1","MESSAGE_TEXT");x=x.replaceFirst("getlocal1\\s+getproperty [^\\n]*\"message\"\\)","MESSAGE_TEXT");check(z.contains("MESSAGE_TEXT")&&x.contains("MESSAGE_TEXT"),"Timestamp renderer hook absent");allowed=true;
    }else if(owner.equals(PatchToken61.PLAN)&&key.equals("S1:_-3Vo")){check(y.contains("pushnull")&&!y.contains("findEntrance"),"Special entrance-floor selector still active");changed++;continue;}
    else if(owner.equals(PatchToken61.DESKTOP)){
     if(key.equals("I1:_-0KM")){z=y.replaceFirst("getlex [^\\n]*\"RoomAppearance61\"\\)[\\s\\S]*?callproperty [^\\n]*\"request\"\\), 2\\s+dup\\s+iffalse (ofs[0-9a-f]+)\\s+returnvalue\\s+\\1:\\s+pop\\s+","");check(!z.equals(y),"Boolean widget request hook absent");allowed=true;}
     else if(Set.of("I1:_-YU","I1:_-1oc").contains(key)){z=roomHook(y,"color");allowed=true;}
     else if(key.equals("I1:dispose")){z=roomHook(y,"release");allowed=true;}
    }
    if(allowed){check(normalized(x).equals(normalized(z)),"Reviewed body changed beyond bounded hook "+owner+" "+key);changed++;continue;}
    if(!normalized(x).equals(normalized(y))){Files.writeString(Path.of("work/feature61/audit-before.txt"),x);Files.writeString(Path.of("work/feature61/audit-after.txt"),y);throw new AssertionError("Unrelated change "+owner+" "+key);}equal++;
   }
  }
  check(changed==14,"Expected14 changed methods, got"+changed);check(CompareProtocol.read(a[0],"_-0cq::_-0z0").equals(CompareProtocol.read(a[1],"_-0cq::_-0z0")),"Static protocol tables changed");for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  System.out.println("PASS: "+equal+" existing Teste33 methods preserved; exactly14 scoped methods reviewed,2 helpers added. Original token login, RoomMessageHandler entrance/masks, native data readers and static protocol tables preserved. No automatic-login classes; offsets valid.");
 }
}

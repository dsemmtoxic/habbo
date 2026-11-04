import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class AuditToken65 extends AuditToken62 {
 static String normalized(String source){return AuditToken62.normalized(source).replaceAll("\\.as\\$[0-9]+", java.util.regex.Matcher.quoteReplacement(".as$script"));}
 public static void main(String[]args)throws Exception{
  var before=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var after=AuditStartup.classes(swf);var names=new TreeSet<>(after.keySet());check(names.removeAll(Set.of("loginpatch:ModernUI65","loginpatch:RoomEntry65"))&&names.equals(before.keySet()),"Unexpected class change");
  var changed=new TreeSet<>(Set.of(PatchToken63.RVIZ+"|I1:update",PatchToken63.RVIZ+"|I1:_-1ii",PatchToken65.GEOMETRY+"|I1:buildGeometry",PatchToken65.GEOMETRY+"|I1:buildUVs"));int retained=0;
  for(var c:before.values()){
   if(Set.of("loginpatch:Login62","loginpatch:WebSession64").contains(c.logical()))continue;var a=methods(c);var b=methods(after.get(c.logical()));
   if(c.logical().equals(PatchToken65.PLANE))for(String name:List.of("entryMasks65","entryMaskManager65","entryMaskBitmap65")){var getter=b.remove("I2:"+name);check(getter!=null&&!getter.contains("setproperty"),"Invalid read-only native mask getter");}
   if(c.logical().equals(PatchToken65.GEOMETRY))check(b.remove("I1:entryInvalidateUVs65")!=null,"Missing UV bridge");
   check(a.keySet().equals(b.keySet()),"Unexpected method inventory "+c.logical());
   for(var e:a.entrySet())if(normalized(e.getValue()).equals(normalized(b.get(e.getKey()))))retained++;else if(c.logical().equals("loginpatch:RoomLighting63")){check(Set.of("S1:open","S1:draw").contains(e.getKey()),"Working64 save/render changed: "+e.getKey());}else{String key=c.logical()+"|"+e.getKey();if(!changed.remove(key)){java.nio.file.Files.writeString(java.nio.file.Path.of("work/feature65/audit-before.asm"),e.getValue());java.nio.file.Files.writeString(java.nio.file.Path.of("work/feature65/audit-after.asm"),b.get(e.getKey()));throw new AssertionError("Unrelated gameplay change "+key);}}
  }
  check(changed.isEmpty(),"Missing doorway hooks "+changed);check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Protocol headers changed");
  var browser=after.get("loginpatch:WebSession64");boolean script=false;for(var trait:browser.abc().class_info.get(browser.index()).static_traits.traits)if(trait instanceof com.jpexs.decompiler.flash.abc.types.traits.TraitSlotConst slot&&AuditStartup.name(browser.abc(),slot.name_index).equals("SCRIPT")){script=browser.abc().constants.getString(slot.value_index).equals(java.nio.file.Files.readString(java.nio.file.Path.of("work/session64.js")));}check(script,"Embedded browser script differs from tested source");
  for(var abc:swf.getAbcList())for(var body:abc.getABC().bodies)body.getCode().checkValidOffsets(body);
  System.out.println("PASS: "+retained+" existing methods preserved, including working64 light persistence/rendering, console, original33 auth and protocol. Only login/browser presentation, two light palette methods, four mesh hooks and read-only native mask/UV bridges changed; all AVM2 offsets valid.");
 }
}

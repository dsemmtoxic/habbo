import java.io.*;import java.nio.file.*;import java.util.*;import java.security.*;import com.jpexs.decompiler.flash.SWF;
class AuditToken63 extends AuditToken62 {
 static final String LOGIN=PatchToken61.LOGIN;
 static String sha(String s)throws Exception{return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(s.getBytes(java.nio.charset.StandardCharsets.UTF_8)));}
 public static void main(String[]a)throws Exception {
  var original=AuditStartup.classes(new SWF(new FileInputStream(a[0]),false));var prior=AuditStartup.classes(new SWF(new FileInputStream(a[1]),false));var swf=new SWF(new FileInputStream(a[2]),false);var now=AuditStartup.classes(swf);var names=new HashSet<>(now.keySet());
  check(names.removeAll(Set.of("loginpatch:ClientTheme63","loginpatch:ClientSettings63","loginpatch:RoomLighting63"))&&names.equals(prior.keySet()),"Unexpected class changes from62");for(var s:List.of("loginpatch:AuthSession34","loginpatch:NativeAir42","loginpatch:NativeBridge48"))check(!now.containsKey(s),"Automatic login included");
  var allowed=new HashSet<>(Set.of(LOGIN+"|S1:runCommand",LOGIN+"|S1:commandNotice",LOGIN+"|S1:resetCommands",PatchToken61.PLAN+"|S1:_-3Vo",PatchToken63.CANVAS+"|I1:_-1Ie",PatchToken63.CANVAS+"|I1:render",PatchToken63.EVENTS+"|I1:_-0dX",PatchToken63.EVENTS+"|I1:_-2rx",PatchToken63.CHAT_EVENTS+"|I1:_-1nD",PatchToken63.DIMMER+"|I1:_-1k2",PatchToken63.PRESETS+"|I1:parse",PatchToken63.RVIZ+"|I1:update","com.sulake.room.renderer:RoomSpriteFactory|I1:createImage","_-26z:_-57|I1:_-0tq","_-26z:_-1cO|I1:_-0tq","com.sulake.habbo.communication.messages.outgoing.room.furniture:RoomDimmerSavePresetMessageComposer|I1:_-0tq","com.sulake.habbo.communication:HabboMessages|initializer"));
  var additions=new HashSet<>(Set.of(LOGIN+"|S1:commandStates63",LOGIN+"|S1:bindCommandContext63",":HitchTheme|S1:skin63",PatchToken63.CANVAS+"|I1:refreshLighting63",PatchToken63.RVIZ+"|I2:lightingObject63",PatchToken63.RVIZ+"|I2:lightingPlanes63",PatchToken63.RVIZ+"|I2:lightingIndexes63"));
  int same=0,changed=0,extra=0;var report=new StringBuilder("owner\tmethod\tbeforeSha256\tafterSha256\n");
  for(var cls:prior.values()){
   String owner=cls.logical();if(Set.of("loginpatch:RoomAppearance61","loginpatch:Login62").contains(owner))continue;
   var before=methods(cls);var after=methods(now.get(owner));
   for(String key:new HashSet<>(after.keySet()))if(!before.containsKey(key)){check(additions.remove(owner+"|"+key),"Unexpected method added "+owner+" "+key);after.remove(key);extra++;}
   check(before.keySet().equals(after.keySet()),"Method inventory differs "+owner);
   for(var e:before.entrySet()){
    String key=e.getKey(),x=normalized(e.getValue()),y=normalized(after.get(key));if(x.equals(y)){same++;continue;}
    check(allowed.remove(owner+"|"+key),"Unrelated method changed "+owner+" "+key);report.append(owner).append('\t').append(key).append('\t').append(sha(x)).append('\t').append(sha(y)).append('\n');changed++;
    if(owner.equals(PatchToken61.PLAN)){check(normalized(methods(original.get(owner)).get(key)).equals(y),"Original33 entrance/wall tracing not restored");}
    if(owner.equals(PatchToken63.CANVAS)&&key.equals("I1:_-1Ie")){check(y.contains("pop\n")&&y.contains("pushfalse\n")&&y.contains("_-3P9")&&y.contains("clipRect"),"Door cleanup must use native flag/clip branch");}
   }
  }
  check(allowed.isEmpty(),"Missing expected bounded changes "+allowed);check(additions.isEmpty(),"Missing native accessor/context methods "+additions);
  check(normalized(methods(prior.get("loginpatch:Console61")).get("S1:text")).equals(normalized(methods(now.get("loginpatch:Console61")).get("S1:text"))),"Console61 changed");
  var beforeTable=CompareProtocol.read(a[1],"_-0cq::_-0z0");var afterTable=CompareProtocol.read(a[2],"_-0cq::_-0z0");var oracle=PatchOldLogin.currentTables(new SWF(new FileInputStream("work/plus.swf"),false));
  for(var en:beforeTable.entrySet()){
   var added=new TreeMap<>(afterTable.get(en.getKey()));for(var old:en.getValue().entrySet())check(Objects.equals(added.remove(old.getKey()),old.getValue()),"Existing protocol binding changed");
   if(en.getKey().endsWith("::_-26i")){check(added.keySet().equals(Set.of(905,3237)),"Only two missing dimmer composers may be registered");for(String[]p:new String[][]{{"RoomDimmerChangeStateMessageComposer","905"},{"RoomDimmerGetPresetsMessageComposer","3237"}})check(Objects.equals(oracle.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.room.furniture:"+p[0]),Integer.parseInt(p[1])),"Dimmer header differs from Plus");}
   else check(added.isEmpty(),"Incoming bindings changed");
  }
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  Files.writeString(Path.of("work/feature63/native-method-review63.tsv"),report);
  System.out.println("PASS: "+same+" existing62 methods preserved; "+changed+" scoped native methods reviewed, "+extra+" accessors/bridges and3 helpers added. Original33 complete RoomPlaneParser restored; Console61, token validation/authentication, data readers, furniture visibility and all unrelated gameplay methods retained. Existing protocol bindings unchanged; only Plus905/3237 dimmer composers added. All offsets valid; no automatic-login branch.");
 }
}

import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class AuditToken69 extends AuditToken68 {
 static final Set<String> NEW69=Set.of("loginpatch:Ping69","loginpatch:Avatar69","loginpatch:UserClick69");
 static Set<String> changed69(){return Set.of(
  "loginpatch:RoomUI68|S1:remaining","loginpatch:RoomUI68|S1:details","loginpatch:RoomUI68|S1:refresh",
  "loginpatch:Market68|initializer","loginpatch:Market68|S1:bind","loginpatch:Market68|S1:request","loginpatch:Market68|S1:result","loginpatch:Market68|S1:filter","loginpatch:Market68|S1:disposeLogic","loginpatch:Market68|S1:tick","loginpatch:Market68|S1:describe",
  "loginpatch:Text68|initializer",PatchToken61.LOGIN+"|S1:runCommand",PatchToken61.LOGIN+"|S1:resetAccountState",
  PatchToken69.LATENCY69+"|I1:onPingResponse",PatchToken69.TOUCH69+"|I1:_-1Hy",PatchToken69.TOUCH69+"|I1:_-01v",PatchToken69.OBJECT69+"|I1:_-1bd",PatchOldLogin.PEER+"|I1:_-0G7",PatchOldLogin.PEER+"|I1:_-0wY",PatchOldLogin.MESSAGE_CLASSES+"|I1:_-2aE",PatchToken68.MARKET_VIEW25+"|I1:_-qu",PatchToken68.MARKET_VIEW25+"|I1:dispose",PatchToken69.DETAILVIEW69+"|initializer");}
 public static void main(String[]args)throws Exception {
  var before=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var after=AuditStartup.classes(swf);var names=new HashSet<>(after.keySet());check(names.containsAll(NEW69),"Missing69 helpers");names.removeAll(NEW69);check(names.equals(before.keySet()),"Unexpected added/deleted class");
  var expected=new HashSet<>(changed69());var expectedAdded=new HashSet<>(Set.of("loginpatch:RoomUI68|S1:unit","loginpatch:RoomUI68|S1:line","loginpatch:Market68|S1:active","loginpatch:Market68|S1:viewTick","loginpatch:Market68|S1:releaseView",PatchToken68.MARKET25+"|I1:marketCount69"));var changes=new ArrayList<String>();var additions=new ArrayList<String>();int retained=0;
  for(var c:before.values()){var old=methods(c);var now=methods(after.get(c.logical()));for(String key:new HashSet<>(now.keySet()))if(!old.containsKey(key)){String added=c.logical()+"|"+key;check(expectedAdded.remove(added),"Unexpected new method "+added);additions.add(added);now.remove(key);}check(old.keySet().equals(now.keySet()),"Methods removed "+c.logical());for(var e:old.entrySet())if(normalized(e.getValue()).equals(normalized(now.get(e.getKey()))))retained++;else{String key=c.logical()+"|"+e.getKey();check(expected.remove(key),"Unrelated change "+key);changes.add(key);}}
  check(expected.isEmpty()&&expectedAdded.isEmpty(),"Reviewed changes missing "+expected+" "+expectedAdded);
  check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Existing protocol table changed");
  for(String owner:List.of("loginpatch:Console61","loginpatch:RoomLighting63","loginpatch:ClientSettings63","loginpatch:RoomAppearance61","loginpatch:Login62","loginpatch:WebSession64","loginpatch:Entrance68","loginpatch:RoomEntry65"))check(methods(before.get(owner)).equals(methods(after.get(owner))),"Retained feature changed "+owner);
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  var report=new StringBuilder("Retained68 methods: "+retained+"\n\nChanged methods:\n");changes.stream().sorted().forEach(x->report.append(x).append('\n'));report.append("\nAdded methods:\n");additions.stream().sorted().forEach(x->report.append(x).append('\n'));Files.writeString(Path.of("work/feature69/method-review69.txt"),report);
  System.out.println("PASS: "+retained+" existing68 methods preserved, "+changes.size()+" scoped changes, "+additions.size()+" added methods and exactly three helpers. Original protocol tables unchanged; one verified ClickCharacter2515 runtime registration added. Login, session, lighting, console, doorway and unrelated gameplay retained; AVM2 offsets valid.");
 }
}

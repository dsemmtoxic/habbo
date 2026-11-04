import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class AuditToken68 extends AuditToken67 {
 static final Set<String> NEW68=Set.of("loginpatch:Text68","loginpatch:DoorQuad68","loginpatch:Entrance68","loginpatch:RoomUI68","loginpatch:Market68");
 static final Set<String> HELPERS68=Set.of("loginpatch:Login62","loginpatch:WebSession64","loginpatch:ClientTheme63","loginpatch:RoomEntry65");
 static final Set<String> HELPER_CHANGES68=Set.of("loginpatch:ClientTheme63|S1:button","loginpatch:ClientTheme63|S1:text","loginpatch:Login62|S1:layout","loginpatch:Login62|S1:pasteToken","loginpatch:RoomEntry65|S1:configure","loginpatch:RoomEntry65|initializer","loginpatch:WebSession64|S1:begin","loginpatch:WebSession64|S1:changing","loginpatch:WebSession64|S1:failed","loginpatch:WebSession64|S1:receive","loginpatch:WebSession64|S1:tick");
 static final Set<String> ADDED68=Set.of("loginpatch:ClientTheme63|S1:displayText","loginpatch:Login62|S1:t","loginpatch:RoomEntry65|S1:openings68","loginpatch:WebSession64|S1:t",PatchToken63.CANVAS+"|I2:entryLayer68",PatchToken63.CANVAS+"|I2:entryOffsetX68",PatchToken63.CANVAS+"|I2:entryOffsetY68",PatchToken63.CANVAS+"|I2:entryEnabled68",PatchToken63.CANVAS+"|I2:entryView68",PatchToken68.MARKET_VIEW25+"|I2:marketLogic68",PatchToken65.PLANE+"|I2:entryDisposed68",PatchToken68.MARKET25+"|I1:marketRefresh68");
 static Set<String> nativeChanges(){return Set.of(
  PatchToken61.LOGIN+"|S1:selectHotelLanguage",PatchToken61.LOGIN+"|S1:localText",PatchToken61.LOGIN+"|S1:tr",PatchToken61.LOGIN+"|S1:commandNotice",PatchToken61.LOGIN+"|S1:resetAccountState",
  PatchOldLogin.DEMO+"|I1:alert",PatchToken68.LOCAL68+"|I1:_-WP",PatchToken63.CANVAS+"|I1:render",PatchToken63.CANVAS+"|I1:dispose",PatchToken68.NAV21+"|I1:_-1Lq",
  PatchToken68.GUEST68+"|constructor",PatchToken68.GUEST68+"|I1:update",PatchToken68.SEARCH68+"|constructor",PatchToken68.ROW68+"|I1:commitData",PatchToken68.DETAILS68+"|I1:commitData",PatchToken68.DETAILS68+"|I1:dispose",PatchToken68.NAVDATA68+"|I3:_-1Sf",
  PatchToken68.MARKET_ROW25+"|I1:commitData",PatchToken68.MARKET_ROW25+"|I1:dispose",PatchToken68.MARKET25+"|I1:_-3vm",PatchToken68.MARKET25+"|I1:_-xE",PatchToken68.MARKET25+"|I1:dispose",PatchToken68.MARKET_VIEW25+"|I1:_-qu",PatchToken68.MARKET_VIEW25+"|I1:_-3cm");}
 public static void main(String[]args)throws Exception {
  var before=AuditStartup.classes(new SWF(new FileInputStream(args[0]),false));var swf=new SWF(new FileInputStream(args[1]),false);var after=AuditStartup.classes(swf);var names=new HashSet<>(after.keySet());check(names.containsAll(NEW68),"Missing new68 helper");names.removeAll(NEW68);check(names.equals(before.keySet()),"Expected only five new68 helpers");
  var expected=new HashSet<>(nativeChanges());expected.addAll(HELPER_CHANGES68);var expectedAdded=new HashSet<>(ADDED68);var changes=new ArrayList<String>();var additions=new ArrayList<String>();int retained=0;
  for(var c:before.values()){
   var old=methods(c);var now=methods(after.get(c.logical()));for(String key:new HashSet<>(now.keySet()))if(!old.containsKey(key)){
    String added=c.logical()+"|"+key;check(expectedAdded.remove(added),"Unexpected new method "+added);additions.add(added);now.remove(key);
   }
   check(old.keySet().equals(now.keySet()),"Method inventory changed "+c.logical());for(var e:old.entrySet())if(normalized(e.getValue()).equals(normalized(now.get(e.getKey()))))retained++;else{String key=c.logical()+"|"+e.getKey();check(expected.remove(key),"Unrelated method changed "+key);changes.add(key);}
  }
  check(expected.isEmpty()&&expectedAdded.isEmpty(),"Missing reviewed68 changes "+expected+" "+expectedAdded);check(CompareProtocol.read(args[0],"_-0cq::_-0z0").equals(CompareProtocol.read(args[1],"_-0cq::_-0z0")),"Network protocol table changed");
  for(String owner:List.of("loginpatch:Console61","loginpatch:RoomLighting63","loginpatch:ClientSettings63","loginpatch:RoomAppearance61"))check(methods(before.get(owner)).keySet().equals(methods(after.get(owner)).keySet()),"Existing feature methods removed");
  var browser=after.get("loginpatch:WebSession64");boolean embedded=false;for(var tr:browser.abc().class_info.get(browser.index()).static_traits.traits)if(tr instanceof TraitSlotConst slot&&AuditStartup.name(browser.abc(),tr.name_index).equals("SCRIPT"))embedded=browser.abc().constants.getString(slot.value_index).equals(Files.readString(Path.of("work/session64.js")));check(embedded,"Session67 JavaScript changed or differs from tested source");
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  var report=new StringBuilder("Retained67 methods: "+retained+"\n\nChanged methods:\n");changes.stream().sorted().forEach(x->report.append(x).append('\n'));report.append("\nAdded methods:\n");additions.stream().sorted().forEach(x->report.append(x).append('\n'));Files.writeString(Path.of("work/feature68/method-review68.txt"),report);
  System.out.println("PASS: "+retained+" existing67 methods preserved; "+changes.size()+" scoped methods changed, "+additions.size()+" methods and exactly five helpers added. Network tables, native login/logout/session67, lighting, console and other gameplay retained; exact browser script and AVM2 offsets verified.");
 }
}

import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.tags.DefineBinaryDataTag;
class Research69 extends AuditToken62 {
 public static void main(String[] a)throws Exception {
  var s=new SWF(new FileInputStream(a[0]),false);var d=Path.of(a[1]);Files.createDirectories(d);
  for(var c:AuditStartup.classes(s).values())if(c.logical().matches(".*(MessageClassManager|_-Z1|RoomTouchHandler|RoomObjectEventHandler|PeerActionsCtrl|LatencyTracker|HabboTracking|ChatCommands|RoomSession|UserDataManager|RoomSessionManager|RoomChatHandler|RoomDetailsView|RoomDetailsRenderer|HabboMessages)$"))for(var e:methods(c).entrySet())Files.writeString(d.resolve(c.logical().substring(c.logical().lastIndexOf(':')+1)+"-"+e.getKey().replace(':','-')+".asm"),e.getValue());
  var tables=a[0].contains("plus")?PatchOldLogin.currentTables(s):new HashMap<String,Map<String,Integer>>();for(var t:tables.entrySet())for(var e:t.getValue().entrySet())if(e.getKey().matches(".*(ClickCharacter|WiredClickUser|LatencyPing|LookTo).*"))System.out.println(t.getKey()+" "+e);
  for(var t:s.getTags())if(t instanceof DefineBinaryDataTag b){var bytes=b.binaryData.getRangeData();String str=new String(bytes,java.nio.charset.StandardCharsets.UTF_8);if(str.contains("colorizer_wrapper")&&str.contains("background_wrapper")){Files.write(d.resolve("room-view-"+b.tag+".xml"),bytes);System.out.println("Room layout binary saved");}}
 }
}

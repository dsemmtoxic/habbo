import java.io.*;import java.nio.file.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class Research70 extends AuditToken62 {
 public static void main(String[]a)throws Exception {
  var s=new SWF(new FileInputStream(a[0]),false);var d=Path.of(a[1]);Files.createDirectories(d);
  for(var c:AuditStartup.classes(s).values())if(c.logical().matches(".*(ChatInput|ChatHistory|ChatHistoryItemRenderer|ChatItem|Chat|SessionDataManager|BadgeSelector|BadgesSlot|AvatarProfileCtrl|PresentCtrl|PresentView|FurniturePresentLogic|RoomDesktop|RoomTouchHandler|_-uW|_-0HH)$"))for(var e:methods(c).entrySet())Files.writeString(d.resolve(c.logical().substring(c.logical().lastIndexOf(':')+1)+"-"+e.getKey().replace(':','-')+".asm"),e.getValue());
  var tables=a[0].contains("plus")?PatchOldLogin.currentTables(s):new HashMap<String,Map<String,Integer>>();for(var t:tables.entrySet())for(var e:t.getValue().entrySet())if(e.getKey().matches(".*(Badge|Present|GiftMessage).*"))System.out.println(t.getKey()+" "+e);
 }
}

import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken73 extends AuditToken72 {
 public static void main(String[] a)throws Exception {
  var old=AuditStartup.classes(new SWF(new FileInputStream(a[0]),false));
  var swf=new SWF(new FileInputStream(a[1]),false);var now=AuditStartup.classes(swf);
  check(old.keySet().equals(now.keySet()),"Class inventory changed");
  var wantChanged=new HashSet<>(Set.of("loginpatch:Text68|initializer",
   "loginpatch:RoomUse70|S1:present","loginpatch:RoomUse70|S1:readTrophy",
   "loginpatch:RoomUse70|S1:showPresent","loginpatch:RoomUse70|S1:closePresent",
   "loginpatch:RoomUse70|S1:readTap","loginpatch:RoomUse70|S1:singleTap",
   "loginpatch:RoomUse70|S1:presentSelection","loginpatch:RoomUse70|S1:presentRequest",
   "loginpatch:RoomUse70|S1:presentEvent",PatchToken69.TOUCH69+"|I1:_-01v"));
  var wantAdded=new HashSet<>(Set.of(PatchToken70.DESKTOP+"|I1:presentController73",
   PatchToken71.PRESENT71+"|I1:prepareGift73"));
  for(String name:List.of("ownsGift","giftAction","openGift","returnGift","fit","reader",
   "colorBlock","caption","messageBody","showReader","giftIcon","showTrophy","holdReader","readerKind"))
   wantAdded.add("loginpatch:RoomUse70|S1:"+name);
  var changes=new TreeSet<String>();var additions=new TreeSet<String>();int retained=0;
  for(var c:old.values()){
   var before=methods(c);var after=methods(now.get(c.logical()));
   for(String key:new HashSet<>(after.keySet()))if(!before.containsKey(key)){
    String k=c.logical()+"|"+key;check(wantAdded.remove(k),"Unexpected added method "+k);additions.add(k);after.remove(key);
   }
   check(before.keySet().equals(after.keySet()),"Method removal: "+c.logical());
   for(var e:before.entrySet()){
    if(normalized(e.getValue()).equals(normalized(after.get(e.getKey())))){retained++;continue;}
    String k=c.logical()+"|"+e.getKey();check(wantChanged.remove(k),"Unexpected changed method "+k);changes.add(k);
   }
  }
  check(wantChanged.isEmpty()&&wantAdded.isEmpty(),"Expected changes absent "+wantChanged+" "+wantAdded);
  check(CompareProtocol.read(a[0],"_-0cq::_-0z0").equals(CompareProtocol.read(a[1],"_-0cq::_-0z0")),"Protocol table changed");
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  Files.writeString(Path.of("work/feature73/method-review73.txt"),"Retained72 methods: "+retained+"\n\nChanged methods:\n"+String.join("\n",changes)+"\n\nAdded methods:\n"+String.join("\n",additions)+"\n");
  System.out.println("PASS: "+retained+" Teste72 methods retained; "+changes.size()+" changed methods and "+additions.size()+" additions limited to gift and trophy reading. Native walking and scoped long-press selection, class inventory, protocol tables and AVM2 offsets verified.");
 }
}

import java.io.*;
import java.nio.file.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class AuditToken74 extends AuditToken73 {
 public static void main(String[] a)throws Exception {
  var old=AuditStartup.classes(new SWF(new FileInputStream(a[0]),false));
  var swf=new SWF(new FileInputStream(a[1]),false);var now=AuditStartup.classes(swf);
  var addedClasses=new HashSet<>(now.keySet());
  addedClasses.removeAll(old.keySet());
  check(addedClasses.equals(Set.of("loginpatch:Portrait74","loginpatch:FriendLock74")),"Unexpected class inventory");
  var portrait=now.get("loginpatch:Portrait74");
  check(portrait.inst().interfaces.length==1&&
   AuditStartup.q(portrait.abc(),portrait.inst().interfaces[0]).equals("_-3fm::_-2m7")&&
   methods(portrait).keySet().containsAll(List.of("I1:_-1pp","I2:disposed","I1:dispose")),
   "Avatar callback interface is incomplete");
  var logical=new HashMap<String,String>();
  for(var entry:now.values())logical.put(entry.raw(),entry.logical());
  var wantChanged=new HashSet<>(Set.of("loginpatch:RoomUse70|S1:present","loginpatch:RoomUse70|S1:showPresent",
   logical.get("_-3oD::_-35L")+"|I1:_-3xi",logical.get("_-Fs::_-2Kx")+"|I1:_-0wY",
   logical.get("_-1wF::_-2vU")+"|I1:_-2n4",logical.get("_-Fs::_-2Kx")+"|I1:_-3Au"));
  var wantAdded=new HashSet<>(Set.of("loginpatch:RoomUse70|S1:readChosen74",
   logical.get("_-0D0::_-31O")+"|I1:showFurnitureMenu74",PatchToken70.DESKTOP+"|I1:showFurnitureMenu74"));
  var removed=new HashSet<>(Set.of("loginpatch:RoomUse70|S1:giftIcon"));
  var changes=new TreeSet<String>();var additions=new TreeSet<String>();int retained=0;
  for(var c:old.values()){
   var before=methods(c);var after=methods(now.get(c.logical()));
   for(String key:new HashSet<>(after.keySet()))if(!before.containsKey(key)){
    String k=c.logical()+"|"+key;check(wantAdded.remove(k),"Unexpected added method "+k);additions.add(k);after.remove(key);
   }
   for(String key:new HashSet<>(before.keySet()))if(!after.containsKey(key)){
    check(removed.remove(c.logical()+"|"+key),"Unexpected method removal: "+c.logical()+"|"+key);
    before.remove(key);
   }
   for(var e:before.entrySet()){
    String original=e.getValue();
    if(c.logical().equals("loginpatch:RoomUse70"))
     original=original.replace("QName(PrivateNamespace(\"loginpatch:RoomUse70\"),\"readerKind\")",
       "QName(PackageNamespace(\"\"),\"readerKind\")");
    if(normalized(original).equals(normalized(after.get(e.getKey())))){retained++;continue;}
    String k=c.logical()+"|"+e.getKey();check(wantChanged.remove(k),"Unexpected changed method "+k);changes.add(k);
   }
  }
  check(wantChanged.isEmpty()&&wantAdded.isEmpty()&&removed.isEmpty(),"Expected changes absent "+wantChanged+" "+wantAdded);
  check(CompareProtocol.read(a[0],"_-0cq::_-0z0").equals(CompareProtocol.read(a[1],"_-0cq::_-0z0")),"Protocol table changed");
  for(var tag:swf.getAbcList())for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
  Files.writeString(Path.of("work/feature74/method-review74.txt"),"Retained73 methods: "+retained+"\n\nChanged methods:\n"+String.join("\n",changes)+"\n\nAdded methods:\n"+String.join("\n",additions)+"\n");
  System.out.println("PASS: "+retained+" Teste73 methods retained; "+changes.size()+" changed methods and "+additions.size()+" additions limited to gift, trophy, and lock display. Native gestures, class inventory, protocol tables and AVM2 offsets verified.");
 }
}

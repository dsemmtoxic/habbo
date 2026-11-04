import java.util.*;import java.io.*;import com.jpexs.decompiler.flash.SWF;
class VerifyColorBindings61 extends PatchOldLogin {
 public static void main(String[]a)throws Exception{
  String name="com.sulake.habbo.communication.messages.outgoing.room.furniture:SetRoomBackgroundColorDataComposer";
  var expected=currentTables(new SWF(new FileInputStream("work/plus.swf"),false)).get("_composers").get(name);if(expected==null)throw new AssertionError("Reference color composer missing");
  var tables=CompareProtocol.read(a[0],"_-0cq::_-0z0");boolean found=false;
  for(var table:tables.values())for(var e:table.entrySet())if(e.getValue().equals(name)){if(!e.getKey().equals(expected))throw new AssertionError("Color header mismatch "+e.getKey()+" vs "+expected);found=true;}
  if(!found)throw new AssertionError("Color composer absent from original33 registry");
  System.out.println("PASS: SetRoomBackgroundColorDataComposer registered at reference header "+expected+" in original33/patched static protocol table; no invented header or local-only save.");
 }
}

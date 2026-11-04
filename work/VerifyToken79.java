import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken79 extends VerifyToken78 {
 static V78 click(SWF swf) throws Exception {
  var v = new V78(swf);
  v.registerClick();
  var peer = v.allocate(v.rawType(PEER));
  peer.put("_-33k", v.context69);
  peer.put("_-Mf", new Obj("menu-view78"));
  v.execute(v.method(PEER, "setup"), peer, v.user);
  var item = v.construct("_-1mZ::_-20D", List.of(PatchToken78.CLICK_ITEM));
  var event = new Obj("native-menu-event79");
  event.put("data", item);
  ((Obj)v.context69.get("communication")).put("connection", v.socket);
  v.execute(v.method(PEER, "_-0wY"), peer, event);
  check(v.frames.size() == 1 && v.enciphered.equals(List.of(10)) && v.flushed == 1,
    "The action must send exactly one frame through the socket path");
  v.user.put("_-1GP", 901);
  v.execute(v.method(PEER, "_-0wY"), peer, event);
  v.user.put("_-1GP", 900);
  v.activeSession = new Obj("different-room-session79");
  v.execute(v.method(PEER, "_-0wY"), peer, event);
  check(v.frames.size() == 1, "A stale target must not produce a second click");
  return v;
 }

 static byte[] frame(int header) {
  // The room index is deliberately different from the account ID (900).
  return ByteBuffer.allocate(10).putInt(6).putShort((short)header).putInt(7).array();
 }

 public static void main(String[] args) throws Exception {
  var before = new SWF(new FileInputStream(args[0]), false);
  var after = new SWF(new FileInputStream(args[1]), false);
  var plus = new SWF(new FileInputStream("work/plus.swf"), false);
  var outgoing = PatchOldLogin.currentTables(plus).get("_composers");
  int generic = outgoing.get(PatchToken79.GENERIC_CLICK);
  int wired = outgoing.get(PatchToken79.WIRED_CLICK);
  check(generic == 2515 && wired == 2936, "Wrong Air Plus reference");
  var reference = AuditStartup.classes(plus);
  var handlers = AuditToken62.methods(reference.get("com.sulake.habbo.roomevents:HabboUserDefinedRoomEvents"));
  check(handlers.get("I1:userSelected").contains("WiredClickUserMessageComposer"),
    "Reference selection does not call the dedicated Wired composer");
  var old = click(before);
  check(Arrays.equals(old.frames.get(0), frame(generic)), "Could not reproduce the original generic click");
  var now = click(after);
  check(Arrays.equals(now.frames.get(0), frame(wired)), "Menu did not send the dedicated Wired click");
  System.out.println("PASS: Teste78 emits generic 2515, Teste79 emits only WiredClickUser 2936 plus the exact 32-bit room index. Saved menu, registry, encoder and socket path exercised.");
 }
}

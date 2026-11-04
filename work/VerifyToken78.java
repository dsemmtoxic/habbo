import java.io.FileInputStream;
import java.nio.ByteBuffer;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken78 extends VerifyToken69 {
 static final String PEER = PatchOldLogin.PEER;
 static final String MANAGER = PatchOldLogin.MESSAGE_CLASSES;
 static final String CLICK = "loginpatch::UserClick69";
 static final String HELPER = "loginpatch::AvatarClick78";
 static final String SOCKET = "com.sulake.core.communication.connection:SocketConnection";
 static final String ENCODER = "com.sulake.core.communication.wireformat:EvaWireFormat";

 static class V78 extends V69 {
  final Obj registry = allocate(rawType(MANAGER));
  final Obj user = new Obj("selected-user78");
  final Obj socket = allocate(rawType(SOCKET));
  final Obj wire = allocate(rawType(ENCODER));
  final Obj transport = new Obj("transport78");
  final Obj cipher = new Obj("cipher78");
  final List<byte[]> frames = new ArrayList<>();
  final List<Integer> enciphered = new ArrayList<>();
  Obj activeSession;
  int flushed;

  V78(SWF swf) throws Exception {
   super(swf);
   activeSession = session;
   nativeTypes.add("_-1mZ::_-20D");
   user.put("_-Oi", 7);
   user.put("_-1GP", 900);
   user.put("type", 1);
   user.put("name", "Avatar");
   staticObject(HELPER).put("targets", new IdentityHashMap<>());
   registry.put("_-wS", new HashMap<>());
   transport.put("connected", true);
   socket.put("disposed", false);
   socket.put("connected", true);
   socket.put("_-4N9", false);
   socket.put("_-XB", registry);
   socket.put("_-18m", wire);
   socket.put("_-2D5", null);
   socket.put("_-2hE", cipher);
   socket.put("_-gJ", transport);
  }

  @Override Object lexical(Method m, Obj self, String name, int id) {
   if (Set.of("int", "String", "Boolean").contains(name)) return new Ref(name);
   return super.lexical(m, self, name, id);
  }

  @Override boolean instanceOf(Object value, String type) {
   if (type.equals("int")) return value instanceof Integer;
   if (type.equals("String")) return value instanceof String;
   if (type.equals("Boolean")) return value instanceof Boolean;
   return super.instanceOf(value, type);
  }

  @Override Object get(Object r, Object k) {
   if (r instanceof Obj o && o.get("buffer") instanceof ByteBuffer) return o.get(k);
   if (r == sessions && k.equals("_-4ke")) return new Bound(r, "_-4ke");
   return super.get(r, k);
  }

  @Override Object construct(String type, List<Object> args) {
   if (type.equals("_-3r7::_-2Pv")) return new Obj("menu-title78");
   if (type.equals("ByteArray") || type.equals("flash.utils::ByteArray")) {
    var bytes = new Obj("flash.utils::ByteArray");
    bytes.put("buffer", ByteBuffer.allocate(1024));
    bytes.put("position", 0);
    bytes.put("length", 0);
    return bytes;
   }
   return super.construct(type, args);
  }

  @Override void set(Object receiver, Object key, Object value) {
   if (receiver instanceof Obj o && o.type.equals("flash.utils::ByteArray") && key.equals("position")) {
    ((ByteBuffer)o.get("buffer")).position(num(value));
   }
   super.set(receiver, key, value);
  }

  @Override Object call(Object receiver, String name, List<Object> args) {
   if (receiver == sessions && name.equals("_-4ke")) return activeSession;
   if (receiver == users69 && name.equals("_-0uJ")) return num(args.get(0)) == 7 ? user : null;
   if (receiver == engine69 && name.equals("_-46h")) return null;
   if (receiver == transport && name.equals("writeBytes")) {
    var bytes = (Obj)args.get(0);
    frames.add(Arrays.copyOf(((ByteBuffer)bytes.get("buffer")).array(), num(bytes.get("length"))));
    return null;
   }
   if (receiver == transport && name.equals("flush")) {flushed++;return null;}
   if (receiver == cipher && name.equals("_-00-")) {enciphered.add(num(((Obj)args.get(0)).get("length")));return null;}
   if (receiver == socket && name.equals("send")) return execute(method(SOCKET, "send"), socket, args.toArray());
   if (receiver == wire && name.equals("encode")) return execute(method(ENCODER, "encode"), wire, args.toArray());
   if (receiver == registry && name.equals("_-0xx")) return execute(method(MANAGER, name), registry, args.toArray());
   if (receiver instanceof Ref ref && ref.name().equals("loginpatch::Avatar77")) {
    return execute(method("loginpatch:Avatar77", name), staticObject(ref.name()), args.toArray());
   }
   if (receiver instanceof Ref ref && ref.name().equals(HELPER)) {
    return execute(method("loginpatch:AvatarClick78", name), staticObject(HELPER), args.toArray());
   }
   if (receiver == staticObject(HELPER) && name.equals("activeSession")) {
    return execute(method("loginpatch:AvatarClick78", name), (Obj)receiver, args.toArray());
   }
   if (receiver instanceof Obj o && o.type.equals("flash.utils::ByteArray")) {
    var bytes = (ByteBuffer)o.get("buffer");
    if (name.equals("writeInt")) bytes.putInt(num(args.get(0)));
    else if (name.equals("writeShort")) bytes.putShort((short)num(args.get(0)));
    else throw new AssertionError("Unexpected byte write: " + name);
    o.put("length", Math.max(num(o.get("length")), bytes.position()));
    o.put("position", bytes.position());
    return null;
   }
   if (receiver instanceof Obj o && o.type.equals(rawType(PEER))) {
    if (name.equals("send")) return execute(method(PEER, name), o, args.toArray());
    if (name.equals("createView")) return null;
   }
   if (receiver instanceof Obj o && o.type.equals("menu-view78") && name.equals("_-1te")) return null;
   return super.call(receiver, name, args);
  }

  void registerClick() throws Exception {
   var registration = method(MANAGER, "_-2aE");
   var instructions = registration.body().getCode().code;
   for (int i = 5; i < instructions.size(); i++) {
    var ins = instructions.get(i);
    if ((ins.getBytes()[0] & 255) == 0x60 && AuditStartup.q(registration.cls().abc(), ins.operands[0]).equals(CLICK)) {
     execute(slice(this, registration, i - 5, instructions.size() - 1, false), registry, allocate("_-0cq::_-0z0"));
     return;
    }
   }
   throw new AssertionError("No click packet registration");
  }
 }

 public static void main(String[] args) throws Exception {
  var v = new V78(new SWF(new FileInputStream(args[0]), false));
  v.text("select", "pt");
  v.registerClick();
  var peer = v.allocate(v.rawType(PEER));
  peer.put("_-33k", v.context69);
  peer.put("_-Mf", new Obj("menu-view78"));
  v.execute(v.method(PEER, "setup"), peer, v.user);

  // Emulate menu data retaining the native item ID alone.
  var item = v.construct("_-1mZ::_-20D", List.of(PatchToken78.CLICK_ITEM));
  var evt = new Obj("native-menu-event78");
  evt.put("data", item);
  ((Obj)v.context69.get("communication")).put("connection", v.socket);
  v.execute(v.method(PEER, "_-0wY"), peer, evt);
  var plus = new SWF(new FileInputStream("work/plus.swf"), false);
  int header = PatchOldLogin.currentTables(plus).get("_composers")
    .get("com.sulake.habbo.communication.messages.outgoing.room:ClickCharacterComposer");
  byte[] expected = ByteBuffer.allocate(10).putInt(6).putShort((short)header).putInt(7).array();
  check(v.frames.size() == 1 && Arrays.equals(v.frames.get(0), expected), "Click frame mismatch: " + v.frames.stream().map(HexFormat.of()::formatHex).toList() + " expected=" + HexFormat.of().formatHex(expected) + " item=" + item + " targets=" + ((Map<?,?>)v.staticObject(HELPER).get("targets")).size());
  check(v.enciphered.equals(List.of(10)) && v.flushed == 1, "Native socket path did not reach encrypt/write/flush");

  v.user.put("_-1GP", 901);
  v.execute(v.method(PEER, "_-0wY"), peer, evt);
  v.user.put("_-1GP", 900);
  v.activeSession = new Obj("different-room-session78");
  v.execute(v.method(PEER, "_-0wY"), peer, evt);
  check(v.frames.size() == 1, "Recycled user slot or old room session emitted a click");
  v.activeSession = v.session;
  evt.put("data", v.construct("_-1mZ::_-20D", List.of(0)));
  v.execute(v.method(PEER, "_-0wY"), peer, evt);
  check(v.frames.size() == 1, "Non-click item was intercepted");
  System.out.println("PASS: native peer setup and ID dispatch reach the saved socket and encoder. The exact click frame matches Air Plus and is flushed by the socket fixture. Stale users and sessions emit nothing.");
 }
}

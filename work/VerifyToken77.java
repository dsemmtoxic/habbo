import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken77 extends VerifyToken69 {
 static final String CLICK = "loginpatch::UserClick69";
 static final String MANAGER = PatchOldLogin.MESSAGE_CLASSES;

 static class V77 extends V69 {
  V77(SWF swf) throws Exception { super(swf); }

  @Override Object get(Object receiver, Object key) {
   if (receiver instanceof Obj o && o.type.equals("wired-editor77") && key.equals("_-1yl")) {
    return new Bound(receiver, "_-1yl");
   }
   return super.get(receiver, key);
  }

  @Override Object call(Object receiver, String name, List<Object> args) {
   if (receiver instanceof Ref ref && ref.name().equals("loginpatch::Avatar77")) {
    return execute(method("loginpatch:Avatar77", name), staticObject(ref.name()), args.toArray());
   }
   if (receiver == avatar69 && name.equals("getId")) return 29;
   if (receiver instanceof Obj o && o.type.equals("wired-editor77") && name.equals("_-1yl")) {
    return "Usuário clica em usuário";
   }
   return super.call(receiver, name, args);
  }
 }

 static void verify77(SWF swf) throws Exception {
  var v = new V77(swf);
  var peer = v.allocate(v.rawType(PatchOldLogin.PEER));
  peer.put("_-33k", v.context69);
  peer.put("_-RY", 900);
  var setup = v.method(PatchOldLogin.PEER, "setup");
  var code = setup.body().getCode().code;
  int hook = code.size() - 7;
  check(AuditStartup.q(setup.cls().abc(), code.get(hook).operands[0]).equals("loginpatch::Avatar77"),
    "Facing hook is missing at the native peer setup boundary");
  v.execute(slice(v, setup, hook, code.size() - 1, false), peer, (Object)null);
  check(v.sent.size() == 1 && payload(v, v.sent.get(0)).equals(List.of(5, 6)),
    "Menu must send only the native look packet");

  var event = new Obj("menu-click77");
  var data = new Obj("menu-data77");
  data.put("action", "click69");
  event.put("data", data);
  v.execute(v.method(PatchOldLogin.PEER, "_-0wY"), peer, event);
  check(v.sent.size() == 2 && v.sent.get(1).type.equals(CLICK) &&
    payload(v, v.sent.get(1)).equals(List.of(29)),
    "Click must send the room object's ID, with no second look packet");

  var registry = v.allocate(v.rawType(MANAGER));
  registry.put("_-wS", new HashMap<>());
  var registration = v.method(MANAGER, "_-2aE");
  var instructions = registration.body().getCode().code;
  int alias = -1;
  for (int i = 0; i < instructions.size(); i++) {
   var ins = instructions.get(i);
   if ((ins.getBytes()[0] & 255) == 0x60 && AuditStartup.q(registration.cls().abc(), ins.operands[0]).equals(CLICK)) {
    alias = i;
    break;
   }
  }
  check(alias >= 5, "Missing click registration");
  v.execute(slice(v, registration, alias - 5, instructions.size() - 1, false),
    registry, v.allocate("_-0cq::_-0z0"));
  int header = num(v.execute(v.method(MANAGER, "_-0xx"), registry, v.sent.get(1)));
  var plus = new SWF(new FileInputStream("work/plus.swf"), false);
  int reference = PatchOldLogin.currentTables(plus).get("_composers")
    .get("com.sulake.habbo.communication.messages.outgoing.room:ClickCharacterComposer");
  check(header == reference && header == 2515, "Native lookup does not return the Air Plus click header");

  peer.put("_-RY", 999);
  v.execute(v.method(PatchOldLogin.PEER, "_-0wY"), peer, event);
  v.execute(slice(v, setup, hook, code.size() - 1, false), peer, (Object)null);
  check(v.sent.size() == 2, "A stale peer must emit neither packet");

  var control = new Obj("wired-control77");
  v.statics.put("_modernControl", control);
  var wiredInfo = new Obj("wired-info77");
  wiredInfo.put("type", 1);
  v.statics.put("_modernInfo", wiredInfo);
  v.statics.put("_wiredEditor", new Obj("wired-editor77"));
  var content = (Obj)v.helper("modernWiredContent", control);
  var children = (List<?>)content.get("children");
  check(children.size() == 1 && v.get(children.get(0), "text").equals("Usuário clica em usuário"),
    "Wired content should retain only its title at this stage");
  System.out.println("PASS: native peer setup sends only LookTo, explicit click sends the room-object ID with Air Plus header 2515, stale peers send nothing, and Wired content omits the description.");
 }

 public static void main(String[] args) throws Exception {
  verify77(new SWF(new FileInputStream(args[0]), false));
 }
}

import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken80 extends VerifyWiredBuilders {
 static final String BUILDER = "loginpatch:BuilderClub80";
 static final String HELPER = "loginpatch::BuilderClub80";
 static final String SETTINGS = "loginpatch::ClientSettings63";

 static class BuilderVM extends WiredVM {
  String flag;
  int panels;
  BuilderVM(SWF swf) {super(swf);}
  @Override Object call(Object receiver, String name, List<Object> args) {
   if (receiver instanceof Ref ref && ref.name().equals(HELPER)) {
    return execute(method(BUILDER, name), staticObject(HELPER), args.toArray());
   }
   if (receiver instanceof Obj o && o.type.equals(classes.get(CATALOG).raw())) {
    if (name.equals("_-2xK") || name.equals("_-0x5")) {
     return execute(method(CATALOG, name), o, args.toArray());
    }
    if (name.equals("getProperty")) return flag;
    if (Set.of("_-1Ze", "_-2RD").contains(name)) return null;
    if (name.equals("getBoolean") && args.get(0).equals("catalog.drag_and_drop")) return true;
   }
   if (name.equals("trackGoogle") || name.equals("dispatchEvent")) return null;
   if (name.equals("_-08s")) {
    check(args.get(1).equals("INVENTORY") && truth(args.get(2)), "Wrong native view opened");
    panels++;
    return null;
   }
   return super.call(receiver, name, args);
  }
 }

 static void builders(SWF swf) throws Exception {
  var vm = new BuilderVM(swf);
  var cat = catalog(vm);
  var room = (Obj)cat.get("_-3ue");
  var ui = new Obj("habbo-ui80");
  ui.put("catalog", cat);
  ui.put("tracking", new Obj("tracking80"));
  ui.put("inventory", new Obj("inventory80"));
  ui.put("events", new Obj("events80"));
  var manager = new Obj(vm.classes.get(PatchToken80.MAIN_VIEW).raw());
  manager.put("_-33k", ui);

  vm.execute(vm.method(PatchToken80.MAIN_VIEW, "_-7-"), manager, 3);
  check(vm.panels == 1 && vm.sent.size() == 1, "Opening inventory did not open the panel and query the count");
  check(vm.sent.get(0).type.equals("_-1Dj::_-3oJ") && payload(vm, vm.sent.get(0)).isEmpty(), "Wrong count request");
  vm.execute(vm.method(PatchToken80.MAIN_VIEW, "_-7-"), manager, 3);
  check(vm.panels == 2 && vm.sent.size() == 1, "Rapid inventory opens should coalesce count requests");
  vm.now += 1100;
  vm.execute(vm.method(PatchToken80.MAIN_VIEW, "_-7-"), manager, 3);
  check(vm.panels == 3 && vm.sent.size() == 2, "Reopening inventory should refresh usage");

  var offer = new Obj("offer80");
  var product = new Obj("product80");
  product.put("_-4Xb", "s");
  offer.put("product", product);
  offer.put("_-25", "pricing_model_single");
  var ctx = new Obj("preview80");
  ctx.put("catalog", cat);
  ctx.put("_-1Gs", offer);
  var buttons = new Obj(vm.classes.get(BUTTONS).raw());
  buttons.put("_-ZD", ctx);
  check(truth(vm.execute(vm.method(BUTTONS, "_-1bj"), buttons)), "Unknown usage still blocks the preview");
  check(vm.notices.isEmpty() && vm.sent.size() == 2, "Preview still interrupts or sends a duplicate query");
  var status = vm.method(CATALOG, "_-0x5");
  for (int count : new int[]{-1, 0, 249, 250, 251}) {
   cat.put("_-AC", count);
   check(num(vm.execute(status, cat, offer)) == (count < 250 ? 0 : 2), "Owner quota wrong for usage " + count);
  }

  room.put("_-0lf", false);
  room.put("_-1pT", true);
  for (int rights : new int[]{0, 1, 2, 3, 4}) {
   room.put("_-423", rights);
   check(num(vm.execute(status, cat, offer)) == (rights < 3 ? 4 : 0), "Wrong group policy for rights level " + rights);
  }
  room.put("_-423", 3);
  vm.flag = "false";
  check(num(vm.execute(status, cat, offer)) == 5, "Hotel disable flag ignored");
  vm.flag = "true";
  check(truth(vm.execute(vm.method(BUTTONS, "_-1bj"), buttons)), "Authorized admin blocked by own full quota");
  check(truth(vm.execute(vm.method(CATALOG, "_-0Lc"), cat, offer, "BUILDERS_CLUB")), "Authorized admin cannot drag the offer");
  offer.put("disposed", false);
  offer.put("pageId", 12);
  offer.put("offerId", 345);
  product.put("_-2XU", "");
  var data = new Obj("fixture-furniture-data");
  data.put("_-uZ", "wall_item");
  product.put("furnitureData", data);
  cat.put("_-105", offer);
  cat.put("_-2He", true);
  cat.put("_-2AG", null);
  var placement = new Obj("fixture-room-placement");
  placement.put("type", "REOE_PLACED");
  placement.put("roomId", 707);
  placement.put("objectId", 1001);
  placement.put("_-1vQ", true);
  placement.put("x", 5);
  placement.put("y", 7);
  placement.put("direction", 2);
  placement.put("_-TY", ":w=1,2 l=3,4 l");
  for (int category : new int[]{10, 20}) {
   placement.put("category", category);
   vm.execute(vm.method(CATALOG, "_-0Fj"), cat, placement);
   var packet = vm.sent.get(vm.sent.size() - 1);
   check(packet.type.equals(category == 10 ? "_-1Dj::_-0Ho" : "_-1Dj::_-33j"), "Incorrect placement message");
   check(payload(vm, packet).equals(category == 10 ? List.of(12, 345, "", 5, 7, 2, false)
     : List.of(12, 345, "", placement.get("_-TY"), false)), "Placement altered the hotel payload");
  }
  room.put("_-1pT", false);
  check(num(vm.execute(status, cat, offer)) == 4, "Non-group guest can place");
  cat.put("_-3ue", null);
  check(num(vm.execute(status, cat, offer)) == 3, "Placement allowed outside room");
  check(num(vm.execute(status, cat, (Object)null)) == 1, "Missing offer accepted");
  System.out.println("PASS: real inventory and preview bytecode, coalesced count query, owner quota, group ranks and feature flag. Group placement sends the standard floor and wall payloads.");
 }

 static class AvatarVM extends VerifyToken78.V78 {
  final Obj location = new Obj("location80");
  final Obj target = new Obj("target80");
  final Obj turnConnection = new Obj("turn-connection80");
  final List<List<?>> turns = new ArrayList<>();
  AvatarVM(SWF swf) throws Exception {
   super(swf);
   location.put("x", 4);
   location.put("y", 6);
   engine69.put("connection", turnConnection);
  }
  @Override Object call(Object receiver, String name, List<Object> args) {
   if (receiver == engine69 && name.equals("_-46h")) return target;
   if (receiver == target && name.equals("getLocation")) return location;
   if (receiver == turnConnection && name.equals("send")) {
    turns.add(payload(this, (Obj)args.get(0)));
    return true;
   }
   return super.call(receiver, name, args);
  }
 }

 static void avatar(SWF swf) throws Exception {
  var v = new AvatarVM(swf);
  v.registerClick();
  v.settings("open", (Object)null);
  var switches = (Map<?,?>)v.staticObject(SETTINGS).get("_buttons");
  check(switches.size() == 8, "Settings panel lost switches");
  var toggle = switches.entrySet().stream().filter(e -> "faceOnMenu".equals(e.getValue())).findFirst().orElseThrow();
  var peer = v.allocate(v.rawType(VerifyToken78.PEER));
  peer.put("_-33k", v.context69);
  peer.put("_-Mf", new Obj("menu-view78"));

  v.execute(v.method(VerifyToken78.PEER, "setup"), peer, v.user);
  check(v.turns.equals(List.of(List.of(4, 6))), "Default does not face avatar on menu open");
  v.settings("changed", VerifyToken63.eventFor((Obj)toggle.getKey()));
  v.execute(v.method(VerifyToken78.PEER, "setup"), peer, v.user);
  check(v.turns.size() == 1, "Disabled setting still sends LookTo");
  var data = (Obj)v.preferences.get("data");
  check(Boolean.FALSE.equals(data.get("faceOnMenu")), "Preference was not written");
  var restarted = new AvatarVM(swf);
  ((Obj)restarted.preferences.get("data")).putAll(data);
  check(!truth(((Obj)restarted.settings("values")).get("faceOnMenu")), "New session lost preference");

  var event = new Obj("peer-action80");
  event.put("data", v.construct("_-1mZ::_-20D", List.of(PatchToken78.CLICK_ITEM)));
  ((Obj)v.context69.get("communication")).put("connection", v.socket);
  v.execute(v.method(VerifyToken78.PEER, "_-0wY"), peer, event);
  check(v.frames.size() == 1 && Arrays.equals(v.frames.get(0), VerifyToken79.frame(2936)), "Preference broke explicit Wired click");
  System.out.println("PASS: settings panel, default turning, disabled turning, persistence and explicit Wired click with the preference disabled.");
 }

 public static void main(String[] args) throws Exception {
  var swf = new SWF(new FileInputStream(args[0]), false);
  builders(swf);
  avatar(swf);
 }
}

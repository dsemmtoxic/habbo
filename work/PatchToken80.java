import java.io.ByteArrayInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.util.HexFormat;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.AbcIndexing;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.ActionScript3Parser;
import com.jpexs.decompiler.flash.abc.types.MethodBody;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken80 extends PatchToken76 {
 static final String BASE_SHA = "0122d57a101e4ec825dbf064401b5127ac1a26b62d376ed233a4a599d497d763";
 static final String CATALOG = "com.sulake.habbo.tablet.catalog:HabboTabletCatalog";
 static final String VIEW = "com.sulake.habbo.tablet.catalog:CatalogViewController";
 static final String ROOM = "com.sulake.habbo.session:IRoomSession";
 static final String MAIN_VIEW = "com.sulake.habbo.ui:MainViewManager";
 static final String SETTINGS = "loginpatch:ClientSettings63";
 static final String AVATAR = "loginpatch:Avatar77";
 static final String FACE_KEY = "faceOnMenu";
 static final String FACE_LABEL = "Girar ao abrir menu de jogador";
 static final String FACE_DETAIL = "Vira seu avatar ao abrir o menu de outro jogador.";

 public static void main(String[] args) {
  try {
   patch80(Path.of(args[0]), Path.of(args[1]));
  } catch (Exception failure) {
   failure.printStackTrace(System.err);
   System.exit(1);
  }
 }

 static void patch80(Path base, Path target) throws Exception {
  byte[] input = Files.readAllBytes(base);
  if (!BASE_SHA.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)))) {
   throw new IllegalArgumentException("Expected exact Teste79 SWF");
  }
  swf = new SWF(new ByteArrayInputStream(input), false);
  abc = swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  var index = new AbcIndexing(swf, SWF.getAirGlobalAbcIndex());
  index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/BuilderClub80.as")), abc, index,
    "BuilderClub80.as", abc.instance_info.size(), abc.script_info.size(), true, swf.getDocumentClass());

  builderPlacement();
  warmOnOpen();
  turnSetting();

  for (var tag : swf.getAbcList()) {
   for (var body : tag.getABC().bodies) body.getCode().checkValidOffsets(body);
  }
  ((Tag)swf.getAbcList().get(1)).setModified(true);
  try (var output = Files.newOutputStream(target)) {
   swf.saveTo(output);
  }
  System.out.println("PASS: background BC count, authorized group placement, and persistent menu turning preference.");
 }

 static Code string(Code code, String value) {
  return code.op(0x2c, abc.constants.getStringId(value, true));
 }

 static Code returning(int status) {
  return new Code().op(0x24, status).op(0x48);
 }

 static Code when(Code code, int branchIfSkipped, Code block) {
  code.branch(branchIfSkipped, block.bytes().length);
  code.out.writeBytes(block.bytes());
  return code;
 }

 static void nop(MethodBody body, int from, int to) {
  for (int i = from; i < to; i++) {
   body.replaceInstruction(i, new AVM2Instruction(0, 0x02, new int[0]));
  }
  sync75(body);
 }

 static int opcode(MethodBody body, int at) {
  return body.getCode().code.get(at).getBytes()[0] & 255;
 }

 static int loadOf(MethodBody body, String name) {
  var code = body.getCode().code;
  for (int i = 0; i < code.size(); i++) {
   var ins = code.get(i);
   if (opcode(body, i) == 0x60 && name.equals(AuditStartup.name(abc, ins.operands[0]))) return i;
  }
  throw new IllegalStateException("Missing load " + name);
 }

 static Code room(Code code, String property) {
  return code.op(0x60, member(CATALOG, "_-22-")).op(0x66, member(ROOM, property));
 }

 static void builderPlacement() throws Exception {
  var preview = method(PREVIEW_BUTTONS, "_-1bj");
  int pending = callIndex(preview, "builderLimitPending", 1);
  if (pending != 6 || opcode(preview, pending + 3) != 0x48) {
   throw new IllegalStateException("Unexpected blocking preview guard");
  }
  nop(preview, 2, pending + 4);

  var status = method(CATALOG, "_-0x5");
  int oldPolicy = loadOf(status, "_-317");
  int ownerTrial = loadOf(status, "_-3R6");
  nop(status, oldPolicy, ownerTrial);

  int helper = helper("BuilderClub80");
  var group = new Code();
  when(room(group, "_-1pT"), 0x11, returning(4));
  when(room(group, "_-423").op(0x24, 3), 0x18, returning(4));
  when(group.op(0x60, helper).op(0xd0).op(0x46, publicName("groupEnabled"), 1), 0x11, returning(5));
  // The placement packet uses the current room. The server checks both
  // memberships and charges the owner's quota, which this client cannot read.
  group.out.writeBytes(returning(0).bytes());

  var policy = new Code().op(0x60, member(CATALOG, "_-22-"));
  when(policy, 0x11, returning(3));
  when(room(policy, "_-0lf"), 0x11, group);
  when(policy.op(0x60, helper).op(0xd0).op(0x46, publicName("ownerAtLimit"), 1), 0x12, returning(2));
  insertInclusive(status, oldPolicy, policy, 3);
 }

 static Code warm(String owner, String catalogField) {
  return new Code().op(0x60, helper("BuilderClub80")).field(owner, catalogField)
    .op(0x4f, publicName("warm"), 1);
 }

 static void warmOnOpen() throws Exception {
  var inventoryOpen = method(MAIN_VIEW, "_-7-");
  int inventoryType = lastString(inventoryOpen, "INVENTORY");
  if (opcode(inventoryOpen, inventoryType - 3) != 0x5d) {
   throw new IllegalStateException("Unexpected inventory open path");
  }
  insertInclusive(inventoryOpen, inventoryType - 3, new Code().op(0x60, helper("BuilderClub80"))
    .field(MAIN_VIEW, "_-33k").op(0x66, publicName("catalog")).op(0x4f, publicName("warm"), 1), 2);

  // The view calls this both when first shown and when changing catalog tabs.
  // The settings catalog field is a native private member, so run this call
  // in the view instead of reading that member dynamically in the helper.
  for (String name : new String[]{"onAddedToStage", "_-bK"}) {
   var view = method(VIEW, name);
   int catalogChanged = callIndex(view, "catalogTypeChanged", 1);
   var isBuilder = string(new Code().field(VIEW, "_-2Zi"), "BUILDERS_CLUB");
   insertInclusive(view, catalogChanged - 4, when(isBuilder, 0x14, warm(VIEW, "_-3HX")), 2);
  }
 }

 static int lastString(MethodBody body, String value) {
  int at = -1;
  for (int i = 0; i < body.getCode().code.size(); i++) {
   if (opcode(body, i) == 0x2c && value.equals(abc.constants.getString(body.getCode().code.get(i).operands[0]))) {
    at = i;
   }
  }
  if (at < 0) throw new IllegalStateException("Missing setting string " + value);
  return at;
 }

 static void appendSetting(MethodBody body, int at, int expected, Code extra) throws Exception {
  if (opcode(body, at) != expected || body.getCode().code.get(at).operands[0] != 7) {
   throw new IllegalStateException("Unexpected settings array or object");
  }
  body.replaceInstruction(at, new AVM2Instruction(0, expected, new int[]{8}));
  sync75(body);
  insertInclusive(body, at, extra, body.max_stack + 2);
 }

 static void turnSetting() throws Exception {
  var initializer = abc.findBody(abc.class_info.get(abc.instance_info.indexOf(instance(SETTINGS))).cinit_index);
  int keys = lastString(initializer, "dc") + 1;
  appendSetting(initializer, keys, 0x56, string(new Code(), FACE_KEY));
  int defaults = 0;
  while (defaults < keys && opcode(initializer, defaults) != 0x55) defaults++;
  appendSetting(initializer, defaults, 0x55, string(new Code(), FACE_KEY).op(0x26));

  var open = smethod(SETTINGS, "open");
  appendSetting(open, lastString(open, "Toque único para usar o mobi - :dc") + 1,
    0x56, string(new Code(), FACE_DETAIL));
  appendSetting(open, lastString(open, "Usar mobis com um toque") + 1,
    0x56, string(new Code(), FACE_LABEL));

  var values = smethod(SETTINGS, "values");
  int prior = lastString(values, "dc");
  var instructions = values.getCode().code;
  if (opcode(values, prior + 1) != 0x60 || opcode(values, prior + 2) != 0x66) {
   throw new IllegalStateException("Unexpected settings values accessor");
  }
  appendSetting(values, prior + 3, 0x55, string(new Code(), FACE_KEY)
    .op(0x60, instructions.get(prior + 1).operands[0]).op(0x66, publicName(FACE_KEY)));

  prefix(smethod(AVATAR, "face"), new Code().op(0x60, helper("ClientSettings63"))
    .op(0x46, publicName("values"), 0).op(0x66, publicName(FACE_KEY)).branch(0x11, 1).op(0x47), 1);
 }
}

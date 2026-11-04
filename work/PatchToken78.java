import java.io.ByteArrayInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.util.HexFormat;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.AbcIndexing;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.ActionScript3Parser;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken78 extends PatchToken76 {
 static final String BASE_SHA78 = "3a6ccf580603bdd0974b0b72e515d5a91280039c5a120815f5da8487604761e4";
 static final int CLICK_ITEM = 69001;
 static final String CLICK_HELPER = "AvatarClick78";

 public static void main(String[] args) {
  try {
   patch78(Path.of(args[0]), Path.of(args[1]));
  } catch (Throwable failure) {
   failure.printStackTrace(System.err);
   System.exit(1);
  }
 }

 static void patch78(Path base, Path target) throws Exception {
  byte[] input = Files.readAllBytes(base);
  if (!BASE_SHA78.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)))) {
   throw new IllegalArgumentException("Expected exact Teste77 SWF");
  }
  swf = new SWF(new ByteArrayInputStream(input), false);
  abc = swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  var index = new AbcIndexing(swf, SWF.getAirGlobalAbcIndex());
  index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/AvatarClick78.as")), abc, index,
    "AvatarClick78.as", abc.instance_info.size(), abc.script_info.size(), true, swf.getDocumentClass());

  var setup = method(PEER, "setup");
  int setupHook = setup.getCode().code.size() - 7;
  var facing = setup.getCode().code.get(setupHook);
  if ((facing.getBytes()[0] & 255) != 0x60 || !qname(abc, facing.operands[0]).equals("loginpatch::Avatar77")) {
   throw new IllegalStateException("Expected native menu setup before avatar facing");
  }
  String user = "com.sulake.habbo.session:IUserData";
  insertInclusive(setup, setupHook, new Code()
    .op(0x60, helper(CLICK_HELPER)).op(0xd0).field(PEER, "_-33k")
    .op(0xd1).op(0x66, member(user, "_-Oi")).op(0xd1).op(0x66, member(user, "_-1GP"))
    .op(0x4f, publicName("remember"), 4), 5);

  var menu = method(PEER, "_-0wY");
  var code = menu.getCode().code;
  if (!qname(abc, code.get(2).operands[0]).equals("loginpatch::Avatar77") ||
      (code.get(10).getBytes()[0] & 255) != 0x47 ||
      (code.get(16).getBytes()[0] & 255) != 0xd6 ||
      !qname(abc, code.get(18).operands[0]).endsWith("IMenuItemData::id")) {
   throw new IllegalStateException("Expected native peer item dispatch");
  }
  for (int i = 2; i <= 10; i++) {
   menu.replaceInstruction(i, new AVM2Instruction(0, 0x02, new int[0]));
  }
  sync75(menu);

  // Reuse the native IMenuItemData ID and the controller's typed socket send.
  var send = new Code()
    .op(0x60, helper(CLICK_HELPER)).op(0xd0).field(PEER, "_-33k")
    .op(0x46, publicName("composer"), 2).op(0xd7)
    .op(0xd3);
  var deliver = new Code().op(0xd0).op(0xd3).op(0x4f, member(PEER, "send"), 1);
  send.branch(0x12, deliver.bytes().length);
  send.out.writeBytes(deliver.bytes());
  send.op(0x47);

  var dispatch = new Code().op(0xd2).op(0x66, code.get(18).operands[0])
    .op(0x2d, abc.constants.getIntId(CLICK_ITEM, true)).branch(0x14, send.bytes().length);
  dispatch.out.writeBytes(send.bytes());
  insertInclusive(menu, 17, dispatch, 4);
  menu.max_regs = Math.max(menu.max_regs, 4);

  for (var tag : swf.getAbcList()) {
   for (var body : tag.getABC().bodies) body.getCode().checkValidOffsets(body);
   ((Tag) tag).setModified(true);
  }
  try (var out = Files.newOutputStream(target)) {
   swf.saveTo(out);
  }
  System.out.println("PASS: the native peer item ID dispatches a click using the room's selected user index.");
 }
}

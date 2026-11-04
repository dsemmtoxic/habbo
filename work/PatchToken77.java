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

class PatchToken77 extends PatchToken76 {
 static final String BASE_SHA77 = "653f54b152146f7a7fb705a7ba315f28046645954524f3090203fb7ddb54c907";

 public static void main(String[] args) {
  try {
   patch77(Path.of(args[0]), Path.of(args[1]));
  } catch (Throwable failure) {
   failure.printStackTrace(System.err);
   System.exit(1);
  }
 }

 static void patch77(Path base, Path target) throws Exception {
  byte[] input = Files.readAllBytes(base);
  if (!BASE_SHA77.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)))) {
   throw new IllegalArgumentException("Expected exact Teste76 SWF");
  }
  swf = new SWF(new ByteArrayInputStream(input), false);
  abc = swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  var index = new AbcIndexing(swf, SWF.getAirGlobalAbcIndex());
  index.selectAbc(abc);
  ActionScript3Parser.compile(Files.readString(Path.of("work/Avatar77.as")), abc, index,
    "Avatar77.as", abc.instance_info.size(), abc.script_info.size(), true, swf.getDocumentClass());

  // The peer controller receives the selected user once in setup. Profile
  // responses rebuild the list later, so turning during list creation repeats.
  var setup = method(PEER, "setup");
  insertInclusive(setup, setup.getCode().code.size() - 1, new Code()
    .op(0x60, helper("Avatar77")).field(PEER, "_-33k").field(PEER, "_-RY")
    .op(0x4f, publicName("face"), 2), 3);
  var menu = method(PEER, "_-0wY");
  var first = menu.getCode().code.get(2);
  if ((first.getBytes()[0] & 255) != 0x60 ||
      !qname(abc, first.operands[0]).equals("loginpatch::Avatar69")) {
   throw new IllegalStateException("Expected original avatar action hook");
  }
  menu.replaceInstruction(2, new AVM2Instruction(0, 0x60, new int[]{helper("Avatar77")}));
  sync75(menu);

  var wired = smethod(LOGIN, "modernWiredContent");
  var code = wired.getCode().code;
  int description = -1;
  for (int i = 3; i < code.size(); i++) {
   var ins = code.get(i);
   if ((ins.getBytes()[0] & 255) == 0x2c &&
       abc.constants.getString(ins.operands[0]).equals("_-0lb")) {
    description = i - 3;
    break;
   }
  }
  if (description < 0 || code.size() - description != 35 ||
      (code.get(description + 13).getBytes()[0] & 255) != 0x5d ||
      (code.get(description + 33).getBytes()[0] & 255) != 0xd2) {
   throw new IllegalStateException("Unexpected Wired description block");
  }
  for (int i = description; i < description + 33; i++) {
   // Keep the existing title label and drop both the description lookup and row.
   if (i < description + 13 || i >= description + 17) {
    wired.replaceInstruction(i, new AVM2Instruction(0, 0x02, new int[0]));
   }
  }
  sync75(wired);

  for (var tag : swf.getAbcList()) {
   for (var body : tag.getABC().bodies) body.getCode().checkValidOffsets(body);
   ((Tag) tag).setModified(true);
  }
  try (var out = Files.newOutputStream(target)) {
   swf.saveTo(out);
  }
  System.out.println("PASS: Teste77 separates avatar facing and user click, and removes the Wired description row.");
 }
}

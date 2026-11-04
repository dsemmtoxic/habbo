import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.security.MessageDigest;
import java.util.HexFormat;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.instructions.AVM2Instruction;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken79 extends PatchToken76 {
 static final String BASE_SHA = "3bd3796c39d2dffce48679ca6152b953cf9e5ff25a2181c6df0daf3b64b03415";
 static final String WIRED_CLICK = "com.sulake.habbo.communication.messages.outgoing.userdefinedroomevents:WiredClickUserMessageComposer";
 static final String GENERIC_CLICK = "com.sulake.habbo.communication.messages.outgoing.room:ClickCharacterComposer";
 static final String CLICK_CLASS = "loginpatch::UserClick69";
 static final String REGISTRY = "_-0cq::_-0z0";

 public static void main(String[] args) {
  try {
   patch79(Path.of(args[0]), Path.of(args[1]));
  } catch (Throwable failure) {
   failure.printStackTrace(System.err);
   System.exit(1);
  }
 }

 static void patch79(Path base, Path target) throws Exception {
  byte[] input = Files.readAllBytes(base);
  if (!BASE_SHA.equals(HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)))) {
   throw new IllegalArgumentException("Expected exact Teste78 SWF");
  }
  var reference = new SWF(new FileInputStream("work/plus.swf"), false);
  var outgoing = currentTables(reference).get("_composers");
  int wiredHeader = outgoing.get(WIRED_CLICK);
  int genericHeader = outgoing.get(GENERIC_CLICK);
  if (wiredHeader != 2936 || genericHeader != 2515) {
   throw new IllegalStateException("Unexpected Air Plus click mapping");
  }
  if (CompareProtocol.read(base.toString(), REGISTRY).values().stream().anyMatch(map -> map.containsKey(wiredHeader))) {
   throw new IllegalStateException("Wired click header is already present in the native registry");
  }

  swf = new SWF(new ByteArrayInputStream(input), false);
  abc = swf.getAbcList().get(1).getABC();
  var registry = method(MESSAGE_CLASSES, "_-2aE");
  var code = registry.getCode().code;
  int headerAt = -1;
  for (int i = 1; i < code.size() - 1; i++) {
   var ins = code.get(i);
   int op = ins.getBytes()[0] & 255;
   if (op == 0x25 && ins.operands[0] == wiredHeader) {
    throw new IllegalStateException("Wired click header is already registered as an alias");
   }
   if (op != 0x60 || !qname(abc, ins.operands[0]).equals(CLICK_CLASS)) continue;
   var previous = code.get(i - 1);
   var next = code.get(i + 1);
   if (headerAt >= 0 || (previous.getBytes()[0] & 255) != 0x25 ||
       previous.operands[0] != genericHeader || (next.getBytes()[0] & 255) != 0x4f ||
       next.operands[0] != member(MESSAGE_CLASSES, "_-3aS")) {
    throw new IllegalStateException("Unexpected click alias registration");
   }
   headerAt = i - 1;
  }
  if (headerAt < 0) throw new IllegalStateException("Click alias registration missing");

  // The explicit peer action is the only caller. The one-int room-index
  // payload matches WiredClickUser; replace the generic click header.
  registry.replaceInstruction(headerAt, new AVM2Instruction(0, 0x25, new int[]{wiredHeader}));
  sync75(registry);
  for (var tag : swf.getAbcList()) {
   for (var body : tag.getABC().bodies) body.getCode().checkValidOffsets(body);
  }
  ((Tag)swf.getAbcList().get(1)).setModified(true);
  try (var out = Files.newOutputStream(target)) {
   swf.saveTo(out);
  }
  System.out.println("PASS: explicit avatar action uses WiredClickUser 2936 instead of generic ClickCharacter 2515.");
 }
}

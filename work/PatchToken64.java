import java.io.*;
import java.nio.file.*;
import java.security.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.*;
import com.jpexs.decompiler.flash.abc.types.*;
import com.jpexs.decompiler.flash.abc.types.traits.*;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken64 extends PatchToken63 {
 static String quote(String s) {
  var out=new StringBuilder("\"");
  for(char c:s.toCharArray())switch(c){case '\\'->out.append("\\\\");case '"'->out.append("\\\"");case '\n'->out.append("\\n");case '\r'->out.append("\\r");case '\t'->out.append("\\t");default->{if(c<32||c=='\u2028'||c=='\u2029')out.append(String.format("\\u%04x",(int)c));else out.append(c);}}
  return out.append('"').toString();
 }
 static void restore(MethodBody to,MethodBody from) {
  to.setCodeBytes(from.getCodeBytes().clone());to.max_stack=from.max_stack;to.max_regs=from.max_regs;to.max_scope_depth=from.max_scope_depth;to.exceptions=from.exceptions.clone();to.getCode();to.setModified();
 }
 static MethodBody baselineMethod(AuditStartup.Cls cls,String name,boolean stat) {
  for(var trait:(stat?cls.abc().class_info.get(cls.index()).static_traits:cls.inst().instance_traits).traits)if(trait instanceof TraitMethodGetterSetter m&&name.equals(AuditStartup.name(cls.abc(),trait.name_index)))return cls.abc().findBody(m.method_info);
  throw new IllegalStateException("Missing baseline method "+name);
 }
 public static void main(String[]args)throws Exception {
  byte[] input=Files.readAllBytes(Path.of(args[0]));
  if(!HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)).equals("de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901"))throw new IllegalArgumentException("Exact original33 required");
  var pristine=new SWF(new ByteArrayInputStream(input),false);
  swf=new SWF(new ByteArrayInputStream(input),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();
  publicAccess();
  for(String[]item:new String[][]{{"consoleText64","_-3i2"},{"consoleBubble64","_-2pq"}})getter(RENDERER,item[0],new Code().op(0xd0).op(0x30).op(0xd0).op(0x66,member(RENDERER,item[1])).op(0x48),1,method(RENDERER,"commitData"));
  for(String name:List.of("ClientTheme63","Console61","ClientSettings63","RoomAppearance61","RoomLighting63","WebSession64","Login62")) {
   String code=Files.readString(Path.of("work/"+name+".as"));
   if(name.equals("WebSession64"))code=code.replace("\"__WEB_SESSION_SCRIPT64__\"",quote(Files.readString(Path.of("work/session64.js"))));
   var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);
   ActionScript3Parser.compile(code,abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
   System.out.println("Compiled "+name);
  }
  chat();room62();login62();backgroundAccess();geometry();commands();lighting();
  var baseline=AuditStartup.classes(pristine);
  restore(smethod(PLAN,"_-3Vo"),baselineMethod(baseline.get(PLAN),"_-3Vo",true));
  restore(method(LOGIC,"_-3uS"),baselineMethod(baseline.get(LOGIC),"_-3uS",false));
  returns(method(RENDERER,"commitData"),new Code().op(0x60,helper("Console61")).op(0xd0).op(0xd1).op(0x4f,publicName("decorate"),2),3);
  var website=smethod(LOGIN,"tokenWebsiteAction");website.setCodeBytes(new Code().op(0xd0).op(0x30).op(0x60,helper("Login62")).op(0xd1).op(0x60,stat(LOGIN,"_tokenActions")).op(0x4f,publicName("website"),2).op(0x47).bytes());website.max_stack=3;website.exceptions=new ABCException[0];website.getCode();website.setModified();
  for(var tag:swf.getAbcList()){for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);((Tag)tag).setModified(true);}
  try(var output=new FileOutputStream(args[1])){swf.saveTo(output);}
  System.out.println("PASS:64 built from exact33. Door mask restored independently of shadow; real Apply callback, native dimmer palette/limits/confirmation, messenger day badges/time labels and official-site session login installed. Android/hotel validation pending.");
 }
}

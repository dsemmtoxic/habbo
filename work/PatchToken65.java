import java.io.*;import java.nio.file.*;import java.security.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.*;import com.jpexs.decompiler.flash.abc.types.*;import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;import com.jpexs.decompiler.flash.tags.Tag;
class PatchToken65 extends PatchToken64 {
 static final String PLANE="com.sulake.habbo.room.object.visualization.room:RoomPlane",GEOMETRY="com.sulake.habbo.room.object.visualization.room:RoomPlaneGeometry";
 static void entryAccess(){
  for(String[]pair:new String[][]{{"entryMasks65","_-4Mn"},{"entryMaskManager65","_-43i"},{"entryMaskBitmap65","_-0HZ"}})getter(PLANE,pair[0],new Code().op(0xd0).op(0x30).field(PLANE,pair[1]).op(0x48),1,method(PLANE,"update"));
  var uv=method(GEOMETRY,"buildGeometry");addMethod(GEOMETRY,"entryInvalidateUVs65",new Code().op(0xd0).op(0x30).op(0xd0).op(0x4f,propertyCall(uv,"_-1y0"),0).op(0x47),1,1,new int[0],false,uv,1);
 }
 static int propertyCall(MethodBody b,String name){for(var ins:b.getCode().code){int op=ins.getBytes()[0]&255;if((op==0x46||op==0x4f)&&name.equals(AuditStartup.name(abc,ins.operands[0])))return ins.operands[0];}throw new IllegalStateException(name);}
 static void entryHooks()throws Exception{
  int helper=helper("RoomEntry65");prefix(method(RVIZ,"update"),new Code().op(0x60,helper).op(0xd0).op(0xd1).op(0x4f,publicName("bind"),2),3);
  var mesh=method(RVIZ,"_-1ii");int found=0;for(int i=0;i<mesh.getCode().code.size();i++){var ins=mesh.getCode().code.get(i);if((ins.getBytes()[0]&255)==0x63&&ins.operands[0]==19){insertInclusive(mesh,i+1,new Code().op(0x60,helper).op(0xd0).op(0xd1).op(0x62,19).op(0x4f,publicName("configure"),3),4);found++;break;}}if(found!=1)throw new IllegalStateException("Native geometry creation not found");
  for(String[]pair:new String[][]{{"buildGeometry","build"},{"buildUVs","uvs"}})prefix(method(GEOMETRY,pair[0]),new Code().op(0x60,helper).op(0xd0).op(0xd1).op(0x46,publicName(pair[1]),2).branch(0x12,1).op(0x47),3);
 }
 public static void main(String[]args)throws Exception{
  byte[]input=Files.readAllBytes(Path.of(args[0]));if(!HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(input)).equals("de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901"))throw new IllegalArgumentException("Exact33 required");
  var pristine=new SWF(new ByteArrayInputStream(input),false);swf=new SWF(new ByteArrayInputStream(input),false);abc=swf.getAbcList().get(1).getABC();SWF.initPlayer();publicAccess();entryAccess();
  for(String[]item:new String[][]{{"consoleText64","_-3i2"},{"consoleBubble64","_-2pq"}})getter(RENDERER,item[0],new Code().op(0xd0).op(0x30).op(0xd0).op(0x66,member(RENDERER,item[1])).op(0x48),1,method(RENDERER,"commitData"));
  for(String name:List.of("ModernUI65","ClientTheme63","Console61","ClientSettings63","RoomAppearance61","RoomEntry65","RoomLighting63","Login62","WebSession64")){
   String code=Files.readString(Path.of("work/"+name+".as"));if(name.equals("WebSession64"))code=code.replace("\"__WEB_SESSION_SCRIPT64__\"",quote(Files.readString(Path.of("work/session64.js"))));var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());index.selectAbc(abc);ActionScript3Parser.compile(code,abc,index,name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());System.out.println("Compiled "+name);
  }
  chat();room62();login62();backgroundAccess();geometry();commands();lighting();var baseline=AuditStartup.classes(pristine);restore(smethod(PLAN,"_-3Vo"),baselineMethod(baseline.get(PLAN),"_-3Vo",true));restore(method(LOGIC,"_-3uS"),baselineMethod(baseline.get(LOGIC),"_-3uS",false));
  returns(method(RENDERER,"commitData"),new Code().op(0x60,helper("Console61")).op(0xd0).op(0xd1).op(0x4f,publicName("decorate"),2),3);
  var website=smethod(LOGIN,"tokenWebsiteAction");website.setCodeBytes(new Code().op(0xd0).op(0x30).op(0x60,helper("Login62")).op(0xd1).op(0x60,stat(LOGIN,"_tokenActions")).op(0x4f,publicName("website"),2).op(0x47).bytes());website.max_stack=3;website.exceptions=new ABCException[0];website.getCode();website.setModified();entryHooks();
  for(var tag:swf.getAbcList()){for(var b:tag.getABC().bodies)b.getCode().checkValidOffsets(b);((Tag)tag).setModified(true);}try(var out=new FileOutputStream(args[1])){swf.saveTo(out);}System.out.println("PASS:65 built from exact33 with working64 lighting retained, full color swatches, transparent modern login, official browser session services and native door-mask mesh clipping.");
 }
}

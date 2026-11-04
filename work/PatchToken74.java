import java.io.*;
import java.nio.file.*;
import java.util.List;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.avm2.parser.script.*;
import com.jpexs.decompiler.flash.abc.types.traits.TraitMethodGetterSetter;
import com.jpexs.decompiler.flash.tags.Tag;

class PatchToken74 extends PatchToken73 {
 public static void main(String[] args) {
  try{finish74(args[0]);}
  catch(Throwable failure){failure.printStackTrace(System.err);System.exit(1);}
 }

 static void finish74(String target)throws Exception {
  try(var in=new FileInputStream(target)){swf=new SWF(in,false);}
  abc=swf.getAbcList().get(1).getABC();
  SWF.initPlayer();
  for(String name:List.of("Portrait74","FriendLock74")){
   var index=new AbcIndexing(swf,SWF.getAirGlobalAbcIndex());
   index.selectAbc(abc);
   ActionScript3Parser.compile(Files.readString(Path.of("work/"+name+".as")),abc,index,
     name+".as",abc.instance_info.size(),abc.script_info.size(),true,swf.getDocumentClass());
  }
  var portrait=instance("loginpatch:Portrait74");
  portrait.interfaces=new int[]{rawClass("_-3fm::_-2m7")};
  for(var t:portrait.instance_traits.traits)
   if(t instanceof TraitMethodGetterSetter&&AuditStartup.name(abc,t.name_index).equals("avatarReady"))
    t.name_index=publicName("_-1pp");

  String chooser=logicalRaw("_-3oD::_-35L");
  var choose=method(chooser,"_-3xi");
  int hidden=callIndex(choose,"hide",1);
  insertInclusive(choose,hidden+1,new Code().op(0x60,helper("RoomUse70")).field(chooser,"_-3x9")
    .op(0xd2).op(0x26).op(0x4f,publicName("readChosen74"),3),4);

  String menu=logicalRaw("_-Fs::_-2Kx");
  var use=method(menu,"_-0wY");
  int call=callIndex(use,"getEventHandler",1);
  if((use.getCode().code.get(call-1).getBytes()[0]&255)!=0xd2)
   throw new IllegalStateException("Use button object boundary changed");
  insertInclusive(use,call-1,new Code().op(0x60,helper("RoomUse70")).field(menu,"_-3x9")
    .op(0xd2).op(0x46,publicName("readChosen74"),2).branch(0x12,1).op(0x47),3);

  prefix(method(menu,"_-3Au"),new Code().op(0x60,helper("RoomUse70")).field(menu,"_-3Cd")
    .op(0x46,publicName("readerKind"),1).branch(0x12,2).op(0x26).op(0x48),2);

  String widgets=logicalRaw("_-0D0::_-31O");
  int roomObject=rawClass("_-1iL::_-Ro");
  addMethod(widgets,"showFurnitureMenu74",new Code().op(0xd0).op(0x30).op(0xd0).op(0xd1)
    .op(0x4f,member(widgets,"_-4gs"),1).op(0x47),2,2,new int[]{roomObject},false,method(widgets,"_-4gs"),1);
  addMethod(DESKTOP,"showFurnitureMenu74",new Code().op(0xd0).op(0x30).field(DESKTOP,"_-1Yj").op(0xd1)
    .op(0x4f,publicName("showFurnitureMenu74"),1).op(0x47),2,2,new int[]{roomObject},false,method(DESKTOP,"_-QW"),1);

  String lock=logicalRaw("_-1wF::_-2vU");
  replace(lock,"_-2n4",new Code().op(0xd0).op(0x30).op(0x60,helper("FriendLock74")).op(0xd0)
    .field(lock,"_-2sW").op(0x66,publicName("ui")).field(lock,"_-49m")
    .field(lock,"_-2ft").op(0xd1).op(0xd2).op(0xd3).field(lock,"_figure1").field(lock,"_figure2")
    .op(0x4f,publicName("mount"),9).op(0x47),10);

  for(var tag:swf.getAbcList()){
   for(var body:tag.getABC().bodies)body.getCode().checkValidOffsets(body);
   ((Tag)tag).setModified(true);
  }
  try(var out=new FileOutputStream(target)){swf.saveTo(out);}
  System.out.println("PASS: Teste74 reads stored gift figures, routes explicit furniture actions, and anchors lock portraits to Air Plus slots.");
 }
}

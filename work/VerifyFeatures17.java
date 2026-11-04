import java.io.*;import java.nio.file.*;import java.util.*;import java.util.regex.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;

// Execute the saved game bytecode. Bitmap decoding, font rasterization, GPU
// layout and native Android windows are explicit primitive/UI boundaries.
class VerifyFeatures17 extends VerifyFeatures16 {
 static final String STYLES="com.sulake.habbo.chat.discussion.viewer.visualization.style:ChatStyleLibrary";
 static final String STYLE="com.sulake.habbo.chat.discussion.viewer.visualization.style:ChatStyle";
 static final String BUBBLE="com.sulake.habbo.chat.discussion.viewer.visualization:Bubble";
 static final String FACTORY="com.sulake.habbo.chat.discussion.viewer:BubbleFactory";
 static final String CHATITEM="com.sulake.habbo.chat.discussion.data:ChatItem";
 static final String SESSIONCHAT="com.sulake.habbo.session.events:RoomSessionChatEvent";
 static class ChatVM extends ReleaseVM {
  final Set<String> primitives=Set.of("flash.filters::GlowFilter","flash.display::BitmapData","flash.text::TextFormat","flash.geom::Rectangle");
  final List<Obj> copied=new ArrayList<>();int userLookups=0,layouts=0;
  ChatVM(SWF s){super(s);}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(m.cls().logical().equals(BUBBLE)&&n.equals("_-0Ki"))return new Bound(self,n);
   return super.lexical(m,self,n,i);
  }
  @Override Object construct(String t,List<Object>a){
   if(t.equals("Array")){if(a.size()==1&&a.get(0) instanceof Number)return new ArrayList<>(Collections.nCopies(num(a.get(0)),null));return new ArrayList<>(a);}
   if(t.equals("RegExp")){String f=a.size()>1?String.valueOf(a.get(1)):"";return Pattern.compile(String.valueOf(a.get(0)),(f.contains("i")?Pattern.CASE_INSENSITIVE:0)|(f.contains("m")?Pattern.MULTILINE:0)|(f.contains("x")?Pattern.COMMENTS:0));}
   if(t.equals("flash.filters::GlowFilter")){var o=new Obj(t);o.put("args",new ArrayList<>(a));return o;}
   if(t.equals("flash.text::TextFormat")){var o=new Obj(t);var keys=List.of("font","size","color","bold","italic","underline");for(int i=0;i<a.size()&&i<keys.size();i++)o.put(keys.get(i),a.get(i));return o;}
   if(t.equals("flash.display::BitmapData")){var o=new Obj(t);o.put("width",a.get(0));o.put("height",a.get(1));return o;}
   if(t.equals("flash.geom::Rectangle")){var o=new Obj(t);for(int i=0;i<4;i++)o.put(List.of("x","y","width","height").get(i),a.get(i));return o;}
   if(t.equals("loginpatch::ChatAtlas")){var o=new Obj(t);o.put("bitmapData",new Obj("embedded-bitmap"));check(raw.containsKey(t),"Atlas class missing");return o;}
   if(t.equals("_-44B::Map")){var o=new Obj(t);execute(method(raw.get(t).logical(),"<init>"),o,a.toArray());return o;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref&&ref.name().equals("_-1N-::_-2mJ")&&Set.of("_-0-S","_-17Z").contains(k))return new Bound(r,String.valueOf(k));
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object v){
   if(r instanceof Obj o&&((o.type.equals(rawType(BUBBLE))&&Set.of("style","_-1Lo").contains(k))||(o.type.equals(rawType(CHATITEM))&&k.equals("text")))){
    var c=raw.get(o.type);for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==3&&AuditStartup.name(c.abc(),t.name_index).equals(k)){execute(new Method(c,c.abc().findBody(m.method_info)),o,v);return;}
   }
   super.set(r,k,v);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof String s&&n.equals("indexOf")&&a.size()>1)return s.indexOf(String.valueOf(a.get(0)),num(a.get(1)));
   if(n.equals("getDefinitionByName")&&primitives.contains(String.valueOf(a.get(0))))return new Ref(String.valueOf(a.get(0)));
   if(n.equals("_-0gh::_-1P8"))return a.get(0); // AVM2 native class cast
   if(r instanceof Ref ref&&ref.name().equals("_-1N-::_-2mJ")&&Set.of("_-0-S","_-17Z").contains(n))return 2;
   if(r instanceof List list&&n.equals("pop"))return list.remove(list.size()-1);
   if(r instanceof Pattern p&&n.equals("exec")){var matcher=p.matcher(String.valueOf(a.get(0)));return matcher.find()?matcher.group():null;}
   if(r instanceof Obj o){
    if(o.type.equals("flash.display::BitmapData")&&n.equals("copyPixels")){check(a.size()==3&&a.get(0) instanceof Obj,"Bad bitmap copy");o.put("source",a.get(1));copied.add(o);return null;}
    if(o.type.equals("chat-session-manager")&&n.equals("getSession"))return o.get("session");
    if(o.type.equals("chat-users")&&n.equals("_-0uJ")){userLookups++;return o.get("user");}
    if(o.type.equals(rawType(BUBBLE))){
     if(n.equals("_-2TQ")){o.put("_-1D2",get(o.get("_-2Ov"),"assetId"));return null;}
     if(Set.of("_-4Yw","_-33X").contains(n)){calls.add("bubble-gpu:"+n);return null;}
     if(n.equals("_-1mN")){layouts++;return null;}
     if(n.equals("_-0Ki"))return null; // Unchanged avatar-expression lookup
    }
   }
   return super.call(r,n,a);
  }
 }
 static void sameMethod(SWF before,SWF after,String owner,String name){var v=new VM(before);var w=new VM(after);check(Arrays.equals(v.method(owner,name).body().getCodeBytes(),w.method(owner,name).body().getCodeBytes()),"Landscape rollback changed "+owner+"."+name);}
 static void testLandscape(SWF original,SWF current){
  for(var entry:List.of(new String[]{HMENU,"_-45c"},new String[]{HMENU,"_-0wY"},new String[]{"com.sulake.habbo.toolbar:Toolbar","_-3Fa"},new String[]{":HabboTabletMain","onAddedToStage"},new String[]{":HabboTabletMain","onStageResize"},new String[]{DESKTOP,"_-0yk"}))sameMethod(original,current,entry[0],entry[1]);
  var v=new VM(current);var helper=v.classes.get(HELPER);for(var t:helper.abc().class_info.get(helper.index()).static_traits.traits)check(!Set.of("_portraitEnabled","enableOrientation","orientationMenuLabel","orientationMenuSelected","responsiveToolbar","fitOrientationViewport").contains(AuditStartup.name(helper.abc(),t.name_index)),"Portrait code retained");
  System.out.println("PASS: Native H menu, toolbar, startup/resize and room-projection methods restored byte-for-byte to original; portrait controls and preference reads removed.");
 }
 static Packet messageWired(int style,boolean extension)throws Exception{
  Packet p=new Packet().i(20);ints(p,List.of(123456));ints(p,List.of());p.i(555).i(987654).s("[red]Mensagem[/red]\n[b]Teste[/b]");ints(p,List.of(1,style,450));strings(p,List.of("ref:1"));ints(p,List.of(100));ints(p,List.of(0));p.i(7).i(3).b(true);groups(p,List.of(List.of(100,110)));groups(p,List.of(List.of(0,900)));ints(p,List.of(100));ints(p,List.of(0));p.b(false);
  p.i(extension?2:0);if(extension)p.i(0).i(777).i(7).i(2).s("nova informação somente de leitura").i(123);ints(p,List.of(0,34,450));return p;
 }
 @SuppressWarnings("unchecked") static void testMessageWired(ChatVM vm,SWF previous)throws Exception{
  var old=new ChatVM(previous);boolean failed=false;try{old.helper("readWired",new Reader(messageWired(210,true).bytes()),"effect");}catch(FixtureError e){check(e.getMessage().contains("Unknown Wired context"),"Wrong previous failure "+e);failed=true;}check(failed,"Previous unknown-context error not reproduced");
  var schema=(Map<String,Obj>)vm.statics.get("_wiredSchema");var notificationOptions=(List<Obj>)((Obj)((List<?>)schema.get("effect:7").get("params")).get(1)).get("options");check(notificationOptions.size()==20,"Missing message styles");
  for(var option:notificationOptions)for(boolean ext:new boolean[]{false,true}){
   int style=num(option.get("value"));var reader=new Reader(messageWired(style,ext).bytes());var info=(Obj)vm.helper("readWired",reader,"effect");check(reader.b.remaining()==0,"Wired packet boundary lost");check(info.get("ints").equals(List.of(1,style,450)),"Message integers lost");check(info.get("text").equals("[red]Mensagem[/red]\n[b]Teste[/b]"),"Message content lost");
   var expected=vm.helper("modernPayload",info);vm.statics.put("_pendingWired",info);var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,"effect"));var editor=new Obj("fixture-editor");var service=new Obj("fixture-service");service.put("localization",null);editor.put("_-2U8",service);editor.put("_-0K0",null);vm.execute(vm.method(VIEW,"_-26m"),editor,data);
   check(vm.statics.get("_wiredPopup")!=null,"Message editor did not open");vm.helper("saveModernWired");check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(expected),"Opening/saving changed core message configuration");
   boolean named=false;for(var binding:(List<Obj>)vm.statics.get("_formBindings"))if(binding.get("kind").equals("options")&&binding.get("target")==info.get("ints")&&num(binding.get("key"))==1){String label=String.valueOf(((Obj)binding.get("control")).get("label"));check(label.equals(option.get("label")+" ▾"),"Style is not named "+style+" "+label);named=true;}check(named,"Style selector absent");
  }
  vm.helper("wiredClosed");System.out.println("PASS: Reproduced prior unknown-context failure; all 20 named message styles open/save through native editor with and without newer read-only metadata; text, variables, selections, sources and width are preserved.");
 }
 @SuppressWarnings("unchecked") static Obj testStyles(ChatVM vm){
  var map=(Obj)vm.construct("_-44B::Map",List.of());vm.helper("extendChatStyles",map);var catalogue=(Obj)vm.statics.get("_chatCatalogue");var list=(List<Obj>)catalogue.get("styles");check(list.size()==89,"Wrong reference catalogue");
  var lib=new Obj(vm.rawType(STYLES));lib.put("_-2Lt",map);
  for(var data:list){int id=num(data.get("id"));var style=(Obj)vm.call(lib,"_-1wl",List.of(id));check(num(vm.get(style,"_-0U8"))==id,"Style fell back to white: "+id);check(vm.get(style,"assetId").equals(data.get("name")),"Style asset mismatch "+id);check(style.get("_-0Pf")!=null&&style.get("_-4Dt")!=null,"Missing image "+id);if(Boolean.TRUE.equals(data.get("incomingOnly")))check(Boolean.TRUE.equals(vm.get(style,"_-1ak")),"Unowned style exposed in picker");}
  var original=vm.call(map,"getValue",List.of(0));int copies=vm.copied.size();vm.helper("extendChatStyles",map);check(vm.call(map,"getValue",List.of(0))==original&&vm.copied.size()==copies,"Styles rebuilt or original overwritten");
  check(vm.call(lib,"_-1wl",List.of(999999))==original,"Unknown-style fallback lost");
  System.out.println("PASS: All 89 reference styles resolve to their exact native style IDs and artwork instead of white; original entries are preserved, bitmap copies cached, ownership-gated styles remain incoming-only, unknown IDs safely fall back.");return lib;
 }
 static Obj item(ChatVM vm,int style,int kind,String text)throws Exception{
  var reader=new Reader(new Packet().i(42).s(text).i(0).i(style).i(0).i(5).bytes());String parser=msg("parser.room.chat:ChatMessageParser");var p=(Obj)vm.construct(vm.rawType(parser),List.of());vm.execute(vm.method(parser,"parse"),p,reader);check(reader.b.remaining()==0,"Chat parser boundary wrong");check(num(vm.get(p,"_-0U8"))==style,"Incoming style lost");
  var session=new Obj("Object");session.put("roomId",12345);var event=(Obj)vm.construct(vm.rawType(SESSIONCHAT),Arrays.asList("RSCE_CHAT_EVENT",session,42,vm.get(p,"text"),kind,vm.get(p,"_-0U8"),new ArrayList<>(),-1));var item=(Obj)vm.construct(vm.rawType(CHATITEM),Arrays.asList(event,1234,null,0,null,null,null,null));check(num(vm.get(item,"style"))==style,"Style lost between session event and ChatItem");return item;
 }
 static Obj bubble(ChatVM vm,Obj style,Obj item){
  var b=new Obj(vm.rawType(BUBBLE));b.put("_-2Ov",style);b.put("_-0rS",item);b.put("_-1iK",new Obj("room-text-renderer"));b.put("_-1D2",null);var chat=new Obj("Object");var manager=new Obj("chat-session-manager");var session=new Obj("Object");var users=new Obj("chat-users");var user=new Obj("Object");user.put("name","Amigo");user.put("figure","figure");users.put("user",user);session.put("_-2gp",users);manager.put("session",session);chat.put("_-4Ej",manager);b.put("_-4Fr",chat);return b;
 }
 @SuppressWarnings("unchecked") static void testRendering(ChatVM vm,Obj library)throws Exception{
  var catalogue=(Obj)vm.statics.get("_chatCatalogue");var definitions=(List<Obj>)catalogue.get("styles");int cases=0;
  for(var def:definitions){int id=num(def.get("id"));var st=(Obj)vm.call(library,"_-1wl",List.of(id));var it=item(vm,id,0,"Olá çã 🎮");var b=bubble(vm,st,it);var factory=new Obj(vm.rawType(FACTORY));factory.put("_-0no",library);factory.put("_-1PE",new ArrayList<>(List.of(b)));factory.put("_-4Fr",b.get("_-4Fr"));int before=vm.userLookups;check(vm.execute(vm.method(FACTORY,"_-4aW"),factory,it)==b,"Native factory discarded bubble "+id);check(b.get("_-2Ov")==st,"Factory selected white fallback "+id);if(Boolean.TRUE.equals(vm.helper("notificationChat",id)))check(before==vm.userLookups,"System message still needs avatar");check(((Obj)b.get("_-1iK")).get("textFormat")!=vm.get(st,"textFormat"),"Shared text format reused "+id);cases++;}
  var style=(Obj)vm.call(library,"_-1wl",List.of(3));var source=(Obj)vm.get(style,"textFormat");var b=bubble(vm,style,item(vm,3,1,"Sussurro"));vm.execute(vm.method(BUBBLE,"_-243"),b);var renderer=(Obj)b.get("_-1iK");var format=(Obj)renderer.get("textFormat");check(num(format.get("color"))==0x777777&&Boolean.TRUE.equals(format.get("italic"))&&format.get("font").equals("UbuntuItalic"),"Whisper is not gray/italic");
  for(int kind:new int[]{2,0,1,0}){b.put("_-0rS",item(vm,3,kind,"Teste"));vm.execute(vm.method(BUBBLE,"_-243"),b);format=(Obj)renderer.get("textFormat");check(Boolean.valueOf(kind==1).equals(format.get("italic"))&&Boolean.valueOf(kind==2).equals(format.get("bold")),"Pooled formatting leaked "+kind);check(num(format.get("color"))==(kind==1?0x777777:num(source.get("color"))),"Pooled color leaked");}check(!Boolean.TRUE.equals(source.get("italic"))&&!Boolean.TRUE.equals(source.get("bold")),"Shared style mutated");
  var notification=(Obj)vm.call(library,"_-1wl",List.of(210));var text="[red]Alerta[/red]\n[B]Negrito[/B] [i]itálico[/i] [u]linha[/u] <img src='x'> & texto";var it=item(vm,210,0,text);var special=bubble(vm,notification,it);((Obj)special.get("_-4Fr")).put("_-4Ej",null);vm.execute(vm.method(BUBBLE,"_-243"),special);var rendered=(Obj)special.get("_-1iK");String html=String.valueOf(rendered.get("text"));check(Boolean.TRUE.equals(rendered.get("isHTML"))&&html.contains("color=\"#FF0000\">Alerta</font>")&&html.contains("face=\"UbuntuBold\">Negrito</font>")&&html.contains("face=\"UbuntuItalic\">itálico</font>")&&html.contains("linha</font></u>")&&html.contains("<br/>"),"Wired formatting failed: "+html);check(html.contains("&lt;img src='x'&gt;")&&html.contains("&amp; texto"),"Arbitrary HTML not escaped");
  String nested=String.valueOf(vm.helper("chatMarkup","[b][i]Ambos[/i]Só negrito[/b]Normal [blue]azul [red]vermelho[/red]azul[/blue]"));check(nested.contains("UbuntuBoldItalic\">Ambos")&&nested.contains("UbuntuBold\">Só negrito")&&nested.contains("Ubuntu\">Normal")&&nested.contains("#0000FF\">azul"),"Nested formatting/font reset lost: "+nested);
  check(vm.layouts>=cases+6,"Native bubble layout was not reached");System.out.println("PASS: 89 incoming packet/session/ChatItem/native bubble paths preserve style IDs; system notifications need no avatar; gray italic whispers, bold shouts and pooled resets work; safe Wired colors/bold/italic/underline/newlines render.");
 }
 @SuppressWarnings("unchecked") static void testOutline(ChatVM vm){testSmallNames(vm);vm.helper("showFriendHighlight",15,123,"Amigo",vm.now);var tags=(Map<Object,Obj>)vm.statics.get("_friendTags");var tag=(Obj)tags.get(15).get("view");var filters=(List<Obj>)tag.get("nativeFilters");check(filters.size()==1,"White outline absent");var args=(List<?>)filters.get(0).get("args");check(num(args.get(0))==0xffffff&&num(args.get(1))==1&&num(args.get(4))==8&&Boolean.FALSE.equals(args.get(7)),"Outline is not white or hides the green text");vm.helper("clearFriendHighlights");System.out.println("PASS: Small bold green friend labels retain transparent background and add a white native text outline.");}
 public static void main(String[]a)throws Exception{
  var current=new SWF(new FileInputStream(a[0]),false);var original=new SWF(new FileInputStream("work/old.swf"),false);var previous=new SWF(new FileInputStream("work/feature17/before.swf"),false);var plus=new SWF(new FileInputStream("work/plus.swf"),false);
  testLandscape(original,current);testNativeNavigator(new SWF(new FileInputStream("work/feature16/before.swf"),false),current);var vm=new ChatVM(current);testMessageWired(vm,previous);var library=testStyles(vm);testRendering(vm,library);testOutline(vm);
  var regression=new ChatVM(current);var oracle=new WiredVM(plus);testNewWire(regression,oracle);testDefinitions(regression,oracle);testNativeWiredEntry(regression);testNativeMovement(regression);testArea(regression);testLiveHeight(regression);testFriends(regression);testRemovedCommands(regression);testHistory(regression,plus);regression.statics.put("_roomCanvas",null);regression.statics.put("_roomEngine",null);testEditors(regression);testContext(regression);
 }
}

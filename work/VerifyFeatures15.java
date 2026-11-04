import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures15 extends VerifyFeatures14 {
 static class ReleaseVM extends NativeVM {
  final List<List<Object>> timeouts=new ArrayList<>();
  ReleaseVM(SWF s){super(s);}
  @Override Object lexical(Method m,Obj self,String n,int i){if(n.equals("NaN"))return Double.NaN;return super.lexical(m,self,n,i);}
  @Override boolean scene(String t){return super.scene(t)||t.equals("starling.text::TextField");}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("flash.events::Event")){var e=new Obj(t);e.put("type",a.get(0));return e;}
   if(t.equals("starling.text::TextField")){var o=display(t);o.put("width",a.get(0));o.put("height",a.get(1));o.put("text",a.get(2));o.put("fontName",a.get(3));o.put("fontSize",a.get(4));o.put("color",a.get(5));o.put("bold",a.get(6));return o;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o){
    if(o==stage&&Set.of("addEventListener","removeEventListener").contains(k))return new Bound(o,String.valueOf(k));
    if(o.type.equals("fixture-history-messenger")&&k.equals("send"))return new Bound(o,"send");
    if(o.type.equals("fixture-toolbar")&&k.equals("_-3Fa"))return new Bound(o,"_-3Fa");
    if(ui(o.type)&&o.type.equals("_-1Ab::_-nO")&&k.equals("data"))return o.get("items");
   }
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object v){
   if(r instanceof Obj o&&o.type.equals("_-1Ab::_-nO")&&k.equals("data")){o.put("items",v);calls.add("history-reset:"+statics.get("_insertingConsoleHistory"));return;}
   super.set(r,k,v);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r==statics&&n.equals("_toolbarRelayout")){var b=(Bound)statics.get(n);return call(b.receiver(),b.name(),a);}
   if(n.equals("getDefinitionByName")&&a.get(0).equals("flash.events::Event"))return new Ref("flash.events::Event");
   if(n.equals("setTimeout")){check(a.get(0) instanceof Bound,"Timeout callback unbound");timeouts.add(new ArrayList<>(a));return timeouts.size();}
   if(r==stage&&Set.of("addEventListener","removeEventListener").contains(n)){if(n.equals("addEventListener"))stage.put("listener:"+a.get(0),a.get(1));else stage.remove("listener:"+a.get(0));return null;}
   if(r instanceof Obj o){
    if(o.type.equals("fixture-history-messenger")&&n.equals("send")){sent.add((Obj)a.get(0));return null;}
    if(o.type.equals("fixture-toolbar")&&n.equals("_-3Fa")){calls.add("relayout");return helper("responsiveToolbar",o,o.get("_-2NJ"),a.get(0),new Bound(o,n));}
    if(o.type.equals("fixture-events")&&n.equals("dispatchEvent")){calls.add("TE_items_updated");return null;}
    if(o==nativeStage&&n.equals("setAspectRatio")){o.put("aspectRatio",a.get(0));return null;}
    if(ui(o.type)&&n.equals("unflatten")){valid(o,n);return null;}
    if(ui(o.type)&&n.equals("validate")&&o.containsKey("fixed-layout")){
     if(o.containsKey("history-provider")){var dp=(Obj)o.get("history-provider");o.put("maxVerticalScrollPosition",Math.max(0,((List<?>)dp.get("items")).size()*24-48));}return null;
    }
   }
   return super.call(r,n,a);
  }
 }
 static void testRemovedCommands(ReleaseVM vm){
  int before=vm.sent.size();for(String text:List.of(":clone Nick",":clonar Nick",":dc",":ping",":PING"))check(Boolean.FALSE.equals(vm.helper("runCommand",text,null)),"Removed command remains: "+text);
  check(before==vm.sent.size(),"Removed commands sent packets");var ctx=context(vm);command(vm,ctx,":comandos");String help=vm.notices.get(vm.notices.size()-1);check(!help.contains(":clone")&&!help.contains(":clonar")&&!help.contains(":dc")&&!help.contains(":ping"),"Removed commands still advertised");
  command(vm,ctx,":typing");check(Boolean.FALSE.equals(vm.statics.get("_typingVisible")),"Typing toggle regressed");command(vm,ctx,":typing");command(vm,ctx,":tradeblock");check(Boolean.TRUE.equals(vm.statics.get("_tradeBlocked")),"Trade toggle regressed");command(vm,ctx,":tradeblock");
  var beforeMethod=vm.method(DESKTOP,"_-QW");check(beforeMethod.body().getCode().code.stream().noneMatch(i->(i.getBytes()[0]&255)==0x46 && AuditStartup.name(beforeMethod.cls().abc(),i.operands[0]).equals("useOnSingleTap")),"DC hook remains in native click handler");
  System.out.println("PASS: clone/clonar, dc and ping removed from command recognition, help and native tap hook; typing/tradeblock retained.");
 }
 @SuppressWarnings("unchecked") static void testNativeWiredEntry(ReleaseVM vm){
  int opened=0;var editor=new Obj("fixture-editor");var service=new Obj("fixture-service");service.put("localization",null);editor.put("_-2U8",service);editor.put("_-0K0",null);
  var schema=(Map<String,Obj>)vm.statics.get("_wiredSchema");
  for(var key:schema.keySet()){
   var p=key.split(":");var data=info(p[0],50000+opened,Integer.parseInt(p[1]));data.put("ints",new ArrayList<>());data.put("text","");vm.statics.put("_pendingWired",data);((Map<Object,Object>)vm.statics.get("_wiredById")).put(data.get("id"),data);
   var nativeData=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,p[0]));
   vm.execute(vm.method("com.sulake.habbo.roomevents.userdefinedroomevents:UserDefinedRoomEventsCtrl","_-26m"),editor,nativeData);
   check(editor.get("_-0K0")==vm.statics.get("_modernControl"),"Native editor lost active control "+key);
   check(editor.get("_-3lo")==null&&editor.get("_-O3")==null,"Opening still constructs hidden legacy window/list "+key);
   check(vm.statics.get("_wiredPopup")!=null,"No visible editor "+key);vm.helper("saveModernWired");opened++;
  }
  for(String key:List.of("trigger:16","effect:7","condition:32","selector:9"))for(int mode=0;mode<3;mode++){
   var p=key.split(":");var info=info(p[0],900000+opened,Integer.parseInt(p[1]));for(String field:List.of("ids","ids2","variables","allowedFurni","allowedUsers","defaultFurniSources","defaultUserSources","defaults"))info.put(field,new ArrayList<>());info.put("ints",new ArrayList<>(mode==0?List.of():List.of(mode==1?0:10)));info.put("text",mode==2?"mensagem çã":"");vm.statics.put("_pendingWired",info);((Map<Object,Object>)vm.statics.get("_wiredById")).put(info.get("id"),info);var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,p[0]));vm.execute(vm.method(VIEW,"_-26m"),editor,data);vm.helper("saveModernWired");opened++;
  }
  vm.helper("wiredClosed");
  check(vm.helper("tr",null,"fallback").equals("fallback"),"Null translation key failed");
  System.out.println("PASS: All "+opened+" empty/new Wired definitions open through the actual patched native entry, save and reopen with no hidden legacy window, stack list, preview or localization-service dependency.");
 }
 static Packet historyEntry(Packet p,int sender,String text,int seconds,String id)throws Exception{return p.i(sender).s("Nome").s("figure").s(text).i(seconds).s(id);}
 @SuppressWarnings("unchecked") static void testHistory(ReleaseVM vm,SWF plus)throws Exception{
  var tables=PatchOldLogin.currentTables(plus);check(tables.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.friendlist:GetMessengerHistoryComposer")==1563,"Request changed");check(tables.get("_events").get("com.sulake.habbo.communication.messages.incoming.friendlist:ConsoleMessageHistoryEvent")==2038,"Response changed");
  var messenger=new Obj("fixture-history-messenger");messenger.put("disposed",false);vm.helper("rememberMessenger",messenger,100);vm.helper("initConsoleHistoryProtocol",2038);
  var conversation=new Obj("fixture-conversation");conversation.put("_-3aV",200);var collection=vm.uiObject("_-1Ab::_-nO");var existing=new Obj("existing-live");collection.put("items",new ArrayList<>(List.of(existing)));conversation.put("messages",collection);
  var list=vm.uiObject("_-2xS::_-0xe");list.put("fixed-layout",true);list.put("history-provider",collection);list.put("dataProvider",collection);list.put("verticalScrollPosition",0);list.put("maxVerticalScrollPosition",0);
  vm.helper("consoleOpened",messenger,conversation,list);var request=vm.sent.get(vm.sent.size()-1);check(payload(vm,request).equals(List.of(200,"")),"First history request wrong");
  var oracle=new WiredVM(plus);var nativeRequest=(Obj)oracle.construct("com.sulake.habbo.communication.messages.outgoing.friendlist::GetMessengerHistoryComposer",List.of(200,""));check(oracle.call(nativeRequest,"getMessageArray",List.of()).equals(payload(vm,request)),"History request differs from AirPlus");
  var packet=new Packet().i(200).i(3);historyEntry(packet,100,"antiga enviada",400,"m1");historyEntry(packet,200,"antiga recebida",300,"m2");historyEntry(packet,200,"já recebida nesta sessão",100,"live3");
  ((Map<Object,Object>)vm.statics.get("_consoleLiveIds")).put("live3",true);((Map<Object,Object>)vm.statics.get("_consoleLivePeers")).put("live3",200);
  var parser=(Obj)oracle.construct("com.sulake.habbo.communication.messages.parser.friendlist::ConsoleMessageHistoryMessageParser",List.of());var oracleReader=new Reader(packet.bytes());oracle.execute(oracle.method(msg("parser.friendlist:ConsoleMessageHistoryMessageParser"),"parse"),parser,oracleReader);check(oracleReader.b.remaining()==0,"Oracle history boundary wrong");
  var input=new Reader(packet.bytes());vm.helper("receiveConsoleHistory",input);check(input.b.remaining()==0,"History packet not consumed");var rows=(List<Obj>)collection.get("items");check(rows.size()==3&&rows.get(2)==existing,"History duplicate or live messages replaced");check(num(rows.get(0).get("_type"))==1&&num(rows.get(1).get("_type"))==2,"History sender sides inverted");check(rows.get(0).get("_-3i2").equals("antiga enviada"),"Message text corrupted");check(!conversation.containsKey("_-0MK"),"History marked unread");check(vm.calls.contains("history-reset:true"),"History reset not protected from auto-scroll");
  int end=num(list.get("maxVerticalScrollPosition"));check(num(list.get("verticalScrollPosition"))==end,"Initial history did not keep newest messages in view");
  vm.now+=4200;list.put("verticalScrollPosition",0);vm.helper("consoleHistoryScrolled",eventFor(list));check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(200,"m1")),"Older-page cursor wrong");
  var older=new Packet().i(200).i(2);historyEntry(older,200,"mais antiga",600,"m0");historyEntry(older,100,"antiga enviada",400,"m1");vm.helper("receiveConsoleHistory",new Reader(older.bytes()));rows=(List<Obj>)collection.get("items");check(rows.size()==4,"Overlapping history page duplicated message");check(num(list.get("verticalScrollPosition"))==24,"Pagination changed visible message instead of preserving scroll");
  vm.now+=4200;list.put("verticalScrollPosition",0);vm.helper("consoleHistoryScrolled",eventFor(list));vm.helper("receiveConsoleHistory",new Reader(new Packet().i(200).i(0).bytes()));int sent=vm.sent.size();vm.now+=5000;vm.helper("consoleHistoryScrolled",eventFor(list));check(vm.sent.size()==sent,"Empty history triggers infinite requests");
  vm.statics.put("_insertingConsoleHistory",true);vm.execute(vm.method("com.sulake.habbo.messenger.view:ConversationSlot","_-2Ga"),new Obj("fixture-slot"),(Object)null);vm.statics.put("_insertingConsoleHistory",false);
  // Reusing the one native conversation list must not scroll a different peer
  // when an older request finishes in the background.
  var other=new Obj("fixture-conversation");other.put("_-3aV",300);var otherCollection=vm.uiObject("_-1Ab::_-nO");otherCollection.put("items",new ArrayList<>());other.put("messages",otherCollection);list.put("dataProvider",otherCollection);list.put("history-provider",otherCollection);vm.helper("consoleOpened",messenger,other,list);list.put("verticalScrollPosition",77);
  var background=new Packet().i(200).i(1);historyEntry(background,200,"carregada ao fundo",900,"mb");vm.helper("receiveConsoleHistory",new Reader(background.bytes()));check(num(list.get("verticalScrollPosition"))==77,"Background history scrolled another peer");
  vm.helper("consoleConversationRemoved",200);var reopened=new Obj("fixture-conversation");reopened.put("_-3aV",200);var newCollection=vm.uiObject("_-1Ab::_-nO");newCollection.put("items",new ArrayList<>());reopened.put("messages",newCollection);list.put("dataProvider",newCollection);list.put("history-provider",newCollection);vm.helper("consoleOpened",messenger,reopened,list);check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(List.of(200,"")),"Reopened conversation did not refresh history");vm.helper("receiveConsoleHistory",new Reader(packet.bytes()));check(((List<?>)newCollection.get("items")).size()==3,"Reopened history lost messages due to stale deduplication");
  System.out.println("PASS: Real AirPlus history schema/request parity, pre-login sent/received messages, live/history ID deduplication, cursor pagination, empty termination, unread-state preservation and stable scroll position.");
 }
 static Obj fixed(ReleaseVM vm,int w,int h){var v=vm.uiObject("_-2xS::LayoutGroup");v.put("fixed-layout",true);v.put("width",w);v.put("height",h);v.put("scaleX",1);v.put("scaleY",1);return v;}
 @SuppressWarnings("unchecked") static void testPortrait(ReleaseVM vm){
  var toolbar=new Obj("fixture-toolbar");var items=new Obj("Object");var view=fixed(vm,1440,120);toolbar.put("view",view);toolbar.put("disposed",false);toolbar.put("_-2NJ",items);var ui=new Obj("fixture-ui");ui.put("events",new Obj("fixture-events"));toolbar.put("habboUI",ui);var order=new ArrayList<>(List.of("ME_MENU","WHATS_NEW","NAVIGATOR","CHAT","CATALOG","INVENTORY","FRIENDS"));
  for(String k:order){var item=new Obj("Object");item.put("view",fixed(vm,k.equals("CHAT")?250:120,k.equals("CHAT")?60:110));items.put(k,item);}
  for(int w:List.of(360,720,1080)){
   vm.stage.put("stageWidth",w);vm.stage.put("stageHeight",w*2);check(Boolean.TRUE.equals(vm.helper("responsiveToolbar",toolbar,items,order,new Bound(toolbar,"_-3Fa"))),"Portrait layout not selected");
   double previous=-1;for(String k:order){var v=(Obj)((Obj)items.get(k)).get("view");double x=((Number)v.get("x")).doubleValue(),scale=((Number)v.get("scaleX")).doubleValue();if(k.equals("CHAT")){eq(((Number)v.get("width")).doubleValue(),w-24,"Chat not full width");continue;}check(x>=0&&x+120*scale<=w+0.01,"Icon outside portrait screen "+w+" "+k);check(x>previous,"Toolbar icons overlap/order wrong");previous=x;}
   check(num(view.get("height"))<w,"Toolbar consumes excessive portrait height");
  }
  vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);check(Boolean.FALSE.equals(vm.helper("responsiveToolbar",toolbar,items,order,new Bound(toolbar,"_-3Fa"))),"Landscape native path not restored");for(var item:items.values()){var v=(Obj)((Obj)item).get("view");eq(((Number)v.get("scaleX")).doubleValue(),1,"Landscape icon scale not restored");}
  vm.helper("enableOrientation",vm.nativeStage);check(Boolean.TRUE.equals(vm.nativeStage.get("autoOrients"))&&vm.nativeStage.get("aspectRatio").equals("any"),"Native stage rotation still locked");
  vm.helper("orientationUiResize",(Object)null);int scheduled=vm.timeouts.size();vm.helper("orientationUiResize",(Object)null);check(vm.timeouts.size()==scheduled,"Rotation relayout not coalesced");vm.helper("layoutAfterRotation");check(vm.calls.contains("relayout"),"Rotation does not rerun layout");
  System.out.println("PASS: Portrait toolbar at 360/720/1080 widths keeps all six icons within screen, chat has its own row, rotation coalesces relayout and landscape sizes restore; native AIR stage allows any orientation.");
 }
 @SuppressWarnings("unchecked") static void testSmallNames(ReleaseVM vm){
  vm.helper("showFriendHighlight",15,123,"Amigo",vm.now);var tags=(Map<Object,Obj>)vm.statics.get("_friendTags");var v=(Obj)tags.get(15).get("view");check(v.type.equals("starling.text::TextField")&&Boolean.TRUE.equals(v.get("bold"))&&num(v.get("color"))==0x67e34f&&num(v.get("fontSize"))==20,"Friend name style wrong");check(!v.containsKey("backgroundSkin")&&!v.containsKey("styleNameList"),"Friend label has a background");vm.helper("clearFriendHighlights");
  System.out.println("PASS: Friend highlight is a smaller green bold text field with no panel or dark background.");
 }
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var p=new SWF(new FileInputStream("work/plus.swf"),false);var vm=new ReleaseVM(s);var oracle=new WiredVM(p);
  testNewWire(vm,oracle);testDefinitions(vm,oracle);testWiredLifecycle(vm);testNativeWiredEntry(vm);testNativeMovement(vm);testArea(vm);testLiveHeight(vm);testFriends(vm);testSmallNames(vm);testRemovedCommands(vm);testHistory(vm,p);testPortrait(vm);
  testInventory(new FixtureVM(new SWF(new FileInputStream("work/old.swf"),false)),vm,new FixtureVM(p));
  vm.statics.put("_roomCanvas",null);vm.statics.put("_roomEngine",null);testEditors(vm);testContext(vm);
 }
}

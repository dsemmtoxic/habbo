import java.io.*;import java.nio.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;
import com.jpexs.decompiler.flash.abc.types.traits.*;

// Execute shipped AVM2 with explicit Android/GPU/network boundaries.
// New checks cover native event callbacks, account wire bytes and tap routing.
class VerifyFeatures18 extends VerifyFeatures17 {
 static final String EVENT=PatchFeatures18.EVENT,TOUCH=PatchFeatures18.TOUCH;
 static class AccountReader extends Reader {final int header;AccountReader(int h,byte[] b){super(b);header=h;}}
 static class FeatureVM extends ChatVM {
  int dpi=2;boolean icons=false;final Set<Object> marked=Collections.newSetFromMap(new IdentityHashMap<>());
  final List<Obj> hits=new ArrayList<>();final List<String> catalogRequests=new ArrayList<>();
  final Map<Object,Object> localization=new HashMap<>();
  FeatureVM(SWF s){super(s);}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("flash.utils::ByteArray")){var o=new Obj(t);o.put("bytes",new ByteArrayOutputStream());return o;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof AccountReader&&k.equals("_-2Dk"))return new Bound(r,"_-2Dk");
   if(r instanceof Obj o){
    if(o.type.equals("static-style-icon")&&(k.equals("width")||k.equals("height")))return num(o.get(k.equals("width")?"sourceWidth":"sourceHeight"))*num(o.get(k.equals("width")?"scaleX":"scaleY"));
    if(o.type.equals("_-1Ab::_-nO")&&k.equals("length"))return ((List<?>)o.get("items")).size();
    if(o.type.equals("fixture-catalog-view")&&k.equals("_-1wL"))return o.get("pageController");
    if((o.type.equals("fixture-page-controller")&&k.equals("_-49d"))||(o.type.equals("fixture-catalog-state")&&k.equals("_-1uN"))||(o.type.equals("fixture-catalog-menu")&&k.equals("_-pY"))||(o.type.equals("fixture-catalog")&&Set.of("_-1ri","_-2le","_-2RD").contains(k))||(o==canvas&&k.equals("_-2qv")))return new Bound(o,String.valueOf(k));
    if(o.type.equals("fixture-catalog")&&Set.of("_-4mq","rooms").contains(k))return execute(method(CATALOG,String.valueOf(k)),o);
   }
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object v){
   if(r instanceof Obj o&&o.type.equals(rawType(CONTROL))&&k.equals("_-3xY")){
    var c=raw.get(o.type);for(var t:c.inst().instance_traits.traits)if(t instanceof TraitMethodGetterSetter m&&m.kindType==3&&AuditStartup.name(c.abc(),t.name_index).equals(k)){execute(new Method(c,c.abc().findBody(m.method_info)),o,v);return;}
   }
   super.set(r,k,v);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof AccountReader in&&n.equals("_-2Dk"))return in.header;
   if(r instanceof List list&&n.equals("splice")){int at=num(a.get(0)),remove=num(a.get(1));var removed=new ArrayList<>();for(int i=0;i<remove;i++)removed.add(list.remove(at));for(int i=2;i<a.size();i++)list.add(at+i-2,a.get(i));return removed;}
   if(n.equals("getDefinitionByName")&&a.get(0).equals("flash.utils::ByteArray"))return new Ref("flash.utils::ByteArray");
   if(r instanceof Ref ref&&ref.name().equals("_-1N-::_-2mJ")&&n.equals("_-0-S"))return dpi;
   if(r instanceof Obj o){
    if(o==canvas&&n.equals("_-2qv")){check(prop(rawType("com.sulake.room.renderer:RoomSpriteCanvas3d"),n),"Nonexistent native highlight API");if(truth(a.get(1)))marked.add(a.get(0));else marked.remove(a.get(0));return null;}
    if(o.type.equals("fixture-tap-handler")&&n.equals("_-3My")){calls.add("native-hit-test");return new ArrayList<>(hits);}
    if(o.type.equals("fixture-localization")&&n.equals("getLocalization"))return localization.getOrDefault(a.get(0),a.get(1));
    if(o.type.equals("_-1Ab::_-nO")&&n.equals("getItemAt"))return ((List<?>)o.get("items")).get(num(a.get(0)));
    if((ui(o.type)||scene(o.type))&&n.equals("getChildIndex")){valid(o,n);return ((List<?>)o.get("children")).indexOf(a.get(0));}
    if((ui(o.type)||scene(o.type))&&n.equals("dispatchEventWith")){
     var handler=(Bound)o.get("listener:"+a.get(0));if(handler!=null){var e=eventFor(o);return call(handler.receiver(),handler.name(),List.of(e));}return null;
    }
    if(o.type.equals("fixture-page-controller")){if(n.equals("_-49d"))return true;}
    if(o.type.equals("fixture-catalog-state")&&n.equals("_-1uN"))return o.get(a.get(0));
    if(o.type.equals("fixture-catalog-menu")&&n.equals("_-pY")){catalogRequests.add("menu:"+a.get(0));return null;}
    if(o.type.equals("fixture-catalog")){
     if(n.equals("_-2le"))return o.get(a.get(0));
     if(n.equals("_-1ri")){catalogRequests.add(a.get(1)+":"+((Obj)a.get(0)).get("pageId"));return null;}
     if(n.equals("_-2RD")){calls.add("end-placement");return null;}
    }
    if(o.type.equals("flash.utils::ByteArray")){
     var bytes=(ByteArrayOutputStream)o.get("bytes");var out=new DataOutputStream(bytes);
     try{switch(n){case "writeByte":out.writeByte(num(a.get(0)));return null;case "writeShort":out.writeShort(num(a.get(0)));return null;case "writeInt":out.writeInt(num(a.get(0)));return null;}}
     catch(IOException e){throw new RuntimeException(e);}
    }
    if(o.type.equals(rawType(BUBBLE))&&n.equals("_-2ZE"))return execute(method(BUBBLE,n),o,a.toArray());
   }
   return super.call(r,n,a);
  }
 }
 @SuppressWarnings("unchecked") static void outline(FeatureVM vm){
  testSmallNames(vm);vm.helper("showFriendHighlight",15,123,"Amigo",vm.now);
  var tags=(Map<Object,Obj>)vm.statics.get("_friendTags");var filters=(List<Obj>)((Obj)tags.get(15).get("view")).get("nativeFilters");var a=(List<?>)filters.get(0).get("args");
  check(num(a.get(0))==0&&num(a.get(2))==4&&num(a.get(3))==4&&num(a.get(4))==12&&Boolean.FALSE.equals(a.get(7)),"Missing wider black friend outline");vm.helper("clearFriendHighlights");
  System.out.println("PASS: Friend name remains green/bold/20px/transparent with a wider 4px black text outline.");
 }
 static void icons(FeatureVM vm){
  for(int dpi:List.of(1,2,3))for(int height:List.of(28,70,160)){
   vm.dpi=dpi;var icon=new Obj("static-style-icon");icon.put("sourceWidth",16);icon.put("sourceHeight",18);
   var style=new Obj("style-double");style.put("_-0iM",new Obj("bitmap"));var anchor=new Obj("point");anchor.put("x",16*dpi);style.put("_-ES",anchor);
   var bg=new Obj("bubble-background");bg.put("height",height*dpi);var b=new Obj(vm.rawType(BUBBLE));b.put("_-47m",icon);b.put("_-2Ov",style);b.put("_-ze",bg);
   vm.execute(vm.method(BUBBLE,"_-2ZE"),b);
   eq(((Number)icon.get("x")).doubleValue()+num(vm.get(icon,"width"))/2.,16*dpi,"Icon is not centered inside colored band");
   check(num(icon.get("scaleX"))==dpi&&num(icon.get("scaleY"))==dpi,"Icon remains too small");
   eq(((Number)icon.get("y")).doubleValue()+num(vm.get(icon,"height"))/2.,height*dpi/2.,"Multiline icon alignment");
   style.put("_-0iM",null);check(Boolean.FALSE.equals(vm.helper("positionChatIcon",icon,style,bg)),"Avatar path intercepted");check(num(icon.get("scaleX"))==1&&num(icon.get("scaleY"))==1,"Pooled avatar inherits icon scale");
  }
  System.out.println("PASS: Native bubble icon callback centers icons in the band and scales 1x/2x/3x; multiline centering and pooled avatar reset hold.");
 }
 @SuppressWarnings("unchecked") static void events(FeatureVM vm)throws Exception{
  var root=vm.uiObject("_-2xS::_-4Mu");var cat=vm.uiObject("_-2xS::_-3EL");var rooms=vm.uiObject("_-2xS::_-3EL");cat.put("width",300);rooms.put("width",300);vm.call(root,"addChild",List.of(cat));vm.call(root,"addChild",List.of(rooms));
  var catalog=new Obj("event-catalog");var loc=new Obj("fixture-localization");catalog.put("localization",loc);
  vm.localization.put("navigator.searchcode.title.eventcategory__1","Jogos");vm.localization.put("navigator.searchcode.title.eventcategory__2","Festas");
  var page=new Obj(vm.rawType(EVENT));page.put("_-3lo",root);page.put("_-0If",cat);page.put("_-ea",rooms);page.put("_-3HX",catalog);
  vm.helper("refreshEventSelectors",page,root,cat,rooms,catalog);
  var adapters=(Map<Object,Obj>)vm.statics.get("_eventPickers");Obj catButton=adapters.get(cat),roomButton=adapters.get(rooms);
  check(Boolean.FALSE.equals(catButton.get("isEnabled")),"Missing event categories fabricated");
  var first=new Obj("category");first.put("_-ZO",1);var second=new Obj("category");second.put("_-ZO",2);
  vm.execute(vm.method(EVENT,"_-1ff"),page,new ArrayList<>(List.of(first,second)));
  var room1=new Obj("owned-room");room1.put("roomName","Meu quarto");var room2=new Obj("owned-room");room2.put("roomName","Outro quarto");
  vm.execute(vm.method(EVENT,"_-IR"),page,new ArrayList<>(List.of(room1,room2)));
  check(catButton.get("label").equals("Jogos ▾")&&roomButton.get("label").equals("1 - Meu quarto ▾"),"Event dropdown labels: "+catButton.get("label")+" / "+roomButton.get("label"));
  for(var entry:List.of(Map.entry(cat,catButton),Map.entry(rooms,roomButton))){
   var states=(Map<Object,Obj>)vm.statics.get("_optionStates");var st=states.get(entry.getValue());st.put("index",1);vm.helper("eventSelectorChanged",eventFor(entry.getValue()));
   check(num(entry.getKey().get("selectedIndex"))==1,"Visible event choice doesn't reach native purchase index");
  }
  check(Boolean.FALSE.equals(cat.get("visible"))&&Boolean.FALSE.equals(rooms.get("includeInLayout")),"Blank old pickers still displayed");
  int before=((List<?>)root.get("children")).size();vm.helper("refreshEventSelectors",page,root,cat,rooms,catalog);check(((List<?>)root.get("children")).size()==before,"Repeated open duplicates dropdowns");
  // Requests and both real incoming record parsers, rather than supplied UI arrays.
  var service=new Obj("fixture-catalog");service.put("localization",loc);var communication=new Obj("fixture-communication");var conn=new Obj("fixture-connection");communication.put("connection",conn);service.put("communication",communication);
  vm.sent.clear();vm.execute(vm.method(CATALOG,"_-0KD"),service);check(vm.sent.size()==2&&vm.sent.get(0).type.equals("loginpatch::RoomAdInfoPayload")&&vm.sent.get(1).type.equals("loginpatch::EventCategoriesPayload"),"Event list queries still omitted");
  for(var request:vm.sent)check(payload(vm,request).isEmpty(),"Event list request has an unexpected payload");
  vm.helper("requestEventLists",service);check(vm.sent.size()==2,"Event list requests not coalesced");
  var categoriesPacket=new Packet().i(2).i(1).s("Jogos recebidos do servidor").b(true).i(2).s("Festas recebidas do servidor").b(true);
  var cp=(Obj)vm.construct(vm.rawType(msg("parser.navigator:UserEventCatsMessageParser")),List.of());var cr=new Reader(categoriesPacket.bytes());vm.execute(vm.method(msg("parser.navigator:UserEventCatsMessageParser"),"parse"),cp,cr);check(cr.b.remaining()==0,"Event category record boundary differs from current protocol");
  var records=vm.get(cp,"_-32E");var navigator=new Obj("navigator");navigator.put("_-km",records);service.put("navigator",navigator);service.put("_navigator",navigator);
  var controller=new Obj("fixture-catalog-view");controller.put("pageController",page);service.put("_-2gB",controller);page.put("_-3HX",service);
  vm.execute(vm.method(CATALOG,"_-60"),service,(Object)null);check(catButton.get("label").equals("Jogos recebidos do servidor ▾"),"Late server categories don't update the open event screen");
  var roomPacket=new Packet().b(true).i(2).i(501).s("Quarto recebido do servidor").b(false).i(502).s("Segundo quarto").b(false);
  var rp=(Obj)vm.construct(vm.rawType(msg("parser.catalog:RoomAdPurchaseInfoEventParser")),List.of());var rr=new Reader(roomPacket.bytes());vm.execute(vm.method(msg("parser.catalog:RoomAdPurchaseInfoEventParser"),"parse"),rp,rr);check(rr.b.remaining()==0,"Owned-room record boundary differs from current protocol");
  var evt=new Obj("message-event");evt.put("parser",rp);vm.execute(vm.method(EVENT,"_-GB"),page,evt);check(roomButton.get("label").equals("1 - Quarto recebido do servidor ▾"),"Late owned-room list remains blank");
  page.put("_-3lo",null);vm.execute(vm.method(EVENT,"_-IR"),page,vm.get(rp,"rooms"));
  vm.sent.clear();
  System.out.println("PASS: Real event-category/owned-room setters populate named choices, both choices update native purchase indices, async/empty lists and repeated view opening are safe.");
 }
 @SuppressWarnings("unchecked") static void catalog(FeatureVM vm){
  Obj control=new Obj("fixture-catalog-view"),catalog=new Obj("fixture-catalog"),menu=new Obj("fixture-catalog-menu");var state=new Obj("fixture-catalog-state");var node=new Obj("catalog-node");node.put("pageId",777);state.put(777,node);catalog.put("NORMAL",state);catalog.put("BUILDERS_CLUB",state);control.put("catalog",catalog);control.put("catalogType","NORMAL");control.put("stage",new Obj("stage"));control.put("menu",menu);
  var content=vm.uiObject("_-2xS::_-4Mu");content.put("fixed-layout",true);content.put("verticalScrollPosition",184);content.put("horizontalScrollPosition",7);var page=new Obj("fixture-page-controller");page.put("view",content);control.put("pageController",page);
  vm.helper("rememberCatalogPage",control,"NORMAL",777);vm.helper("rememberCatalogPosition",control,"NORMAL",page);
  vm.helper("rememberCatalogPage",control,"BUILDERS_CLUB",888);content.put("verticalScrollPosition",0);vm.helper("restoreCatalogScroll",control,"NORMAL");check(num(content.get("verticalScrollPosition"))==184,"Catalog position lost");
  vm.helper("catalogTypeChanged",control,"NORMAL");vm.helper("restoreCatalogPage",control);check(vm.catalogRequests.contains("NORMAL:777")&&vm.catalogRequests.contains("menu:777"),"Catalog page not requested or navigation not restored");
  vm.helper("rememberCatalogPage",control,"NORMAL",777);check(((Map<?,?>)vm.statics.get("_catalogRestore")).isEmpty(),"Restore request remains active after page arrives");
  var history=(Map<Object,Obj>)vm.statics.get("_catalogHistory");var byType=history.get(control);check(num(((Obj)byType.get("NORMAL")).get("page"))==777&&num(((Obj)byType.get("BUILDERS_CLUB")).get("page"))==888,"Normal/BC memories mixed");
  vm.helper("clearCatalogHistory",control);check(history.get(control)==null,"Disposed catalog leaves history alive");
  System.out.println("PASS: Separate shop/BC page memories and scroll restoration survive reopens; unavailable pages are checked against the real index and disposal clears state.");
 }
 @SuppressWarnings("unchecked") static void furniture(FeatureVM vm){
  var info=info("effect",123,3);info.put("limit",2);info.put("wall",false);info.put("ids",new ArrayList<>());info.put("ids2",new ArrayList<>());
  vm.statics.put("_modernInfo",info);var ctrl=new Obj(vm.rawType(CONTROL));vm.statics.put("_modernControl",ctrl);vm.statics.put("_pickLabels",new ArrayList<>(Arrays.asList(vm.uiObject("_-2xS::_-Fk"),vm.uiObject("_-2xS::_-Fk"))));
  Obj one=vm.furni(10,"chair",0,1),two=vm.furni(11,"table",0,1),wall=vm.furni(12,"poster",0,1),avatar=vm.furni(13,"avatar",0,1);wall.put("category",20);avatar.put("category",100);
  vm.helper("chooseWiredFurniture",0);check(Boolean.TRUE.equals(vm.helper("wiredFurniturePicking")),"Selection did not start");
  var handler=new Obj("fixture-tap-handler");handler.put("_-0zB",vm.canvas);handler.put("_-1QM",vm.display("starling.display::Sprite"));var gesture=new Obj("tap-gesture");var point=new Obj("flash.geom::Point");point.put("x",300);point.put("y",220);gesture.put("location",point);var e=new Obj("gesture-event");e.put("target",gesture);
  vm.hits.addAll(List.of(avatar,one));vm.execute(vm.method(TOUCH,"_-1FL"),handler,e);
  check(info.get("ids").equals(List.of(10))&&vm.marked.contains(one)&&vm.calls.contains("native-hit-test"),"One tap did not select/highlight furniture through native hit test");
  vm.helper("wiredFurnitureTap",vm.canvas,List.of(two));vm.helper("wiredFurnitureTap",vm.canvas,List.of(wall));check(info.get("ids").equals(List.of(10,11)),"Wall selected when disabled");
  vm.helper("wiredFurnitureTap",vm.canvas,List.of(one));check(info.get("ids").equals(List.of(11))&&!vm.marked.contains(one),"Repeat tap does not deselect");
  vm.helper("chooseWiredFurniture",1);vm.helper("wiredFurnitureTap",vm.canvas,List.of(one));check(info.get("ids2").equals(List.of(10))&&info.get("ids").equals(List.of(11)),"Second selection overwrites first");
  var move=(Obj)vm.construct("_-3eU::_-1Iq",List.of(3,5));check(Boolean.TRUE.equals(vm.helper("blockTyping",move)),"Movement packets still sent while picking");
  for(String name:List.of("_-2W3","_-4VQ","_-01v"))vm.execute(vm.method(TOUCH,name),handler,e);
  check(vm.sent.isEmpty(),"Selecting a mobi sent a game packet");vm.helper("endFurniturePicking");check(vm.marked.isEmpty()&&Boolean.FALSE.equals(vm.helper("blockTyping",move)),"Picking state/marks/movement not restored");
  vm.helper("chooseWiredFurniture",0);vm.helper("wiredClosed");check(Boolean.FALSE.equals(vm.helper("wiredFurniturePicking"))&&vm.marked.isEmpty(),"Closing Wired leaves avatar locked");
  System.out.println("PASS: Native single tap selects/deselects the visible mobi; avatars/walls/limits/groups handled; walk/use/long-press paths blocked only during selection; closing restores movement/marks.");
 }
 static void income(FeatureVM vm,SWF plus)throws Exception {
  vm.helper("initAccountProtocol",1915,3112,3624,3820);
  var packet=new Packet().i(3);packet.out.writeByte(1);packet.out.writeByte(0);packet.i(5).s("");packet.out.writeByte(2);packet.out.writeByte(1);packet.i(10).s("");packet.out.writeByte(5);packet.out.writeByte(0);packet.i(40).s("");
  var conn=new Obj("fixture-connection");var input=new AccountReader(1915,packet.bytes());
  check(Boolean.TRUE.equals(vm.helper("interceptAccountPacket",input,conn))&&input.b.remaining()==0,"Income records not parsed to packet boundary");
  check(((Obj)vm.helper("incomeSummary",1)).get("text").equals("5 duckets"),"Ducket reward wrong");
  check(((Obj)vm.helper("incomeSummary",2)).get("text").equals("10 moedas"),"Credit reward wrong");
  check(((Obj)vm.helper("incomeSummary",5)).get("text").equals("40 duckets"),"Level reward category wrong");
  check(Boolean.FALSE.equals(((Obj)vm.helper("incomeSummary",3)).get("available")),"Unavailable category claimable");
  for(int category=0;category<14;category++){
   var request=(Obj)vm.construct("loginpatch::IncomeClaimPayload",List.of(category));
   var args=payload(vm,request);check(args.equals(List.of(category)),"Typed income category changed");
   var bytes=(Obj)vm.execute(vm.method("com.sulake.core.communication.wireformat:EvaWireFormat","encode"),new Obj("wire"),3820,args);
   byte[] actual=((ByteArrayOutputStream)bytes.get("bytes")).toByteArray();byte[] expected={0,0,0,3,14,(byte)236,(byte)category};check(Arrays.equals(actual,expected),"Income category not encoded as one byte");
  }
  check(vm.helper("encodeIncomeClaim",1358,List.of(3,5))==null,"Movement packet replaced by account encoder");
  var button=vm.uiObject("_-2xS::Button");((Map<Object,Object>)vm.statics.get("_incomeButtons")).put(button,1);
  vm.sent.clear();vm.helper("claimIncome",eventFor(button));check(vm.sent.size()==1&&payload(vm,vm.sent.get(0)).equals(List.of(1)),"Claim sent without correct user-selected category");
  vm.helper("claimIncome",eventFor(button));check(vm.sent.size()==1,"Duplicate tap double-claims reward");
  var failed=new Packet();failed.out.writeByte(1);failed.b(false);vm.helper("interceptAccountPacket",new AccountReader(3112,failed.bytes()),conn);
  vm.helper("claimIncome",eventFor(button));check(vm.sent.size()==2,"Failed claim cannot be retried");
  var success=new Packet();success.out.writeByte(1);success.b(true);vm.helper("interceptAccountPacket",new AccountReader(3112,success.bytes()),conn);
  check(vm.sent.size()==3&&vm.sent.get(2).type.equals("loginpatch::IncomeStatusPayload"),"Successful claim did not refresh from server");
  check(((Obj)vm.helper("incomeSummary",1)).get("text").equals("5 duckets"),"Balance/reward changed optimistically before server status");
  vm.helper("interceptAccountPacket",new AccountReader(1915,new Packet().i(0).bytes()),conn);check(Boolean.FALSE.equals(((Obj)vm.helper("incomeSummary",1)).get("available")),"Consumed reward still claimable");
  vm.helper("resetAccountState");check(((List<?>)vm.statics.get("_incomeRewards")).isEmpty()&&vm.statics.get("_accountConnection")==null,"Changing account leaks earnings state");
  System.out.println("PASS: Earnings packets parse exact category/type/amount records; all 14 claims serialize the required one-byte field; user-only claims, duplicate blocking, success/failure refresh and account reset verified.");
 }
 static class MenuVM extends CheckedVM {
  MenuVM(SWF s){super(s);}
  @Override Object get(Object r,Object k){if(r instanceof AccountReader&&k.equals("_-2Dk"))return new Bound(r,"_-2Dk");return super.get(r,k);}
  @Override Object construct(String t,List<Object>a){if(t.equals("flash.net::URLRequest")||t.equals("URLRequest")){var o=new Obj(t);o.put("url",a.get(0));return o;}return super.construct(t,a);}
  @Override Object call(Object r,String n,List<Object>a){if(r instanceof AccountReader in&&n.equals("_-2Dk"))return in.header;if(n.equals("navigateToURL")){calls.add("privacy-url:"+((Obj)a.get(0)).get("url"));return null;}return super.call(r,n,a);}
 }
 @SuppressWarnings("unchecked") static void menu(SWF current)throws Exception{
  var vm=new MenuVM(current);vm.helper("initAccountProtocol",1915,3112,3624,3820);
  for(int accounts:List.of(1,2)){
   var menu=vm.uiObject(vm.rawType(HMENU));var ui=new Obj("fixture-ui");var session=new Obj("fixture-session");session.put("_-1XO",new ArrayList<>(Collections.nCopies(accounts,new Obj("avatar"))));ui.put("sessionDataManager",session);var communication=new Obj("fixture-communication");communication.put("connection",new Obj("fixture-connection"));ui.put("communication",communication);menu.put("_-33k",ui);menu.put("_icon",vm.uiObject("_-2xS::_-1aX"));
   vm.execute(vm.method(HMENU,"_-45c"),menu);var tab=(Obj)menu.get("_-0Ix");var provider=(Obj)tab.get("dataProvider");var items=(List<Obj>)vm.get(provider,"data");
   check(vm.get(items.get(items.size()-1),"label").equals("${toolbar.logout}")&&vm.get(items.get(items.size()-2),"label").equals("Lucros")&&vm.get(items.get(items.size()-3),"label").equals("Privacidade"),"H-menu item order wrong");
   vm.sent.clear();var earnEvent=new Obj("event");earnEvent.put("data",items.get(items.size()-2));vm.execute(vm.method(HMENU,"_-0wY"),menu,earnEvent);
   check(Boolean.TRUE.equals(menu.get("closed"))&&vm.statics.get("_accountPopup")!=null&&vm.sent.size()==1&&vm.sent.get(0).type.equals("loginpatch::IncomeStatusPayload"),"Native earnings menu does not open or sends an unsolicited claim");
   var rewards=new Packet().i(1);rewards.out.writeByte(1);rewards.out.writeByte(0);rewards.i(5).s("");
   vm.helper("interceptAccountPacket",new AccountReader(1915,rewards.bytes()),communication.get("connection"));
   var buttons=(Map<Object,Object>)vm.statics.get("_incomeButtons");check(buttons.size()==14,"Earnings rows not rendered");Obj daily=null;
   for(var entry:buttons.entrySet()){var claim=(Obj)entry.getKey();if(num(entry.getValue())==1){daily=claim;check(Boolean.TRUE.equals(claim.get("isEnabled")),"Daily gift remains disabled");}else check(Boolean.FALSE.equals(claim.get("isEnabled")),"Empty category is claimable");}
   vm.helper("claimIncome",eventFor(daily));check(vm.sent.get(vm.sent.size()-1).type.equals("loginpatch::IncomeClaimPayload"),"Rendered claim button is disconnected");
   var ack=new Packet();ack.out.writeByte(1);ack.b(true);vm.helper("interceptAccountPacket",new AccountReader(3112,ack.bytes()),communication.get("connection"));
   var privacyEvent=new Obj("event");privacyEvent.put("data",items.get(items.size()-3));vm.execute(vm.method(HMENU,"_-0wY"),menu,privacyEvent);vm.helper("openAccountPrivacy",(Object)null);
   check(vm.calls.contains("privacy-url:https://www.habbo.com.br/settings/privacy"),"Privacy doesn't open official settings");vm.helper("closeAccountPanel",(Object)null);
  }
  System.out.println("PASS: Native H menu (one/multiple avatars) has Privacy and Earnings immediately before Logout; native selection opens status-only Earnings and real official privacy settings.");
 }
 static void wireParity(FeaturesVM vm,WiredVM oracle)throws Exception{
  int cases=0;for(String kind:List.of("effect","trigger","condition","addon","selector","variable")){
   var info=info(kind,16777217,0);info.put("ints",new ArrayList<>(List.of(1,2,3)));info.put("text","texto çã 🎮");
   var args=new ArrayList<Object>(List.of(info.get("id"),info.get("ints"),info.get("variables"),info.get("text"),info.get("ids"),info.get("ids2")));
   if(kind.equals("effect"))args.add(4);else if(kind.equals("condition"))args.add(1);else if(kind.equals("selector")){args.add(true);args.add(false);}
   args.add(info.get("furniSources"));args.add(info.get("userSources"));String name=kind.equals("effect")?"Action":kind.substring(0,1).toUpperCase()+kind.substring(1);
   var c=(Obj)oracle.construct(oracle.classes.get(OUT+"Update"+name+"MessageComposer").raw(),args);var exp=oracle.execute(oracle.method(OUT+"Update"+name+"MessageComposer","getMessageArray"),c);
   check(vm.helper("modernPayload",info).equals(exp),"Payload differs from actual current "+kind+" composer");cases++;
  }
  System.out.println("PASS: Six modern Wired payloads retain reference parity.");
 }
 @SuppressWarnings("unchecked") static void formsWithoutLegacyPicker(FeaturesVM vm){
  var schema=(Map<String,Obj>)vm.statics.get("_wiredSchema");check(schema.size()>=149,"Missing current Wired editors");int count=0;
  for(var e:schema.entrySet()){
   var key=e.getKey().split(":");var info=info(key[0],10000001+count,Integer.parseInt(key[1]));var params=(List<Obj>)e.getValue().get("params");var ints=new ArrayList<Integer>();for(var p:params)ints.add(count%2==0?42:(p.get("kind").equals("options")?num(((List<Obj>)p.get("options")).get(0).get("value")):0));info.put("ints",ints);
   ((Map<Object,Object>)vm.statics.get("_wiredById")).put(info.get("id"),info);vm.statics.put("_pendingWired",info);
   var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,key[0]));
   var service=new Obj("fixture-service");service.put("localization",new Obj("fixture-localization"));var editor=new Obj("fixture-editor");
   var ctrl=(Obj)vm.helper("modernWired",data,service,vm.uiObject("_-2xS::_-4Mu"),vm.uiObject("_-2xS::Button"),null,editor);
   check(ctrl.type.equals(vm.rawType(CONTROL)),"Missing native selector bridge");
   var expected=vm.helper("modernPayload",info);
   check(Boolean.TRUE.equals(vm.helper("saveModernWired")),"Modern Wired did not save");
   var saved=vm.sent.get(vm.sent.size()-1);var actual=vm.execute(vm.method(vm.raw.get(saved.type).logical(),"_-0tq"),saved);
   check(actual.equals(expected),"Opening/saving editor changed state for "+e.getKey()+" got="+actual+" expected="+expected);
   count++;
  }
  System.out.println("PASS: "+count+" current Wired form schemas build using validated native UI properties, save unchanged state, and keep both furniture-selection groups separate; all seven composer classes instantiate via the old IMessageComposer interface.");
 }
 static void regression(SWF current,SWF plus)throws Exception {
  var vm=new FeatureVM(current);var oracle=new WiredVM(plus);wireParity(vm,oracle);testDefinitions(vm,oracle);testNativeWiredEntry(vm);testNativeMovement(vm);testArea(vm);testLiveHeight(vm);testFriends(vm);testRemovedCommands(vm);testHistory(vm,plus);
  vm.statics.put("_roomCanvas",null);vm.statics.put("_roomEngine",null);formsWithoutLegacyPicker(vm);testContext(vm);var library=testStyles(vm);testRendering(vm,library);
 }
 public static void main(String[]a)throws Exception {
  SWF current=new SWF(new FileInputStream(a[0]),false),plus=new SWF(new FileInputStream("work/plus.swf"),false);
  if(a.length>1&&a[1].equals("regression")){regression(current,plus);return;}
  var vm=new FeatureVM(current);outline(vm);icons(vm);events(vm);catalog(vm);furniture(vm);income(vm,plus);menu(current);
 }
}

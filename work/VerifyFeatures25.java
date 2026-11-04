import java.io.*;import java.nio.file.*;import java.util.*;import java.awt.image.BufferedImage;import javax.imageio.ImageIO;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;

// Saved AVM2 executes the native parser registry, floor geometry and application
// methods. Flash drawing/textures and Android/network remain explicit boundaries.
class VerifyFeatures25 extends VerifyFeatures23 {
 static final String PLAN="com.sulake.habbo.room.object:RoomPlaneParser",EVENT_BASE="com.sulake.core.communication.messages:MessageEvent",ENTRY_EVENT="com.sulake.habbo.communication.messages.incoming.room.layout:RoomEntryTileMessageEvent",OCC_EVENT="com.sulake.habbo.communication.messages.incoming.room.layout:RoomOccupiedTilesMessageEvent";
 static final String PREVIEW="loginpatch:FloorPreview25",CANCEL_P="com.sulake.habbo.communication.messages.parser.marketplace:MarketplaceCancelOfferResultParser",CANCEL_E="com.sulake.habbo.communication.messages.incoming.marketplace:MarketplaceCancelOfferResultEvent";
 static class VM25 extends VM23 {
  final Set<String> nativeTypes=new HashSet<>();final Set<Obj> nativeObjects=Collections.newSetFromMap(new IdentityHashMap<>());
  final Obj registry,connection;final Map<String,Integer> eventHeaders=new HashMap<>();
  int ownRequests=0,viewUpdates=0;boolean strictLegacy=true,legacyCanvasRepro=false;Obj ownView,ownList;
  VM25(SWF s)throws Exception {
   super(s);
   for(String owner:List.of(PLAN,"com.sulake.habbo.room.object:RoomPlaneData",EVENT_BASE,ENTRY_EVENT,OCC_EVENT,PatchOldLogin.MESSAGE_CLASSES,PatchOldLogin.SOCKET,CANCEL_P,CANCEL_E))if(classes.containsKey(owner))nativeTypes.add(rawType(owner));
   nativeTypes.addAll(List.of("_-0Ee::_-c2","_-0AB::Vector3d"));
   var tables=CompareProtocol.read(Files.exists(Path.of("work/HabboTablet_LoginSSO25.swf"))?"work/HabboTablet_LoginSSO25.swf":"work/base24.swf","_-0cq::_-0z0");
   for(var table:tables.entrySet())if(table.getKey().endsWith("::_-0up"))for(var en:table.getValue().entrySet())if(classes.containsKey(en.getValue()))eventHeaders.put(rawType(en.getValue()),en.getKey());
   registry=allocate(rawType(PatchOldLogin.MESSAGE_CLASSES));registry.put("_-1Mf",new HashMap<>(eventHeaders));registry.put("_-17M",new HashMap<>());
   connection=allocate(rawType(PatchOldLogin.SOCKET));connection.put("_disposed",false);connection.put("_-XB",registry);
   ((Obj)ui.get("communication")).put("connection",connection);
  }
  Obj allocate(String t) {
   var o=new Obj(t);nativeObjects.add(o);var c=raw.get(t);
   while(c!=null){for(var tr:c.inst().instance_traits.traits)if(tr instanceof TraitSlotConst sl){String name=AuditStartup.name(c.abc(),sl.name_index);String ty=sl.type_index==0?"*":Objects.toString(AuditStartup.name(c.abc(),sl.type_index),"*");Object v=switch(sl.value_kind){case 3->c.abc().constants.getInt(sl.value_index);case 4->c.abc().constants.getUInt(sl.value_index);case 6->c.abc().constants.getDouble(sl.value_index);case 1->c.abc().constants.getString(sl.value_index);case 10->false;case 11->true;default->Set.of("int","uint").contains(ty)?0:ty.equals("Number")?Double.NaN:ty.equals("Boolean")?false:null;};o.putIfAbsent(name,v);}c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}
   return o;
  }
  Method inherited(String t,String n,int kind){var c=raw.get(t);while(c!=null){for(var tr:c.inst().instance_traits.traits)if(tr instanceof TraitMethodGetterSetter mt&&tr.kindType==kind&&AuditStartup.name(c.abc(),tr.name_index).equals(n))return new Method(c,c.abc().findBody(mt.method_info));c=raw.get(AuditStartup.q(c.abc(),c.inst().super_index));}return null;}
  @Override boolean own(String t){return super.own(t)||Set.of("loginpatch::FloorPreview25","loginpatch::RoomGeometry33","loginpatch::AuthSession34","loginpatch::AuthWebScript34").contains(t);}
  @Override Object construct(String t,List<Object>a){
   if(legacyCanvasRepro&&t.equals(rawType(PLAN)))return super.construct(t,a);
   if(nativeTypes!=null&&nativeTypes.contains(t)){var o=allocate(t);execute(method(raw.get(t).logical(),"<init>"),o,a.toArray());return o;}
   return super.construct(t,a);
  }
  @Override void constructSuper(Method m,Obj self,List<Object>a){
   if(nativeObjects!=null&&nativeObjects.contains(self)){var parent=raw.get(AuditStartup.q(m.cls().abc(),m.cls().inst().super_index));if(parent!=null&&!parent.logical().equals("::Object"))execute(method(parent.logical(),"<init>"),self,a.toArray());return;}
   super.constructSuper(m,self,a);
  }
  @Override Object lexical(Method m,Obj self,String n,int index){
   if(Set.of("Number","int","uint","Boolean","isFinite").contains(n))return new Ref(n);
   if(m.cls().logical().equals(PatchOldLogin.CATALOG)&&n.equals("send"))return new Bound(self,n);
   if(nativeObjects!=null&&nativeObjects.contains(self)) {
    if(self.containsKey(n))return self.get(n);
    var f=inherited(self.type,n,2);if(f!=null)return execute(f,self);
    if(inherited(self.type,n,1)!=null)return new Bound(self,n);
    var c=m.cls();for(var tr:c.abc().class_info.get(c.index()).static_traits.traits)if(AuditStartup.name(c.abc(),tr.name_index).equals(n))return get(staticObject(c.raw()),n);
   }
   return super.lexical(m,self,n,index);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&o.type.equals("native-market-map")&&k.equals("length"))return ((Map<?,?>)o.get("items")).size();
   if(r instanceof Obj o&&nativeObjects!=null&&nativeObjects.contains(o)){var m=inherited(o.type,String.valueOf(k),2);if(m!=null)return execute(m,o);if(o.containsKey(k))return o.get(k);if(inherited(o.type,String.valueOf(k),1)!=null)return new Bound(o,String.valueOf(k));}
   return super.get(r,k);
  }
  @Override void set(Object r,Object k,Object value){
   if(r instanceof List list&&k.equals("length")){int length=num(value);while(list.size()>length)list.remove(list.size()-1);while(list.size()<length)list.add(null);return;}
   if(r instanceof Obj o&&o.type.equals(rawType("com.sulake.room.renderer:RoomSpriteCanvas"))&&k.equals("roomEngine"))throw new FixtureError("1056: native Flash RoomSpriteCanvas has no roomEngine property");
   if(r instanceof Obj o&&nativeObjects!=null&&nativeObjects.contains(o)){var m=inherited(o.type,String.valueOf(k),3);if(m!=null){execute(m,o,value);return;}}
   super.set(r,k,value);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(n.equals("Number"))return a.get(0)==null?Double.NaN:number(a.get(0));
   if(n.equals("vector")&&a.size()==1&&(a.get(0)==null||a.get(0) instanceof List))return a.get(0);
   if(r instanceof List list&&n.equals("unshift")){list.addAll(0,a);return list.size();}
   if(r==ownView&&n.equals("_-027")){ownList=uiObject("_-2xS::_-0xe");ownList.put("listener:takeBackRequested",new Bound(ownView,"_-3WO"));return ownList;}
   if(r==ownList&&n.equals("dispatchEventWith")){var ev=new Obj("native-market-event-boundary");ev.put("type",a.get(0));ev.put("data",a.get(2));return execute(method(PatchFeatures25.MARKET_VIEW25,"_-3WO"),ownView,ev);}
   if(n.equals("int"))return num(a.get(0));if(n.equals("uint"))return Integer.toUnsignedLong(num(a.get(0)));if(n.equals("Boolean"))return truth(a.get(0));if(n.equals("isFinite"))return Double.isFinite(number(a.get(0)));
   if(r instanceof Ref ref&&ref.name().equals("Math")){if(n.equals("atan2"))return Math.atan2(number(a.get(0)),number(a.get(1)));if(n.equals("acos"))return Math.acos(number(a.get(0)));if(n.equals("asin"))return Math.asin(number(a.get(0)));if(n.equals("atan"))return Math.atan(number(a.get(0)));}
   if(r instanceof Ref ref&&nativeTypes!=null&&nativeTypes.contains(ref.name()))return execute(method(raw.get(ref.name()).logical(),n),staticObject(ref.name()),a.toArray());
   if(nativeObjects!=null&&nativeObjects.contains(r)){var o=(Obj)r;if(o==connection&&n.equals("send")){sent.add((Obj)a.get(0));return true;}var m=inherited(o.type,n,1);if(m!=null)return execute(m,o,a.toArray());}
   if(r instanceof Obj o&&o.type.equals("floor-gpu-canvas"))throw new AssertionError("New preview unexpectedly uses a mock GPU room canvas");
   if(r==e&&n.equals("_-7N")&&strictLegacy){var c=new Obj(rawType("com.sulake.room.renderer:RoomSpriteCanvas"));rooms.get(num(a.get(0))).put("canvas",c);return new Obj("flash.display::Sprite");}
   if(r instanceof Obj o&&o.type.equals(rawType("com.sulake.habbo.room.object.image:SortableImage"))&&n.equals("_-3uV"))return execute(method("com.sulake.habbo.room.object.image:SortableImage",n),o,a.toArray());
   if(r instanceof Obj o&&o.type.equals("own-market-view")&&n.equals("_-4If")){viewUpdates++;return null;}
   if(r instanceof Obj o&&o.type.equals("market-catalog")){if(n.equals("_-21Y")){ownRequests++;return null;}if(n.equals("_-00q"))return true;if(n.equals("_-0pf"))return execute(method(PatchOldLogin.CATALOG,n),o,a.toArray());if(n.equals("send")){sent.add((Obj)a.get(0));return null;}}
   if(r instanceof Obj o&&o.type.equals("native-market-map")){var map=(Map<Object,Object>)o.get("items");if(n.equals("remove"))return map.remove(a.get(0));if(n.equals("getValue"))return map.get(a.get(0));}
   if(r instanceof Obj o&&o.type.equals(rawType(PatchFeatures25.MARKET25))){if(n.equals("_-2Zv"))return execute(method(PatchFeatures25.MARKET25,n),o,a.toArray());}
   if(r instanceof Obj o&&o.type.equals("market-offer")&&n.equals("dispose")){o.put("disposed",true);return null;}
   return super.call(r,n,a);
  }
  Object incoming(String event,byte[] bytes){int id=eventHeaders.get(rawType(event));return execute(method(PatchOldLogin.SOCKET,"_-0lj"),connection,new AccountReader(id,bytes));}
 }
 static long pixels(Obj bitmap){var im=(BufferedImage)bitmap.get("image");long count=0;for(int y=0;y<im.getHeight();y++)for(int x=0;x<im.getWidth();x++)if((im.getRGB(x,y)&0xffffff)!=0)count++;return count;}
 static void open25(VM25 v)throws Exception {parser(v,PatchFeatures22.FLOOR_MAP22,new Packet().b(false).i(-1).s("xxxxxxx\rx00000x\rx00000x\rx00000x\rxxxxxxx\r").bytes());v.editor("open",v.ui);}
 static void floorReproduction(SWF old)throws Exception {
  var v=new VM25(old);v.legacyCanvasRepro=true;open25(v);
  check(v.incoming(ENTRY_EVENT,new Packet().i(1).i(1).i(2).bytes())==null&&v.incoming(OCC_EVENT,new Packet().i(0).bytes())==null,"Expected absent floor listeners in baseline");
  check(!truth(v.state().get("_entryReady"))&&!truth(v.state().get("_occupiedReady"))&&!truth(v.editor("save")),"Baseline wait/save failure not reproduced");
  boolean caught=false;try{v.editor("buildPreview");}catch(FixtureError e){check(e.getMessage().startsWith("1056:"),"Different preview error "+e);caught=true;}check(caught,"Baseline native 2D-canvas #1056 not reproduced");
  System.out.println("PASS: Teste24 reproduces missing native floor event subscriptions (packets ignored, Save blocked) and the reported #1056 by checking the real sealed 2D-canvas contract.");
 }
 static void floorFlow(SWF s)throws Exception {
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080})) {
   var v=new VM25(s);v.stage.put("stageWidth",size[0]);v.stage.put("stageHeight",size[1]);open25(v);
   check(((Map<?,?>)v.registry.get("_-17M")).size()==2,"Floor did not register exactly two event consumers");
   check(!truth(v.editor("save")),"Saved before room entry and occupied data");
   var a=v.incoming(ENTRY_EVENT,new Packet().i(1).i(1).i(2).bytes());var b=v.incoming(OCC_EVENT,new Packet().i(1).i(2).i(2).bytes());
   check(a instanceof List&&b instanceof List&&truth(v.state().get("_entryReady"))&&truth(v.state().get("_occupiedReady")),"Real socket/registry/parser chain did not make floor ready");
   v.now+=500;v.editor("frame",(Object)null);
   check(pixels((Obj)v.state().get("_editData"))>30000&&pixels((Obj)v.state().get("_previewData"))>5000,"Floor map or native-plane preview is black");
   var editPanel=(Obj)v.state().get("_editPanel");var editChildren=(List<?>)editPanel.get("children");check(editChildren.get(1)==v.state().get("_editImage")&&editChildren.get(2)==v.state().get("_editHit")&&number(((Obj)v.state().get("_editHit")).get("alpha"))<0.01,"Hit area obscures map");
   var model=(Obj)v.state().get("_model");check(truth(m(v,model,"blocked",2,2)),"Occupied floor protection lost");
   v.state().put("_level",5);v.editor("mapTouched",ev(tile(v,"began",4,3)));v.editor("mapTouched",ev(tile(v,"ended",4,3)));check(num(m(v,model,"getHeight",4,3))==5,"Native touch did not edit floor");
   click(v,"wallThinner");click(v,"floorThinner");v.now+=500;v.editor("frame",(Object)null);check(pixels((Obj)v.state().get("_previewData"))>5000,"Preview disappeared after thickness/height changes");
   check(num(v.e.get("_-0Y"))==12345&&v.rooms.isEmpty(),"Preview created or replaced a real engine room");
   int sent=v.sent.size();check(truth(v.editor("save"))&&v.sent.size()==sent+1,"Ready owner with BC cannot save");check(payload(v,v.sent.get(v.sent.size()-1)).equals(m(v,model,"payload")),"Floor save differs from native fields");
   check(!truth(v.editor("save"))&&v.sent.size()==sent+1,"Duplicate save");
   if(size[0]==1536){ImageIO.write((BufferedImage)((Obj)v.state().get("_editData")).get("image"),"png",Path.of("work/feature25/map.png").toFile());ImageIO.write((BufferedImage)((Obj)v.state().get("_previewData")).get("image"),"png",Path.of("work/feature25/preview.png").toFile());}
   v.editor("close");check(((Map<?,?>)v.registry.get("_-17M")).isEmpty()&&v.state().get("_root")==null,"Closing leaks floor event consumers");
  }
  System.out.println("PASS: Native SocketConnection/MessageClassManager dispatch now supplies entry and occupied data; both panels render nonblack at three landscape sizes, touch/height/thickness update the draft, exact native save works once, and close removes consumers without changing the live room.");
 }
 static void visibility25(SWF s)throws Exception {
  var v=new VM25(s);v.helper("initClient23",2500);v.helper("bindRoom23",v.e,12345);var object=visualObject();v.flagObjects.add(object);var model=(Obj)object.get("model");var vis=new Obj(v.rawType(PatchFeatures23.FV23));vis.put("_-3Cd",object);vis.put("_-12p",num(model.get("id")));vis.put("_-1NX",1);vis.put("_-lj",false);vis.put("_-0VG",false);vis.put("_-113",false);
  var sprite=new Obj("visual-sprite");sprite.put("tag","invisible");var image=new Obj(v.rawType("com.sulake.habbo.room.object.image:SortableImage"));image.put("alpha",1.0);sprite.put("image",image);
  for(boolean hide:List.of(true,false,true,false,true)) {
   v.helper("interceptWired",new AccountReader(2500,new Packet().b(false).b(false).b(false).b(hide).bytes()),v.connection);
   // Even with a consumed/cached model update id the changed flag forces native refresh.
   vis.put("_-12p",num(model.get("id")));check(truth(v.execute(v.method(PatchFeatures23.FV23,"updateModel"),vis,64)),"Visibility lost to cached model id");
   v.helper("spriteAlpha23",192,object,sprite);check(Math.abs(number(image.get("alpha"))-(hide?0:192.0/256))<0.00001,"Cached GPU image did not hide/restore immediately");
   vis.put("_-0VG",false);check(!truth(v.execute(v.method(PatchFeatures23.FV23,"updateModel"),vis,64)),"Unchanged visibility forces every sprite to redraw");
  }
  System.out.println("PASS: Repeated hide/show/hide updates use the saved native SortableImage alpha setter immediately, and visibility changes invalidate the native cached model id while unchanged frames retain the original fast path.");
 }
 static void market25(SWF s)throws Exception {
  var v=new VM25(s);var logic=v.allocate(v.rawType(PatchFeatures25.MARKET25));var cat=new Obj("market-catalog");cat.put("localization",new Obj("market-localization"));logic.put("_-3HX",cat);logic.put("_disposed",false);var view=new Obj("own-market-view");logic.put("_-2rI",view);var map=new Obj("native-market-map");var items=new LinkedHashMap<Object,Object>();var offer=new Obj("market-offer");items.put(123456,offer);map.put("items",items);map.put("length",1);logic.put("_-3lm",map);logic.put("_-158",1);
  v.ownView=v.allocate(v.rawType(PatchFeatures25.MARKET_VIEW25));v.ownView.put("_-44h",logic);v.execute(v.method(PatchFeatures25.MARKET_VIEW25,"_-3cm"),v.ownView);check(truth(v.ownList.get("isEnabled")),"Own-return list inherits the purchase/trade lock");
  var row=new Obj(v.rawType(PatchFeatures25.MARKET_ROW25));row.put("_-ZD",v.ownList);row.put("_-0SL",v.construct(v.rawType("com.sulake.habbo.tablet.catalog.marketplace:MarketPlaceOfferData"),Arrays.asList(123456,18800,1,"",null,10,3,7,1)));v.execute(v.method(PatchFeatures25.MARKET_ROW25,"_-3Ui"),row,eventFor(row));check(payload(v,v.sent.get(v.sent.size()-1)).equals(List.of(123456)),"Native return button/list/controller/catalog chain sends the wrong offer id");v.ownRequests=0;
  var e=(Obj)v.construct(v.rawType(CANCEL_E),List.of(new Bound(v.statics,"unused")));var parsed=(Obj)v.construct(v.rawType(CANCEL_P),List.of());v.execute(v.method(CANCEL_P,"parse"),parsed,new Reader(new Packet().i(123456).b(true).bytes()));v.set(e,"parser",parsed);
  v.execute(v.method(PatchFeatures25.MARKET25,"_-3vm"),logic,e);check(items.isEmpty()&&truth(offer.get("disposed"))&&v.viewUpdates==1&&v.ownRequests==1&&num(logic.get("_-158"))==0,"Successful return did not remove/count/resync own offer");
  var button=v.uiObject("_-2xS::Button");var data=new Obj("row-data");data.put("status",2);v.helper("marketReturnRow25",data,button);check(!truth(button.get("visible")),"Sold row exposes return");data.put("status",3);v.helper("marketReturnRow25",data,button);check(truth(button.get("visible"))&&truth(button.get("isEnabled")),"Expired pooled row remains disabled/hidden");
  System.out.println("PASS: Native return button -> own-list event -> controller -> catalog -> composer sends the exact offer id; own returns stay enabled, successful server acknowledgement removes/counts/resyncs the offer, and pooled sold-to-expired rows restore their return button.");
 }
 static void kept(SWF s)throws Exception {
  var plus=new SWF(new FileInputStream("work/plus.swf"),false);var v=new VM25(s);
  models(v);login20(v);palette20(v);wired20(v);cleanup21(v);placement21(v);purse21(v);swatches21(v);languages21(v);verifyHeads(v);verifyEarnings(v);verifyMenu(s);outline(v);events(v);catalog(v);income(v,plus);creation(v,plus);blocks(s);news(v);cacheTests(v);regression23(s,plus);
 }
 public static void main(String[]a)throws Exception {
  var s=new SWF(new FileInputStream(a[0]),false);floorReproduction(new SWF(new FileInputStream("work/base24.swf"),false));floorFlow(s);visibility25(s);market25(s);kept(s);
  System.out.println("PASS: Teste25 verification complete (saved native AVM2; Flash drawing, GPU upload, Android and network boundaries).");
 }
}

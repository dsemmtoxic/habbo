import java.io.*;import java.util.*;import com.jpexs.decompiler.flash.SWF;
class VerifyFeatures14 extends VerifyFeatures13 {
 static final String ENGINE="com.sulake.habbo.room:RoomEngine",MOVING="com.sulake.habbo.room.object.logic:MovingObjectLogic",DESKTOP="com.sulake.habbo.ui:RoomDesktop";
 static class NativeVM extends EditorVM {
  final Map<Integer,Obj> movers=new LinkedHashMap<>(),avatars=new LinkedHashMap<>();
  final Obj desktop=new Obj("desktop-double"),session=new Obj("room-session-double"),users=new Obj("room-users-double"),preferences=new Obj("preferences-double"),authPrefs34=new Obj("auth-preferences-boundary34");
  final List<Obj> roomUsers=new ArrayList<>();int nativeViews=0,used=0;Object selectedMove;
  NativeVM(SWF s){super(s);desktop.put("roomEngine",engine);desktop.put("_-22-",session);canvas.put("desktop",desktop);session.put("disposed",false);session.put("_-4kZ",99);session.put("_-2gp",users);preferences.put("data",new Obj("Object"));authPrefs34.put("data",new Obj("Object"));}
  Obj vector(double x,double y,double z){return (Obj)construct("_-0AB::Vector3d",List.of(x,y,z));}
  double coord(Obj o,String key){return ((Number)o.get(key)).doubleValue();}
  Obj mover(int id){return movers.computeIfAbsent(id,k->{var m=new Obj(rawType(MOVING));m.put("_-3Cd",furniture.get(id));m.put("_-0sG",vector(3,5,2.37));m.put("_-4Oy",vector(0,0,0));m.put("_-0pS",vector(0,0,0));m.put("_-4U7",0);m.put("_-1tf",0);m.put("_-4j6",0);m.put("_-2Fr",500);return m;});}
  @Override Object invokeSuper(Method m,Obj self,String n,List<Object>a){
   if(m.cls().logical().equals(MOVING)&&n.equals("processUpdateMessage")){var parent=raw.get(AuditStartup.q(m.cls().abc(),m.cls().inst().super_index));return execute(method(parent.logical(),n),self,a.toArray());}
   return super.invokeSuper(m,self,n,a);
  }
  @Override Object lexical(Method m,Obj self,String n,int i){if(n.equals("String"))return new Ref("String");return super.lexical(m,self,n,i);}
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref&&ref.name().equals("flash.net::SharedObject"))return new Bound(r,String.valueOf(k));
   if(r instanceof Obj o){
    if(o.type.equals(rawType(CONTROL))&&k.equals("view"))return execute(method(CONTROL,"view"),o);
    if(o.type.equals("fixture-editor")&&Set.of("_-1yl","_-0lb").contains(k))return new Bound(o,String.valueOf(k));
    if(o.type.equals("_-0AB::Vector3d")&&k.equals("length"))return Math.sqrt(coord(o,"x")*coord(o,"x")+coord(o,"y")*coord(o,"y")+coord(o,"z")*coord(o,"z"));
    if(o==users&&k.equals("_-1Z1"))return new Bound(o,"_-1Z1");
    if(o==desktop){check(prop(rawType(DESKTOP),String.valueOf(k)),"Bad native desktop property "+k);return o.containsKey(k)?o.get(k):new Bound(o,String.valueOf(k));}
    if(o.type.equals("furni-double")&&k.equals("_-3YM"))return new Bound(o,"_-3YM");
    if(ui(o.type)&&k.equals("numChildren"))return ((List<?>)o.get("children")).size();
   }
   return super.get(r,k);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Ref math&&math.name().equals("Math")&&(n.equals("min")||n.equals("max")))return n.equals("min")?a.stream().mapToDouble(x->((Number)x).doubleValue()).min().orElse(Double.POSITIVE_INFINITY):a.stream().mapToDouble(x->((Number)x).doubleValue()).max().orElse(Double.NEGATIVE_INFINITY);
   if(n.equals("getDefinitionByName")&&a.get(0).equals("flash.net::SharedObject"))return new Ref("flash.net::SharedObject");
   if(r instanceof Ref ref&&ref.name().equals("flash.net::SharedObject")&&n.equals("getLocal")){if(a.get(0).equals("habbo_air_login34"))return authPrefs34;check(a.get(0).equals("habbo_classic_commands"),"Unexpected preference name");return preferences;}
   if(r instanceof Obj o){
    if(o==engine){
     if(n.equals("_-0ex")){updates.add(new ArrayList<>(a));return execute(method(ENGINE,n),engine,a.toArray());}
     if(n.equals("_-2-Z"))return furniture.get(num(a.get(1)));
     if(n.equals("getSelectedObjectData"))return selectedMove;
     if(n.equals("_-46h")&&num(a.get(2))==100)return avatars.get(num(a.get(1)));
    }
    if(o.type.equals("furni-double")){
     if(n.equals("getEventHandler"))return mover(num(o.get("id")));
     if(n.equals("setLocation")||n.equals("setDirection")){if(a.get(0)!=null){var v=(Obj)a.get(0);o.put(n.equals("setLocation")?"location":"direction",vector(coord(v,"x"),coord(v,"y"),coord(v,"z")));}return null;}
     if(n.equals("_-3YM"))return o.getOrDefault("category",10);
    }
    if(o.type.equals("_-0AB::Vector3d")){
     if(n.equals("_-4Dq")){var v=(Obj)a.get(0);for(String k:List.of("x","y","z"))o.put(k,get(v,k));return null;}
     if(n.equals("add")||n.equals("sub")){var v=(Obj)a.get(0);for(String k:List.of("x","y","z"))o.put(k,coord(o,k)+(n.equals("add")?1:-1)*coord(v,k));return null;}
     if(n.equals("mul")){for(String k:List.of("x","y","z"))o.put(k,coord(o,k)*((Number)a.get(0)).doubleValue());return null;}
    }
    if(o.type.equals("fixture-editor")&&n.equals("_-1yl")){nativeViews++;return "Wired de teste";}
    if(o.type.equals("fixture-editor")&&n.equals("_-0lb"))return "Configuração do Wired";
    if(o==desktop&&n.equals("useObject")){used++;return null;}
    if(o==users&&n.equals("_-1Z1")){check(prop(rawType("com.sulake.habbo.session:UserDataManager"),n),"Bad user list API");return roomUsers;}
    if((o==preferences||o==authPrefs34)&&n.equals("flush")){calls.add("preferences-saved");return "flushed";}
    if((ui(o.type)||scene(o.type))&&n.equals("dispatchEventWith")){var listener=o.get("listener:"+a.get(0));if(listener instanceof Bound b)return call(b.receiver(),b.name(),List.of(new Obj("event-double")));return null;}
    if((ui(o.type)||scene(o.type))&&Set.of("validate","dispose","removeEventListener","getChildAt").contains(n)){
     valid(o,n);
     if(n.equals("getChildAt"))return ((List<?>)o.get("children")).get(num(a.get(0)));
     if(n.equals("removeEventListener")){o.remove("listener:"+a.get(0));return null;}
     if(n.equals("dispose")){o.put("disposed",true);return null;}
     if(o.type.equals("_-2xS::_-Fk")){o.put("width",Math.min(320,String.valueOf(o.get("text")).length()*12));o.put("height",24);}
     else {double width=0,height=0;for(var c:(List<?>)o.get("children")){var child=(Obj)c;call(child,"validate",List.of());width=Math.max(width,((Number)child.getOrDefault("width",0)).doubleValue());height+=((Number)child.getOrDefault("height",0)).doubleValue();}o.put("width",width+12);o.put("height",height+12);}
     return null;
    }
   }
   return super.call(r,n,a);
  }
  Obj avatar(int index,int account,String name,int type){var u=new Obj("Object");u.put("_-Oi",index);u.put("_-1GP",account);u.put("name",name);u.put("type",type);roomUsers.add(u);var obj=new Obj("furni-double");obj.put("location",vector(2,3,1.0));avatars.put(index,obj);return u;}
 }
 static Obj eventFor(Obj target){var e=new Obj("event-double");e.put("currentTarget",target);return e;}
 @SuppressWarnings("unchecked") static void choose(NativeVM vm,Obj owner,int index){
  vm.helper("openOptions",eventFor(owner));var choices=(Map<Object,Obj>)vm.statics.get("_optionChoices");Obj button=null;
  for(var e:choices.entrySet())if(num(e.getValue().get("index"))==index)button=(Obj)e.getKey();
  check(button!=null,"Missing option button "+index);vm.helper("chooseOption",eventFor(button));
 }
 @SuppressWarnings("unchecked") static void testWiredLifecycle(NativeVM vm){
  Obj previous=null;int count=0;
  for(String key:List.of("trigger:16","effect:7","condition:32","selector:9"))for(int pass=0;pass<3;pass++){
   var parts=key.split(":");var info=info(parts[0],98765+count,Integer.parseInt(parts[1]));info.put("ints",new ArrayList<>(key.equals("effect:7")?List.of(0,0):List.of(pass==1?42:0)));if(pass==2)info.put("ints",new ArrayList<>());info.put("text",pass==1?"Recebido\nsem alterações":"");
   vm.statics.put("_pendingWired",info);((Map<Object,Object>)vm.statics.get("_wiredById")).put(info.get("id"),info);
   var data=(Obj)vm.construct(vm.rawType(WIRED+"WiredData"),Arrays.asList(null,parts[0]));var service=new Obj("fixture-service");service.put("localization",new Obj("fixture-localization"));
   var ctrl=(Obj)vm.helper("modernWired",data,service,vm.uiObject("_-2xS::_-4Mu"),vm.uiObject("_-2xS::Button"),previous,new Obj("fixture-editor"));
   check(ctrl.get("_-3lo")==vm.statics.get("_modernContent"),"Native view ownership lost");check(ctrl.get("_image")==null,"Legacy thumbnail preview path still used");
   var expected=vm.helper("modernPayload",info);vm.helper("saveModernWired");check(payload(vm,vm.sent.get(vm.sent.size()-1)).equals(expected),"Opening or saving changed existing values "+key);
   if(!key.equals("effect:7")&&pass!=1){var picker=(Obj)vm.statics.get("_actionPicker");choose(vm,picker,9);var extra=(Obj)vm.statics.get("_actionExtra");choose(vm,extra,18);vm.helper("saveModernWired");check(info.get("text").equals("17"),"Sign filter broken");choose(vm,picker,10);choose(vm,extra,2);vm.helper("saveModernWired");check(info.get("text").equals("dance 2"),"Dance filter broken");choose(vm,picker,1);vm.helper("saveModernWired");check(info.get("text").equals(""),"Incompatible extra not cleared");}
   if(key.equals("effect:7")){for(var binding:(List<Obj>)vm.statics.get("_formBindings"))if(binding.get("kind").equals("options")&&binding.get("target")==info.get("ints")){choose(vm,(Obj)binding.get("control"),1);break;}vm.helper("saveModernWired");check(num(((List<?>)info.get("ints")).get(0))==1,"Message visibility did not save");}
   previous=ctrl;count++;
  }
  vm.helper("wiredClosed");check(vm.nativeViews>=count,"Actual native WiredCtrl view getter/prefix was not executed");check(vm.controls.stream().noneMatch(o->o.type.equals("_-2xS::_-3EL")),"Legacy PickerList still instantiated");
  System.out.println("PASS: 12 actual native Wired view/dispose/reopen paths (action, message, action condition and selector), live option callbacks and save payloads; no preview or legacy PickerList dependency.");
 }
 static void testNativeMovement(NativeVM vm){
  int id=7654321;vm.furni(id,"tile_stackmagic",2.37,1);var m=vm.mover(id);
  vm.execute(vm.method(ENGINE,"_-0ex"),vm.engine,12345,id,vm.vector(3,5,4.22),vm.vector(0,0,0));vm.execute(vm.method(MOVING,"update"),m,500);
  eq(vm.height(id),0,"Original erroneous destination did not reproduce floor reset");var old=(Obj)vm.furniture.get(id).get("location");eq(vm.coord(old,"x"),0,"Original X jump not reproduced");
  for(String type:List.of("tile_stackmagic","tile_stackmagic_c","tile_walkmagic","tile_walkmagic_2")){
   vm.furniture.get(id).put("furnitype",type);vm.furniture.get(id).put("location",vm.vector(3,5,2.37));vm.statics.put("_heightRoom",12345);
   for(double z:List.of(0.0,1.25,4.22,80.0,2.37)){
    vm.helper("previewHeight",id,z);vm.execute(vm.method(MOVING,"update"),m,1000);vm.execute(vm.method(MOVING,"update"),m,1500);
    var p=(Obj)vm.furniture.get(id).get("location");eq(vm.coord(p,"x"),3,"Height changed X");eq(vm.coord(p,"y"),5,"Height changed Y");eq(vm.coord(p,"z"),z,"Height reset during native animation: "+type);
   }
   var saved=new Obj("Object");saved.put("id",id);saved.put("category",10);saved.put("_-UL",vm.vector(3,5,2.37));vm.selectedMove=saved;vm.helper("previewHeight",id,6.55);eq(vm.coord((Obj)saved.get("_-UL"),"z"),6.55,"Move cancellation still restores stale Z");vm.selectedMove=null;
  }
  System.out.println("PASS: Reproduced Teste13's X/Y jump and Z reset by executing native RoomEngine/MovingObjectLogic; fixed height samples remain at exact X/Y/Z after native animation for stack and walk tiles.");
 }
 static Packet friend(Packet p,int id,String name)throws Exception{return p.i(id).s(name).i(1).b(true).b(true).s("figure").i(0).s("").s("").s("").b(false).b(false).b(false).h(0);}
 @SuppressWarnings("unchecked") static void testFriends(NativeVM vm)throws Exception{
  String frag=msg("parser.friendlist:FriendsListFragmentMessageParser"),upd=msg("parser.friendlist:FriendListUpdateMessageParser");
  var fp=new Packet().i(1).i(0).i(1);friend(fp,555,"Amigo");var f=(Obj)vm.construct(vm.rawType(frag),List.of());vm.execute(vm.method(frag,"parse"),f,new Reader(fp.bytes()));check(Boolean.TRUE.equals(((Map<?,?>)vm.statics.get("_friendIds")).get(555)),"Fragment did not identify friend");
  vm.avatar(1,555,"Amigo",1);vm.avatar(2,666,"Visitante",1);vm.avatar(3,555,"Bot",3);vm.avatar(99,555,"Eu",1);vm.statics.put("_friendHighlightEnabled",true);vm.helper("roomSocialFrame",(Object)null);
  var tags=(Map<Object,Obj>)vm.statics.get("_friendTags");check(tags.size()==1&&tags.containsKey(1),"Highlighted nonfriend/bot/self");var tag=tags.get(1);Object view=tag.get("view");int expiration=num(tag.get("expires"));
  vm.now+=300;vm.helper("roomSocialFrame",(Object)null);check(((Map<Object,Obj>)vm.statics.get("_friendTags")).get(1).get("view")==view,"Repeated scan recreated highlight");
  vm.now=expiration+1;vm.helper("roomSocialFrame",(Object)null);check(((Map<?,?>)vm.statics.get("_friendTags")).isEmpty(),"Highlight did not expire");
  vm.roomUsers.remove(0);vm.avatars.remove(1);vm.now+=300;vm.helper("roomSocialFrame",(Object)null);vm.avatar(1,555,"Amigo",1);vm.now+=300;vm.helper("roomSocialFrame",(Object)null);check(((Map<?,?>)vm.statics.get("_friendTags")).containsKey(1),"Friend returning did not highlight");
  var delta=new Packet().i(0).i(1).i(-1).i(555);var u=(Obj)vm.construct(vm.rawType(upd),List.of());vm.execute(vm.method(upd,"flush"),u);vm.execute(vm.method(upd,"parse"),u,new Reader(delta.bytes()));check(((Map<?,?>)vm.statics.get("_friendIds")).get(555)==null,"Removed friend retained");vm.now+=300;vm.helper("roomSocialFrame",(Object)null);check(((Map<?,?>)vm.statics.get("_friendTags")).isEmpty(),"Removed friendship label remains");
  var ctx=context(vm);command(vm,ctx,":friendhl");check(Boolean.FALSE.equals(vm.statics.get("_friendHighlightEnabled")),"friendhl did not disable");check(vm.calls.contains("preferences-saved"),"Preference not saved");command(vm,ctx,":friendhl");check(Boolean.TRUE.equals(vm.statics.get("_friendHighlightEnabled")),"friendhl did not enable");
  System.out.println("PASS: Actual friend fragment/removal parsers drive six-second avatar labels; nonfriends, bots and self excluded, expiry/reentry/removal work, and :friendhl toggles/persists its preference.");
 }
 static void testDc(NativeVM vm){
  vm.statics.put("_areaActive",false);vm.statics.put("_heightPopup",null);var ctx=context(vm);vm.furni(12,"chair",0,1);var obj=vm.furniture.get(12);var objects=new ArrayList<Object>(List.of(obj));
  check(Boolean.FALSE.equals(vm.helper("useOnSingleTap",vm.desktop,objects)),"DC enabled by default");command(vm,ctx,":dc");int before=vm.used;vm.execute(vm.method(DESKTOP,"_-QW"),vm.desktop,objects,null);check(vm.used==before+1,"Single tap did not use native action once");
  obj.put("category",100);check(Boolean.FALSE.equals(vm.helper("useOnSingleTap",vm.desktop,objects)),"Avatar click intercepted");obj.put("category",10);vm.selectedMove=new Obj("active-move");check(Boolean.FALSE.equals(vm.helper("useOnSingleTap",vm.desktop,objects)),"Furniture movement interrupted");vm.selectedMove=null;
  vm.statics.put("_areaActive",true);check(Boolean.FALSE.equals(vm.helper("useOnSingleTap",vm.desktop,objects)),"Area editor interrupted");vm.statics.put("_areaActive",false);command(vm,ctx,":dc");check(Boolean.FALSE.equals(vm.helper("useOnSingleTap",vm.desktop,objects)),"DC did not disable");
  System.out.println("PASS: :dc routes one native room tap to one Use action and leaves avatars, active movement and area selection alone; toggle off restores normal clicks.");
 }
 public static void main(String[]a)throws Exception{
  var s=new SWF(new FileInputStream(a[0]),false);var vm=new NativeVM(s);var oracle=new WiredVM(new SWF(new FileInputStream("work/plus.swf"),false));
  testNewWire(vm,oracle);testDefinitions(vm,oracle);testWiredLifecycle(vm);testNativeMovement(vm);testArea(vm);testLiveHeight(vm);testFriends(vm);testDc(vm);
  vm.statics.put("_roomCanvas",null);vm.statics.put("_roomEngine",null);testEditors(vm);testContext(vm);
 }
}

import java.io.*;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

// Executes saved AVM2 gesture, walking composer and present routes. The room
// geometry hit, native widget presentation and hotel transport are boundaries.
class VerifyToken71 extends VerifyToken70 {
 static final String GIFT_EVENT="_-0sg::_-2LR";
 static class V71 extends V70 {
  final List<String> order=new ArrayList<>();
  final Obj desktop71=new Obj("use-desktop70"), walkRoom=new Obj("walk-room71"), walkLogic=new Obj("walk-logic71"), walkEngineEvents=new Obj("walk-events71"), widget71=new Obj("gift-widget71");
  Obj mover,ctrl,presentObject; List<Object> nativeGift;
  V71(SWF s)throws Exception {
   super(s);
   // Resolve the native MoveAvatarComposer from the walking method.
   var walking=method(PatchToken69.OBJECT69,"_-4j1");
   for(var ins:walking.body().getCode().code)if((ins.getBytes()[0]&255)==0x60){String q=AuditStartup.q(walking.cls().abc(),ins.operands[0]);if(q.endsWith("::_-1Iq"))nativeTypes.add(q);}
   nativeTypes.add(rawType(PatchToken71.PRESENT71));
   mover=allocate(rawType(PatchToken69.OBJECT69));mover.put("_roomEngine",engine69);engine69.put("events",walkEngineEvents);engine69.put("_-4Ej",sessions);engine69.put("_-08m",false);
   session.put("_-1Ti",false);session.put("_-0lf",false);session.put("_-0rn",false);session.put("_-3f-",true);
   desktop71.put("_-22-",session);desktop71.put("sessionDataManager",data69);data69.put("isAnyRoomController",false);desktop71.put("roomEngine",engine69);
   desktop71.put("_roomEngine",engine69);desktop71.put("_-1Yj",widget71);desktop71.put("_-3f8",new Obj("Object"));desktop71.put("builder",false);
   ctrl=allocate(rawType(PatchToken71.PRESENT71));
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&o.type.equals(GIFT_EVENT)&&Set.of("type","object").contains(k))return o.get(k);
   if(r==walkRoom||r==walkLogic||r==widget71||r==walkEngineEvents)return new Bound(r,String.valueOf(k));
   if(r instanceof Obj o&&o.type.equals("flash.geom::Point")&&Set.of("clone","offset").contains(k))return new Bound(r,String.valueOf(k));
   return super.get(r,k);
  }
  @Override Object construct(String t,List<Object> a){
   if(t.equals(GIFT_EVENT)){var o=new Obj(t);o.put("type",a.get(0));o.put("object",a.get(1));return o;}
   return super.construct(t,a);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r==desktop71){
    if(n.equals("_-2PB"))return desktop71.get("builder");
    if(n.equals("_-025"))return null;
    if(n.equals("showPresent71"))return execute(method(PatchToken70.DESKTOP,n),desktop71,a.toArray());
    if(n.equals("useObject")){order.add("use");used.add((Obj)a.get(0));return null;} // Furniture operation boundary; gift routes tested independently below.
   }
   if(r==engine69&&n.equals("_-46h")&&num(a.get(1))==731&&num(a.get(2))==10)return presentObject;
   if(r==widget71&&n.equals("_-0id"))return ctrl;
   if(r==ctrl&&n.equals("_-Nh")){nativeGift=new ArrayList<>(a);return null;}
   if(r==walkRoom&&n.equals("_-a1"))return walkLogic;
   if(r==walkEngineEvents&&n.equals("dispatchEvent"))return true;
   if(r==walkLogic&&n.equals("handleRoomTouchAtLocation")){
    check(a.get(2).equals("ROE_MOUSE_CLICK"),"DC does not use native room click");
    var tile=new Obj("Object");tile.put("_-44j",4);tile.put("_-1G",6);
    order.add("walk");return execute(method(PatchToken69.OBJECT69,"_-4To"),mover,12345,tile);
   }
   if(r instanceof Obj o&&o.type.equals("use-object70")&&n.equals("getId"))return 731;
   if(r instanceof Obj o&&o.type.equals("flash.geom::Point")){
    if(n.equals("clone"))return construct(o.type,List.of(o.get("x"),o.get("y")));
    if(n.equals("offset")){o.put("x",number(o.get("x"))+number(a.get(0)));o.put("y",number(o.get("y"))+number(a.get(1)));return null;}
   }
   return super.call(r,n,a);
  }
  Object desk(String n,Object...a){return execute(method(PatchToken70.DESKTOP,n),desktop71,a);}
  Obj tapSetup(Obj mobi){
   var handler=allocate(rawType(PatchToken69.TOUCH69));var canvas=new Obj("use-canvas70");
   canvas.put("desktop",desktop71);canvas.put("roomEngine",engine69);canvas.put("roomObject",walkRoom);canvas.put("scale",1);canvas.put("width",100);canvas.put("height",60);canvas.put("geometry",new Obj("Object"));
   var display=new Obj("tap-display69");display.put("x",0);display.put("y",0);
   var sprites=new Obj("Object");sprites.put("numChildren",0);
   handler.put("_-0zB",canvas);handler.put("_-1QM",display);handler.put("_-K9",sprites);handler.put("_-44m",new ASDictionary());handler.put("_-3nS",new Obj("Object"));
   handler.put("fixtureHits69",new ArrayList<>(List.of(new Obj("hit-avatar69"),mobi)));roomUse("gesture",handler);return handler;
  }
  void tap(Obj handler,Obj point){
   var gesture=new Obj("use-gesture70");gesture.put("location",point);var event=new Obj("Object");event.put("target",gesture);
   execute(method(PatchToken69.TOUCH69,"_-1FL"),handler,event);
  }
 }
 static Obj mobi(int category){var o=new Obj("use-object70");o.put("category",category);return o;}
 static void dc71(SWF old,SWF current)throws Exception {
  var prev=new V71(old);var floor=mobi(10);var oldTap=prev.tapSetup(floor);
  prev.helper("runCommand",":dc",prev.context69);prev.tap(oldTap,(Obj)prev.construct("flash.geom::Point",List.of(50,30)));
  check(prev.order.equals(List.of("use"))&&prev.sent.isEmpty()&&prev.bubbles.isEmpty(),"Original use-only, silent DC failure did not reproduce");
  var v=new V71(current);v.text("select","pt");var t=v.tapSetup(floor);
  check(truth(v.helper("runCommand"," :DC ",v.context69))&&v.sent.isEmpty()&&v.bubbles.size()==1&&v.get(v.bubbles.get(0),"text").equals(":dc ativado."),"No private on bubble");
  check(num(v.get(v.bubbles.get(0),"userId"))==1&&v.get(v.bubbles.get(0),"session")==v.session,"DC bubble not anchored to own avatar/session");
  for(boolean walkMode:List.of(true,false)){
   v.session.put("_-3f-",walkMode);var point=(Obj)v.construct("flash.geom::Point",List.of(50,30));int before=v.sent.size();
   v.order.clear();v.tap(t,point);
   check(v.order.equals(List.of("walk","use"))&&v.sent.size()==before+1&&payload(v,v.sent.get(before)).equals(List.of(4,6)),"DC does not walk before using the floor mobi");
   check(num(point.get("x"))==50&&num(point.get("y"))==30,"DC mutated gesture's original point");
  }
  v.helper("runCommand",":dc",v.context69);check(v.sent.size()==2&&v.bubbles.size()==2&&v.get(v.bubbles.get(1),"text").equals(":dc desativado."),"No private off bubble or command leaked to chat");
  v.session.put("_-3f-",true);v.order.clear();v.tap(t,(Obj)v.construct("flash.geom::Point",List.of(50,30)));check(v.order.equals(List.of("walk")),"Disabled DC does not preserve walking without auto-use");
  v.helper("runCommand",":dc",v.context69);v.desktop71.put("builder",true);v.order.clear();v.tap(t,(Obj)v.construct("flash.geom::Point",List.of(50,30)));check(v.order.equals(List.of("walk")),"DC hijacks builder selection");
  v.desktop71.put("builder",false);t.put("fixtureHits69",new ArrayList<>(List.of(new Obj("hit-avatar69"))));v.order.clear();v.tap(t,(Obj)v.construct("flash.geom::Point",List.of(50,30)));check(v.order.equals(List.of("walk")),"Avatar tap triggered auto-use");
  var state=(Obj)v.staticObject("loginpatch::ClientSettings63");check(num(((Obj)t.get("_-3nS")).get("_-2QQ"))==250&&truth(((Obj)v.preferences.get("data")).get("dc")),"DC lost its short tap preference");
  var a=AuditStartup.classes(old).get(PatchToken69.TOUCH69);var b=AuditStartup.classes(current).get(PatchToken69.TOUCH69);check(AuditToken62.methods(a).get("I1:_-01v").equals(AuditToken62.methods(b).get("I1:_-01v")),"Long-press native code changed");
  System.out.println("PASS: Teste70 reproduces silent DC and swallowed walking. Saved Teste71 runs the native walk path and exact MoveAvatar payload before a single use in both gesture modes; DC off, avatar hit and builder selection keep native handling. Each typed toggle creates a private self-avatar bubble without chat packets. Short/long gesture separation and persistence retained.");
 }
 static List<String> labels(Obj root){
  var texts=new ArrayList<String>();if(root.get("text") instanceof String s)texts.add(s);
  if(root.get("children") instanceof List<?> list)for(var child:list)if(child instanceof Obj o)texts.addAll(labels(o));
  return texts;
 }
 static void gift71(SWF old,SWF current)throws Exception {
  var prev=new V71(old);var v=new V71(current);v.text("select","pt");var gift=mobi(10);gift.put("handler",new Obj(v.rawType("com.sulake.habbo.room.object.logic.furniture:FurniturePresentLogic")));
  var model=new Obj("gift-model70");model.put("furniture_data","Texto legado");model.put("furniture_purchaser_name","Quem enviou");gift.put("model",model);prev.presentObject=v.presentObject=gift;
  var event=new Obj("Object");event.put("type","RETWE_REQUEST_PRESENT");event.put("roomId",12345);event.put("objectId",731);event.put("category",10);
  check(!truth(prev.desk("_-0KM",event)),"Original missing gift event route did not reproduce");
  for(String route:List.of("_-0KM","_-N2","useObject","_-kG")){
   var direct=v.construct(GIFT_EVENT,List.of("ROWRE_PRESENT",gift));v.desk(route,route.equals("_-0KM")?event:route.equals("_-kG")?direct:gift);
   var root=(Obj)v.staticObject("loginpatch::RoomUse70").get("_present");check(root!=null&&root.get("name").equals("presentMessage70"),"Visitor popup missing at "+route);
   var texts=labels(root);check(texts.contains("Texto legado")&&texts.contains("De: Quem enviou")&&v.sent.isEmpty()&&v.nativeGift==null,"Visitor gift body/sender or read-only behavior differs: "+texts);
   v.roomUse("closePresent",(Object)null);
  }
  event.put("roomId",12346);check(!truth(v.roomUse("presentRequest",v.desktop71,event)),"Stale room gift request accepted");event.put("roomId",12345);
  v.session.put("_-1Ti",true);v.desk("_-0KM",event);check(v.nativeGift.get(0).equals("Quem enviou")&&v.nativeGift.get(1).equals("Texto legado")&&num(v.ctrl.get("_-02l"))==731&&v.sent.isEmpty(),"Controller did not get native legacy gift dialog with correct id");
  var map=(Obj)v.construct("_-44B::Map",List.of());v.call(map,"add",List.of("MESSAGE","Texto do mapa"));v.call(map,"add",List.of("PURCHASER_NAME","Novo remetente"));model.put("map",map);
  v.desk("useObject",gift);check(v.nativeGift.get(0).equals("Novo remetente")&&v.nativeGift.get(1).equals("Texto do mapa")&&v.sent.isEmpty(),"Gift fields from structured map lost or auto-open packet sent");
  gift.put("handler",new Obj("unrelated-furniture"));check(!truth(v.roomUse("present",v.desktop71,gift)),"Non-gift furniture permissions changed");
  System.out.println("PASS: Teste70 rejects actual RETWE_REQUEST_PRESENT. Saved Teste71 handles the engine request, direct event, native selection and explicit use for a visitor, with sender/body and zero open packets. Controller dialog receives native gift ID and both legacy string and structured map. Stale room and non-gifts rejected.");
 }
 public static void main(String[] a)throws Exception {
  var previous=new SWF(new FileInputStream(a[0]),false);var current=new SWF(new FileInputStream(a[1]),false);
  switch(a[2]){case "dc"->dc71(previous,current);case "gifts"->gift71(previous,current);default->throw new IllegalArgumentException(a[2]);}
 }
}

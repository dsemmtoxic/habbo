import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

// Executes the saved gesture and widget callbacks. Sprite hit candidates,
// platform UI rendering and server transport are test boundaries.
class VerifyToken72 extends VerifyToken71 {
 static final String GIFT="com.sulake.habbo.room.object.logic.furniture:FurniturePresentLogic";
 static final String TROPHY="com.sulake.habbo.room.object.logic.furniture:FurnitureTrophyLogic";
 static class V72 extends V71 {
  V72(SWF swf)throws Exception {super(swf);text("select","pt");}
  @Override Object call(Object receiver,String name,List<Object> args){
   if(receiver instanceof Obj model&&model.type.equals("gift-model70")&&name.equals("getNumber"))
    return model.getOrDefault(args.get(0),Double.NaN);
   if(receiver==desktop71&&name.equals("useObject")&&args.get(0)==presentObject)
    return desk("useObject",presentObject);
   return super.call(receiver,name,args);
  }
  Obj reader(String type,String data,int owner){
   var object=mobi(10);
   object.put("handler",new Obj(rawType(type)));
   var model=new Obj("gift-model70");
   model.put("furniture_data",data);
   model.put("furniture_owner_id",owner);
   object.put("model",model);
   presentObject=object;
   return object;
  }
  void gesture(String method,Obj handler){
   var target=new Obj("use-gesture70");
   target.put("location",construct("flash.geom::Point",List.of(50,30)));
   var event=new Obj("Object");
   event.put("target",target);
   execute(method(PatchToken69.TOUCH69,method),handler,event);
  }
  Obj panel(){return (Obj)staticObject("loginpatch::RoomUse70").get("_present");}
  List<String> read(){
   check(panel()!=null,"Reading panel did not open");
   var shown=labels(panel());
   roomUse("closePresent",(Object)null);
   check(panel()==null,"Reading panel did not close");
   return shown;
  }
  Object request(String name,int room){
   var event=new Obj("Object");
   event.put("type",name);
   event.put("roomId",room);
   event.put("objectId",731);
   event.put("category",10);
   return desk("_-0KM",event);
  }
 }
 public static void main(String[] args)throws Exception {
  var old=new V72(new SWF(new FileInputStream(args[0]),false));
  var previousGift=old.reader(GIFT,"Mensagem antiga",42);
  old.gesture("_-1FL",old.tapSetup(previousGift));
  check(old.panel()==null&&old.order.equals(List.of("walk")),"Teste71 single-tap gap not reproduced");
  old.session.put("_-3f-",false);
  old.gesture("_-4VQ",old.tapSetup(previousGift));
  check(old.panel()==null,"Teste71 double-tap gap not reproduced");
  old.reader(TROPHY,"Neto\t03/11/2026\tParabéns!",42);
  check(!truth(old.request("RETWE_REQUEST_TROPHY",12345)),"Teste71 trophy dispatch gap not reproduced");

  var v=new V72(new SWF(new FileInputStream(args[1]),false));
  var gift=v.reader(GIFT,"Boa festa!\nAproveite o presente.",42);
  var model=(Obj)gift.get("model");
  model.put("furniture_purchaser_name","Alice");
  for(boolean preference:List.of(true,false)){
   v.session.put("_-3f-",preference);
   for(String route:List.of("_-1FL","_-4VQ")){
    v.gesture(route,v.tapSetup(gift));
    var shown=v.read();
    check(shown.containsAll(List.of("Mensagem do presente","De: Alice","Boa festa!\nAproveite o presente.")),
          "Legacy message missing from "+route+" in gesture mode "+preference+": "+shown);
   }
  }
  check(v.sent.isEmpty(),"Reading triggered a server packet");
  var map=(Obj)v.construct("_-44B::Map",List.of());
  v.call(map,"add",List.of("MESSAGE","Mensagem estruturada"));
  v.call(map,"add",List.of("PURCHASER_NAME","Bruna"));
  model.put("map",map);
  v.session.put("_-1Ti",true);
  v.data69.put("_-0e7",9);
  check(truth(v.request("RETWE_REQUEST_PRESENT",12345)),"Present engine request not handled");
  check(v.read().containsAll(List.of("De: Bruna","Mensagem estruturada"))&&v.nativeGift==null,
        "Room rights incorrectly replaced reading with unwrapping");
  v.session.put("_-1Ti",false);
  v.data69.put("_-0e7",42);
  v.gesture("_-1FL",v.tapSetup(gift));
  check(v.nativeGift!=null&&v.nativeGift.get(1).equals("Mensagem estruturada")&&num(v.ctrl.get("_-02l"))==731,
        "Present owner did not get native opening options");
  check(v.sent.isEmpty(),"Native gift options opened the contents automatically");

  var trophy=v.reader(TROPHY,"Neto\t03/11/2026\tParabéns!\tSegunda parte",42);
  var t=v.tapSetup(trophy);
  v.gesture("_-1FL",t);
  check(v.read().containsAll(List.of("Dedicatória do troféu","De: Neto\n03/11/2026","Parabéns!\tSegunda parte")),
        "Trophy fields or trailing dedication lost");
  check(truth(v.request("RETWE_REQUEST_TROPHY",12345))&&v.read().contains("Dedicatória do troféu"),
        "Trophy engine request did not open the reader");
  v.desk("_-kG",v.construct(GIFT_EVENT,List.of("ROWRE_TROPHY",trophy)));
  check(v.read().contains("Dedicatória do troféu"),"Direct trophy event did not open the reader");
  check(!truth(v.request("RETWE_REQUEST_TROPHY",12346))&&v.panel()==null,"Stale room request opened the panel");

  ((Obj)trophy.get("model")).put("furniture_data","Dedicatória sem data");
  v.gesture("_-4VQ",t);
  check(v.read().contains("Dedicatória sem data"),"Unstructured inscription was discarded");
  ((Obj)trophy.get("model")).put("furniture_data",null);
  v.gesture("_-1FL",t);
  check(v.read().contains("Este troféu não tem dedicatória."),"Empty trophy body failed");
  v.helper("runCommand",":dc",v.context69);
  v.gesture("_-1FL",t);
  check(v.read().contains("Dedicatória do troféu")&&v.order.equals(List.of("walk"))&&v.sent.size()==1
       &&payload(v,v.sent.get(0)).equals(List.of(4,6)),"DC did not walk and then open the trophy");
  System.out.println("PASS: reproduced Teste71 gesture and trophy gaps; short and double taps and widget callbacks open both readers. DC movement and owner-only gift options verified.");
 }
}

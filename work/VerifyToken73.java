import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken73 extends VerifyToken72 {
 static class V73 extends V72 {
  final Obj giftUi=new Obj("gift-ui73"), giftCatalog=new Obj("gift-catalog73");
  int catalogPage=-1;
  V73(SWF swf)throws Exception {
   super(swf);
   nativeTypes.add("_-26z::_-4LH");
   ctrl.put("_-4XR",connection);
   giftUi.put("catalog",giftCatalog);
   desktop71.put("_-38",sessions);
   desktop71.put("_-2o8",giftUi);
  }
  @Override Object get(Object receiver,Object key){
   if(receiver==giftUi&&Set.of("_-38x","_-47D").contains(key))return new Bound(receiver,String.valueOf(key));
   return super.get(receiver,key);
  }
  @Override Object call(Object receiver,String name,List<Object> args){
   if(receiver==desktop71){
    if(Set.of("presentController73","_-QW","_-3ir","_-N2","_-1L9").contains(name))
     return desk(name,args.toArray());
    if(name.equals("_-oE")){order.add("move");return null;}
    if(name.equals("_-39J"))return null;
   }
   if(receiver==widget71&&name.equals("_-QW")){order.add("choose");return null;}
   if(receiver==widget71&&name.equals("_-1pQ"))return null;
   if(receiver==giftUi&&name.equals("_-47D"))return null;
   if(receiver==giftUi&&name.equals("_-38x")){catalogPage=num(args.get(0));return null;}
   return super.call(receiver,name,args);
  }
  void gesture73(String name,Obj furniture){
   var handler=tapSetup(furniture);
   handler.put("fixtureHits69",new ArrayList<>(List.of(furniture)));
   var target=new Obj(name.equals("_-01v")?"_-3UT::_-0HH":"use-gesture70");
   target.put("location",construct("flash.geom::Point",List.of(50,30)));
   var event=new Obj("Object");
   event.put("target",target);
   execute(method(PatchToken69.TOUCH69,name),handler,event);
  }
  void doubleTap(Obj furniture){gesture73("_-4VQ",furniture);}
  Obj control(String name){
   for(Object child:(List<?>)panel().get("children"))
    if(child instanceof Obj o&&name.equals(o.get("name")))return o;
   return null;
  }
  Obj gift(){
   var object=reader(GIFT,"Boa festa!\nAproveite o presente.",42);
   ((Obj)object.get("model")).put("furniture_purchaser_name","Alice");
   return object;
  }
  void viewport(int width,int height){
   stage.put("stageWidth",width);
   stage.put("stageHeight",height);
  }
  void fits(int width,int height){
   check(number(panel().get("x"))>=0&&number(panel().get("y"))>=0
    &&number(panel().get("x"))+number(panel().get("width"))<=width
    &&number(panel().get("y"))+number(panel().get("height"))<=height,"Reader clips off screen");
  }
  boolean color(int rgb){
   for(Object child:(List<?>)panel().get("children"))
    if(child instanceof Obj o&&o.type.equals("starling.display::Quad")&&num(o.get("color"))==rgb)return true;
   return false;
  }
 }

 public static void main(String[] args)throws Exception {
  var old=new V72(new SWF(new FileInputStream(args[0]),false));
  old.data69.put("userId",42);
  old.data69.put("_-0e7",3);
  old.reader(GIFT,"Legacy",42);
  check(truth(old.request("RETWE_REQUEST_PRESENT",12345))&&old.panel()!=null&&old.nativeGift==null,
    "Teste72 ownership regression did not reproduce");

  var v=new V73(new SWF(new FileInputStream(args[1]),false));
  v.data69.put("userId",42);
  v.data69.put("_-0e7",3);
  var gift=v.gift();
  for(var size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{640,360},new int[]{360,640})){
   v.viewport(size[0],size[1]);
   for(boolean preference:List.of(true,false)){
    v.session.put("_-3f-",preference);
     v.doubleTap(gift);
     check("giftCard73".equals(v.panel().get("name"))&&v.color(0x0c748b)&&v.color(0x790926),
       "Missing regular gift card");
     check(labels(v.panel()).containsAll(List.of("Presente","De: Alice","Boa festa!\nAproveite o presente.")),
       "Legacy sender/body missing");
     check(v.control("openGift73")!=null&&v.control("returnGift73")!=null,"Owner lost gift buttons");
     v.fits(size[0],size[1]);
   }
  }
  check(v.sent.isEmpty(),"Reading dispatched a gift-open packet");
  click(v,v.control("openGift73"));
  check(v.sent.size()==1&&payload(v,v.sent.get(0)).equals(List.of(731))&&v.panel()==null,
    "Open button did not send the native composer with the gift ID");
  v.ctrl.put("_-2o8",v.giftUi);
  v.doubleTap(gift);
  click(v,v.control("returnGift73"));
  check(v.sent.size()==1&&v.catalogPage==4&&"Alice".equals(v.giftCatalog.get("_-1yA"))&&v.panel()==null,
    "Return gift did not open the native catalog for the sender");

  v.doubleTap(gift);
  var stale=v.control("openGift73");
  v.engine69.put("_-0Y",12346);
  click(v,stale);
  check(v.panel()==null&&v.sent.size()==1,"Stale room allowed opening gift");
  v.engine69.put("_-0Y",12345);
  v.doubleTap(gift);
  stale=v.control("openGift73");
  v.data69.put("userId",43);
  click(v,stale);
  check(v.panel()==null&&v.sent.size()==1,"Changed ownership allowed opening gift");
  v.data69.put("_-0e7",42);
  v.session.put("_-1Ti",true);
  v.doubleTap(gift);
  check(v.control("openGift73")==null&&v.control("returnGift73")==null&&labels(v.panel()).contains("De: Alice"),
    "Room rights or respect count exposed owner actions to a visitor");

  v.data69.put("userId",42);
  var model=(Obj)gift.get("model");
  var map=(Obj)v.construct("_-44B::Map",List.of());
  v.call(map,"add",List.of("MESSAGE","Mensagem especial"));
  v.call(map,"add",List.of("PURCHASER_NAME","Habbo"));
  v.call(map,"add",List.of("TRUSTED_SENDER","true"));
  model.put("map",map);
  v.doubleTap(gift);
  check(v.color(0x205f10)&&labels(v.panel()).containsAll(List.of("Presente especial!","Mensagem especial"))
    &&v.control("openGift73")!=null&&v.control("returnGift73")==null,"Staff gift styling/actions wrong");

  var trophy=v.reader(TROPHY,"Neto\t03/11/2026\tParabéns!\tSegunda parte",42);
  for(int[] value:List.of(new int[]{1,0xecc547},new int[]{2,0xc9bdcc},new int[]{3,0xb87834},new int[]{0,0xecc547})){
   ((Obj)trophy.get("model")).put("furniture_color",value[0]);
   v.doubleTap(trophy);
   check("trophyPlaque73".equals(v.panel().get("name"))
    &&v.color(value[1])&&v.control("openGift73")==null,"Wrong trophy finish for value "+value[0]);
   check(v.read().containsAll(List.of("Troféu","Neto","03/11/2026","Parabéns!\tSegunda parte")),
     "Trophy date, author, or dedication lost");
  }
  ((Obj)trophy.get("model")).put("furniture_data","Dedicatória sem data");
  v.doubleTap(trophy);
  check(v.read().contains("Dedicatória sem data"),"Legacy trophy data lost");
  ((Obj)trophy.get("model")).put("furniture_data",null);
  v.doubleTap(trophy);
  check(v.read().contains("Este troféu não tem dedicatória."),"Missing empty inscription fallback");

  for(var furniture:List.of(gift,trophy)){
   v.presentObject=furniture;
   for(String event:List.of("ROWRE_PRESENT","ROWRE_TROPHY"))
    v.desk("_-kG",v.construct(GIFT_EVENT,List.of(event,furniture)));
   for(String request:List.of("RETWE_REQUEST_PRESENT","RETWE_REQUEST_TROPHY"))
    v.request(request,12345);
   v.desk("useObject",furniture);
   check(v.panel()==null,"Non-double-tap route opened a reader");
   for(boolean preference:List.of(true,false)){
    v.session.put("_-3f-",preference);
    v.order.clear();
    v.gesture73("_-1FL",furniture);
    check(v.panel()==null,"Single tap opened a reader");
    for(boolean rights:List.of(true,false)){
     v.session.put("_-1Ti",rights);
     v.order.clear();
     v.gesture73("_-01v",furniture);
     check(v.order.equals(List.of(rights?"move":"choose"))&&v.panel()==null,
       "Long press did not reach the native move/choose path");
    }
   }
  }
  v.session.put("_-3f-",true);
  v.helper("runCommand",":dc",v.context69);
  v.order.clear();
  int before=v.sent.size();
  v.gesture73("_-1FL",trophy);
  check(v.panel()==null&&v.order.equals(List.of("walk"))&&v.sent.size()==before+1
    &&payload(v,v.sent.get(before)).equals(List.of(4,6)),"DC reader single tap should walk without reading");
  v.doubleTap(trophy);
  check(v.read().contains("Troféu"),"DC blocked double tap");
  v.order.clear();
  v.gesture73("_-1FL",mobi(10));
  check(v.order.equals(List.of("walk","use"))&&v.panel()==null,"DC ordinary furniture use regression");
  System.out.println("PASS: double-tap-only reading, native long-press move/choose, DC walking and use, real owner ID, native open/return actions, stale-room rejection, all three Air Plus trophy finishes, legacy text and viewport bounds.");
 }
}

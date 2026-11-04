import java.io.FileInputStream;
import java.util.*;
import com.jpexs.decompiler.flash.SWF;

class VerifyToken74 extends VerifyToken73 {
 static final String PORTRAIT="loginpatch:Portrait74", LOCK="_-1wF::_-2vU",
   USE="_-Fs::_-2Kx", CHOOSE="_-3oD::_-35L";
 static class V74 extends V73 {
  final Obj renderer=new Obj("portrait-renderer74"), eventHandler=new Obj("ordinary-handler74");
  final List<List<Object>> figures=new ArrayList<>(), renders=new ArrayList<>();
  boolean waiting=true, mirror;
  int baseUses, hides, visitorMenus;
  V74(SWF swf)throws Exception {
   super(swf);
   desktop71.put("_-3lM",renderer);
  }
  String logical(String rawName){return raw.get(rawName).logical();}
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&o.type.equals("_-1R8::_-1E1")&&k.equals("id"))return o.get(k);
   if(r instanceof Obj o&&Set.of("portrait-renderer74","portrait-source74","ordinary-handler74",
      "lock-ui74").contains(o.type))
    return o.containsKey(k)?o.get(k):new Bound(r,String.valueOf(k));
   return super.get(r,k);
  }
  @Override boolean scene(String type){return type.equals("loginpatch::Portrait74")||type.equals(LOCK)||super.scene(type);}
  @Override void constructSuper(Method m,Obj self,List<Object> args){
   if(!m.cls().logical().equals(PORTRAIT))super.constructSuper(m,self,args);
  }
  @Override Object construct(String type,List<Object> args){
   if(type.equals("loginpatch::Portrait74")){
    var child=display(type);
    execute(method(PORTRAIT,"<init>"),child,args.toArray());
    return child;
   }
   return super.construct(type,args);
  }
  @Override Object call(Object r,String n,List<Object> a){
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::FriendLock74"))
    return execute(method("loginpatch:FriendLock74",n),staticObject(ref.name()),a.toArray());
   if(r==renderer&&n.equals("_-4QF")){
    figures.add(new ArrayList<>(a));
    return new Obj("portrait-source74");
   }
   if(r instanceof Obj o&&o.type.equals("portrait-source74")){
    if(n.equals("isPlaceholder"))return waiting;
    if(n.equals("setDirection")){o.put("direction",a.get(1));return null;}
    if(n.equals("_-3Ub"))return mirror;
    if(n.equals("_-4Th")){
     renders.add(List.of(a.get(0),o.get("direction")));
     return construct("flash.display::BitmapData",List.of(42,70,true,0));
    }
    if(Set.of("_-3fO","_-3cz","dispose").contains(n))return null;
   }
   if(r==desktop71&&n.equals("showFurnitureMenu74"))return desk(n,a.toArray());
   if(r==widget71&&n.equals("showFurnitureMenu74"))
    return execute(method(logical("_-0D0::_-31O"),n),widget71,a.toArray());
   if(r==widget71&&n.equals("_-4gs")){visitorMenus++;return null;}
   if(r==eventHandler&&n.equals("useObject")){baseUses++;return null;}
   if(r instanceof Obj o&&o.type.equals(CHOOSE)&&n.equals("hide")){hides++;return null;}
   if(r instanceof Obj o&&o.type.equals("lock-ui74")&&n.equals("getProperty"))return "https://assets.example/";
   return super.call(r,n,a);
  }
  Obj menuEvent(int action){
   var item=new Obj("_-1R8::_-1E1");
   item.put("id",action);
   var event=new Obj("Object");
   event.put("data",item);
   return event;
  }
  void use(Obj furniture){
   var menu=new Obj(USE);
   menu.put("_-3x9",desktop71);
   menu.put("_-3Cd",furniture);
   execute(method(logical(USE),"_-0wY"),menu,menuEvent(1));
  }
  void choose(Obj furniture){
   var list=uiObject("_-2xS::_-0xe");
   var row=new Obj("Object");
   row.put("data",furniture);
   var data=new Obj("Object");
   data.put("items",List.of(row));
   list.put("dataProvider",data);
   list.put("selectedIndex",0);
   var chooser=new Obj(CHOOSE);
   chooser.put("_-3v4",list);
   chooser.put("_-3x9",desktop71);
   execute(method(logical(CHOOSE),"_-3xi"),chooser,new Obj("Object"));
  }
  Obj lock(){
   var lock=display(LOCK);
   var controller=new Obj("Object");
   controller.put("ui",new Obj("lock-ui74"));
   lock.put("_-2sW",controller);
   lock.put("_-49m",renderer);
   lock.put("_figure1","hd-190-1");
   lock.put("_figure2","hd-200-2");
   execute(method(logical(LOCK),"_-2n4"),lock,"Pessoa A","Pessoa B","06/05/2026");
   return lock;
  }
 }
 static Obj child(Obj parent,int index){return (Obj)((List<?>)parent.get("children")).get(index);}
 public static void main(String[] args)throws Exception {
  var v=new V74(new SWF(new FileInputStream(args[0]),false));
  v.viewport(1536,709);
  v.data69.put("userId",42);
  var gift=v.gift();
  ((Obj)gift.get("model")).put("furniture_purchaser_figure","hr-828-42.hd-209-11");
  v.session.put("_-1Ti",true);
  v.gesture73("_-01v",gift);
  check(v.panel()==null&&v.order.equals(List.of("move")),"Hold opened a reader");
  v.order.clear();
  v.choose(gift);
  check(v.panel()!=null&&v.order.equals(List.of("move"))&&v.hides==1,"Menu choice lost native move/reader path");
  var portrait=v.control("giftSenderHead74");
  check(portrait!=null&&portrait.get("_image")==null&&v.figures.get(0).get(0).equals("hr-828-42.hd-209-11"),
    "Gift did not use the stored send-time figure");
  v.waiting=false;
  v.mirror=true;
  v.execute(v.method(PORTRAIT,"_-1pp"),portrait,"other");
  check(v.renders.isEmpty(),"Unrelated figure refreshed portrait");
  v.execute(v.method(PORTRAIT,"_-1pp"),portrait,"hr-828-42.hd-209-11");
  check(v.renders.equals(List.of(List.of("head",2)))&&number(((Obj)portrait.get("_image")).get("scaleX"))<0,
    "Ready figure did not produce an aspect-preserving cropped head");
  v.roomUse("closePresent",(Object)null);
  v.execute(v.method(PORTRAIT,"dispose"),portrait);
  int before=v.figures.size();
  v.execute(v.method(PORTRAIT,"_-1pp"),portrait,"hr-828-42.hd-209-11");
  check(v.figures.size()==before,"Late callback refreshed a disposed portrait");

  var trophy=v.reader(TROPHY,"Neto\t03/11/2026\tParabéns!",42);
  v.session.put("_-1Ti",false);
  v.order.clear();
  v.choose(trophy);
  check(v.visitorMenus==1&&v.order.isEmpty()&&"trophyPlaque73".equals(v.panel().get("name")),
    "Visitor choice lost its use menu or requested a move");
  v.roomUse("closePresent",(Object)null);
  var menu=new Obj(USE);
  menu.put("_-3Cd",trophy);
  check(truth(v.execute(v.method(v.logical(USE),"_-3Au"),menu,false)),"Visitor use button hidden for trophy");
  v.use(trophy);
  check("trophyPlaque73".equals(v.panel().get("name"))&&v.sent.isEmpty(),"Use button failed to open trophy");
  v.roomUse("closePresent",(Object)null);
  v.use(gift);
  check("giftCard73".equals(v.panel().get("name")),"Use button failed to open gift");
  v.roomUse("closePresent",(Object)null);
  var ordinary=mobi(10);
  ordinary.put("handler",v.eventHandler);
  v.use(ordinary);
  check(v.baseUses==1&&v.panel()==null,"Ordinary use changed");

  for(int[] size:List.of(new int[]{1536,709},new int[]{640,360},new int[]{360,640})){
   v.viewport(size[0],size[1]);
   var card=child(v.lock(),0);
   var left=child(card,1);
   var right=child(card,2);
   check(num(left.get("x"))==115&&num(right.get("x"))==186&&num(left.get("y"))==7&&num(right.get("y"))==7,
    "Avatar slots differ from Air Plus");
   check(number(card.get("x"))>=0&&number(card.get("y"))>=0&&
     number(card.get("x"))+375*number(card.get("scaleX"))<=size[0],"Lock card off screen");
   check(v.renders.subList(v.renders.size()-2,v.renders.size()).equals(List.of(List.of("full",2),List.of("full",4))),
    "Lock figures face the wrong way or use head crop");
  }
  System.out.println("PASS: saved menu Use and Choose routes, native move retention, stored sender figure and async crop, disposed portrait guard, and Air Plus lock layout at three viewport sizes.");
 }
}

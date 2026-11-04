import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;

// Executes saved room events and CoreComponentContext -> native gradient draw.
// Only GPU/AGAL, platform service injection, frame scheduling and XML I/O are
// explicit boundaries. No test is a physical Android observation.
class VerifyAppearance62 extends VerifyToken61 {
 static final String CORE=PatchToken62.CORE,GRADIENT=PatchToken62.GRADIENT,LOGIC=PatchToken62.LOGIC,MASK=PatchToken62.MASK;
 static class V62 extends V {
  Obj core,gradient,gpu,handler,maskStore,furnitureLogic,tonerDispatcher;final List<List<Double>> uploads=new ArrayList<>();final List<List<Object>> maskAdds=new ArrayList<>();int draws,bufferDisposals,objectEvents,roomEvents;Obj lastVertexBuffer;String presented="";
  V62(SWF s)throws Exception{super(s);for(String c:List.of("com.sulake.habbo.room.events:RoomObjectHSLColorEnableEvent","com.sulake.room.object:RoomObjectModel","com.sulake.habbo.room.object.data:IntArrayStuffData"))nativeTypes.add(rawType(c));nativeTypes.add("_-0Xf::_-0ha");}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(self==furnitureLogic&&n.equals("object"))return toner;
   if(self==furnitureLogic&&n.equals("eventDispatcher"))return tonerDispatcher;
   return super.lexical(m,self,n,i);
  }
  @Override Object construct(String t,List<Object>a){
   if(t.equals("_-0ir::AGALMiniAssembler"))return new Obj("agal-boundary62");
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r==hub&&k.equals("events"))return new Obj("widget-event-dispatcher62");
   if(r==furnitureLogic&&k.equals("object"))return toner;
   if(r==furnitureLogic&&k.equals("eventDispatcher"))return tonerDispatcher;
   if(r instanceof Ref ref&&ref.name().equals("_-9C::_-2h8")&&Set.of("_-0g9","_-40z").contains(k))return false;
   return super.get(r,k);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Obj o&&o.type.equals("gpu-context61")){
    if(n.equals("createVertexBuffer")||n.equals("createIndexBuffer")||n.equals("createProgram")){var value=new Obj("gpu-resource62");value.put("kind",n);if(n.equals("createVertexBuffer"))lastVertexBuffer=value;return value;}
    if(n.equals("drawTriangles")){draws++;return null;}
    if(Set.of("setBlendFactors","setProgram","setVertexBufferAt").contains(n))return null;
   }
   if(r instanceof Obj o&&o.type.equals("gpu-resource62")){
    if(n.equals("dispose")){o.put("disposed",true);bufferDisposals++;return null;}
    if(n.equals("upload"))return null;
    if(n.equals("uploadFromVector")){o.put("uploaded",a.get(0));if(o.get("kind").equals("createVertexBuffer")){var values=new ArrayList<Double>();for(var v:(List<?>)a.get(0))values.add(number(v));uploads.add(values);}return null;}
   }
   if(r instanceof Obj o&&o.type.equals("agal-boundary62")&&n.equals("assemble"))return new Obj("shader-bytearray62");
   if(r instanceof Obj o&&o.type.equals("frame-update62"))return null;
   if(r==view&&n.equals("removeChildren"))throw new AssertionError("Background update cleared room scene");
   if(r==view&&n.equals("render"))return null;
   if(r==hub&&Set.of("_-41J","_-nQ","_-kY").contains(n))return null; // Widget activation, outside background rendering.
   if(r instanceof Obj o&&o.type.equals("room-event-dispatcher62")&&n.equals("dispatchEvent")){roomEvents++;execute(method(HUI,"_-4P7"),hub,a.get(0));return true;}
   if(r instanceof Obj o&&o.type.equals("widget-event-dispatcher62")&&n.equals("dispatchEvent"))return true;
   if(r instanceof Obj o&&o.type.equals("furniture-event-dispatcher62")&&n.equals("dispatchEvent")){objectEvents++;execute(method("com.sulake.habbo.room:RoomObjectEventHandler","_-02k"),handler,a.get(0),12345);return true;}
   if(r==toner&&n.equals("getModelController"))return toner.get("model");
   if(r==toner&&n.equals("setState")){toner.put("state",a.get(0));return true;}
   if(r==maskStore&&n.equals("addMask")){maskAdds.add(new ArrayList<>(a));return null;}
   if(r==maskStore&&n.equals("_-0k5"))return new Obj("xml-boundary62");
   if(r instanceof Obj o&&o.type.equals("xml-boundary62")&&n.equals("toXMLString"))return "<planeMasks/>";
   if(r instanceof Obj o&&o.type.equals("mask-model62")&&n.equals("setString")){o.put(String.valueOf(a.get(0)),a.get(1));return null;}
   return super.call(r,n,a);
  }
  @Override void setupToner()throws Exception{
   super.setupToner();desktop.put("_-2o8",hub);
   gpu=(Obj)proxy.get("_-In");gpu.put("driverInfo","test GPU boundary");gpu.put("profile","baseline");
   core=allocate(rawType(CORE));core.put("_stage3DProxy",proxy);core.put("_view3D",view);core.put("_starling",new Obj("starling-frame61"));core.put("_-4bg",new Bound(new Obj("frame-update62"),"update"));core.put("_flags",2);core.put("_-1Vr",1000000);core.put("_lastUpdateTimeMs",now);
   gradient=allocate(rawType(GRADIENT));gradient.put("_context",gpu);call(gradient,"colors",List.of(527374,1318180));core.put("_-YO",gradient);var child=allocate(rawType("com.sulake.core.runtime:ComponentContext"));child.put("_context",core);hub.put("_context",child);
   handler=allocate(rawType("com.sulake.habbo.room:RoomObjectEventHandler"));handler.put("_roomEngine",e);e.put("events",new Obj("room-event-dispatcher62"));
  }
  @Override void frame(){execute(method(CORE,"onEnterFrame"),core,(Object)null);}
  void objectColorEvent(boolean on,int h,int s,int l){
   var event=(Obj)construct(rawType("com.sulake.habbo.room.events:RoomObjectHSLColorEnableEvent"),List.of("ROHSLCEE_ROOM_BACKGROUND_COLOR",toner,on,h,s,l));
   execute(method("com.sulake.habbo.room:RoomObjectEventHandler","_-3uQ"),handler,event,12345);
  }
  void switchRoomMode(){
   var manager=allocate(rawType(PatchToken62.MAINVIEW));manager.put("_-33k",hub);
   var config=construct("_-0Xf::_-0ha",List.of(1,List.of(1,2,3),List.of(791578)));
   manager.put("_-13I",List.of(config));execute(method(PatchToken62.MAINVIEW,"_-38x"),manager,1,false,false);
  }
  void furnitureData(int on,int h,int s,int l)throws Exception{
   var model=construct(rawType("com.sulake.room.object:RoomObjectModel"),List.of());call(model,"setNumber",List.of("furniture_real_room_object",1));toner.put("model",model);
   var data=construct(rawType("com.sulake.habbo.room.object.data:IntArrayStuffData"),List.of());var reader=new Reader(new Packet().i(4).i(on).i(h).i(s).i(l).bytes());call(data,"initializeFromIncomingMessage",List.of(reader));check(reader.b.remaining()==0,"Toner integer-array reader left bytes");call(data,"writeRoomObjectModel",List.of(model));
   furnitureLogic=allocate(rawType("com.sulake.habbo.room.object.logic.furniture:FurnitureRoomBackgroundColorLogic"));tonerDispatcher=new Obj("furniture-event-dispatcher62");execute(method("com.sulake.habbo.room.object.logic.furniture:FurnitureRoomBackgroundColorLogic","_-Sc"),furnitureLogic);
  }
  void assertDraw(int rgb){
   int before=draws;frame();check(draws==before+1&&!uploads.isEmpty(),"Actual core frame did not draw native background");
   var vertices=uploads.get(uploads.size()-1);check(vertices.size()==20,"Native gradient vertex layout changed");
   for(int vertex=0;vertex<4;vertex++)for(int channel=0;channel<3;channel++)check(Math.abs(vertices.get(vertex*5+2+channel)-((rgb>>(16-8*channel))&255)/255.0)<1e-7,"Final drawn background differs from Toner: "+vertices);
  }
 }
 static void rendering(SWF old,SWF now)throws Exception{
  var prior=new V62(old);prior.setupToner();prior.colorEvent(true,85,255,127);prior.switchRoomMode();int wanted=num(prior.get(prior.desktop,"_-2jo"));prior.frame();check(!prior.uploads.isEmpty(),"Did not execute old native background renderer");var obsolete=prior.uploads.get(0);check(Math.abs(obsolete.get(2)-((wanted>>16)&255)/255.0)>0.001&&num(prior.gradient.get("_-3-b"))==791578,"Teste61 overlay/mode failure not reproduced");
  var v=new V62(now);v.setupToner();Obj sameDesktop=v.desktop,sameView=v.view,sameGradient=v.gradient;
  for(int[] hsl:List.of(new int[]{85,255,127},new int[]{170,255,127},new int[]{0,0,255},new int[]{0,255,127},new int[]{42,133,200})){v.colorEvent(true,hsl[0],hsl[1],hsl[2]);v.switchRoomMode();v.assertDraw(num(v.get(v.desktop,"_-2jo")));check(v.desktop==sameDesktop&&v.view==sameView&&v.gradient==sameGradient,"Background recreated the room/view");}
  v.colorEvent(false,0,0,0);v.assertDraw(0);v.colorEvent(true,85,255,127);v.assertDraw(num(v.get(v.desktop,"_-2jo")));
  v.objectColorEvent(true,170,255,127);v.assertDraw(num(v.get(v.desktop,"_-2jo")));check(num(v.get(v.desktop,"_-2jo"))==num(v.appearance("rgb",170,255,127)),"Native furniture-to-room event route lost color");
  int disposed=v.bufferDisposals;v.colorEvent(true,170,255,127);check(v.bufferDisposals==disposed,"Identical color discarded GPU buffers again");
  var recovered=new Obj("gpu-context61");recovered.put("driverInfo","test recreated GPU boundary");recovered.put("profile","baseline");v.set(v.gradient,"context",recovered);v.proxy.put("_-In",recovered);v.assertDraw(num(v.get(v.desktop,"_-2jo")));check(v.view==sameView,"Context recovery recreated room view");
  var other=(Obj)v.construct(v.rawType(HSL),List.of("ROHSLCEE_ROOM_BACKGROUND_COLOR",999,false,0,0,0));int current=num(v.get(v.desktop,"_-2jo"));v.execute(v.method(HUI,"_-4P7"),v.hub,other);check(num(v.get(v.desktop,"_-2jo"))==current,"Old-room event repainted the current room");v.assertDraw(current);
  v.appearance("release",v.desktop);v.frame();check(num(v.gradient.get("_-3-b"))==527374&&num(v.gradient.get("_-0t"))==1318180,"Leaving room lost original gradient");
  var early=new V62(now);early.setupToner();early.hub.put("_-3x9",null);early.colorEvent(true,170,255,127);early.hub.put("_-3x9",early.desktop);early.appearance("mount",early.desktop,early.view,0);early.switchRoomMode();early.assertDraw(num(early.get(early.desktop,"_-2jo")));check(num(early.get(early.desktop,"_-2jo"))!=0,"Already-on Toner lost before desktop was created");
  for(int enabled:List.of(1,0,1)){early.furnitureData(enabled,85,255,127);int expected=enabled==0?0:num(early.appearance("rgb",85,255,127));check(num(early.get(early.desktop,"_-2jo"))==expected&&num(early.toner.get("state"))==enabled,"Native furniture path: enabled="+enabled+" expected="+expected+" actual="+num(early.get(early.desktop,"_-2jo"))+" state="+early.toner.get("state")+" objectEvents="+early.objectEvents+" roomEvents="+early.roomEvents+" model="+early.call(early.toner.get("model"),"getNumberArray",List.of("furniture_data")));early.assertDraw(expected);}
  System.out.println("PASS: reproduced61 native opaque room gradient/mode reset covering the clear color. Native context.root, MainViewManager room transition, CoreComponentContext and gradient vertex upload/draw follow five colors and off/on in one room/view. Actual integer-array data -> room model -> Toner logic -> object/room handlers reaches the same background. Early enabled state, return to room, GPU-context recovery, repeated-color buffer reuse, stale-room rejection and original-background restoration passed.");
 }
 static void doorMask(SWF old,SWF now)throws Exception{
  var a=new V62(old);var b=new V62(now);for(var v:List.of(a,b)){v.maskStore=new Obj("mask-store62");var logic=v.allocate(v.rawType(LOGIC));logic.put("_-uN",v.maskStore);var model=new Obj("mask-model62");var position=v.construct("_-0AB::Vector3d",List.of(3,3,0));var mask=v.allocate(v.rawType(MASK));v.execute(v.method(MASK,"<init>"),mask,"RORMUM_ADD_MASK","door_0","door",position,"hole");v.execute(v.method(LOGIC,"_-3uS"),logic,mask,model);}
  check(a.maskAdds.size()==1&&b.maskAdds.isEmpty(),"Door opening mask not removed or old failure not reproduced");
  var logic=b.allocate(b.rawType(LOGIC));logic.put("_-uN",b.maskStore);var mask=b.allocate(b.rawType(MASK));b.execute(b.method(MASK,"<init>"),mask,"RORMUM_ADD_MASK","window_1","window",b.construct("_-0AB::Vector3d",List.of(1,2,0)),"hole");b.execute(b.method(LOGIC,"_-3uS"),logic,mask,new Obj("mask-model62"));check(b.maskAdds.size()==1&&b.maskAdds.get(0).get(1).equals("window"),"Ordinary furniture/window mask removed");
  var furnitureDoor=b.allocate(b.rawType(MASK));b.execute(b.method(MASK,"<init>"),furnitureDoor,"RORMUM_ADD_MASK","furniture_555","door",b.construct("_-0AB::Vector3d",List.of(1,2,0)),"hole");b.execute(b.method(LOGIC,"_-3uS"),logic,furnitureDoor,new Obj("mask-model62"));check(b.maskAdds.size()==2,"Furniture-owned door mask removed with room entrance");
  var baseline=new V62(new SWF(new FileInputStream("work/HabboTablet_LoginSSO33.swf"),false));check(entrance(baseline,map(true,true,false))!=null&&entrance(b,map(true,true,false))==null,"Special entrance floor remains");
  for(boolean top:List.of(false,true)){String floor=map(true,!top,top);var x=baseline.room(floor);var y=b.room(floor);int px=top?6:3,py=top?0:3;check(number(baseline.call(x,"_-4-t",List.of(px,py)))==number(b.call(y,"_-4-t",List.of(px,py))),"World entrance geometry changed");check(number(b.call(y,"_-4-t",List.of(1,8)))==0,"Isolated tile raised");}
  System.out.println("PASS: actual native RoomLogic rejects only the door hole; old61 creates it, windows retain native masking, entrance coordinates/height, normal movement and isolated-floor regression retained.");
 }
 public static void main(String[]a)throws Exception{var old=new SWF(new FileInputStream(a[0]),false);var now=new SWF(new FileInputStream(a[1]),false);rendering(old,now);doorMask(old,now);System.out.println("PASS: appearance62; physical Android/GPU/server pending.");}
}

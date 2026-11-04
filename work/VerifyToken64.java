import java.io.*;import java.nio.file.*;import java.util.*;import java.time.*;
import com.jpexs.decompiler.flash.SWF;import com.jpexs.decompiler.flash.abc.types.traits.*;
class VerifyToken64 extends VerifyToken63 {
 static final String WEB="loginpatch:WebSession64";
 static class V64 extends V63 {
  int browserOpens;boolean browserLaunch;Object savedProfile;
  V64(SWF s)throws Exception{super(s);}
  @Override boolean ui(String n){return super.ui(n)||n.equals(rawType(PatchToken61.RENDERER));}
  @Override boolean own(String n){return super.own(n)||n.equals("loginpatch::WebSession64");}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(m.cls().logical().equals(WEB))for(var t:m.cls().abc().class_info.get(m.cls().index()).static_traits.traits)if(t instanceof TraitMethodGetterSetter&&n.equals(AuditStartup.name(m.cls().abc(),t.name_index)))return new Bound(new Ref(m.cls().raw()),n);
   return super.lexical(m,self,n,i);
  }
  @Override Object construct(String t,List<Object>a){
   if(t.equals("Date")&&a.size()>=3){var date=LocalDate.of(num(a.get(0)),num(a.get(1))+1,1).plusDays(num(a.get(2))-1).atStartOfDay(ZoneId.of("America/Sao_Paulo"));var d=new Obj("date61");d.put("time",(double)date.toInstant().toEpochMilli());return d;}
   if(t.equals("flash.display::Loader")||t.equals("Loader")){var loader=new Obj("loader64");loader.put("contentLoaderInfo",new Obj("loaderInfo64"));return loader;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&o.type.equals(rawType(PatchToken61.RENDERER))){if(k.equals("owner"))return o.get("_-ZD");if(k.equals("index"))return o.get("_index");if(k.equals("consoleText64")||k.equals("consoleBubble64"))return execute(method(PatchToken61.RENDERER,String.valueOf(k)),o);}
   return super.get(r,k);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::WebSession64")){
    if(n.equals("profile"))return savedProfile; // Persistent browser/profile I/O boundary.
    if(n.equals("open")){browserOpens++;browserLaunch=truth(a.get(1));return null;} // OS WebView boundary.
    return execute(method(WEB,n),staticObject(ref.name()),a.toArray());
   }
   if(r instanceof Obj o&&Set.of("loader64","loaderInfo64").contains(o.type)){if(n.equals("addEventListener")){o.put("listener:"+a.get(0),a.get(1));return null;}if(n.equals("removeEventListener")){o.remove("listener:"+a.get(0));return null;}if(n.equals("load")){o.put("request",a.get(0));return null;}if(Set.of("unload","close").contains(n))return null;}
   return super.call(r,n,a);
  }
  Object web(String n,Object...a){return execute(method(WEB,n),staticObject("loginpatch::WebSession64"),a);}
 }
 @SuppressWarnings("unchecked") static Obj button(Obj parent,String label){for(var child:(List<Obj>)parent.get("children"))if(label.equals(child.get("label")))return child;throw new AssertionError("Missing "+label);}
 static void click(V63 v,Obj button){check(button.get("listener:triggered") instanceof Bound,"Button has no real listener: "+button.get("label"));var registered=(Bound)button.get("listener:triggered");v.call(registered.receiver(),registered.name(),List.of(eventFor(button)));}
 @SuppressWarnings("unchecked") static void lighting64(SWF before,SWF now)throws Exception {
  var old=new V63(before);old.setupToner();old.execute(old.method(PatchToken63.EVENTS,"_-0dX"),old.handler,12345,777,10,0,false);var oldState=old.staticObject("loginpatch::RoomLighting63");check(button((Obj)oldState.get("_popup"),"Aplicar").get("listener:triggered")==null,"Original unbound Apply bug was not reproduced");
  var v=new V64(now);v.setupToner();v.execute(v.method(PatchToken63.EVENTS,"_-0dX"),v.handler,12345,777,10,0,false);var state=v.staticObject("loginpatch::RoomLighting63");var controls=(List<Obj>)state.get("_sliders");controls.get(0).put("value",170);v.lighting("changed",(Object)null);int sent=v.sent.size();click(v,button((Obj)state.get("_popup"),"Aplicar"));check(v.sent.size()==sent+1&&payload(v,v.sent.get(v.sent.size()-1)).equals(List.of(777,170,255,127)),"Actual Apply click did not send exact Toner fields");check(state.get("_popup")!=null&&num(state.get("_savingAt"))!=0,"Closed before server confirmation");
  ((Obj)v.toner.get("model")).put("furniture_room_background_color_hue",170);v.colorEvent(true,170,255,127);v.lighting("refresh",(Object)null);check(state.get("_popup")==null,"Matching native Toner state did not complete save");
  v.execute(v.method(PatchToken63.EVENTS,"_-0dX"),v.handler,12345,777,10,0,false);check(num(((List<Obj>)state.get("_sliders")).get(0).get("value"))==170,"Reopen lost server color");v.lighting("close",(Object)null);
  v.toner.put("logic63",new Obj("_-2mk::_-CC"));v.lighting("legacy",v.toner,"2,1,1,#74F5F5,127");v.execute(v.method(PatchToken63.EVENTS,"_-0dX"),v.handler,12345,777,10,0,false);
  check(((List<?>)state.get("_sliders")).size()==1&&((List<?>)state.get("_colorButtons")).size()==7,"Original dimmer controls missing");var brightness=((List<Obj>)state.get("_sliders")).get(0);check(num(brightness.get("minimum"))==76&&num(brightness.get("maximum"))==255,"Dimmer dark limit differs from Plus");
  click(v,((List<Obj>)state.get("_colorButtons")).get(6));brightness.put("value",0);v.lighting("changed",(Object)null);check(num(v.lightUpdates.get(v.lightUpdates.size()-1).get(2))==76,"Preview permits total darkness");click(v,button((Obj)state.get("_popup"),"Aplicar"));
  var message=v.sent.stream().map(x->payload(v,x)).filter(x->x.size()==7).reduce((a,b)->b).orElseThrow();check(message.equals(List.of(1,1,"#000000",76,true,false,777)),"Dimmer save wire differs from Plus: "+message);
  v.lighting("legacy",v.toner,"2,1,1,#000000,76");var packet=new Packet().i(3).i(1);for(int i=1;i<=3;i++)packet.i(i).i(1).s(i==1?"#000000":"#74F5F5").i(i==1?76:127);packet.b(true).i(777);var reader=new Reader(packet.bytes());v.call(v.construct(v.rawType(PatchToken63.PRESETS),List.of()),"parse",List.of(reader));check(reader.b.remaining()==0,"Native presets tail was not consumed");v.lighting("refresh",(Object)null);check(state.get("_popup")==null,"Preset confirmation did not close editor");
  System.out.println("PASS: reproduced63 unbound Apply; actual triggered events now send Toner and exact seven-field Plus dimmer payloads. Server updates confirm before close; reopen retains accepted color. Seven native colors, min76/255 for preview/save and complete preset response verified.");
 }
 @SuppressWarnings("unchecked") static void console64(SWF now)throws Exception {
  var v=new V64(now);var first=(Obj)v.construct(v.rawType(MESSAGE),List.of(2,200,"Mensagem çã 🎮",26*3600));var second=(Obj)v.construct(v.rawType(MESSAGE),List.of(1,100,"Outra mensagem",25*3600));var today=(Obj)v.construct(v.rawType(MESSAGE),List.of(2,200,"Nova",0));var old=(Obj)v.construct(v.rawType(MESSAGE),List.of(2,200,"Antiga",72*3600));
  check(v.c("text",first).equals("Mensagem çã 🎮")&&v.c("clock",first).equals("10:00"),"Body and clock not separated");check(v.c("day",first).equals("Ontem")&&v.c("day",today).equals("Hoje")&&v.c("day",old).equals("29/10"),"Calendar day captions incorrect");
  var collection=v.uiObject("_-1Ab::_-nO");collection.put("items",new ArrayList<>(List.of(first,second,today)));var list=v.uiObject("_-2xS::_-0xe");list.put("dataProvider",collection);var renderer=v.uiObject(v.rawType(PatchToken61.RENDERER));renderer.put("_-ZD",list);renderer.put("_index",0);renderer.put("width",900);var label=v.uiObject("_-2xS::_-Fk");label.put("y",20);renderer.put("_-3i2",label);var bubble=v.display("starling.display::Quad");bubble.put("height",100);bubble.put("width",260);bubble.put("x",0);renderer.put("_-2pq",bubble);
  check(truth(v.c("startsDay",renderer,first)),"First day badge missing");renderer.put("_index",1);check(!truth(v.c("startsDay",renderer,second)),"Repeated day badge on same day");renderer.put("_index",2);check(truth(v.c("startsDay",renderer,today)),"Day transition badge missing");v.c("decorate",renderer,today);var decorations=(Obj)((Map<?,?>)v.staticObject("loginpatch::Console61").get("_renderers")).get(renderer);check(decorations!=null&&((Obj)decorations.get("time")).get("text").equals("12:00")&&truth(((Obj)decorations.get("badge")).get("visible")),"Clock/day UI was not attached");
  v.c("rendererRemoved",eventFor(renderer));check(((Map<?,?>)v.staticObject("loginpatch::Console61").get("_renderers")).isEmpty(),"Recycled renderer retained children/references");v.advance(13*3600*1000);check(v.c("clock",today).equals("12:00")&&v.c("day",today).equals("Ontem"),"Stable time or midnight calendar rollover broken");
  pagination(now);
  System.out.println("PASS: raw Unicode body and small independent time label, one badge per calendar day (Hoje/Ontem/dd-MM), midnight rollover and renderer cleanup. Original pagination, cursor, unread, retry and deduplication regression passed.");
 }
 @SuppressWarnings("unchecked") static void login64(SWF now)throws Exception {
  var v=new V64(now);for(int[]size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2340,1080},new int[]{1280,800},new int[]{709,1536},new int[]{800,360},new int[]{640,360},new int[]{375,812})){
   var screen=v.create(size[0],size[1],"pt");var state=v.state(screen);var card=(Obj)state.get("card");var ui=(Obj)state.get("login62");contained(card,(Obj)state.get("root"),"card");check(Math.abs(number(card.get("x"))+number(card.get("width"))/2-size[0]/2.)<=1,"Card not centered");
   for(String key:List.of("title","instructions","login","website","country"))contained((Obj)state.get(key),card,key);for(String key:List.of("gear","accountTab","tokenTab","accountName","accountHint","head"))contained((Obj)ui.get(key),card,key);
   check(ui.get("mode").equals("account")&&!truth(((Obj)state.get("input")).get("visible")),"Account login not default");int browser=v.browserOpens;v.helper("tokenLoginAction",eventFor((Obj)state.get("login")));check(v.browserOpens==browser+1&&v.browserLaunch,"Primary Enter not connected to system browser session");
   click(v,(Obj)ui.get("tokenTab"));check(ui.get("mode").equals("token")&&truth(((Obj)state.get("input")).get("visible")),"Manual token option missing: mode="+ui.get("mode")+" visible="+((Obj)state.get("input")).get("visible")+" screen="+ui.get("screen")+" tabName="+((Obj)ui.get("tokenTab")).get("name"));for(String key:List.of("input"))contained((Obj)state.get(key),card,key);contained((Obj)ui.get("paste"),card,"paste");
   ((Obj)state.get("input")).put("text","hhbr.unit.ticket");int auth=v.authCalls;v.helper("tokenLoginAction",eventFor((Obj)state.get("login")));check(v.authCalls==auth+1&&v.submittedTicket.equals("unit.ticket"),"Original token authentication changed");v.helper("disposeTokenLogin",screen);
  }
  var screen=v.create(1536,709,"pt");var state=v.state(screen);v.login("fromSession",state,"hhbr.session.ticket");check(v.submittedTicket.equals("session.ticket")&&((Obj)state.get("input")).get("text").equals(""),"Browser ticket did not use original native login/clear sensitive field");
  var web=v.staticObject("loginpatch::WebSession64");web.put("_host","www.habbo.com.br");check(truth(v.web("trusted","https://www.habbo.com.br/home"))&&!truth(v.web("trusted","https://www.habbo.com.br.evil.example/"))&&!truth(v.web("trusted","http://www.habbo.com.br/")),"Browser origin validation too broad");
  System.out.println("PASS: centered smaller login at8 sizes, account/token tabs and existing preferences gear. Actual Enter callback opens browser; token route and browser-derived ticket use original33 validation/auth and clear the input. HTTPS exact-host checks reject lookalikes and insecure origins. OS WebView/network/cookies/2FA remain device boundaries.");
 }
 public static void main(String[]args)throws Exception {var before=new SWF(new FileInputStream(args[0]),false);var now=new SWF(new FileInputStream(args[1]),false);String mode=args.length>2?args[2]:"all";if(mode.equals("lighting")||mode.equals("all"))lighting64(before,now);if(mode.equals("console")||mode.equals("all"))console64(now);if(mode.equals("login")||mode.equals("all"))login64(now);if(mode.equals("render")||mode.equals("all"))rendering63(new SWF(new FileInputStream("work/HabboTablet_Token62_Base33.swf"),false),now);if(mode.equals("settings")||mode.equals("all"))settings63(now);if(mode.equals("door")||mode.equals("all"))door63(new SWF(new FileInputStream("work/HabboTablet_LoginSSO33.swf"),false),new SWF(new FileInputStream("work/HabboTablet_Token62_Base33.swf"),false),now);}
}

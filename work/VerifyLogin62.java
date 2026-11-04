import java.io.*;import java.nio.file.*;import java.util.*;
import com.jpexs.decompiler.flash.SWF;

// Native login screen and new saved AVM2 presentation run here. Clipboard,
// Feathers measurement, browser navigation and authentication I/O are boundaries.
class VerifyLogin62 extends VerifyAppearance62 {
 static final String L62="loginpatch:Login62";
 static class LoginVM extends V62 {
  int clipboardReads,authCalls;String submittedTicket="",openedUrl="";
  LoginVM(SWF s)throws Exception{super(s);}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("flash.net::URLRequest")||t.equals("URLRequest")){var request=new Obj("url-request62");request.put("url",a.get(0));return request;}
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Obj o&&((o.type.equals("fixture-login-controller19")&&k.equals("_-zP"))||(o.type.equals("auth-transport62")&&k.equals("_-1vv"))))return new Bound(r,String.valueOf(k));
   return super.get(r,k);
  }
  @Override boolean own(String t){return super.own(t)||t.equals("loginpatch::Login62");}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(m.cls().logical().equals(L62))for(var tr:m.cls().abc().class_info.get(m.cls().index()).static_traits.traits)if(tr instanceof com.jpexs.decompiler.flash.abc.types.traits.TraitMethodGetterSetter&&n.equals(AuditStartup.name(m.cls().abc(),tr.name_index)))return new Bound(new Ref(m.cls().raw()),n);
   return super.lexical(m,self,n,i);
  }
  @Override Object call(Object r,String n,List<Object>a){
   if(r instanceof Ref ref&&ref.name().equals("loginpatch::Login62"))return execute(method(L62,n),staticObject(ref.name()),a.toArray());
   if(r instanceof Obj o&&o.type.equals("clipboard-boundary")&&n.equals("getData"))clipboardReads++;
   if(r instanceof Obj o&&o.type.equals("fixture-login-controller19")&&n.equals("_-zP")){authCalls++;submittedTicket=String.valueOf(a.get(0));return null;}
   if(r instanceof Obj o&&o.type.equals("auth-transport62")&&n.equals("_-1vv"))return null;
   if(n.equals("navigateToURL")){openedUrl=String.valueOf(((Obj)a.get(0)).get("url"));return null;}
   return super.call(r,n,a);
  }
  Object login(String n,Object...a){return execute(method(L62,n),staticObject("loginpatch::Login62"),a);}
  @SuppressWarnings("unchecked") Obj create(int w,int h,String hotel){
   stage.put("stageWidth",w);stage.put("stageHeight",h);var controller=new Obj("fixture-login-controller19");controller.put("environment.id",hotel);controller.put("communication",new Obj("auth-transport62"));var view=new Obj("fixture-login-view19");
   var screen=uiObject(rawType(PatchOldLogin.SCREEN));screen.put("_controller",controller);screen.put("_-ZU",view);
   execute(method(PatchOldLogin.SCREEN,"initializeHandler"),screen,eventFor(screen));execute(method(PatchOldLogin.SCREEN,"onAddedToStage"),screen,eventFor(screen));
   return screen;
  }
  @SuppressWarnings("unchecked") Obj state(Obj screen){return (Obj)((Map<?,?>)statics.get("_tokenScreens")).get(screen);}
 }
 static void contained(Obj child,Obj parent,String name){
  for(String axis:List.of("x","y")){double pos=number(child.get(axis)),size=number(child.get(axis.equals("x")?"width":"height")),limit=number(parent.get(axis.equals("x")?"width":"height"));check(Double.isFinite(pos)&&Double.isFinite(size)&&pos>=-0.1&&size>0&&pos+size<=limit+0.6,"Login control clipped: "+name+" "+axis+" "+pos+"/"+size+" in "+limit);}
 }
 @SuppressWarnings("unchecked") static void presentation(SWF now)throws Exception{
  var v=new LoginVM(now);
  for(int[] size:List.of(new int[]{1536,709},new int[]{960,540},new int[]{2400,1080},new int[]{1280,800},new int[]{709,1536},new int[]{800,360},new int[]{640,360})){
   var screen=v.create(size[0],size[1],"pt");var state=v.state(screen);check(state!=null&&state.get("login62")!=null,"Native screen did not build Login62");
   Obj root=(Obj)state.get("root"),card=(Obj)state.get("card"),country=(Obj)state.get("country"),extra=(Obj)state.get("login62"),input=(Obj)state.get("input");
   check(((List<?>)root.get("children")).size()==1,"Duplicate login card or detached hotel button");contained(card,root,"card");
   check(Math.abs(number(card.get("x"))+number(card.get("width"))/2-size[0]/2.)<1,"Login card not centered");
   for(String key:List.of("title","instructions","input","login","website","country"))contained((Obj)state.get(key),card,key);
   for(String key:List.of("paste","badge","caption","separator"))contained((Obj)extra.get(key),card,key);
   check(truth(input.get("visible"))&&truth(input.get("displayAsPassword"))&&num(input.get("maxChars"))==8192,"Token field hidden/unmasked/unbounded");
   check(number(((Obj)extra.get("paste")).get("x"))>=number(input.get("x"))+number(input.get("width")),"Paste button overlaps token field");
   check(((Obj)state.get("login")).get("label").equals("Entrar")&&((Obj)state.get("website")).get("label").equals("Obter token no site"),"Wide-button captions survived");
   check(country.get("parent")==card&&country.get("label").equals("BR ▾")&&country.get("defaultIcon")==state.get("icon"),"Compact hotel selector missing");
   var paste=(Obj)extra.get("paste");v.clipboard="  hhbr.unit.ticket  ";int reads=v.clipboardReads;v.login("pasteToken",eventFor(paste));check(input.get("text").equals("hhbr.unit.ticket")&&v.clipboardReads==reads+1&&v.authCalls==0,"Paste must fill the field only");
   int changes=v.countryChanges;v.helper("tokenHotelAction",eventFor(country));check(v.countryChanges==changes+1,"Hotel selector lost original native route");
   int children=((List<?>)card.get("children")).size();v.helper("layoutTokenLogin",screen);check(((List<?>)card.get("children")).size()==children,"Resize duplicated login controls");
   v.helper("disposeTokenLogin",screen);check(!((Map<?,?>)v.statics.get("_tokenScreens")).containsKey(screen)&&input.get("text").equals(""),"Disposed login retains token/state");
   var controls=(Map<?,?>)v.staticObject("loginpatch::Login62").get("_controls");check(!controls.containsKey(input)&&!controls.containsKey(paste),"Login callbacks leaked");
  }
  for(String hotel:List.of("pt","en","de","fr","es","it","nl","fi","tr")){var screen=v.create(960,540,hotel);var state=v.state(screen);check(!String.valueOf(((Obj)state.get("title")).get("text")).isBlank(),"Missing hotel translation");v.helper("disposeTokenLogin",screen);}
  System.out.println("PASS: native LoginScreen builds the responsive card at7 landscape/portrait sizes; visible masked token, separate paste, primary enter, compact hotel flag, site action, nine hotel translations, resize without duplication and disposal without retained token/callbacks.");
 }
 static void actions(SWF now)throws Exception{
  var v=new LoginVM(now);var screen=v.create(1536,709,"pt");var state=v.state(screen);var input=(Obj)state.get("input");var primary=(Obj)state.get("login");
  input.put("text","hhbr.unit.ticket");v.clipboard="hhus.wrong.hotel";int reads=v.clipboardReads;v.helper("tokenLoginAction",eventFor(primary));check(v.authCalls==1&&v.submittedTicket.equals("unit.ticket")&&v.clipboardReads==reads&&input.get("text").equals(""),"Typed token was replaced by clipboard or changed by new UI");
  input.put("text","hhbr.enter.ticket");v.login("entered",eventFor(input));check(v.authCalls==2&&v.submittedTicket.equals("enter.ticket"),"Keyboard Enter lost native token authentication");
  input.put("text","");v.clipboard="hhbr.clipboard.ticket";v.helper("tokenLoginAction",eventFor(primary));check(v.authCalls==3&&v.submittedTicket.equals("clipboard.ticket"),"Original empty-field clipboard shortcut removed");
  int count=v.authCalls;input.put("text","hhus.wrong.hotel");v.helper("tokenLoginAction",eventFor(primary));check(v.authCalls==count&&v.calls.stream().anyMatch(x->x.startsWith("alert:")),"Foreign-hotel token accepted");
  v.clipboard="x".repeat(8193);input.put("text","");v.login("pasteToken",eventFor((Obj)((Obj)state.get("login62")).get("paste")));check(input.get("text").equals("")&&v.authCalls==count,"Oversized paste truncated into an accepted token");
  v.helper("tokenWebsiteAction",eventFor((Obj)state.get("website")));check(v.openedUrl.contains("https://www.habbo.com.br/settings/avatars"),"Site link lost selected hotel");
  v.helper("disposeTokenLogin",screen);
  System.out.println("PASS: typed token and keyboard Enter use original Teste33 validation/authentication, typed text takes precedence over clipboard, empty-field shortcut retained, wrong hotel/oversized paste rejected and selected-hotel website preserved. No automatic login added.");
 }
 public static void main(String[]a)throws Exception{var now=new SWF(new FileInputStream(a[0]),false);presentation(now);actions(now);System.out.println("PASS: login62; real keyboard/font/device validation pending.");}
}

import java.io.*;import java.nio.file.*;import java.util.*;import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import com.jpexs.decompiler.flash.SWF;

// Saved AVM2 executes unchanged. Android clipboard, GPU textures, native text
// rasterization and services are explicit boundaries, never a real account.
class VerifyFeatures19 extends VerifyFeatures18 {
 static final String PURSE19=PatchFeatures19.PURSE,UTILS19=PatchFeatures19.UTILS;
 static class VM19 extends FeatureVM {
  final Obj loginPrefs=new Obj("login-preferences"),loginData=new Obj("Object");
  final Obj textureManager=new Obj("portrait-textures"),avatarRenderer=new Obj("portrait-renderer");
  final List<Obj> avatarsMade=new ArrayList<>();final Map<String,Obj> portraitCache=new HashMap<>();
  Object clipboard="";int countryChanges=0;final List<String> warmHotels=new ArrayList<>();
  VM19(SWF swf){super(swf);loginPrefs.put("data",loginData);}
  @Override Object lexical(Method m,Obj self,String n,int i){
   if(self.type.equals("fixture-catalog19")&&n.equals("events"))return self.get("events");
   if(n.equals("SharedObject"))return new Ref("flash.net::SharedObject");
   if(n.equals("Clipboard"))return new Ref("flash.desktop::Clipboard");
   if(n.equals("Array")||n.equals("Object"))return new Ref(n);
   return super.lexical(m,self,n,i);
  }
  @Override boolean ui(String t){return super.ui(t)||t.equals(rawType(PURSE19))||t.equals(rawType(PatchOldLogin.SCREEN));}
  @Override Object construct(String t,List<Object>a){
   if(t.equals("flash.display::BitmapData")){
    var o=new Obj(t);int w=num(a.get(0)),h=num(a.get(1));o.put("width",w);o.put("height",h);o.put("image",new BufferedImage(w,h,BufferedImage.TYPE_INT_ARGB));return o;
   }
   if(t.equals("loginpatch::UiAtlas19")){
    try{var o=new Obj(t);var bitmap=new Obj("flash.display::BitmapData");var img=ImageIO.read(Path.of("work/UiAtlas19.png").toFile());bitmap.put("image",img);bitmap.put("width",img.getWidth());bitmap.put("height",img.getHeight());o.put("bitmapData",bitmap);check(raw.containsKey(t),"UI atlas class absent");return o;}catch(IOException e){throw new RuntimeException(e);}
   }
   if(t.equals("starling.display::Image")){
    var o=display(t);var tex=(Obj)a.get(0);o.put("texture",tex);o.put("scaleX",1.0);o.put("scaleY",1.0);o.put("width",tex.get("width"));o.put("height",tex.get("height"));return o;
   }
   return super.construct(t,a);
  }
  @Override Object get(Object r,Object k){
   if(r instanceof Ref ref){
    if(ref.name().equals("Array")&&k.equals("NUMERIC"))return 16;
    if(ref.name().equals("_-0zo::_-1Tv")&&k.equals("_-0R5"))return textureManager;
    if(ref.name().equals("flash.desktop::Clipboard")&&k.equals("generalClipboard"))return new Obj("clipboard-boundary");
   }
   if(r instanceof Obj o){
    if(o==textureManager&&Set.of("_-4nG","_-0OO").contains(k))return new Bound(o,String.valueOf(k));
    if(o==avatarRenderer&&Set.of("_-2YV","_-0VM","_-4QF").contains(k))return new Bound(o,String.valueOf(k));
    if(o.type.equals("fixture-purse19")&&k.equals("_-4CK"))return new Bound(o,String.valueOf(k));
    if(o.type.equals("fixture-catalog19")&&Set.of("_-119","_-0ik","_-0Tj","_-3BY").contains(k))return new Bound(o,String.valueOf(k));
    if((ui(o.type)||scene(o.type))&&Set.of("textRendererProperties","defaultLabelProperties").contains(k)){valid(o,k);return o.computeIfAbsent(k,key->new Obj("text-properties"));}
    if(o.type.equals("starling.display::Image")&&(k.equals("width")||k.equals("height"))){var tex=(Obj)o.get("texture");return number(tex.get(k))*number(o.get(k.equals("width")?"scaleX":"scaleY"));}
    if(o.type.equals("flash.geom::Rectangle")&&k.equals("bottom"))return number(o.get("y"))+number(o.get("height"));
    if(o.type.equals("fixture-purse19")&&k.equals("_-vM"))return o.get("points");
   }
   return super.get(r,k);
  }
  @SuppressWarnings("unchecked") @Override Object call(Object r,String n,List<Object>a){
   if(n.equals("getDefinitionByName")&&Set.of("starling.textures::Texture","HitchTheme").contains(String.valueOf(a.get(0))))return new Ref(a.get(0).equals("HitchTheme")?"::HitchTheme":String.valueOf(a.get(0)));
   if(r instanceof Ref ref){
    if(ref.name().equals("flash.net::SharedObject")&&n.equals("getLocal")){if(a.get(0).equals("fuselogin"))return loginPrefs;}
    if(ref.name().equals("_-309::_-2Yt"))return execute(method(UTILS19,n),staticObject(ref.name()),a.toArray());
    if(ref.name().equals("Math")&&(n.equals("ceil")||n.equals("floor")))return n.equals("ceil")?Math.ceil(number(a.get(0))):Math.floor(number(a.get(0)));
    if(ref.name().equals("starling.textures::Texture")&&n.equals("fromBitmapData")){var b=(Obj)a.get(0);var tex=new Obj("texture-boundary");tex.put("width",b.get("width"));tex.put("height",b.get("height"));tex.put("image",b.get("image"));return tex;}
    if(ref.name().equals("::HitchTheme")&&n.equals("getTexture")){var tex=new Obj("texture-boundary");tex.put("width",24);tex.put("height",24);tex.put("name",a.get(0));return tex;}
   }
   if(r instanceof List list&&n.equals("sort")){list.sort(Comparator.comparingInt(VerifyStartupCompatibility::num));return list;}
   if(r instanceof Obj o){
    if(o.type.equals(rawType(PURSE19))&&n.equals("onAddedToStage"))return execute(method(PURSE19,n),o,a.toArray());
    if(o==loginPrefs&&n.equals("flush"))return "flushed";
    if(o.type.equals("ui-styles")&&n.equals("remove"))return true;
    if((ui(o.type)||scene(o.type))&&n.equals("getChildByName")){valid(o,n);for(var child:(List<Obj>)o.get("children"))if(Objects.equals(child.get("name"),a.get(0)))return child;return null;}
    if((ui(o.type)||scene(o.type))&&n.equals("validate")){
     valid(o,n);
     if(o.type.equals("_-2xS::_-Fk")){var props=(Obj)o.get("textRendererProperties");var format=props==null?null:(Obj)props.get("textFormat");double size=format==null?20:number(format.get("size"));o.put("width",Math.min(number(o.getOrDefault("maxWidth",10000)),String.valueOf(o.getOrDefault("text","")).length()*size*.55));o.put("height",size*1.2);}
     else if(!o.containsKey("width")||!o.containsKey("height")){double w=0,h=0;for(var child:(List<Obj>)o.get("children")){call(child,"validate",List.of());w=Math.max(w,number(child.get("x"))+number(get(child,"width")));h=Math.max(h,number(child.get("y"))+number(get(child,"height")));}o.putIfAbsent("width",w);o.putIfAbsent("height",h);}
     return null;
    }
    if(o.type.equals("flash.display::BitmapData")){
     var image=(BufferedImage)o.get("image");
     if(n.equals("copyPixels")){
      var source=(Obj)a.get(0);var src=(BufferedImage)source.get("image");var rect=(Obj)a.get(1);var point=(Obj)a.get(2);
      if(src!=null&&image!=null)for(int y=0;y<num(rect.get("height"));y++)for(int x=0;x<num(rect.get("width"));x++){
       int sx=x+num(rect.get("x")),sy=y+num(rect.get("y")),dx=x+num(point.get("x")),dy=y+num(point.get("y"));
       if(sx>=0&&sy>=0&&sx<src.getWidth()&&sy<src.getHeight()&&dx>=0&&dy>=0&&dx<image.getWidth()&&dy<image.getHeight())image.setRGB(dx,dy,src.getRGB(sx,sy));
      }
      o.put("source",rect);copied.add(o);return null;
     }
     if(n.equals("getColorBoundsRect")){
      int minX=image.getWidth(),minY=image.getHeight(),maxX=-1,maxY=-1;
      for(int y=0;y<image.getHeight();y++)for(int x=0;x<image.getWidth();x++)if((image.getRGB(x,y)>>>24)!=0){minX=Math.min(minX,x);minY=Math.min(minY,y);maxX=Math.max(maxX,x);maxY=Math.max(maxY,y);}
      return construct("flash.geom::Rectangle",List.of(minX,minY,Math.max(0,maxX-minX+1),Math.max(0,maxY-minY+1)));
     }
     if(n.equals("dispose")){o.put("disposed",true);return null;}
    }
    if(o==textureManager){
     if(n.equals("_-4nG"))return portraitCache.get(String.valueOf(a.get(0)));
     if(n.equals("_-0OO")){var source=(Obj)a.get(1);var copy=new Obj("cached-portrait");var image=(BufferedImage)source.get("image");copy.put("image",image);copy.put("width",image.getWidth());copy.put("height",image.getHeight());portraitCache.put(String.valueOf(a.get(0)),copy);return copy;}
    }
    if(o==avatarRenderer){
     if(n.equals("_-2YV"))return a.get(0);if(n.equals("_-0VM"))return true;
     if(n.equals("_-4QF")){var avatar=new Obj("portrait-avatar");avatar.put("figure",a.get(0));var full=(Obj)construct("flash.display::BitmapData",List.of(64,110,true,0));var image=(BufferedImage)full.get("image");for(int y=25;y<49;y++)for(int x=23;x<43;x++)image.setRGB(x,y,0xffffbb88);
      if(String.valueOf(a.get(0)).contains("hr-")){for(int y=0;y<100;y++)for(int x=0;x<64;x++)if(x<18||x>48)image.setRGB(x,y,0xff445566);}
      avatar.put("bitmap",full);avatarsMade.add(avatar);return avatar;}
    }
    if(o.type.equals("portrait-avatar")){if(n.equals("getImage"))return o.get("bitmap");if(n.equals("appendAction"))return true;if(n.equals("dispose")){o.put("disposed",true);return null;}}
    if(o.type.equals("fixture-purse19")&&n.equals("_-4CK"))return ((Map<?,?>)o.get("points")).getOrDefault(num(a.get(0)),null)==null?0:((Map<?,?>)o.get("points")).get(num(a.get(0)));
    if(o.type.equals("fixture-catalog19")){
     if(n.equals("_-119"))return o.get("purse");
     if(n.equals("_-0ik")){calls.add("subscribe-purse");return null;}
     if(n.equals("_-0Tj")){calls.add("unsubscribe-purse");return null;}
     if(n.equals("_-1tD")){for(var widget:((Map<?,?>)statics.get("_purseBars")).keySet())helper("updatePurseBar",widget);return null;}
     if(n.equals("_-3BY")){calls.add("catalog-link:"+a);return null;}
    }
    if(o.type.equals("fixture-balance-events19")&&n.equals("dispatchEvent")){calls.add("balance-event");return true;}
    if(o.type.equals("fixture-login-controller19")){
     if(n.equals("forgetUserLoginCredentials"))return execute(method(PatchOldLogin.DEMO,n),o);
     if(n.equals("getProperty"))return o.get(a.get(0));
     if(n.equals("alert")){calls.add("alert:"+a.get(0));return null;}
    }
    if(o.type.equals("fixture-login-view19")&&n.equals("showEnvironmentSelect")){countryChanges++;return null;}
    if(o.type.equals("fixture-login-view19")&&n.equals("applyEnvironment")){warmHotels.add(String.valueOf(a.get(0)));return null;}
    if(o.type.equals("clipboard-boundary")&&n.equals("getData"))return clipboard;
   }
   return super.call(r,n,a);
  }
 }
 static void verifyLogin(VM19 vm){
  for(String hotel:List.of("pt","en","fr")){
   vm.loginData.put("environment",hotel);vm.loginData.put("autologin",true);vm.loginData.put("password","obsolete");
   vm.execute(vm.method(UTILS19,"_-2eQ"),vm.staticObject("_-309::_-2Yt"));
   check(hotel.equals(vm.loginData.get("environment")),"Hotel erased with credentials");check(vm.loginData.get("password")==null&&vm.loginData.get("autologin")==null,"Credentials were retained");
  }
  var root=vm.uiObject("_-2xS::_-4Mu");var input=vm.uiObject("_-2xS::_-1XI");var pass=vm.uiObject("_-2xS::_-1XI");var remember=vm.uiObject("_-2xS::_-00s");var row=vm.uiObject("_-2xS::LayoutGroup");var cancel=vm.uiObject("_-2xS::Button");var login=vm.uiObject("_-2xS::Button");var web=vm.uiObject("_-2xS::Button");var oldFooter=vm.uiObject("_-2xS::LayoutGroup");var rem=vm.uiObject("_-2xS::LayoutGroup");
  vm.call(row,"addChild",List.of(cancel));vm.call(row,"addChild",List.of(login));vm.call(rem,"addChild",List.of(remember));
  for(var child:List.of(input,pass,rem,row,web,oldFooter))vm.call(root,"addChild",List.of(child));
  var ctrl=new Obj("fixture-login-controller19");ctrl.put("environment.id","pt");var title=vm.uiObject("_-2xS::_-Fk");var instructions=vm.uiObject("_-2xS::_-Fk");
  vm.helper("configure",input,pass,remember,login,web,title,instructions,ctrl);
  check(Boolean.FALSE.equals(input.get("visible"))&&Boolean.FALSE.equals(input.get("includeInLayout")),"Token field remains in layout");check(Boolean.FALSE.equals(cancel.get("visible")),"Red cancel remains");check(Boolean.FALSE.equals(oldFooter.get("includeInLayout")),"Old create-account footer remains");check(login.get("label").equals("Colar código e entrar"),"Paste action lost");
  for(int[] size:List.of(new int[]{1440,720},new int[]{2400,1080},new int[]{1280,800})){
   vm.stage.put("stageWidth",size[0]);vm.stage.put("stageHeight",size[1]);var screen=vm.uiObject(vm.rawType(PatchOldLogin.SCREEN));var icon=vm.uiObject("_-2xS::_-1aX");vm.call(root,"addChild",List.of(icon));var view=new Obj("fixture-login-view19");
   vm.helper("decorateLogin",screen,view,icon);vm.helper("decorateLogin",screen,view,icon);var button=(Obj)vm.call(screen,"getChildByName",List.of("login-hotel-flag"));
   check(((List<?>)screen.get("children")).size()==1&&button.get("defaultIcon")==icon,"Flag duplicated or lost icon");var anchor=(Obj)button.get("layoutData");check(number(anchor.get("left"))>0&&number(anchor.get("top"))>0,"Flag not in top corner");vm.helper("changeLoginHotel",eventFor(button));
  }
  check(vm.countryChanges==3,"Flag does not open hotel selector");vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);
  ctrl.put("_-ZU",new Obj("fixture-login-view19"));
  for(String hotel:List.of("pt","en","fr")){vm.loginData.put("environment",hotel);vm.execute(vm.method(PatchOldLogin.DEMO,"_-2m5"),ctrl);}
  check(vm.warmHotels.equals(List.of("pt","en","fr")),"Native warm startup ignores remembered hotel");
  vm.loginData.put("environment",null);vm.execute(vm.method(PatchOldLogin.DEMO,"_-2m5"),ctrl);check(vm.countryChanges==4,"First run no longer offers hotel selection");
  vm.clipboard="";vm.helper("login",ctrl,input);check(vm.calls.stream().anyMatch(x->x.startsWith("alert:")),"Missing token is not explained");
  System.out.println("PASS: Native credential clearing retains each selected hotel, clears password/autologin; clipboard-only login hides token/cancel/footer; one corner flag opens native country selector at three viewports.");
 }
 static void verifyHeads(VM19 vm)throws Exception{
  var context=new Obj("chat-context");context.put("_-3lM",vm.avatarRenderer);
  var bubble=new Obj(vm.rawType(BUBBLE));bubble.put("_-4Fr",context);
  vm.execute(vm.method(BUBBLE,"_-2PC"),bubble,"portrait-fixture","hd-180-1.hr-999999-1.ha-999999-1","sml");
  var portrait=vm.portraitCache.get("portrait-fixture");check(portrait!=null&&num(portrait.get("width"))==36&&num(portrait.get("height"))==36,"Portrait was not cropped");var image=(BufferedImage)portrait.get("image");check(image.getRGB(18,18)==0xffffbb88,"Face is no longer centered");check(vm.avatarsMade.stream().allMatch(o->Boolean.TRUE.equals(o.get("disposed"))),"Avatar renderer leaked");int made=vm.avatarsMade.size();vm.helper("cacheChatFace",context,"portrait-fixture","hd-180-1.hr-999999-1",null,bubble);check(vm.avatarsMade.size()==made,"Cached portrait regenerated");
  ImageIO.write(image,"png",Path.of("work/feature19/portrait-fixture.png").toFile());
  for(int dpi:List.of(1,2,3))for(int height:List.of(28,70,160)){
   vm.dpi=dpi;var texture=new Obj("texture-boundary");texture.put("width",36);texture.put("height",36);var icon=(Obj)vm.construct("starling.display::Image",List.of(texture));
   var style=new Obj("style-double");var anchor=new Obj("point");anchor.put("x",13*dpi);style.put("_-ES",anchor);var margin=new Obj("rect");margin.put("x",28*dpi);style.put("textFieldMargins",margin);var back=new Obj("style-bg");var tex=new Obj("texture-boundary");tex.put("height",28);back.put("texture",tex);style.put("background",back);
   var bg=new Obj("bubble-bg");bg.put("height",height*dpi);check(Boolean.TRUE.equals(vm.helper("positionChatIcon",icon,style,bg)),"Avatar path not handled");
   check(number(icon.get("x"))>=0&&number(icon.get("x"))+number(vm.get(icon,"width"))<=28*dpi,"Head extends outside face slot");
   eq(number(icon.get("x"))+number(vm.get(icon,"width"))/2,13*dpi,"Head horizontal anchor wrong");check(number(vm.get(icon,"height"))<=24*dpi,"Head overflows vertically");
   style.put("_-0iM",new Obj("bitmap"));vm.helper("positionChatIcon",icon,style,bg);check(num(icon.get("scaleX"))==dpi,"Static icon inherits portrait crop scale");
   style.put("_-ES",null);vm.helper("positionChatIcon",icon,style,bg);check(Boolean.FALSE.equals(icon.get("visible")),"Anonymous style shows pooled face");
  }
  System.out.println("PASS: Native head-cache entry crops 36px portraits around skin/face, ignores huge accessory bounds, reuses cache/disposes renderers; 1x/2x/3x face anchors stay inside the bubble; notification/avatar pool resets hold.");
 }
 static Obj makeUi(VM19 vm){
  var ui=new Obj("fixture-ui19");var catalog=new Obj("fixture-catalog19");var communication=new Obj("fixture-communication");communication.put("connection",new Obj("fixture-connection"));catalog.put("communication",communication);
  var purse=new Obj("fixture-purse19");purse.put("credits",0);purse.put("points",new LinkedHashMap<Integer,Integer>(Map.of(0,3109,5,0)));purse.put("_-0em",33*1440);catalog.put("purse",purse);catalog.put("_-3R6",16*86400);ui.put("catalog",catalog);ui.put("communication",communication);return ui;
 }
 @SuppressWarnings("unchecked") static void verifyCurrencies(VM19 vm,SWF plus)throws Exception{
  var table=PatchOldLogin.currentTables(plus);check(table.get("_composers").get("com.sulake.habbo.communication.messages.outgoing.inventory.purse:GetCreditsInfoComposer")==1664,"Credit header differs from reference");
  var ui=makeUi(vm);var catalog=(Obj)ui.get("catalog");var purse=(Obj)catalog.get("purse");var widget=vm.uiObject(vm.rawType(PURSE19));widget.put("_-33k",ui);vm.execute(vm.method(PURSE19,"createView"),widget);vm.call(widget,"dispatchEventWith",List.of("addedToStage"));
  check(vm.sent.get(vm.sent.size()-1).type.equals("loginpatch::CreditsInfoPayload")&&payload(vm,vm.sent.get(vm.sent.size()-1)).isEmpty(),"No typed credit query");int sent=vm.sent.size();vm.helper("requestCredits",catalog);check(vm.sent.size()==sent,"Credit query repeated immediately");
  var entries=(List<Obj>)vm.helper("purseBalances",ui);check(entries.size()==5&&entries.get(0).get("value").equals("…"),"Unknown balance falsely displayed as zero");
  String parser=msg("parser.inventory.purse:CreditBalanceParser");var balance=(Obj)vm.construct(vm.rawType(parser),List.of());vm.execute(vm.method(parser,"parse"),balance,new Reader(new Packet().s("9.0").bytes()));int credits=num(vm.get(balance,"balance"));check(credits==9,"Actual string balance parser loses 9.0");
  var event=new Obj(vm.rawType(msg("incoming.inventory.purse:CreditBalanceEvent")));event.put("parser",balance);catalog.put("_-38H",purse);catalog.put("events",new Obj("fixture-balance-events19"));vm.execute(vm.method(CATALOG,"_-3ly"),catalog,event);
  check(num(purse.get("credits"))==9&&Boolean.TRUE.equals(((Map<?,?>)vm.statics.get("_creditReady")).get(purse)),"Native credit callback does not update the model");
  entries=(List<Obj>)vm.helper("purseBalances",ui);check(entries.get(0).get("value").equals("9"),"Credit balance not reflected");check(entries.stream().filter(x->x.get("key").equals("points:0")).count()==1,"Duckets duplicated");
  var points=(Map<Integer,Integer>)purse.get("points");for(int id:List.of(3,101,102,103,104,105,999))points.put(id,id+10);
  vm.helper("initCurrencyProtocol",3177,920);vm.helper("interceptAccountPacket",new AccountReader(3177,new Packet().i(25).bytes()),((Obj)ui.get("communication")).get("connection"));vm.helper("interceptAccountPacket",new AccountReader(920,new Packet().i(11).bytes()),((Obj)ui.get("communication")).get("connection"));
  entries=(List<Obj>)vm.helper("purseBalances",ui);check(entries.size()==14,"Additional currencies omitted");check(entries.stream().filter(x->x.get("key").equals("silver")&&x.get("value").equals("25")).count()==1,"Silver not shown");
  check(entries.stream().filter(x->x.get("key").equals("emerald")&&x.get("value").equals("11")).count()==1,"Emerald not shown");
  for(int[] size:List.of(new int[]{1440,720},new int[]{2400,1080},new int[]{1280,800})){
   vm.stage.put("stageWidth",size[0]);vm.stage.put("stageHeight",size[1]);vm.helper("updatePurseBar",widget);
   var state=(Obj)((Map<?,?>)vm.statics.get("_purseBars")).get(widget);var content=(Obj)state.get("content");
   check(number(widget.get("width"))<size[0],"Purse extends beyond screen");for(var cell:(List<Obj>)content.get("children"))check(number(cell.get("x"))+number(cell.get("width"))<=number(widget.get("width"))+.01&&number(cell.get("y"))+number(cell.get("height"))<=number(widget.get("height"))+.01,"Currency cell leaves bar");
  }
  vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);vm.helper("resetAccountState");check(((Map<?,?>)vm.statics.get("_extraBalances")).isEmpty()&&((Map<?,?>)vm.statics.get("_creditReady")).isEmpty(),"New account sees previous balance");
  System.out.println("PASS: Typed 1664 query, coalescing and real CreditBalanceParser preserve 9.0 -> 9; one Duckets cell, 14 distinct currencies/statuses fit three viewports; silver/emerald packets and account reset work.");
 }
 @SuppressWarnings("unchecked") static void verifyEarnings(VM19 vm)throws Exception{
  vm.helper("initAccountProtocol",1915,3112,3624,3820);var ui=makeUi(vm);var menu=new Obj("_-4Fj::_-Bx");var item=new Obj("item");item.put("id",18001);check(Boolean.FALSE.equals(vm.helper("featureMenuSelected",menu,ui,item)),"Privacy is still offered");item.put("id",18002);
  for(int[] size:List.of(new int[]{1440,720},new int[]{2400,1080},new int[]{1280,800})){
   vm.stage.put("stageWidth",size[0]);vm.stage.put("stageHeight",size[1]);vm.statics.put("_accountUi",ui);vm.statics.put("_accountConnection",((Obj)ui.get("communication")).get("connection"));vm.helper("showEarnings");
   var packet=new Packet().i(2);packet.out.writeByte(1);packet.out.writeByte(0);packet.i(5).s("");packet.out.writeByte(5);packet.out.writeByte(1);packet.i(9).s("");
   vm.helper("interceptAccountPacket",new AccountReader(1915,packet.bytes()),((Obj)ui.get("communication")).get("connection"));
   var root=(Obj)vm.statics.get("_accountPopup");var rows=(Obj)vm.statics.get("_incomeRows");check(number(root.get("width"))>=size[0]*.8&&number(root.get("height"))<=size[1],"Earnings remains narrow or leaves viewport");
   check(((List<?>)rows.get("children")).size()==14,"Missing reward categories");for(var row:(List<Obj>)rows.get("children")){check(number(row.get("height"))>=54*(size[1]/720.),"Rows remain compact");var name=(Obj)((List<?>)row.get("children")).get(0);check(((List<?>)name.get("children")).get(0) instanceof Obj icon&&icon.type.equals("starling.display::Image"),"Reward category icon missing");}
   var buttons=(Map<Object,Object>)vm.statics.get("_incomeButtons");Obj daily=null;for(var entry:buttons.entrySet())if(num(entry.getValue())==1)daily=(Obj)entry.getKey();check(daily!=null&&Boolean.TRUE.equals(daily.get("isEnabled")),"Real daily reward disabled");int before=vm.sent.size();vm.helper("claimIncome",eventFor(daily));vm.helper("claimIncome",eventFor(daily));check(vm.sent.size()==before+1,"Duplicate claim allowed");
   var ack=new Packet();ack.out.writeByte(1);ack.b(true);vm.helper("interceptAccountPacket",new AccountReader(3112,ack.bytes()),((Obj)ui.get("communication")).get("connection"));vm.helper("closeAccountPanel",(Object)null);
  }
  vm.stage.put("stageWidth",1440);vm.stage.put("stageHeight",720);
  System.out.println("PASS: Wide earnings panel, 14 spacious icon rows, visible reward amounts, enabled real claims and duplicate protection work at three viewports; obsolete Privacy menu handler is disabled.");
 }
 @SuppressWarnings("unchecked") static void verifyMenu(SWF current){
  var vm=new MenuVM(current);for(int accounts:List.of(1,2)){
   var menu=vm.uiObject(vm.rawType(HMENU));var ui=new Obj("fixture-ui");var session=new Obj("fixture-session");session.put("_-1XO",new ArrayList<>(Collections.nCopies(accounts,new Obj("avatar"))));ui.put("sessionDataManager",session);menu.put("_-33k",ui);menu.put("_icon",vm.uiObject("_-2xS::_-1aX"));vm.execute(vm.method(HMENU,"_-45c"),menu);var tab=(Obj)menu.get("_-0Ix");var provider=(Obj)tab.get("dataProvider");var items=(List<Obj>)vm.get(provider,"data");
   check(vm.get(items.get(items.size()-1),"label").equals("${toolbar.logout}")&&vm.get(items.get(items.size()-2),"label").equals("Lucros"),"Earnings not above Logout");check(items.stream().noneMatch(x->Objects.equals(vm.get(x,"label"),"Privacidade")),"Privacy remains in native H");
  }
  System.out.println("PASS: Actual H-menu builder (one/two avatars) retains Earnings above Logout and removes Privacy.");
 }
 public static void main(String[]a)throws Exception{
  var current=new SWF(new FileInputStream(a[0]),false);var plus=new SWF(new FileInputStream("work/plus.swf"),false);
  var vm=new VM19(current);verifyLogin(vm);verifyHeads(vm);verifyCurrencies(vm,plus);verifyEarnings(vm);verifyMenu(current);
  var kept=new VM19(current);outline(kept);events(kept);catalog(kept);furniture(kept);income(kept,plus);
  regression(current,plus);
 }
}

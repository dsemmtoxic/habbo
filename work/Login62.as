package loginpatch {
 import flash.desktop.Clipboard;
 import flash.utils.Dictionary;
 import flash.utils.getDefinitionByName;
 import starling.core.Starling;
 import flash.display.Loader;
 import flash.display.Bitmap;
 import flash.display.BitmapData;
 import flash.events.Event;
 import flash.geom.Rectangle;
 import flash.geom.Point;
 import flash.net.URLRequest;
 import starling.textures.Texture;
 public final class Login62 {
  private static var _controls:Dictionary=new Dictionary(true);
  private static var _avatarLoads:Dictionary=new Dictionary(true);
  private static function klass(name:String):Class{return getDefinitionByName(name) as Class;}
  private static function t(state:Object,value:String):String{return klass("loginpatch::Text68").get(value,String(state.controller.getProperty("environment.id")));}
  private static function captions(state:Object):Array{
   var language:String=String(state.controller.getProperty("environment.id"));
   var values:Object={
    pt:["Entrar no hotel","Use o token do Launcher para acessar sua conta.","TOKEN DE ACESSO","Cole seu token aqui","Colar","Entrar","Obter token no site"],
    en:["Enter the hotel","Use your Launcher token to access your account.","ACCESS TOKEN","Paste your token here","Paste","Enter","Get a token on the website"],
    de:["Hotel betreten","Melde dich mit deinem Launcher-Token an.","ZUGANGSTOKEN","Token hier einfügen","Einfügen","Anmelden","Token auf der Website holen"],
    fr:["Entrer dans l’hôtel","Utilise ton jeton Launcher pour te connecter.","JETON D’ACCÈS","Colle ton jeton ici","Coller","Entrer","Obtenir un jeton sur le site"],
    es:["Entrar al hotel","Usa el token del Launcher para acceder a tu cuenta.","TOKEN DE ACCESO","Pega tu token aquí","Pegar","Entrar","Obtener token en la web"],
    it:["Entra nell’hotel","Usa il token del Launcher per accedere al tuo account.","TOKEN DI ACCESSO","Incolla qui il token","Incolla","Entra","Ottieni il token sul sito"],
    nl:["Ga het hotel binnen","Gebruik je Launcher-token om in te loggen.","TOEGANGSTOKEN","Plak hier je token","Plakken","Inloggen","Token ophalen op de website"],
    fi:["Astu hotelliin","Kirjaudu tilillesi Launcher-tunnuksella.","KIRJAUTUMISTUNNUS","Liitä tunnus tähän","Liitä","Kirjaudu","Hae tunnus verkkosivulta"],
    tr:["Otele gir","Hesabına erişmek için Launcher tokenini kullan.","ERİŞİM TOKENİ","Tokenini buraya yapıştır","Yapıştır","Giriş yap","Web sitesinden token al"]
   };
   return values[language]==null?values.en:values[language];
  }
  private static function makeButton(state:Object,label:String,action:Function,name:String):Object {var b:Object=ClientTheme63.button(label,action);b.name=name;state.card.addChild(b);_controls[b]=state;return b;}
  private static function ensure(state:Object):void {
   if(state.login62!=null)return;
   ClientTheme63.releaseFrame(state.card);state.card.backgroundSkin=null;state.card.name="loginModern65";
   // Native LoginScreen stores these two fields as feathers Label slots.
   // Preserve their class and lifetime; custom text is a separate view.
   state.title.visible=false;state.title.includeInLayout=false;state.instructions.visible=false;state.instructions.includeInLayout=false;
   var titleView:Object=ModernUI65.text("",28);var instructionsView:Object=ModernUI65.text("",18,0xffffff,false);state.card.addChild(titleView);state.card.addChild(instructionsView);
   var badge:Object=ModernUI65.text("HABBO",62,0xffd636,true);state.card.addChild(badge);
   var caption:Object=ModernUI65.text("",16);state.card.addChild(caption);
   var logo:Object=ClientTheme63.icon("H_logo");state.card.addChild(logo);
   var gear:Object=makeButton(state,"",ClientSettings63.open,"settings");gear.defaultIcon=ClientTheme63.icon("settings_small");
   var accountTab:Object=makeButton(state,"Conta",modeChanged,"account");var tokenTab:Object=makeButton(state,"Token",modeChanged,"token");
   var accountName:Object=ModernUI65.text("",30);state.card.addChild(accountName);accountName.hAlign="center";
   var accountHint:Object=ModernUI65.text("",17,0xffffff,false);state.card.addChild(accountHint);accountHint.hAlign="center";
   var head:Object=ClientTheme63.icon("H_logo");state.card.addChild(head);
   var paste:Object=makeButton(state,"Colar",pasteToken,"paste");var switchButton:Object=makeButton(state,"Alternar personagem",switchAvatar,"switchAvatar");
   var cancel:Object=makeButton(state,"Cancelar",cancelBrowser,"cancelBrowser");cancel.visible=false;
   state.country.removeFromParent();state.card.addChild(state.country);state.input.displayAsPassword=true;state.input.maxChars=8192;state.input.addEventListener("enter",entered);state.card.addChild(state.input);
   state.login62={titleView:titleView,instructionsView:instructionsView,paste:paste,badge:badge,caption:caption,logo:logo,gear:gear,accountTab:accountTab,tokenTab:tokenTab,accountName:accountName,accountHint:accountHint,head:head,switchButton:switchButton,cancel:cancel,mode:"account",screen:null,profileKey:"",avatarTexture:null,avatarBitmap:null,avatarW:54,avatarH:62,hotel:String(state.controller.getProperty("environment.id")),busy:false,browserMessage:""};
   _controls[state.input]=state;sessionUpdated(state);
  }
  private static function placeButton(button:Object,x:Number,y:Number,w:Number,h:Number,kind:String="glass",selected:Boolean=false):void {ClientTheme63.box(button,x,y,w,h);ModernUI65.paint(button,w,h,kind,selected);}
  public static function fitHead(width:Number,height:Number,maxWidth:Number,maxHeight:Number):Array {if(width<=0||height<=0)return [1,1];var scale:Number=Math.min(maxWidth/width,maxHeight/height);if(scale>=1)scale=Math.max(1,Math.floor(scale));return [width*scale,height*scale];}
  public static function layout(screen:Object,screens:Object):void {
   var state:Object=screens[screen];if(state==null)return;ensure(state);var ui:Object=state.login62;ui.screen=screen;
   var w:Number=Starling.current.stage.stageWidth;var h:Number=Starling.current.stage.stageHeight;var wide:Boolean=w/h>1.25;
   var u:Number=Math.max(0.55,Math.min(1.4,h/(wide?660:860),w/(wide?900:480)));
   var container:Object=state.container;container.width=w;container.height=h;container.maxHeight=h;container.x=container.y=0;var A:Class=klass("_-0iC::_-BX");container.layoutData=new A(0,0,0,0);
   state.root.width=w;state.root.height=h;state.root.x=state.root.y=0;var card:Object=state.card;card.width=Math.min(w-32*u,(wide?1260:610)*u);card.height=Math.min(h-24*u,(wide?600:780)*u);card.x=(w-card.width)/2;card.y=(h-card.height)/2;
   var environment:String=String(state.controller.getProperty("environment.id"));klass("loginpatch::Text68").select(environment);if(String(ui.hotel)!=environment){ui.hotel=environment;sessionUpdated(state);}
   var Theme:Class=klass("HitchTheme");state.icon.source=Theme.getTexture(Theme["_-oc"](environment)?environment:"H_logo_small");state.icon.width=state.icon.height=22*u;
   var flags:Object={pt:"Br/Pt",en:"English",fi:"Suomi",fr:"France",de:"Deutsch",nl:"NL",es:"Español",it:"Italia",tr:"Türkçe"};state.country.label=String(flags[environment]==null?"English":flags[environment]);
   var formX:Number=wide?card.width*0.54:24*u;var formW:Number=wide?card.width-formX-20*u:card.width-48*u;
   ui.logo.visible=ui.badge.visible=false;
   var serverW:Number=wide?card.width*0.32:156*u;var serverH:Number=(wide?58:46)*u;
   placeButton(state.country,wide?(formX-serverW)/2:(card.width-serverW)/2,wide?(card.height-serverH)/2:20*u,serverW,serverH);state.country.visible=true;state.country.includeInLayout=true;
   placeButton(ui.gear,w-card.x-64*u,16*u-card.y,48*u,46*u);ui.gear.defaultIcon=ClientTheme63.icon("settings_small");
   ui.accountTab.label=t(state,"Conta");ui.tokenTab.label="Token";ui.switchButton.label=t(state,"Alternar personagem");ui.cancel.label=t(state,"Cancelar");
   var tabY:Number=(wide?44:100)*u;placeButton(ui.accountTab,formX,tabY,(formW-12*u)/2,46*u,"tab",ui.mode=="account");placeButton(ui.tokenTab,formX+(formW+12*u)/2,tabY,(formW-12*u)/2,46*u,"tab",ui.mode=="token");
   var account:Boolean=ui.mode=="account";var p:Object=klass("loginpatch::WebSession64").profile(state.controller);var c:Array=captions(state);
   state.title.visible=state.instructions.visible=false;ui.titleView.visible=ui.instructionsView.visible=ui.caption.visible=state.input.visible=ui.paste.visible=!account;state.input.includeInLayout=!account;
   ui.head.visible=ui.accountName.visible=ui.accountHint.visible=account;
   var headY:Number=(wide?116:182)*u;var boxH:Number=(wide?144:152)*u;var boxW:Number=166*u;var fitted:Array=fitHead(Number(ui.avatarW),Number(ui.avatarH),boxW,boxH);
   ClientTheme63.box(ui.head,formX+(formW-Number(fitted[0]))/2,headY+(boxH-Number(fitted[1]))/2,Number(fitted[0]),Number(fitted[1]));ui.head.smoothing="none";
   ClientTheme63.box(ui.accountName,formX,(wide?278:354)*u,formW,44*u);ModernUI65.format(ui.accountName,30*u);ClientTheme63.box(ui.accountHint,formX,(wide?326:402)*u,formW,44*u);ModernUI65.format(ui.accountHint,17*u,0xffffff,false);
   ui.accountName.text=p==null?t(state,"Vincule sua conta"):String(p.name);ui.accountHint.text=ui.busy?String(ui.browserMessage):p==null?t(state,"Entre pelo site oficial do Habbo"):t(state,"Conta vinculada neste aparelho");
   var titleY:Number=(wide?160:200)*u;ui.titleView.text=c[0];ClientTheme63.box(ui.titleView,formX,titleY,formW,48*u);ModernUI65.format(ui.titleView,30*u);ui.instructionsView.text=c[1];ClientTheme63.box(ui.instructionsView,formX,titleY+58*u,formW,54*u);ModernUI65.format(ui.instructionsView,18*u,0xffffff,false);
   ui.caption.text=c[2];ClientTheme63.box(ui.caption,formX,titleY+128*u,formW,26*u);ModernUI65.format(ui.caption,16*u);
   state.input.prompt=c[3];ClientTheme63.box(state.input,formX,titleY+162*u,formW-104*u,56*u);ui.paste.label=c[4];placeButton(ui.paste,formX+formW-94*u,titleY+162*u,94*u,56*u);
   state.login.label=ui.busy?t(state,"Conectando..."):account?(p==null?t(state,"Vincular conta"):t(state,"Entrar")):c[5];state.login.isEnabled=!ui.busy;var primaryY:Number=(wide?386:468)*u;placeButton(state.login,formX,primaryY,formW,64*u,"primary");
   ui.switchButton.visible=account&&p!=null&&!ui.busy;placeButton(ui.switchButton,formX,primaryY+82*u,formW,50*u);
   state.website.label=account?t(state,"Gerenciar conta"):c[6];state.website.visible=!ui.busy;placeButton(state.website,formX,primaryY+(account&&p!=null?146:82)*u,formW,44*u);
   ui.cancel.visible=ui.busy;placeButton(ui.cancel,formX,primaryY+82*u,formW,48*u);
   container.readjustLayout();
  }
  private static function layoutState(state:Object):void {if(state.login62!=null&&state.login62.screen!=null)HabboTicketLogin.layoutTokenLogin(state.login62.screen);}
  public static function submit(event:Object,actions:Object):void {var state:Object=actions[event.currentTarget];if(state==null||state.login62.busy)return;if(state.login62.mode=="account")klass("loginpatch::WebSession64").open(state,true);else send(state);}
  public static function website(event:Object,actions:Object):void {var state:Object=actions[event.currentTarget];if(state==null)return;if(state.login62.mode=="account")klass("loginpatch::WebSession64").open(state,false);else HabboTicketLogin.openWebsite(state.controller);}
  public static function switchAvatar(event:Object):void {var state:Object=_controls[event.currentTarget];if(state!=null&&!state.login62.busy)klass("loginpatch::WebSession64").switchAvatar(state);}
  public static function cancelBrowser(event:Object):void {klass("loginpatch::WebSession64").close(null);}
  public static function browserState(state:Object,busy:Boolean,message:String=""):void {if(state==null||state.login62==null)return;state.login62.busy=busy;state.login62.browserMessage=message;layoutState(state);}
  public static function modeChanged(event:Object):void {var state:Object=_controls[event.currentTarget];if(state==null||state.login62.busy)return;state.login62.mode=String(event.currentTarget.name);if(state.login62.mode!="token")state.input.text="";layoutState(state);}
  public static function imageAllowed(url:String,controller:Object):Boolean {var host:String=klass("loginpatch::WebSession64").host(controller);return (url.indexOf("https://"+host+"/habbo-imaging/avatar/")==0||url.indexOf("https://"+host.substr(4)+"/habbo-imaging/avatar/")==0)&&/\.png$/.test(url)&&url.length<4096;}
  public static function sessionUpdated(state:Object):void {
   if(state==null||state.login62==null)return;var ui:Object=state.login62;var p:Object=klass("loginpatch::WebSession64").profile(state.controller);var key:String=p==null?"":String(state.controller.getProperty("environment.id"))+":"+String(p.figure)+":"+String(p.image);
   if(key==ui.profileKey){layoutState(state);return;}ui.profileKey=key;cancelAvatarLoads(state);
   ui.head.texture=klass("HitchTheme").getTexture("H_logo");if(ui.avatarTexture!=null)ui.avatarTexture.dispose();if(ui.avatarBitmap!=null)ui.avatarBitmap.dispose();ui.avatarTexture=null;ui.avatarBitmap=null;ui.avatarW=54;ui.avatarH=62;
   if(p!=null){var url:String=String(p.image);if(!imageAllowed(url,state.controller))url="https://"+klass("loginpatch::WebSession64").host(state.controller)+"/habbo-imaging/avatarimage?figure="+encodeURIComponent(String(p.figure))+"&headonly=1&direction=2&head_direction=2&size=l";
    var loader:Loader=new Loader();_avatarLoads[loader.contentLoaderInfo]={state:state,key:key,loader:loader};loader.contentLoaderInfo.addEventListener("complete",avatarLoaded);loader.contentLoaderInfo.addEventListener("ioError",avatarFailed);loader.contentLoaderInfo.addEventListener("securityError",avatarFailed);loader.load(new URLRequest(url));}
   layoutState(state);
  }
  public static function avatarLoaded(event:Event):void {
   var entry:Object=_avatarLoads[event.currentTarget];if(entry!=null&&entry.state.login62!=null&&entry.state.login62.profileKey==entry.key){try{var bitmap:Bitmap=entry.loader.content as Bitmap;if(bitmap!=null){var bounds:Rectangle=bitmap.bitmapData.getColorBoundsRect(0xff000000,0,false);if(bounds.width>0&&bounds.height>0){var cropped:BitmapData=new BitmapData(bounds.width,bounds.height,true,0);cropped.copyPixels(bitmap.bitmapData,bounds,new Point());var texture:Texture=Texture.fromBitmapData(cropped,false);var ui:Object=entry.state.login62;ui.avatarTexture=texture;ui.avatarBitmap=cropped;ui.avatarW=cropped.width;ui.avatarH=cropped.height;ui.head.texture=texture;layoutState(entry.state);}}}catch(error:Error){}}
   avatarFailed(event);
  }
  public static function avatarFailed(event:Event):void {var entry:Object=_avatarLoads[event.currentTarget];if(entry==null)return;entry.loader.contentLoaderInfo.removeEventListener("complete",avatarLoaded);entry.loader.contentLoaderInfo.removeEventListener("ioError",avatarFailed);entry.loader.contentLoaderInfo.removeEventListener("securityError",avatarFailed);delete _avatarLoads[event.currentTarget];try{entry.loader.unload();}catch(error:Error){}}
  private static function cancelAvatarLoads(state:Object):void {for(var info:Object in _avatarLoads){var entry:Object=_avatarLoads[info];if(entry.state===state){try{entry.loader.close();}catch(error:Error){}info.removeEventListener("complete",avatarLoaded);info.removeEventListener("ioError",avatarFailed);info.removeEventListener("securityError",avatarFailed);delete _avatarLoads[info];}}}
  public static function fromSession(state:Object,code:String):void {if(state==null||state.login62==null)return;state.input.text=code;send(state);}
  private static function send(state:Object):void {HabboTicketLogin.login(state.controller,state.input);if(Starling.current.nativeStage!=null)Starling.current.nativeStage.focus=null;}
  public static function entered(event:Object):void {var state:Object=_controls[event.currentTarget];if(state!=null&&state.login62.mode=="token")send(state);}
  public static function pasteToken(event:Object):void {
   var state:Object=_controls[event.currentTarget];if(state==null)return;var value:Object;try{value=Clipboard.generalClipboard.getData("air:text");}catch(error:Error){value=null;}
   if(value==null||String(value).replace(/^\s+|\s+$/g,"").length==0){state.controller.alert(t(state,"Login por código"),t(state,"Copie o código do Launcher no site oficial do Habbo e volte para continuar."));return;}
   var raw:String=String(value).replace(/^\s+|\s+$/g,"");if(raw.length>8192){state.controller.alert(t(state,"Código inválido"),t(state,"Use o código do Launcher copiado no site Habbo."));return;}state.input.text=raw;
  }
  public static function release(screen:Object,screens:Object):void {
   var state:Object=screens[screen];if(state==null||state.login62==null)return;klass("loginpatch::WebSession64").release(state);cancelAvatarLoads(state);
   var ui:Object=state.login62;if(ui.avatarTexture!=null)ui.avatarTexture.dispose();if(ui.avatarBitmap!=null)ui.avatarBitmap.dispose();
   ClientSettings63.close(null);state.input.removeEventListener("enter",entered);for(var control:Object in _controls)if(_controls[control]===state){ModernUI65.release(control);delete _controls[control];}
   state.input.text="";state.login62=null;
  }
 }
}

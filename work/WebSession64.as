package loginpatch {
 import flash.media.StageWebView;
 import flash.events.Event;
 import flash.events.LocationChangeEvent;
 import flash.events.KeyboardEvent;
 import flash.geom.Rectangle;
 import flash.net.SharedObject;
 import flash.crypto.generateRandomBytes;
 import flash.utils.ByteArray;
 import flash.utils.setInterval;
 import flash.utils.clearInterval;
 import flash.utils.getTimer;
 import starling.core.Starling;
 import starling.display.Quad;
 public final class WebSession64 {
  private static const SCRIPT:String="__WEB_SESSION_SCRIPT64__";
  private static var _web:StageWebView;
  private static var _state:Object;
  private static var _bar:Object;
  private static var _status:Object;
  private static var _nonce:String="";
  private static var _host:String="";
  private static var _mode:String="";
  private static var _timer:uint=0;
  private static var _deadline:int=0;
  private static var _visible:Boolean=false;
  private static var _injected:String="";
  private static var _viewportKey:String="";
  private static var _initialId:String="";
  private static function t(value:String):String {return ClientTheme63.klass("loginpatch::Text68").get(value,_state==null?"":hotel(_state.controller));}
  private static function hotel(controller:Object):String {return String(controller.getProperty("environment.id"));}
  public static function host(controller:Object):String {var hosts:Object={pt:"www.habbo.com.br",en:"www.habbo.com",fi:"www.habbo.fi",fr:"www.habbo.fr",de:"www.habbo.de",nl:"www.habbo.nl",es:"www.habbo.es",it:"www.habbo.it",tr:"www.habbo.com.tr"};return String(hosts[hotel(controller)]);}
  private static function prefix(controller:Object):String {var values:Object={pt:"hhbr",en:"hhus",fi:"hhfi",fr:"hhfr",de:"hhde",nl:"hhnl",es:"hhes",it:"hhit",tr:"hhtr"};return String(values[hotel(controller)]);}
  public static function profile(controller:Object):Object {try{var storage:SharedObject=SharedObject.getLocal("habboBrowserProfile64");return storage.data[hotel(controller)];}catch(error:Error){}return null;}
  private static function remember(value:Object):void {
   if(_state==null)return;
   try{var storage:SharedObject=SharedObject.getLocal("habboBrowserProfile64");var record:Object={name:String(value.name),figure:String(value.figure),id:value.id is String?String(value.id):"",image:""};
    if(record.id.length>128)record.id="";if(value.image is String&&Login62.imageAllowed(String(value.image),_state.controller))record.image=String(value.image);storage.data[hotel(_state.controller)]=record;storage.flush();}catch(error:Error){}
   Login62.sessionUpdated(_state);
  }
  public static function trusted(url:String):Boolean {if(_host=="")return false;var match:Object=/^https:\/\/([^\/:?#]+)(?::443)?(?:[\/?#]|$)/i.exec(url);return match!=null&&(String(match[1]).toLowerCase()==_host||String(match[1]).toLowerCase()==_host.substr(4));}
  private static function allowed(url:String):Boolean {return trusted(url)||/^https:\/\/accounts\.habbo\.com(?:[\/?#]|$)/i.test(url);}
  public static function validCode(code:String,prefix:String):Boolean {return code!=null&&code.length<=8192&&new RegExp("^"+prefix+"\\.[A-Za-z0-9_-]+\\.[A-Za-z0-9_.-]+$","i").test(code);}
  private static function randomNonce():String {var bytes:ByteArray=generateRandomBytes(16);var value:String="";bytes.position=0;while(bytes.bytesAvailable){var part:String=bytes.readUnsignedByte().toString(16);value+=(part.length==1?"0":"")+part;}return value;}
  public static function open(state:Object,launch:Boolean=true):void {begin(state,launch?(profile(state.controller)==null?"link":"enter"):"manage");}
  public static function switchAvatar(state:Object):void {begin(state,"switch");}
  private static function begin(state:Object,mode:String):void {
   close(null);if(!StageWebView.isSupported){state.controller.alert(t("Entrar na conta"),t("O navegador do sistema não está disponível neste aparelho."));return;}
   _state=state;_mode=mode;_host=host(state.controller);if(_host=="undefined"){close(null);return;}_nonce=randomNonce();var p:Object=profile(state.controller);_initialId=p!=null&&p.id is String?String(p.id):"";
   Login62.browserState(state,true,mode=="enter"?t("Conectando com a sessão salva..."):t("Aguardando o navegador..."));
   _bar=ClientTheme63.group();_bar.name="officialHabboLogin65";_bar.backgroundSkin=new Quad(1,1,0x101c2d);Starling.current.stage.addChild(_bar);
   var back:Object=ClientTheme63.button(t("Voltar"),close);back.name="back";_bar.addChild(back);var refreshButton:Object=ClientTheme63.button(t("Atualizar"),reload);refreshButton.name="refresh";_bar.addChild(refreshButton);
   _status=ModernUI65.text("https://"+_host,17,0xffffff,false);_status.name="status";_bar.addChild(_status);
   _web=new StageWebView(true);_web.addEventListener("complete",loaded);_web.addEventListener("locationChange",loaded);_web.addEventListener("locationChanging",changing);_web.addEventListener("error",failed);
   _web.stage=Starling.current.nativeStage;_visible=mode!="enter";_bar.visible=_visible;resize();if(!_visible)_web.stage=null;
   Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);Starling.current.nativeStage.addEventListener("resize",resized);_timer=setInterval(tick,500);_deadline=getTimer()+25000;
   _web.loadURL("https://"+_host+(mode=="switch"?"/settings/avatars":"/"));
  }
  private static function resize():void {
   if(_web==null||_bar==null)return;var s:Object=Starling.current.stage;var u:Number=ClientTheme63.scale();var h:Number=64*u;var viewport:Rectangle=Starling.current.viewPort;
   var key:String=viewport.x+":"+viewport.y+":"+viewport.width+":"+viewport.height+":"+s.stageWidth+":"+s.stageHeight+":"+h;if(key==_viewportKey)return;_viewportKey=key;
   _bar.width=s.stageWidth;_bar.height=h;_bar.backgroundSkin.width=_bar.width;_bar.backgroundSkin.height=h;
   var back:Object=_bar.getChildByName("back");var refreshButton:Object=_bar.getChildByName("refresh");ClientTheme63.box(back,10*u,8*u,102*u,46*u);ModernUI65.paint(back,102*u,46*u);ClientTheme63.box(refreshButton,s.stageWidth-132*u,8*u,122*u,46*u);ModernUI65.paint(refreshButton,122*u,46*u);ClientTheme63.box(_status,124*u,18*u,s.stageWidth-266*u,32*u);
   var ratio:Number=viewport.height/Number(s.stageHeight);_web.viewPort=new Rectangle(viewport.x,viewport.y+h*ratio,viewport.width,Math.max(1,viewport.height-h*ratio));
  }
  public static function resized(event:Object):void {resize();}
  private static function showBrowser(message:String):void {if(_web==null)return;_visible=true;_bar.visible=true;_web.stage=Starling.current.nativeStage;_status.text=message;_deadline=0;resize();}
  private static function config():Object {var match:Object=/^https:\/\/([^\/:?#]+)/i.exec(_web.location);return {host:match==null?_host:String(match[1]).toLowerCase(),prefix:prefix(_state.controller),bridge:"habbosession65://"+_nonce+"/result",mode:_mode,initialId:_initialId};}
  public static function tick():void {if(_web==null)return;resize();if(_deadline!=0&&getTimer()>_deadline){showBrowser(t("A sessão ainda não respondeu. Entre na conta ou toque em Atualizar."));}}
  private static function inject():void {if(_web==null||_state==null||!trusted(_web.location)||_injected==_web.location)return;_injected=_web.location;_web.loadURL("javascript:void "+SCRIPT.replace("__H64_CONFIG__",JSON.stringify(config())));}
  public static function loaded(event:Event):void {if(event.type=="complete")_injected="";if(_web!=null&&trusted(_web.location))inject();}
  public static function changing(event:LocationChangeEvent):void {
   if(_web==null||_state==null)return;var url:String=event.location;var bridge:String="habbosession65://"+_nonce+"/result#";
   if(url.indexOf("habbosession65:")==0){event.preventDefault();if(url.indexOf(bridge)!=0||!trusted(_web.location)||url.length>18000)return;try{receive(JSON.parse(decodeURIComponent(url.substr(bridge.length))));}catch(error:Error){showBrowser(t("Não foi possível identificar a sessão. Toque em Atualizar."));}return;}
   if(/^habbo(?:app)?:/i.test(url)){event.preventDefault();return;}
   if(!allowed(url)&&url.indexOf("javascript:")!=0&&url!="about:blank"){event.preventDefault();showBrowser(t("Use o login com e-mail no site oficial do Habbo."));}
  }
  public static function receive(value:Object):void {
   if(_state==null||value==null)return;
   if(value.kind=="needs-login"){showBrowser(value.reason=="signed-out"?t("Entre na conta pelo site oficial."):value.reason=="age-verification"?t("O Habbo solicita a verificação de idade no site."):value.reason=="safety-lock"?t("Conclua a verificação de segurança da conta no site."):t("Conclua a verificação solicitada pelo Habbo."));return;}
   if(value.kind=="error"){showBrowser(t("Não foi possível continuar. Toque em Atualizar para tentar novamente."));return;}
   var p:Object=value.profile;var valid:Boolean=p!=null&&p.name is String&&String(p.name).length>0&&String(p.name).length<=64&&p.figure is String&&/^[A-Za-z0-9.\-]{1,1024}$/.test(String(p.figure));if(!valid)return;remember(p);
   if((value.kind=="linked"&&_mode=="link")||(value.kind=="selected"&&_mode=="switch")){close(null);return;}
   if(value.kind!="ticket"||_mode!="enter")return;var code:String=String(value.code);if(!validCode(code,prefix(_state.controller)))return;var state:Object=_state;close(null);Login62.fromSession(state,code);
  }
  public static function reload(event:Object):void {if(_web!=null){_injected="";_deadline=getTimer()+25000;_web.reload();}}
  public static function failed(event:Object):void {showBrowser(t("Não foi possível carregar. Toque em Atualizar."));}
  public static function keyDown(event:KeyboardEvent):void {if(event.keyCode==16777238||event.keyCode==27){event.preventDefault();if(_visible&&_web!=null&&_web.isHistoryBackEnabled)_web.historyBack();else close(null);}}
  public static function close(event:Object):void {
   var state:Object=_state;if(_timer!=0)clearInterval(_timer);_timer=0;
   if(_web!=null){_web.removeEventListener("complete",loaded);_web.removeEventListener("locationChange",loaded);_web.removeEventListener("locationChanging",changing);_web.removeEventListener("error",failed);_web.stop();_web.stage=null;_web.dispose();_web=null;}
   if(Starling.current!=null&&Starling.current.nativeStage!=null){Starling.current.nativeStage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDown);Starling.current.nativeStage.removeEventListener("resize",resized);}
   if(_bar!=null)_bar.removeFromParent(true);_bar=null;_status=null;_state=null;_nonce="";_host="";_mode="";_deadline=0;_injected="";_viewportKey="";_initialId="";_visible=false;
   if(state!=null)Login62.browserState(state,false);
  }
  public static function release(state:Object):void {if(_state===state)close(null);}
 }
}

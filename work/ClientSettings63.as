package loginpatch {
 import flash.net.SharedObject;
 import flash.utils.Dictionary;
 import starling.core.Starling;
 public final class ClientSettings63 {
  private static var _loaded:Boolean=false;
  private static var _values:Object={afk:false,typing:true,tradeblock:false,mutebots:false,mutepets:false,friendhl:true,dc:false};
  private static var _context:Object;
  private static var _desktop:Object;
  private static var _gear:Object;
  private static var _popup:Object;
  private static var _status:Object;
  private static var _buttons:Dictionary=new Dictionary(true);
  private static var _syncing:Boolean=false;
  private static var _saveError:Boolean=false;
  private static const KEYS:Array=["afk","typing","tradeblock","mutebots","mutepets","friendhl","dc"];
  private static function load():void {
   if(_loaded)return;_loaded=true;
   var native:Array=HabboTicketLogin.commandStates63();_values.friendhl=Boolean(native[3]);
   try {var store:SharedObject=SharedObject.getLocal("habbo_classic_commands");for each(var key:String in KEYS)if(store.data[key]===true||store.data[key]===false)_values[key]=Boolean(store.data[key]);}catch(error:Error){}
  }
  private static function persist():void {
   _saveError=false;
   try {var store:SharedObject=SharedObject.getLocal("habbo_classic_commands");for each(var key:String in KEYS)store.data[key]=Boolean(_values[key]);if(store.flush()=="pending")_saveError=true;}catch(error:Error){_saveError=true;}
   ClientTheme63.klass("loginpatch::RoomUse70").refreshGestures();
   if(_status!=null)_status.text=_saveError?"Não foi possível salvar no aparelho. As opções continuam ativas nesta sessão.":"Preferências salvas neste aparelho. Valem nos próximos acessos.";
  }
  public static function values():Object {load();return {afk:_values.afk,typing:_values.typing,tradeblock:_values.tradeblock,mutebots:_values.mutebots,mutepets:_values.mutepets,friendhl:_values.friendhl,dc:_values.dc};}
  public static function quiet():Boolean {return _syncing;}
  private static function apply():void {
   if(_context==null||_context.disposed||_context.roomEngine==null)return;
   var manager:Object=_context["_-4Ej"];var session:Object=manager==null?null:manager.getSession(int(_context.roomEngine["_-0Y"]));if(session==null||session.disposed)return;
   HabboTicketLogin.bindCommandContext63(_context);var native:Array=HabboTicketLogin.commandStates63();var keys:Array=["afk","typing","tradeblock","friendhl"];
   _syncing=true;
   try {for(var i:int=0;i<4;i++)if(Boolean(native[i])!=Boolean(_values[keys[i]]))HabboTicketLogin.runCommand(":"+keys[i],_context);}finally {_syncing=false;}
  }
  public static function bind(desktop:Object):void {
   if(desktop==null||desktop.chat==null)return;
   if(_desktop!==desktop){release(_desktop);_desktop=desktop;_context=desktop.chat;_gear=ClientTheme63.settings(open);desktop["_-3uX"].addChild(_gear);_gear.addEventListener("enterFrame",positionGear);}
   _context=desktop.chat;load();apply();positionGear(null);
  }
  public static function positionGear(event:Object):void {
   if(_gear==null)return;var u:Number=ClientTheme63.scale();var w:Number=Starling.current.stage.stageWidth;ClientTheme63.box(_gear,w-142*u,14*u,54*u,50*u);
  }
  public static function reset():void {_context=null;}
  public static function release(desktop:Object):void {
   if(desktop!==_desktop)return;close(null);if(_gear!=null){_gear.removeEventListener("enterFrame",positionGear);_gear.removeFromParent(true);}_gear=null;_desktop=null;_context=null;
  }
  public static function beforeCommand(text:String,context:Object):Boolean {
   if(text==null)return false;var command:String=text.replace(/^\s+|\s+$/g,"").toLowerCase();
   if(command==":comandos"||command==":settings"||command==":config"){if(context!=null)_context=context;open(null);return true;}
   if(command!=":mutebots"&&command!=":mutepets"&&command!=":dc")return false;
   load();_values[command.substr(1)]=!Boolean(_values[command.substr(1)]);persist();refreshSwitches();
   if(command==":dc")ClientTheme63.klass("loginpatch::Ping69").notice(context,_values.dc?":dc ativado.":":dc desativado.");
   return true;
  }
  public static function afterCommand(text:String,context:Object):void {
   if(_syncing||text==null)return;var command:String=text.replace(/^\s+|\s+$/g,"").toLowerCase();
   if([":afk",":typing",":tradeblock",":friendhl"].indexOf(command)<0)return;
   load();_context=context;var native:Array=HabboTicketLogin.commandStates63();_values.afk=Boolean(native[0]);_values.typing=Boolean(native[1]);_values.tradeblock=Boolean(native[2]);_values.friendhl=Boolean(native[3]);persist();refreshSwitches();
  }
  public static function muted(event:Object):Boolean {
   load();if(event==null||event.type!="RSCE_CHAT_EVENT"||(!_values.mutebots&&!_values.mutepets))return false;
   var session:Object=event.session;if(session==null||session.disposed)return false;var users:Object=session["_-2gp"];if(users==null)return false;var user:Object=users["_-0uJ"](int(event.userId));if(user==null)return false;
   var type:int=int(user.type);return (type==2&&Boolean(_values.mutepets))||((type==3||type==4)&&Boolean(_values.mutebots));
  }
  public static function changed(event:Object):void {var key:String=_buttons[event.currentTarget];if(key==null)return;load();_values[key]=!Boolean(_values[key]);apply();persist();refreshSwitches();}
  private static function refreshSwitches():void {for(var b:Object in _buttons)ClientTheme63.switchState(b,Boolean(_values[_buttons[b]]),18*ClientTheme63.scale());}
  public static function open(event:Object):void {
   load();close(null);var u:Number=ClientTheme63.scale();var w:Number=Math.min(710*u,Starling.current.stage.stageWidth-28*u);var h:Number=Math.min(670*u,Starling.current.stage.stageHeight-28*u);
   var root:Object=ClientTheme63.group();root.name="commandSettings63";root.width=w;root.height=h;
   var title:Object=ClientTheme63.text("Suas preferências",27*u,0xffffff,true);ClientTheme63.box(title,22*u,17*u,w-95*u,40*u);root.addChild(title);
   var x:Object=ClientTheme63.close(close);ClientTheme63.box(x,w-62*u,12*u,48*u,45*u);root.addChild(x);
   var C:Class=ClientTheme63.klass("_-2xS::_-4Mu");var body:Object=new C();body.horizontalScrollPolicy="off";body.verticalScrollPolicy="auto";ClientTheme63.box(body,16*u,70*u,w-32*u,h-136*u);root.addChild(body);
   var titles:Array=["Anti-inatividade", "Indicador de digitação", "Bloquear trocas", "Silenciar bots", "Silenciar mascotes", "Destacar amigos", "Usar mobis com um toque"];
   var details:Array=["Mantém o avatar ativo - :afk","Mostrar quando você está escrevendo - :typing","Recusar novas trocas - :tradeblock","Ocultar falas dos bots neste cliente - :mutebots","Ocultar falas dos mascotes - :mutepets","Realçar seus amigos no quarto - :friendhl","Toque único para usar o mobi - :dc"];
   _buttons=new Dictionary(true);
   for(var i:int=0;i<KEYS.length;i++){
    var y:Number=i*78*u;var a:Object=ClientTheme63.text(titles[i],22*u,0xffffff,true);ClientTheme63.box(a,8*u,y+4*u,w-178*u,29*u);body.addChild(a);
    var d:Object=ClientTheme63.text(details[i],16*u,0xbbcdd4);ClientTheme63.box(d,8*u,y+35*u,w-178*u,38*u);body.addChild(d);
    var toggle:Object=ClientTheme63.button("",changed);ClientTheme63.box(toggle,w-160*u,y+13*u,108*u,48*u);_buttons[toggle]=KEYS[i];body.addChild(toggle);
   }
   _status=ClientTheme63.text("As opções são permanentes e também podem ser alteradas no quarto.",16*u,0xbbcdd4);ClientTheme63.box(_status,24*u,h-56*u,w-48*u,44*u);root.addChild(_status);
   _popup=root;ClientTheme63.frame(root);refreshSwitches();ClientTheme63.popup(root);root.x=Math.round((Starling.current.stage.stageWidth-w)/2);root.y=Math.round((Starling.current.stage.stageHeight-h)/2);
  }
  public static function close(event:Object):void {if(_popup!=null){ClientTheme63.releaseFrame(_popup);_popup.removeFromParent(true);}_popup=null;_status=null;_buttons=new Dictionary(true);}
 }
}

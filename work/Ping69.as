package loginpatch {
 import flash.utils.getTimer;
 import flash.utils.Timer;
 import flash.events.TimerEvent;
 public final class Ping69 {
  private static var _sequence:int=1073741824;
  private static var _pending:Object={};
  private static var _timer:Timer;
  public static function run(text:String,context:Object):Boolean {
   if(text==null)return false;var command:String=text.replace(/^\s+|\s+$/g,"").toLowerCase();if(command!=":ping"&&command!=":pingsay")return false;
   var session:Object=current(context);if(session==null)return true;var connection:Object=context.communication.connection;if(connection==null)return true;
   var id:int=++_sequence;_pending[String(id)]={context:context,session:session,connection:connection,at:getTimer(),say:command==":pingsay"};
   var C:Class=ClientTheme63.klass("_-ET::_-4NH");if(!connection.send(new C(id))){delete _pending[String(id)];local(context,session,Text68.get("Não foi possível medir o ping. Tente novamente."));return true;}
   if(_timer==null){_timer=new Timer(1000);_timer.addEventListener(TimerEvent.TIMER,tick);}_timer.start();return true;
  }
  private static function current(context:Object):Object {
   if(context==null||context.disposed||context.roomEngine==null||context["_-4Ej"]==null)return null;
   var session:Object=context["_-4Ej"].getSession(int(context.roomEngine["_-0Y"]));return session==null||session.disposed||session.state!="RSE_STARTED"?null:session;
  }
  private static function valid(state:Object):Boolean {return state.context!=null&&!state.context.disposed&&state.context.communication.connection===state.connection&&current(state.context)===state.session;}
  public static function format(milliseconds:int):String {var value:String=int(Math.max(0,milliseconds)).toString();while(value.length<3)value="0"+value;return "Ping: "+value;}
  public static function response(event:Object):Boolean {
   if(event==null||event.getParser()==null)return false;var id:int=int(event.getParser().requestId);if(id<=1073741824||id>_sequence)return false;
   var state:Object=_pending[String(id)];delete _pending[String(id)];if(state==null||!valid(state))return true;
   var message:String=format(getTimer()-int(state.at));if(state.say)state.session["_-1gs"](message,0);else local(state.context,state.session,message);return true;
  }
  public static function notice(context:Object,message:String):void {var session:Object=current(context);if(session!=null)local(context,session,Text68.get(message));}
  private static function local(context:Object,session:Object,message:String):void {
   var C:Class=ClientTheme63.klass("_-1Xf::_-3OZ");context["_-4Ej"].events.dispatchEvent(new C("RSCE_CHAT_EVENT",session,int(session["_-4kZ"]),message,0,0));
  }
  public static function tick(event:Object):void {
   var count:int=0;for(var id:String in _pending){var state:Object=_pending[String(id)];if(!valid(state)){delete _pending[String(id)];continue;}if(getTimer()-int(state.at)>=10000){delete _pending[String(id)];local(state.context,state.session,Text68.get("Não foi possível medir o ping. Tente novamente."));}else count++;}
   if(count==0&&_timer!=null)_timer.stop();
  }
  public static function reset():void {_pending={};if(_timer!=null)_timer.stop();}
 }
}

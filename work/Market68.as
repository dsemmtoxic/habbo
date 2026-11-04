package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getTimer;
 import starling.core.Starling;
 public final class Market68 {
  private static var _buttons:Dictionary=new Dictionary(true);
  private static var _returned:Dictionary=new Dictionary(true);
  private static var _ends:Dictionary=new Dictionary(true);
  private static var _views:Dictionary=new Dictionary(true);
  public static function active(offer:Object):Boolean {
   if(offer==null||int(offer.offerId)<=0||int(offer.status)!=1||int(offer["_-4Wz"])<0)return false;
   if(_ends[offer]==null)_ends[offer]=Number(getTimer())+Math.max(1,int(offer["_-4Wz"]))*60000;
   return Number(_ends[offer])>getTimer();
  }
  public static function bind(button:Object,data:Object,view:Object,nativeAction:Function):void {
   if(button==null||view==null)return;button.removeEventListener("triggered",nativeAction);var state:Object=_buttons[button];
   var id:int=data==null?0:int(data.offerId);if(state==null){state={};_buttons[button]=state;button.addEventListener("triggered",request);}
   if(state.id!==id){button.removeEventListener("enterFrame",tick);state.until=0;}
   state.id=id;state.status=data==null?2:int(data.status);state.offer=data;state.logic=view.marketLogic68;
   var allowed:Boolean=active(data);button.visible=button.includeInLayout=allowed;button.isEnabled=allowed&&!(Number(state.until)>getTimer());
  }
  public static function request(event:Object):void {
   var button:Object=event.currentTarget;var state:Object=_buttons[button];if(state==null||state.logic==null||state.logic.disposed||!active(state.offer)||Number(state.until)>getTimer())return;
   state.until=getTimer()+10000;button.isEnabled=false;button.addEventListener("enterFrame",tick);state.logic["_-0if"](int(state.id));
  }
  public static function result(logic:Object,event:Object):void {
   if(event==null)return;var parser:Object=event.getParser();if(parser==null)return;
   if(parser.success){var returned:Object=_returned[logic];if(returned==null){returned={};_returned[logic]=returned;}returned[int(parser.offerId)]=true;}
   for(var button:Object in _buttons){var state:Object=_buttons[button];if(state.logic===logic&&int(state.id)==int(parser.offerId)){state.until=0;button.removeEventListener("enterFrame",tick);button.isEnabled=active(state.offer);}}
  }
  public static function filter(logic:Object,refresh:Boolean=true):void {
   if(logic==null||logic.disposed)return;var returned:Object=_returned[logic];var offers:Object=logic["_-26L"]();if(offers==null)return;var changed:Boolean=false;
   var keys:Array=offers["_-Kz"]();
   for each(var key:Object in keys){var offer:Object=offers.getValue(key);if(!active(offer)||returned!=null&&returned[int(key)]){offers.remove(key);if(offer!=null)offer.dispose();changed=true;}}
   if(changed){logic.marketCount69();if(refresh)logic.marketRefresh68();}
  }
  public static function disposeLogic(logic:Object):void {delete _returned[logic];for(var hint:Object in _views)if(_views[hint].logic===logic)releaseView(_views[hint].view);}
  public static function tick(event:Object):void {
   var button:Object=event.currentTarget;var state:Object=_buttons[button];if(state==null||Number(state.until)<=getTimer()){
    button.removeEventListener("enterFrame",tick);if(state!=null){state.until=0;button.isEnabled=active(state.offer);if(state.logic!=null&&!state.logic.disposed)state.logic["_-2Zv"]();}
   }
  }
  public static function describe(view:Object,hint:Object,redeem:Object,count:Object):void {
   if(view==null||hint==null||redeem==null||count==null)return;
   if(_views[hint]==null){_views[hint]={view:view,logic:view.marketLogic68,last:-1};hint.addEventListener("enterFrame",viewTick);}
   redeem.visible=redeem.includeInLayout=redeem.isEnabled=false;
   hint.text=Text68.get("Resgate as moedas da Feira Livre pelo menu H, em Lucros.");
   var u:Number=ClientTheme63.scale();hint.width=Math.max(100,Number(Starling.current.stage.stageWidth)*0.72-24*u);hint.wordWrap=true;
   var A:Class=ClientTheme63.klass("_-2YJ::_-bQ");hint.layoutData=A["_-2lz"](12*u,12*u,NaN,12*u);count.layoutData=A["_-2lz"](20*u,0,NaN,0,hint);
  }
  public static function viewTick(event:Object):void {var state:Object=_views[event.currentTarget];if(state==null)return;var second:int=int(getTimer()/1000);if(state.last==second)return;state.last=second;filter(state.logic);}
  public static function releaseView(view:Object):void {if(view==null)return;for(var hint:Object in _views)if(_views[hint].view===view){hint.removeEventListener("enterFrame",viewTick);delete _views[hint];}}
  public static function release(button:Object):void {if(button==null)return;button.removeEventListener("triggered",request);button.removeEventListener("enterFrame",tick);delete _buttons[button];}
 }
}

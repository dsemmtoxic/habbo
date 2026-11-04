package loginpatch {
 import flash.utils.Dictionary;
 import flash.text.TextFormat;
 import starling.display.Quad;
 import starling.core.Starling;
 public final class RoomUse70 {
  private static var _handlers:Dictionary=new Dictionary(true);
  private static var _present:Object;
  private static var _gift:Object;
  public static function gesture(handler:Object):void {if(handler==null)return;_handlers[handler]=true;var tap:Object=handler.singleTapGesture70;if(tap!=null)tap["_-2QQ"]=ClientSettings63.values().dc?250:1500;}
  public static function refreshGestures():void {for(var handler:Object in _handlers)gesture(handler);}
  public static function release(handler:Object):void {delete _handlers[handler];}
  private static function tappedFurniture(handler:Object,event:Object):Object {
   if(handler==null||event==null||handler.tapBlocked70||event.target==null)return null;
   var canvas:Object=handler.tapCanvas70;
   if(canvas==null||canvas.desktop==null||canvas.desktop["_-2PB"]())return null;
   if(canvas.roomEngine!=null&&canvas.roomEngine["_-08m"])return null;
   var point:Object=event.target.location;
   if(point==null)return null;
   var hits:Object=handler.tapObjects70(point);
   if(hits==null)return null;
   for each(var object:Object in hits){
    if(object==null)continue;
    var category:int=int(object["_-3YM"]());
    if(category==10||category==20)return object;
   }
   return null;
  }
  public static function singleTap(handler:Object,event:Object):Boolean {
   if(!ClientSettings63.values().dc)return false;
   var object:Object=tappedFurniture(handler,event);
   if(object==null||readerKind(object)!=0)return false;
   var desktop:Object=handler.tapCanvas70.desktop;
   desktop["_-025"]();
   handler["_-2W3"](event.target.location.clone());
   desktop.useObject(object);
   return true;
  }
  public static function readTap(handler:Object,event:Object):Boolean {
   var object:Object=tappedFurniture(handler,event);
   var kind:int=readerKind(object);
   return kind!=0&&present(handler.tapCanvas70.desktop,object,kind);
  }
  public static function holdReader(hits:Object):Boolean {
   return hits!=null&&hits.length>0&&readerKind(hits[0])!=0;
  }
  public static function presentSelection(desktop:Object,object:Object):Boolean {
   // Leave the native selection and move handler in charge.
   return false;
  }
  public static function presentRequest(desktop:Object,event:Object):Boolean {
   return event!=null&&(event.type=="RETWE_REQUEST_PRESENT"||event.type=="RETWE_REQUEST_TROPHY");
  }
  public static function presentEvent(desktop:Object,event:Object):Boolean {
   return event!=null&&(event.type=="ROWRE_PRESENT"||event.type=="ROWRE_TROPHY");
  }
  public static function readChosen74(desktop:Object,object:Object,fromPicker:Boolean=false):Boolean {
   if(desktop==null||desktop["_-2PB"]())return false;
   var kind:int=readerKind(object);
   if(kind==0||object.getModel()==null||desktop["_-22-"]==null)return false;
   if(fromPicker&&!desktop["_-22-"]["_-1Ti"])desktop.showFurnitureMenu74(object);
   return present(desktop,object,kind);
  }
  public static function readerKind(object:Object):int {
   if(object==null)return 0;
   var category:int=int(object["_-3YM"]());
   if(category!=10&&category!=20)return 0;
   var logic:Object=object.getEventHandler();
   if(logic is ClientTheme63.klass("_-2mk::_-fw"))return 1;
   if(logic is ClientTheme63.klass("_-2mk::_-3k"))return 2;
   return 0;
  }
  public static function giftMap(model:Object):Object {
   var map:Object=model.getStringToStringMap("furniture_data");
   if(map==null){var M:Class=ClientTheme63.klass("_-44B::Map");map=new M();}
   var keys:Array=["MESSAGE","PURCHASER_NAME","PURCHASER_FIGURE","PRODUCT_CODE"];
   var fields:Array=["furniture_data","furniture_purchaser_name","furniture_purchaser_figure","furniture_type_id"];
   for(var i:int=0;i<keys.length;i++)if(map.getValue(keys[i])==null){var value:String=model.getString(fields[i]);if(value!=null)map.add(keys[i],value);}
   return map;
  }
  public static function present(desktop:Object,object:Object,kind:int=0):Boolean {
   if(desktop==null||object==null||desktop["_-22-"]==null)return false;
   // Generic Use can also be reached by selection and :dc.
   if(kind==0)return readerKind(object)!=0;
   var model:Object=object.getModel();
   if(model==null)return false;
   if(kind==2){
    readTrophy(model.getString("furniture_data"),int(model.getNumber("furniture_color")));
    return true;
   }
   var data:Object=giftMap(model);
   showPresent(desktop,object,data.getValue("PURCHASER_NAME"),data.getValue("MESSAGE"),
    data.getValue("PURCHASER_FIGURE"),
    data.getValue("TRUSTED_SENDER")=="true"||model.getNumber("furniture_trusted_sender")==1);
   return true;
  }

  private static function ownsGift(desktop:Object,object:Object):Boolean {
   var manager:Object=desktop.sessionDataManager;
   var ownerId:Number=object.getModel().getNumber("furniture_owner_id");
   return manager!=null&&ownerId>0&&ownerId==Number(manager.userId);
  }

  private static function giftAction(open:Boolean):void {
   var gift:Object=_gift;
   if(gift==null)return;
   var desktop:Object=gift.desktop;
   var session:Object=desktop["_-22-"];
   var engine:Object=desktop.roomEngine;
   if(session==null||engine==null||int(session.roomId)!=gift.roomId||
      int(engine["_-0Y"])!=gift.roomId||
      engine["_-46h"](gift.roomId,gift.id,gift.category)!==gift.object||
      !ownsGift(desktop,gift.object)){
    closePresent(null);
    return;
   }
   if(!open&&gift.sender.length==0)return;
   var controller:Object=desktop.presentController73();
   if(controller==null)return;
   controller.prepareGift73(gift.id,gift.sender);
   closePresent(null);
   if(open)controller["_-3EO"]();
   else controller["_-1Fi"]();
  }

  private static function openGift(event:Object):void {giftAction(true);}
  private static function returnGift(event:Object):void {giftAction(false);}

  private static function fit(width:Number,height:Number):Number {
   var stage:Object=Starling.current.stage;
   return Math.min(ClientTheme63.scale(),(stage.stageWidth-24)/width,(stage.stageHeight-24)/height);
  }

  private static function reader(name:String,width:Number,height:Number):Object {
   var Group:Class=ClientTheme63.klass("_-2xS::LayoutGroup");
   var root:Object=new Group();
   root.name=name;
   root.width=width;
   root.height=height;
   return root;
  }

  private static function colorBlock(root:Object,x:Number,y:Number,w:Number,h:Number,color:uint):void {
   var shape:Quad=new Quad(w,h,color);
   shape.x=x;
   shape.y=y;
   shape.touchable=false;
   root.addChild(shape);
  }

  private static function caption(root:Object,value:String,size:Number,color:uint,bold:Boolean,
     align:String,x:Number,y:Number,w:Number,h:Number,italic:Boolean=false):void {
   var label:Object=ClientTheme63.text(value,size,color,bold);
   var format:TextFormat=new TextFormat(italic?(bold?"UbuntuBoldItalic":"UbuntuItalic"):(bold?"UbuntuBold":"Ubuntu"),size,color);
   format.align=align;
   format.italic=italic;
   label.textRendererProperties.textFormat=format;
   ClientTheme63.box(label,x,y,w,h);
   root.addChild(label);
  }

  private static function messageBody(root:Object,message:String,placeholder:String,x:Number,y:Number,
     w:Number,h:Number,size:Number,color:uint,italic:Boolean):void {
   var Container:Class=ClientTheme63.klass("_-2xS::_-4Mu");
   var body:Object=new Container();
   body.horizontalScrollPolicy="off";
   body.verticalScrollPolicy="auto";
   ClientTheme63.box(body,x,y,w,h);
   var label:Object=ClientTheme63.text(message==null||message.length==0?placeholder:Text68.clean(message),size,color);
   var format:TextFormat=new TextFormat(italic?"UbuntuItalic":"Ubuntu",size,color);
   format.italic=italic;
   label.textRendererProperties.textFormat=format;
   label.width=Math.max(1,body.width-10);
   body.addChild(label);
   root.addChild(body);
  }

  private static function showReader(root:Object,modal:Boolean):void {
   _present=root;
   ClientTheme63.popup(root,modal);
   root.x=Math.round((Starling.current.stage.stageWidth-root.width)/2);
   root.y=Math.round((Starling.current.stage.stageHeight-root.height)/2);
  }

  public static function showPresent(desktop:Object,object:Object,sender:String,message:String,figure:String,staff:Boolean):void {
   closePresent(null);
   if(sender==null)sender="";
   var id:int=object.getId();
   var owner:Boolean=id>0&&ownsGift(desktop,object);
   if(owner)_gift={desktop:desktop,object:object,id:id,roomId:int(desktop["_-22-"].roomId),
     category:int(object["_-3YM"]()),sender:sender};
   var height:Number=owner?430:368;
   var u:Number=fit(610,height);
   var w:Number=610*u;
   var h:Number=height*u;
   var root:Object=reader("giftCard73",w,h);

   colorBlock(root,0,0,w,h,0x163d4b);
   colorBlock(root,2*u,2*u,w-4*u,h-4*u,0xe2e3e1);
   colorBlock(root,2*u,2*u,w-4*u,49*u,0x0c748b);
   colorBlock(root,2*u,2*u,w-4*u,23*u,0x2889a1);
   caption(root,staff?"Presente especial!":"Presente",25*u,0xffffff,true,"center",50*u,9*u,w-100*u,37*u);
   var x:Object=ClientTheme63.close(closePresent);
   ClientTheme63.box(x,w-48*u,7*u,38*u,35*u);
   root.addChild(x);

   colorBlock(root,18*u,67*u,w-36*u,73*u,0xffffff);
   colorBlock(root,22*u,71*u,w-44*u,65*u,staff?0x205f10:0x790926);
   colorBlock(root,38*u,89*u,28*u,27*u,staff?0xdbf2cb:0xffdc64);
   caption(root,staff?"+":"!",20*u,0x261c13,true,"center",38*u,89*u,28*u,27*u);
   caption(root,staff?"Presente enviado pela equipe do Habbo.":"Evite abrir links em mensagens de presentes. Eles podem levar a golpes.",
    17*u,0xffffff,true,"left",84*u,80*u,w-124*u,50*u);

   colorBlock(root,18*u,153*u,w-36*u,197*u,0xffffff);
   colorBlock(root,22*u,157*u,w-44*u,189*u,staff?0xdd970e:0xcbd5db);
   colorBlock(root,107*u,162*u,w-135*u,179*u,0xffffff);
   if(figure!=null&&figure.length>0){
    var Portrait:Class=ClientTheme63.klass("loginpatch::Portrait74");
    var head:Object=new Portrait(desktop["_-3lM"],figure,"head",2,77*u,148*u);
    head.name="giftSenderHead74";
    head.x=25*u;
    head.y=177*u;
    root.addChild(head);
   }
   for(var y:int=193;y<311;y+=24)colorBlock(root,117*u,y*u,w-155*u,1*u,0xe0e5e8);
   messageBody(root,message,"Este presente não tem mensagem.",117*u,168*u,w-153*u,144*u,20*u,0x20252a,true);
   if(sender.length>0)
    caption(root,Text68.get("De")+": "+Text68.clean(sender),17*u,0x803147,true,"right",117*u,315*u,w-155*u,23*u,true);

   if(owner){
    var reply:Boolean=!staff&&sender.length>0;
    if(reply){
     var back:Object=ClientTheme63.button("Retribuir presente",returnGift);
     back.name="returnGift73";
     ClientTheme63.paint(back,"blue",19*u);
     ClientTheme63.box(back,22*u,367*u,274*u,43*u);
     root.addChild(back);
    }
    var unwrap:Object=ClientTheme63.button("Abrir presente",openGift,"green");
    unwrap.name="openGift73";
    ClientTheme63.paint(unwrap,"green",19*u);
    ClientTheme63.box(unwrap,(reply?314:168)*u,367*u,274*u,43*u);
    root.addChild(unwrap);
   }
   showReader(root,true);
  }

  private static function readTrophy(data:String,metal:int):void {
   if(data==null)data="";
   var first:int=data.indexOf("\t");
   var second:int=first<0?-1:data.indexOf("\t",first+1);
   if(second<0)showTrophy("",data,"",metal);
   else showTrophy(data.substring(0,first),data.substring(second+1),data.substring(first+1,second),metal);
  }

  private static function showTrophy(sender:String,message:String,date:String,metal:int):void {
   closePresent(null);
   // Air Plus: furniture_color 1 = gold, 2 = silver, 3 = bronze.
   var face:uint=metal==2?0xc9bdcc:metal==3?0xb87834:0xecc547;
   var rim:uint=metal==2?0x5d5367:metal==3?0x582d13:0x8d6119;
   var shine:uint=metal==2?0xf4eff6:metal==3?0xe4aa71:0xffed9c;
   var ink:uint=metal==3?0x211205:0x271e12;
   var u:Number=fit(670,290);
   var w:Number=670*u;
   var h:Number=290*u;
   var root:Object=reader("trophyPlaque73",w,h);
   colorBlock(root,0,0,w,h,rim);
   colorBlock(root,2*u,2*u,w-4*u,h-4*u,shine);
   colorBlock(root,5*u,5*u,w-10*u,h-10*u,face);
   for(var y:int=15;y<=34;y+=4){
    colorBlock(root,16*u,y*u,226*u,1*u,rim);
    colorBlock(root,428*u,y*u,178*u,1*u,rim);
   }
   caption(root,"Troféu",24*u,ink,true,"center",244*u,9*u,182*u,33*u);
   var x:Object=ClientTheme63.button("X",closePresent);
   x.defaultSkin=new Quad(1,1,face);
   x.downSkin=new Quad(1,1,shine);
   x.defaultLabelProperties.textFormat=new TextFormat("UbuntuBold",23*u,rim);
   ClientTheme63.box(x,620*u,9*u,36*u,35*u);
   root.addChild(x);
   messageBody(root,message,"Este troféu não tem dedicatória.",27*u,52*u,w-54*u,182*u,23*u,ink,false);
   colorBlock(root,27*u,240*u,w-54*u,2*u,rim);
   colorBlock(root,27*u,242*u,w-54*u,1*u,shine);
   caption(root,Text68.clean(date),19*u,ink,true,"left",27*u,249*u,225*u,30*u);
   caption(root,Text68.clean(sender),19*u,ink,true,"right",255*u,249*u,388*u,30*u);
   showReader(root,false);
  }

  public static function closePresent(event:Object):void {
   _gift=null;
   if(_present!=null)_present.removeFromParent(true);
   _present=null;
  }
  public static function reset():void {closePresent(null);_handlers=new Dictionary(true);}
 }
}

package loginpatch {
 import flash.utils.Dictionary;
 import flash.utils.getQualifiedClassName;
 import flash.utils.getTimer;
 import flash.display.BitmapData;
 import flash.geom.ColorTransform;
 import starling.core.Starling;
 import starling.display.Image;
 import starling.display.Quad;
 import starling.textures.Texture;
 public final class RoomLighting63 {
  private static var _desktop:Object;
  private static var _object:Object;
  private static var _room:int=-1;
  private static var _category:int=10;
  private static var _kind:String="";
  private static var _popup:Object;
  private static var _sliders:Array=[];
  private static var _labels:Array=[];
  private static var _hex:Object;
  private static var _preview:Quad;
  private static var _onButton:Object;
  private static var _wallsButton:Object;
  private static var _status:Object;
  private static var _on:Boolean;
  private static var _walls:Boolean=false;
  private static var _preset:int=1;
  private static var _presetButtons:Array=[];
  private static var _presets:Array=[];
  private static var _dirty:Boolean=false;
  private static var _loading:Boolean=false;
  private static var _initial:Object;
  private static var _live:Dictionary=new Dictionary(true);
  private static var _payloads:Dictionary=new Dictionary(true);
  private static var _images:Dictionary=new Dictionary(true);
  private static var _materials:Dictionary=new Dictionary(true);
  private static var _tones:Object={};
  private static var _gradients:Array=[];
  private static const COLORS:Array=[7665141,21495,15161822,15353138,15923281,8581961,0];
  private static var _colorButtons:Array=[];
  private static var _baseColor:uint=0xffffff;
  private static var _drafts:Object={};
  private static var _applyButton:Object;
  private static var _savingAt:int=0;
  private static var _expected:Object;
  private static function klass(name:String):Class {return ClientTheme63.klass(name);}
  public static function bind(desktop:Object):void {_desktop=desktop;}
  private static function allowed(desktop:Object):Boolean {
   if(desktop==null)return false;var s:Object=desktop["_-22-"];if(s==null||s.disposed)return false;
   return Boolean(s["_-0lf"])||Boolean(s["_-1Ti"])||(desktop.sessionDataManager!=null&&Boolean(desktop.sessionDataManager.isAnyRoomController));
  }
  private static function valid():Boolean {return _object!=null&&allowed(_desktop)&&int(_desktop["_-22-"].roomId)==_room&&_desktop.roomEngine.connection!=null&&_desktop.roomEngine["_-46h"](_room,int(_object.getId()),_category)===_object;}
  private static function kind(object:Object):String {
   if(object==null||object.getEventHandler()==null)return "";var name:String=getQualifiedClassName(object.getEventHandler());
   return name=="_-2mk::_-0we"?"toner":name=="_-2mk::_-CC"?"dimmer":"";
  }
  public static function onUse(engine:Object,room:int,id:int,category:int):Boolean {
   if(engine==null||(category!=10&&category!=20))return false;var object:Object=engine["_-46h"](room,id,category);var type:String=kind(object);if(type==""||(type=="toner"&&category!=10))return false;
   if(_desktop!=null&&_desktop.roomEngine===engine&&allowed(_desktop)&&int(_desktop["_-22-"].roomId)==room)open(object,type,room,category);
   return true;
  }
  public static function request(desktop:Object,event:Object):Boolean {
   if(event==null||(event.type!="RETWE_REQUEST_BACKGROUND_COLOR"&&event.type!="RETWE_REQUEST_DIMMER"))return false;
   if(!allowed(desktop)||int(desktop["_-22-"].roomId)!=int(event.roomId))return true;
   var object:Object=desktop.roomEngine["_-46h"](int(event.roomId),int(event.objectId),int(event.category));if(object==null||(int(event.category)!=10&&int(event.category)!=20))return true;
   _desktop=desktop;open(object,event.type=="RETWE_REQUEST_DIMMER"?"dimmer":"toner",int(event.roomId),int(event.category));return true;
  }
  private static function byte(n:Number):int {return int(Math.max(0,Math.min(255,Math.round(n))));}
  public static function multiply(color:uint,tint:uint):uint {return uint((int((color>>16&255)*(tint>>16&255)/255)<<16)|(int((color>>8&255)*(tint>>8&255)/255)<<8)|int((color&255)*(tint&255)/255));}
  private static function hsl(color:uint):Array {var C:Class=klass("_-0AB::_-0By");var n:uint=uint(C["_-4Vh"](color));return [n>>16&255,n>>8&255,n&255];}
  private static function rgb(h:int,s:int,l:int):uint {return RoomAppearance61.rgb(h,s,l);}
  private static function hex(color:uint):String {var value:String="000000"+(color&0xffffff).toString(16).toUpperCase();return value.substr(value.length-6);}
  private static function roomState(engine:Object,room:int):Object {var object:Object=engine==null?null:engine["_-46h"](room,room,0);return object==null?null:object.getModel();}
  public static function tint(model:Object):uint {if(model==null)return 0xffffff;var value:Number=Number(model.getNumber("room_background_color"));return isNaN(value)?0xffffff:uint(value);}
  public static function background(room:int,color:uint):uint {var state:Object=_tones[room];return state==null||state.walls?color:multiply(color,uint(state.rgb));}
  public static function legacy(object:Object,data:String):void {
   if(object==null||data==null)return;var parts:Array=data.split(",");if(parts.length<5)return;
   var color:uint=uint(parseInt(String(parts[3]).replace("#",""),16));_live[object]={on:int(parts[0])>1,preset:int(parts[1]),walls:int(parts[2])==2,color:color,light:byte(Number(parts[4]))};
  }
  public static function engineDimmer(engine:Object,event:Object,room:int):void {
   if(engine==null||event==null||event.type!="RODSUE_DIMMER_STATE")return;
   var on:Boolean=int(event.state)!=0;engine["_-3rr"](room,on?uint(event.color):0xffffff,on?int(event["_-2a2"]):255,int(event["_-22W"])==2);
  }
  public static function track(canvas:Object,object:Object,sprite:Object):void {
   if(canvas==null||sprite==null||sprite.image==null)return;
   _images[sprite.image]={canvas:canvas,sprite:sprite,category:int(object["_-3YM"]())};
  }
  public static function frame(canvas:Object):void {
   if(canvas==null)return;var roomObject:Object=canvas.roomObject;var model:Object=roomObject==null?null:roomObject.getModel();var color:uint=tint(model);var walls:Boolean=model==null||Number(model.getNumber("room_colorize_bg_only"))>0;var changed:Boolean=false;
   for(var image:Object in _images){var entry:Object=_images[image];if(image.disposed){delete _images[image];continue;}if(entry.canvas!==canvas)continue;
    var source:Object=entry.sprite;var blend:String=String(source.blendMode);var target:uint=uint(source.color);
    if(!walls&&blend!="add"&&blend!="screen")target=multiply(target,color);
    if(uint(image.color)!=target){image.color=target;changed=true;}
   }
   if(changed)canvas.refreshLighting63();
   if(_desktop!=null&&_desktop===canvas.desktop&&_desktop["_-22-"]!=null&&roomObject!=null){var id:int=int(_desktop["_-22-"].roomId);var before:Object=_tones[id];if(before==null||uint(before.rgb)!=color||Boolean(before.walls)!=walls){_tones[id]={rgb:color,walls:walls};RoomAppearance61.recolor();}}
  }
  private static function copyTransform(c:Object):ColorTransform {return c==null?new ColorTransform():new ColorTransform(c.redMultiplier,c.greenMultiplier,c.blueMultiplier,c.alphaMultiplier,c.redOffset,c.greenOffset,c.blueOffset,c.alphaOffset);}
  public static function planes(visualization:Object):void {
   var object:Object=visualization.lightingObject63;if(object==null)return;var model:Object=object.getModel();if(model==null)return;var color:uint=tint(model);var planes:Array=visualization.lightingPlanes63 as Array;var indices:Array=visualization.lightingIndexes63 as Array;if(planes==null||indices==null)return;
   for(var i:int=0;i<planes.length;i++){
    if(planes[i]==null||int(planes[i].type)==3)continue;var sprite:Object=visualization["_-eh"](int(indices[i]));if(sprite==null||sprite.mesh==null||sprite.mesh.material==null)continue;
    var material:Object=sprite.mesh.material;var state:Object=_materials[material];if(state==null){state={base:copyTransform(material.colorTransform),color:-1};_materials[material]=state;}
    if(Number(state.color)==Number(color))continue;var transform:ColorTransform=copyTransform(state.base);transform.concat(new ColorTransform((color>>16&255)/255,(color>>8&255)/255,(color&255)/255));material.colorTransform=transform;state.color=Number(color);
   }
  }
  public static function payload(composer:Object,values:Array):Array {var data:Array=_payloads[composer] as Array;return data==null?values:data.concat();}
  private static function send(raw:String,values:Array,constructorArgs:Array=null):Boolean {
   if(!valid())return false;var C:Class=klass(raw);var message:Object;
   if(constructorArgs==null)message=new C();else message=new C(constructorArgs[0],constructorArgs[1],constructorArgs[2],constructorArgs[3],constructorArgs[4]);
   _payloads[message]=values;return Boolean(_desktop.roomEngine.connection.send(message));
  }
  public static function presets(parser:Object,data:Object):void {
   var on:Boolean=Boolean(data.readBoolean());var id:int=int(data["_-0u0"]());
   if(!valid()||_kind!="dimmer"||id!=int(_object.getId()))return;
   var presets:Array=[];for(var i:int=0;i<int(parser["_-0JU"]);i++){var p:Object=parser["_-4BJ"](i);if(p!=null)presets.push({id:int(p.id),walls:int(p.type)==2,color:uint(p.color),light:int(p.light),on:on});}
   _presets=presets;if(!_dirty&&_savingAt==0){_preset=Math.max(1,int(parser["_-4IB"]));for each(var item:Object in _presets)if(item.id==_preset){_live[_object]={on:item.on,walls:item.walls,color:item.color,light:item.light,preset:item.id};loadState(item);break;}}
  }
  private static function loadState(state:Object):void {_loading=true;_baseColor=uint(state.color);_on=Boolean(state.on);_walls=Boolean(state.walls);_preset=Math.max(1,int(state.preset==null?state.id:state.preset));_sliders[0].value=Math.max(76,byte(Number(state.light)));_loading=false;draw();}
  private static function open(object:Object,type:String,room:int,category:int=10):void {
   close(null);_object=object;_kind=type;_room=room;_category=category;_dirty=false;_presets=[];_drafts={};_colorButtons=[];_expected=null;_savingAt=0;var model:Object=object.getModel();var values:Array;
   var live:Object=_live[object];_on=int(object.getState(0))!=0;_walls=live==null?false:Boolean(live.walls);_preset=live==null?1:Math.max(1,int(live.preset));
   if(type=="toner")values=[byte(Number(model.getNumber("furniture_room_background_color_hue"))),byte(Number(model.getNumber("furniture_room_background_color_saturation"))),byte(Number(model.getNumber("furniture_room_background_color_lightness")))];
   else {_baseColor=live==null?0xffffff:uint(live.color);values=[live==null?255:Math.max(76,byte(Number(live.light)))];_on=live==null?_on:Boolean(live.on);}
   _initial={on:_on,walls:_walls,color:type=="dimmer"?_baseColor:rgb(int(values[0]),int(values[1]),127),light:int(values[type=="dimmer"?0:2]),preset:_preset,h:int(values[0]),s:int(values[1]),l:int(values[2])};
   var u:Number=ClientTheme63.scale();var w:Number=Math.min(570*u,Starling.current.stage.stageWidth-24*u);var h:Number=Math.min((type=="dimmer"?610:610)*u,Starling.current.stage.stageHeight-24*u);var root:Object=ClientTheme63.group();root.name="roomLighting63";root.width=w;root.height=h;
   var title:Object=ClientTheme63.text(type=="toner"?"Toner de fundo":"Regulador de luz",27*u,0xffffff,true);ClientTheme63.box(title,22*u,18*u,w-90*u,40*u);root.addChild(title);var x:Object=ClientTheme63.close(close);ClientTheme63.box(x,w-61*u,12*u,46*u,44*u);root.addChild(x);
   var Scroll:Class=klass("_-2xS::_-4Mu");var body:Object=new Scroll();body.horizontalScrollPolicy="off";body.verticalScrollPolicy="auto";ClientTheme63.box(body,18*u,70*u,w-36*u,h-154*u);root.addChild(body);var inner:Number=w-56*u;
   _preview=new Quad(inner,42*u,0);_preview.touchable=false;body.addChild(_preview);_sliders=[];_labels=[];_loading=true;var titles:Array=["Matiz (HUE)","Saturação","Luminosidade"];var Slider:Class=klass("_-2xS::_-Fh");
   if(type=="dimmer"){
    var colorsLabel:Object=ClientTheme63.text("Cor da iluminação",20*u);ClientTheme63.box(colorsLabel,4*u,58*u,inner,30*u);body.addChild(colorsLabel);
    for(var j:int=0;j<COLORS.length;j++){var swatch:Object=ClientTheme63.button("",colorChanged);swatch.name=String(j);ClientTheme63.box(swatch,j*inner/7,96*u,inner/7-5*u,48*u);body.addChild(swatch);_colorButtons.push(swatch);}
   }
   for(var i:int=0;i<(type=="toner"?3:1);i++){
    var label:Object=ClientTheme63.text(type=="toner"?titles[i]:"Intensidade",20*u);ClientTheme63.box(label,4*u,(type=="toner"?58+i*92:166)*u,inner,29*u);body.addChild(label);_labels.push(label);
    var slider:Object=new Slider();slider.minimum=type=="dimmer"?76:0;slider.maximum=255;slider.step=1;slider.value=int(values[i]);slider.addEventListener("change",changed);ClientTheme63.box(slider,4*u,(type=="toner"?92+i*92:205)*u,inner-8*u,43*u);body.addChild(slider);_sliders.push(slider);
   }
   _loading=false;var rowY:Number=(type=="toner"?342:276)*u;
   _onButton=ClientTheme63.button("",toggle);ClientTheme63.box(_onButton,2*u,rowY,108*u,48*u);body.addChild(_onButton);
   var hexLabel:Object=ClientTheme63.text("#",25*u);ClientTheme63.box(hexLabel,inner-166*u,rowY+6*u,20*u,36*u);body.addChild(hexLabel);
   var TextInput:Class=klass("_-2xS::_-1XI");_hex=new TextInput();_hex.restrict="0-9a-fA-F";_hex.maxChars=6;_hex.isEnabled=type=="toner";_hex.addEventListener("enter",hexChanged);_hex.addEventListener("focusOut",hexChanged);ClientTheme63.box(_hex,inner-140*u,rowY,140*u,48*u);body.addChild(_hex);
   _wallsButton=null;_presetButtons=[];
   if(type=="dimmer"){
    _wallsButton=ClientTheme63.button("",wallsChanged);ClientTheme63.box(_wallsButton,2*u,rowY+65*u,inner,44*u);body.addChild(_wallsButton);
    for(i=1;i<=3;i++){var b:Object=ClientTheme63.button("Preset "+i,presetChanged);b.name=String(i);ClientTheme63.box(b,(i-1)*(inner/3+2*u),rowY+123*u,inner/3-6*u,44*u);body.addChild(b);_presetButtons.push(b);}
   }
   var cancel:Object=ClientTheme63.button("Cancelar",close,"red");ClientTheme63.box(cancel,22*u,h-76*u,(w-56*u)/2,48*u);root.addChild(cancel);_applyButton=ClientTheme63.button("Aplicar",RoomLighting63.save,"green");ClientTheme63.box(_applyButton,w/2+6*u,h-76*u,(w-56*u)/2,48*u);root.addChild(_applyButton);
   _status=ClientTheme63.text("",15*u,0xbbcdd4);ClientTheme63.box(_status,24*u,h-26*u,w-48*u,22*u);root.addChild(_status);_popup=root;ClientTheme63.frame(root);draw();ClientTheme63.popup(root,false);root.x=Starling.current.stage.stageWidth-w-12*u;root.y=(Starling.current.stage.stageHeight-h)/2;root.addEventListener("enterFrame",refresh);
   if(type=="toner")for(i=0;i<3;i++)gradient(_sliders[i],i);
   if(type=="dimmer")send("_-26z::_-57",[int(object.getId())]);
  }
  private static function fillGradient(bitmap:BitmapData,index:int):void {
   for(var x:int=0;x<256;x++)bitmap.setPixel(x,0,rgb(index==0?x:int(_sliders[0].value),index==0?255:index==1?x:int(_sliders[1].value),index==2?x:127));
  }
  private static function gradient(slider:Object,index:int):void {
   var bitmap:BitmapData=new BitmapData(256,1,false,0);fillGradient(bitmap,index);var texture:Texture=Texture.fromBitmapData(bitmap,false);var image:Image=new Image(texture);image.smoothing="none";_gradients[index]={bitmap:bitmap,texture:texture,h:int(_sliders[0].value),s:int(_sliders[1].value)};
   slider.validate();slider["_-3NQ"].stateToSkinFunction=null;slider["_-3NQ"].defaultSkin=image;
  }
  private static function updateGradients():void {
   for(var i:int=1;i<3;i++){var state:Object=_gradients[i];if(state==null)continue;var h:int=int(_sliders[0].value);var s:int=int(_sliders[1].value);if(state.h==h&&(i==1||state.s==s))continue;fillGradient(state.bitmap as BitmapData,i);state.texture.root.uploadBitmapData(state.bitmap);state.h=h;state.s=s;}
  }
  private static function draw():void {
   if(_popup==null||_sliders.length==0)return;var color:uint;
   if(_kind=="toner"){color=rgb(int(_sliders[0].value),int(_sliders[1].value),int(_sliders[2].value));_labels[0].text="Matiz (HUE)  "+Math.round(Number(_sliders[0].value)*360/255)+"°";_labels[1].text="Saturação  "+Math.round(Number(_sliders[1].value)*100/255)+"%";_labels[2].text="Luminosidade  "+Math.round(Number(_sliders[2].value)*100/255)+"%";}
   else {color=_baseColor;_labels[0].text="Intensidade  "+Math.round((Number(_sliders[0].value)-76)*100/179)+"%";for(var k:int=0;k<_colorButtons.length;k++)ModernUI65.swatch(_colorButtons[k],uint(COLORS[k]),uint(COLORS[k])==_baseColor);}
   _preview.color=color;_hex.text=hex(color);
   ClientTheme63.switchState(_onButton,_on,18*ClientTheme63.scale());if(_wallsButton!=null){_wallsButton.label=_walls?"Somente piso e paredes: ON":"Somente piso e paredes: OFF";ClientTheme63.paint(_wallsButton,_walls?"green":"blue",18*ClientTheme63.scale());}
   for(var i:int=0;i<_presetButtons.length;i++)ClientTheme63.paint(_presetButtons[i],i+1==_preset?"green":"blue",17*ClientTheme63.scale());
   if(_kind=="toner")updateGradients();if(_dirty)preview();
  }
  private static function preview():void {
   if(!valid())return;
   if(_kind=="toner")_desktop["_-YU"](_on?int(_sliders[0].value):0,_on?int(_sliders[1].value):0,_on?int(_sliders[2].value):0);
   else _desktop.roomEngine["_-3rr"](_room,_on?_baseColor:0xffffff,_on?Math.max(76,int(_sliders[0].value)):255,_walls);
  }
  private static function restore():void {
   if(_desktop==null||_object==null||_desktop["_-22-"]==null||_desktop["_-22-"].disposed||int(_desktop["_-22-"].roomId)!=_room||_desktop.roomEngine["_-46h"](_room,int(_object.getId()),_category)!==_object)return;
   if(_kind=="toner"){
    var model:Object=_object.getModel();var on:Boolean=int(_object.getState(0))!=0;_desktop["_-YU"](on?byte(Number(model.getNumber("furniture_room_background_color_hue"))):0,on?byte(Number(model.getNumber("furniture_room_background_color_saturation"))):0,on?byte(Number(model.getNumber("furniture_room_background_color_lightness"))):0);
   }else{var state:Object=_live[_object];if(state==null)state=_initial;if(state!=null)_desktop.roomEngine["_-3rr"](_room,state.on?uint(state.color):0xffffff,state.on?int(state.light):255,Boolean(state.walls));}
  }
  public static function changed(event:Object):void {if(_loading||_popup==null||_savingAt!=0)return;_dirty=true;draw();}
  public static function hexChanged(event:Object):void {
   if(_popup==null||_kind!="toner"||_savingAt!=0)return;var value:String=String(_hex.text);if(!/^[0-9a-fA-F]{6}$/.test(value)){_status.text="Use uma cor hexadecimal com 6 dígitos.";return;}
   var values:Array=hsl(uint(parseInt(value,16)));_loading=true;for(var i:int=0;i<3;i++)_sliders[i].value=int(values[i]);_loading=false;_dirty=true;_status.text="";draw();
  }
  public static function toggle(event:Object):void {if(_savingAt!=0)return;_on=!_on;_dirty=true;draw();}
  public static function wallsChanged(event:Object):void {if(_savingAt!=0)return;_walls=!_walls;_dirty=true;draw();}
  public static function colorChanged(event:Object):void {if(_savingAt!=0)return;var index:int=int(event.currentTarget.name);if(index<0||index>=COLORS.length)return;_baseColor=uint(COLORS[index]);_dirty=true;draw();}
  private static function draft():Object {return {id:_preset,preset:_preset,on:_on,walls:_walls,color:_baseColor,light:Math.max(76,byte(Number(_sliders[0].value)))};}
  public static function presetChanged(event:Object):void {if(_savingAt!=0)return;_drafts[_preset]=draft();var chosen:int=int(event.currentTarget.name);var item:Object=_drafts[chosen];if(item==null)for each(var p:Object in _presets)if(int(p.id)==chosen){item=p;break;}if(item==null)item={id:chosen,on:_on,walls:false,color:COLORS[0],light:255};var on:Boolean=_on;loadState(item);_on=on;_preset=chosen;_dirty=true;draw();}
  public static function save(event:Object):void {
   if(_savingAt!=0)return;if(!valid()){close(null);return;}
   if(!/^[0-9a-fA-F]{6}$/.test(String(_hex.text))){_status.text="Use uma cor hexadecimal com 6 dígitos.";return;}
   if(_kind=="toner"&&String(_hex.text).toUpperCase()!=hex(rgb(int(_sliders[0].value),int(_sliders[1].value),int(_sliders[2].value))))hexChanged(null);
   var ok:Boolean=false;var id:int=int(_object.getId());var C:Class;
   if(_kind=="toner"){
    _expected={on:_on,h:byte(Number(_sliders[0].value)),s:byte(Number(_sliders[1].value)),l:byte(Number(_sliders[2].value))};
    C=klass("_-26z::_-120");ok=Boolean(_desktop.roomEngine.connection.send(new C(id,byte(Number(_sliders[0].value)),byte(Number(_sliders[1].value)),byte(Number(_sliders[2].value)))));
    if(ok&&_on!=(int(_object.getState(0))!=0)){C=klass("_-3eU::_-3D8");ok=Boolean(_desktop.roomEngine.connection.send(new C(id)));}
   }else{
    _drafts[_preset]=draft();_expected=draft();var current:Object=_live[_object];var wasOn:Boolean=current==null?Boolean(_initial.on):Boolean(current.on);ok=true;
    if(_on&&!wasOn)ok=send("_-26z::_-1cO",[id]);
    for each(var d:Object in _drafts)if(int(d.id)!=_preset&&ok)ok=sendPreset(d,false,id);
    if(ok)ok=sendPreset(_expected,_on,id);
    if(ok&&!_on&&wasOn)ok=send("_-26z::_-1cO",[id]);
    if(ok)ok=send("_-26z::_-57",[id]);
   }
   if(ok){_savingAt=Math.max(1,getTimer());_applyButton.isEnabled=false;_status.text="Aguardando confirmação do quarto…";}else {_expected=null;_status.text="Não foi possível enviar. Tente novamente.";}
  }
  private static function sendPreset(d:Object,apply:Boolean,id:int):Boolean {var base:String="#"+hex(uint(d.color));var values:Array=[int(d.id),d.walls?2:1,base,int(Math.max(76,byte(Number(d.light)))),apply];return send("_-26z::_-05v",[values[0],values[1],base,values[3],apply,false,id],values);}
  private static function confirmed():Boolean {
   if(_expected==null)return false;var model:Object=_object.getModel();
   if(_kind=="toner")return (int(_object.getState(0))!=0)==Boolean(_expected.on)&&byte(Number(model.getNumber("furniture_room_background_color_hue")))==int(_expected.h)&&byte(Number(model.getNumber("furniture_room_background_color_saturation")))==int(_expected.s)&&byte(Number(model.getNumber("furniture_room_background_color_lightness")))==int(_expected.l);
   var live:Object=_live[_object];if(live==null||Boolean(live.on)!=Boolean(_expected.on))return false;
   for each(var d:Object in _drafts){var found:Boolean=false;for each(var p:Object in _presets)if(int(p.id)==int(d.id)&&uint(p.color)==uint(d.color)&&int(p.light)==int(d.light)&&Boolean(p.walls)==Boolean(d.walls)){found=true;break;}if(!found)return false;}
   return !_expected.on||(int(live.preset)==_preset&&uint(live.color)==uint(_expected.color)&&int(live.light)==int(_expected.light)&&Boolean(live.walls)==Boolean(_expected.walls));
  }
  public static function refresh(event:Object):void {if(!valid()){close(null);return;}if(_savingAt!=0){if(confirmed()){_dirty=false;close(null);}else if(getTimer()-_savingAt>7000){_savingAt=0;_expected=null;_applyButton.isEnabled=true;_status.text="O quarto ainda não confirmou. Tente aplicar novamente.";}}}
  public static function close(event:Object):void {if(_dirty&&_popup!=null)restore();_dirty=false;_savingAt=0;_expected=null;_drafts={};_colorButtons=[];_applyButton=null;for each(var gradientState:Object in _gradients){if(gradientState!=null){gradientState.texture.dispose();gradientState.bitmap.dispose();}}_gradients=[];if(_popup!=null){ClientTheme63.releaseFrame(_popup);_popup.removeEventListener("enterFrame",refresh);_popup.removeFromParent(true);}_popup=null;_object=null;_room=-1;_category=10;_kind="";_sliders=[];_labels=[];_preview=null;_hex=null;_status=null;_onButton=null;_wallsButton=null;_presetButtons=[];_presets=[];_initial=null;}
  public static function release(desktop:Object):void {if(desktop!==_desktop)return;close(null);if(desktop!=null&&desktop["_-22-"]!=null)delete _tones[int(desktop["_-22-"].roomId)];_desktop=null;_images=new Dictionary(true);_materials=new Dictionary(true);_live=new Dictionary(true);}
 }
}

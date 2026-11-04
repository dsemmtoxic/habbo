package loginpatch
{
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class FloorEditor22
   {
      
      private static var _ui:Object;
      
      private static var _root:Object;
      
      private static var _card:Object;
      
      private static var _model:Object;
      
      private static var _original:Object;
      
      private static var _entry:Object;
      
      private static var _occupied:Array;
      
      private static var _atlas:Object;
      
      private static var _connection:Object;
      
      private static var _editPanel:Object;
      
      private static var _previewImage:Object;
      
      private static var _previewTexture:Object;
      
      private static var _previewData:BitmapData;
      
      private static var _retireStage:Object;
      
      private static var _editHit:Object;
      
      private static var _editImage:Object;
      
      private static var _editTexture:Object;
      
      private static var _editData:BitmapData;
      
      private static var _previewHit:Object;
      
      private static var _previewHolder:Object;
      
      private static var _previewCanvas:Object;
      
      private static var _previewDisplay:Object;
      
      private static var _previewPan:Object;
      
      private static var _directionImage:Object;
      
      private static var _directionTexture:Object;
      
      private static var _directionData:BitmapData;
      
      private static var _drawLabel:Object;
      
      private static var _wallLabel:Object;
      
      private static var _areaLabel:Object;
      
      private static var _status:Object;
      
      private static var _save:Object;
      
      private static var _wallButton:Object;
      
      private static var _floorButton:Object;
      
      private static var _heightHandle:Object;
      
      private static var _wallHandle:Object;
      
      private static var _confirm:Object;
      
      private static var _nativeStage:Object;
      
      private static var _lastTile:Object;
      
      private static var _stroke:Object;
      
      private static var _pan:Object;
      
      private static var _room:int = -1;
      
      private static var _map:String = "";
      
      private static var _fixed:int = -1;
      
      private static var _wall:int = 0;
      
      private static var _floor:int = 0;
      
      private static var _largePlans:Boolean = false;
      
      private static var _entryReady:Boolean = false;
      
      private static var _occupiedReady:Boolean = false;
      
      private static var _requestSent:Boolean = false;
      
      private static var _saving:Boolean = false;
      
      private static var _saveTime:int = 0;
      
      private static var _waitingSince:int = 0;
      
      private static var _mode:String = "add";
      
      private static var _level:int = 0;
      
      private static var _buttons:Dictionary = new Dictionary(true);
      
      private static var _modeButtons:Array = [];
      
      private static var _textures:Array = [];
      
      private static var _bitmaps:Array = [];
      
      private static var _frames:Object = {
         "add":[0,0,40,40],
         "entry":[41,0,40,40],
         "lower":[82,0,40,40],
         "raise":[123,0,40,40],
         "remove":[164,0,40,40],
         "slider":[205,0,12,15],
         "stepDown":[218,0,16,10],
         "stepUp":[235,0,16,10],
         "zoomIn":[252,0,43,44],
         "zoomOut":[296,0,43,44]
      };
      
      private static var _events:Array = [];
      
      private static var _editDirty:Boolean = false;
      
      private static var _directionDirty:Boolean = false;
      
      private static var _assetsDirty:Boolean = false;
      
      private static var _closing:Boolean = false;
      
      private static var _retired:Array = [];
      
      private static var _mapBaseX:Number = 0;
      
      private static var _previewRoom:int = 0;
      
      private static var _previewDirty:Boolean = false;
      
      private static var _previewUntil:int = 0;
      
      private static var _lastFrame:int = 0;
      
      private static var _previewZoom:Number = 1;
      
      private static var _previewOffset:Point = new Point();
      
      private static var _size:String = "";
      
      private static var _zoom:Number = 1;
      
      private static var _originX:Number = 0;
      
      private static var _originY:Number = 0;
      
      private static var _seen:Object = {};
      
      private static var _panning:Boolean = false;
      
      public function FloorEditor22()
      {
         super();
      }
      
      private static function klass(n:String) : Class
      {
         return getDefinitionByName(n) as Class;
      }
      
      private static function patch() : Class
      {
         return klass("loginpatch::HabboTicketLogin");
      }
      
      private static function stage() : Object
      {
         return klass("starling.core::Starling").current.stage;
      }
      
      private static function text(k:String, fallback:String = "") : String
      {
         var L:Class = klass("loginpatch::FloorStrings22");
         var s:Object = L.getText(patch().floorLanguage(),k);
         return s == null ? (fallback == "" ? k : fallback) : String(s);
      }
      
      private static function group(w:Number, h:Number, color:uint = 0, bg:Boolean = true) : Object
      {
         var G:Class = klass("_-2xS::LayoutGroup");
         var g:Object = new G();
         g.width = w;
         g.height = h;
         if(bg)
         {
            var Q:Class = klass("starling.display::Quad");
            g.backgroundSkin = new Q(w,h,color);
         }
         return g;
      }
      
      private static function quad(parent:Object, x:Number, y:Number, w:Number, h:Number, c:uint) : Object
      {
         var Q:Class = klass("starling.display::Quad");
         var q:Object = new Q(w,h,c);
         q.x = x;
         q.y = y;
         parent.addChild(q);
         return q;
      }
      
      private static function label(s:String, x:Number, y:Number, w:Number, size:Number = 26, color:uint = 0) : Object
      {
         var L:Class = klass("_-2xS::_-Fk");
         var l:Object = new L();
         l.validate();
         l.text = s;
         l.touchable = false;
         l.wordWrap = false;
         l.textRendererProperties.textFormat = new TextFormat("Ubuntu",size,color);
         l.textRendererProperties.embedFonts = true;
         l.x = x;
         l.y = y;
         l.width = w;
         _card.addChild(l);
         return l;
      }
      
      private static function image(data:BitmapData) : Object
      {
         var T:Class = klass("starling.textures::Texture");
         var t:Object = T.fromBitmapData(data,false,false,1);
         _textures.push(t);
         _bitmaps.push(data);
         var I:Class = klass("starling.display::Image");
         var im:Object = new I(t);
         im.touchable = false;
         im.smoothing = "none";
         return im;
      }
      
      private static function icon(n:String) : Object
      {
         var r:Array = _frames[n];
         if(r == null)
         {
            throw new ArgumentError("Missing editor icon " + n);
         }
         if(_atlas == null)
         {
            var A:Class = klass("loginpatch::FloorAtlas22");
            _atlas = new A();
         }
         var b:BitmapData = new BitmapData(r[2],r[3],true,0);
         b.copyPixels(_atlas.bitmapData,new Rectangle(r[0],r[1],r[2],r[3]),new Point());
         return image(b);
      }
      
      private static function makeButton(action:String, s:String, x:Number, y:Number, w:Number, h:Number, c:uint = 12765130, ic:String = "") : Object
      {
         var B:Class = klass("_-2xS::Button");
         var b:Object = new B();
         b.label = s;
         b.x = x;
         b.y = y;
         b.width = w;
         b.height = h;
         var skin:Object = group(w,h,c);
         quad(skin,0,0,w,4,16777215).touchable = false;
         quad(skin,0,h - 4,w,4,10527653).touchable = false;
         var down:Object = group(w,h,10267573);
         _buttons[b] = {
            "action":action,
            "skin":skin,
            "down":down,
            "width":w,
            "height":h
         };
         b.addEventListener("addedToStage",buttonAdded);
         b.addEventListener("triggered",actionTriggered);
         _card.addChild(b);
         installButton(b);
         if(ic != "")
         {
            var im:Object = icon(ic);
            if(ic.indexOf("zoom") == 0)
            {
               im.scaleX = im.scaleY = 0.82;
            }
            b.defaultIcon = im;
         }
         return b;
      }
      
      private static function installButton(b:Object) : void
      {
         var v:Object = _buttons[b];
         if(v == null)
         {
            return;
         }
         b.validate();
         b.stateToSkinFunction = null;
         b.defaultSkin = v.skin;
         b.downSkin = v.down;
         b.minWidth = b.minHeight = 0;
         b.padding = 0;
         if(v.rightPadding != null)
         {
            b.paddingRight = v.rightPadding;
         }
         b.defaultLabelProperties.textFormat = new TextFormat("Ubuntu",25,v.action == "close" || v.action == "save" || v.action == "reset" ? 16777215 : 0);
         b.defaultLabelProperties.embedFonts = true;
         if(v.action == "save" || v.action == "keep" || v.action == "discardClose" || v.action == "discardReset")
         {
            b.defaultLabelProperties.wordWrap = true;
         }
         b.validate();
         b.width = v.width;
         b.height = v.height;
      }
      
      public static function buttonAdded(e:Object) : void
      {
         installButton(e.currentTarget);
      }
      
      private static function badge(x:Number, y:Number, c:uint) : void
      {
         var s:Shape = new Shape();
         s.graphics.lineStyle(3,c);
         s.graphics.beginFill(0);
         s.graphics.drawCircle(24,24,21);
         s.graphics.endFill();
         var b:BitmapData = new BitmapData(48,48,true,0);
         b.draw(s);
         var im:Object = image(b);
         im.x = x;
         im.y = y;
         _card.addChild(im);
      }
      
      private static function glove() : Object
      {
         var s:Shape = new Shape();
         var g:Object = s.graphics;
         g.lineStyle(2,1381653);
         g.beginFill(16777215);
         g.moveTo(11,21);
         g.lineTo(7,17);
         g.curveTo(1,15,3,22);
         g.lineTo(9,31);
         g.lineTo(12,37);
         g.lineTo(30,37);
         g.lineTo(35,25);
         g.lineTo(36,13);
         g.curveTo(35,9,32,12);
         g.lineTo(30,23);
         g.lineTo(30,7);
         g.curveTo(28,2,25,7);
         g.lineTo(24,22);
         g.lineTo(23,4);
         g.curveTo(20,0,18,5);
         g.lineTo(18,22);
         g.lineTo(16,9);
         g.curveTo(12,5,11,10);
         g.lineTo(11,21);
         g.endFill();
         g.lineStyle(1,11712443);
         g.moveTo(13,30);
         g.lineTo(28,30);
         var b:BitmapData = new BitmapData(40,40,true,0);
         b.draw(s);
         return image(b);
      }
      
      public static function observe(kind:String, p:Object) : void
      {
         if(kind == "perks")
         {
            _largePlans = Boolean(p["_-Pl"]("BUILDER_AT_WORK"));
            if(_model != null)
            {
               _model.largePlans = _largePlans;
            }
         }
         else if(kind == "map")
         {
            _map = String(p.text);
            _fixed = int(p.fixedWallsHeight);
            if(_root != null && _saving)
            {
               close();
               return;
            }
            if(_root != null && _model == null)
            {
               initializeModel();
            }
         }
         else if(kind == "visual")
         {
            _wall = Math.round(Math.log(Number(p["_-33a"])) / Math.LN2);
            _floor = Math.round(Math.log(Number(p["_-2Hr"])) / Math.LN2);
         }
         else if(kind == "entry" && _root != null && _requestSent && !_entryReady)
         {
            _entry = {
               "x":int(p.x),
               "y":int(p.y),
               "dir":int(p.dir)
            };
            _entryReady = true;
            if(_model != null)
            {
               _model.entryX = _entry.x;
               _model.entryY = _entry.y;
               _model.direction = _entry.dir;
            }
            initialized();
         }
         else if(kind == "occupied" && _root != null && _requestSent && !_occupiedReady)
         {
            _occupied = p["_-0Go"].concat();
            _occupiedReady = true;
            if(_model != null)
            {
               _model.setOccupied(_occupied);
            }
            initialized();
         }
      }
      
      public static function open(ui:Object) : Boolean
      {
         if(ui != null && "habboUI" in ui)
         {
            ui = ui.habboUI;
         }
         if(ui == null || ui.disposed || ui.roomEngine == null)
         {
            return false;
         }
         var room:int = int(ui.roomEngine["_-0Y"]);
         var session:Object = ui["_-4Ej"].getSession(room);
         if(session == null || session.disposed || !session["_-0lf"])
         {
            patch().floorAlert(text("floorplaneditor.title"),text("floor22.owner"));
            return false;
         }
         if(_root != null)
         {
            if(_room == room && _root.parent != null && _root.visible)
            {
               return true;
            }
            close();
         }
         sweepWindows();
         _ui = ui;
         _room = room;
         _entry = null;
         _occupied = null;
         _entryReady = _occupiedReady = false;
         _saving = false;
         _model = _original = null;
         _mode = "add";
         _level = 0;
         _previewZoom = 1;
         _previewOffset = new Point();
         _waitingSince = getTimer();
         _requestSent = true;
         patch().dismissMottoKeyboard(null);
         subscribe(ui.communication.connection);
         build();
         initializeModel();
         var E:Class = klass("loginpatch::FloorEntryRequest22");
         var O:Class = klass("loginpatch::FloorOccupiedRequest22");
         ui.communication.connection.send(new E());
         ui.communication.connection.send(new O());
         return true;
      }
      
      private static function subscribe(connection:Object) : void
      {
         _connection = connection;
         for each(var n:String in ["_-31r::_-l","_-31r::_-2jX"])
         {
            var C:Class = klass(n);
            var e:Object = new C(floorMessage);
            _events.push(e);
            _connection.addMessageEvent(e);
         }
      }
      
      public static function floorMessage(e:Object) : void
      {
      }
      
      private static function unsubscribe() : void
      {
         var e:Object;
         var c:Object = _connection;
         var events:Array = _events;
         _events = [];
         _connection = null;
         if(c != null)
         {
            for each(e in events)
            {
               try
               {
                  c.removeMessageEvent(e);
               }
               catch(error:Error)
               {
               }
            }
         }
      }
      
      private static function initializeModel() : void
      {
         if(_map == "" || _root == null)
         {
            return;
         }
         var M:Class = klass("loginpatch::FloorPlanModel22");
         _model = new M(_map,_fixed);
         _model.largePlans = _largePlans;
         _model.wallThickness = _wall;
         _model.floorThickness = _floor;
         if(_entryReady)
         {
            _model.entryX = _entry.x;
            _model.entryY = _entry.y;
            _model.direction = _entry.dir;
         }
         if(_occupiedReady)
         {
            _model.setOccupied(_occupied);
         }
         centerMap();
         initialized();
      }
      
      private static function initialized() : void
      {
         if(_model != null && _entryReady && _occupiedReady && _original == null)
         {
            _original = _model.snapshot();
         }
         if(_root != null)
         {
            refresh();
            renderMap();
            drawDirection();
            _previewDirty = true;
         }
      }
      
      public static function canSave() : Boolean
      {
         if(_ui == null || _ui.disposed || _ui.roomEngine == null || int(_ui.roomEngine["_-0Y"]) != _room)
         {
            return false;
         }
         var s:Object = _ui["_-4Ej"].getSession(_room);
         return s != null && !s.disposed && Boolean(s["_-0lf"]) && _ui.catalog != null && Number(_ui.catalog["_-3R6"]) > 0;
      }
      
      public static function save(source:Object = null) : Boolean
      {
         if(_model == null || !_entryReady || !_occupiedReady || _saving || !canSave())
         {
            return false;
         }
         var error:String = _model.errorKey();
         if(error != "")
         {
            _status.text = text("notification.floorplan_editor.error.message." + error,text("floorplaneditor.saving.fail"));
            return false;
         }
         var C:Class = klass("_-1n9::_-1pM");
         _saving = true;
         _save.isEnabled = false;
         _status.text = text("floor22.saving");
         var sent:Boolean = Boolean(_ui.communication.connection.send(new C(_model.data(),int(_model.entryX),int(_model.entryY),int(_model.direction),int(_model.wallThickness),int(_model.floorThickness),int(_model.wallHeight))));
         if(!sent)
         {
            _saving = false;
            _save.isEnabled = true;
            _status.text = text("floorplaneditor.saving.fail");
            return false;
         }
         close(source == null ? _save : source);
         return true;
      }
      
      private static function build() : void
      {
         var Container:Class = klass("starling.display::Sprite");
         _root = new Container();
         _root.name = "floorPlanEditor30";
         var shade:Object = quad(_root,0,0,stage().stageWidth,stage().stageHeight,0);
         shade.alpha = 0.45;
         _card = new Container();
         _card.name = "floorPlanEditorCard30";
         quad(_card,0,0,1200,700,14606046).touchable = false;
         _root.addChild(_card);
         quad(_card,0,0,1200,70,12413440).touchable = false;
         quad(_card,0,0,1200,34,13009191).touchable = false;
         var title:Object = label(text("floorplaneditor.title") + " · T30",70,10,1060,34,16777215);
         title.textRendererProperties.textFormat.align = "center";
         makeButton("close","×",1137,7,56,55,13500416);
         label(text("floor.plan.editor.draw.mode"),22,88,570);
         var modes:Array = ["add","remove","raise","lower","entry","move"];
         var i:int = 0;
         while(i < 6)
         {
            var b:Object = makeButton("mode:" + modes[i],"",22 + i * 97,130,82,57,12699079,i < 5 ? modes[i] : "");
            _modeButtons.push(b);
            if(i == 5)
            {
               b.defaultIcon = glove();
            }
            i++;
         }
         label(text("floorplaneditor.enter.direction.label"),655,88,275,25);
         makeButton("direction","",688,133,114,63,14606046);
         _directionData = new BitmapData(108,60,true,0);
         var T:Class = klass("starling.textures::Texture");
         _directionTexture = T.fromBitmapData(_directionData,false,false,1);
         var I:Class = klass("starling.display::Image");
         _directionImage = new I(_directionTexture);
         _directionImage.x = 691;
         _directionImage.y = 133;
         _directionImage.touchable = false;
         _card.addChild(_directionImage);
         label(text("floorplaneditor.look.feel.label"),966,88,220,25);
         _wallButton = makeButton("wallThickness","",932,130,246,54);
         _floorButton = makeButton("floorThickness","",932,193,246,54);
         badge(21,221,1347302);
         _drawLabel = label("0",22,227,46,25,16777215);
         _drawLabel.textRendererProperties.textFormat.align = "center";
         label(text("floorplaneditor.draw.height.label"),82,232,270,25);
         _areaLabel = label("",376,209,226,23);
         _areaLabel.wordWrap = true;
         _areaLabel.height = 63;
         _areaLabel.textRendererProperties.textFormat.align = "right";
         badge(619,221,16777215);
         _wallLabel = label("",620,227,46,23,16777215);
         _wallLabel.textRendererProperties.textFormat.align = "center";
         label(text("floorplaneditor.wall.height.label"),688,232,265,25);
         quad(_card,22,275,43,329,16777215).touchable = false;
         var hit:Object = quad(_card,26,279,35,321,3355443);
         hit.addEventListener("touch",heightTouched);
         i = 0;
         while(i < 30)
         {
            quad(_card,45,279 + (29 - i) * 321 / 30,15,321 / 30 + 1,heightColor(i)).touchable = false;
            i++;
         }
         _heightHandle = icon("slider");
         _heightHandle.x = 24;
         _heightHandle.width = 32;
         _heightHandle.height = 24;
         _card.addChild(_heightHandle);
         quad(_card,620,275,43,329,16777215).touchable = false;
         hit = quad(_card,624,279,35,321,3355443);
         hit.addEventListener("touch",wallHeightTouched);
         i = 0;
         while(i <= 16)
         {
            quad(_card,644,279 + i * 321 / 17,15,2,12895428).touchable = false;
            i++;
         }
         _wallHandle = icon("slider");
         _wallHandle.x = 622;
         _wallHandle.width = 32;
         _wallHandle.height = 24;
         _card.addChild(_wallHandle);
         var S:Class = klass("starling.display::Sprite");
         _editPanel = new S();
         _editPanel.x = 68;
         _editPanel.y = 275;
         _editPanel.clipRect = new Rectangle(0,0,534,329);
         _card.addChild(_editPanel);
         quad(_editPanel,0,0,534,329,0).touchable = false;
         _editHit = quad(_editPanel,0,0,534,329,0);
         _editHit.alpha = 0.001;
         _editHit.addEventListener("touch",mapTouched);
         _previewHolder = new S();
         _previewHolder.x = 666;
         _previewHolder.y = 275;
         _previewHolder.clipRect = new Rectangle(0,0,512,329);
         _card.addChild(_previewHolder);
         quad(_previewHolder,0,0,512,329,0).touchable = false;
         _previewHit = quad(_previewHolder,0,0,512,329,0);
         _previewHit.alpha = 0.001;
         _previewHit.addEventListener("touch",previewTouched);
         makeButton("editZoomIn","",505,284,40,42,1583406,"zoomIn");
         makeButton("editZoomOut","",552,284,40,42,1583406,"zoomOut");
         makeButton("previewZoomIn","",1081,284,40,42,1583406,"zoomIn");
         makeButton("previewZoomOut","",1128,284,40,42,1583406,"zoomOut");
         makeButton("reset",text("floorplaneditor.reset.button"),22,641,238,58,13631488);
         _save = makeButton("save",text("floorplaneditor.save.button"),820,623,358,76,1481682);
         _status = label(text("floor22.loading"),277,633,525,19,4868682);
         _status.wordWrap = true;
         _status.height = 62;
         stage().addChild(_root);
         _assetsDirty = true;
         _root.addEventListener("enterFrame",frame);
         _nativeStage = klass("starling.core::Starling").current.nativeStage;
         if(_nativeStage != null)
         {
            _nativeStage.addEventListener("keyDown",backPressed,false,1000,true);
         }
         layout();
         refresh();
      }
      
      private static function layout() : void
      {
         if(_root == null)
         {
            return;
         }
         var s:Object = stage();
         var u:Number = Math.min(s.stageWidth * 0.96 / 1200,s.stageHeight * 0.98 / 700);
         var q:Object = _root.getChildAt(0);
         q.width = s.stageWidth;
         q.height = s.stageHeight;
         _card.scaleX = _card.scaleY = u;
         _card.x = (s.stageWidth - 1200 * u) / 2;
         _card.y = (s.stageHeight - 700 * u) / 2;
         _size = s.stageWidth + ":" + s.stageHeight;
      }
      
      private static function moveHint() : String
      {
         var lang:String = patch().floorLanguage();
         var h:Object = {
            "pt":"Use a luva para mover o mapa; + e − para ampliar.",
            "en":"Use the glove to move the map; + and − to zoom.",
            "de":"Mit dem Handschuh verschieben; + und − zum Zoomen.",
            "es":"Usa el guante para mover el mapa; + y − para ampliar.",
            "fr":"Utilise le gant pour déplacer ; + et − pour zoomer.",
            "it":"Usa il guanto per spostare; + e − per lo zoom.",
            "nl":"Verplaats met de handschoen; zoom met + en −.",
            "fi":"Siirrä käsineellä; zoomaa + ja −.",
            "tr":"Eldivenle taşı; + ve − ile yakınlaştır."
         };
         return h[lang] == null ? h.en : h[lang];
      }
      
      private static function refresh() : void
      {
         if(_root == null)
         {
            return;
         }
         _drawLabel.text = String(_level);
         _heightHandle.y = 279 + (29 - _level) * 297 / 29;
         for each(var b:Object in _modeButtons)
         {
            var v:Object = _buttons[b];
            v.skin.backgroundSkin.color = v.action == "mode:" + _mode ? 10464953 : 12699079;
         }
         var ready:Boolean = _model != null && _entryReady && _occupiedReady;
         _save.isEnabled = ready && !_saving && canSave();
         _save.label = canSave() ? text("floorplaneditor.save.button") : text("floorplaneditor.bc.button");
         if(_model != null)
         {
            _wallLabel.text = _model.wallHeight < 0 ? "--" : String(_model.wallHeight);
            _wallHandle.y = 279 + (16 - Math.max(-1,_model.wallHeight)) * 297 / 17;
            _wallButton.label = text(["floorplaneditor.walls.thinnest","floorplaneditor.walls.thin","floorplaneditor.walls.normal","floorplaneditor.walls.thick"][int(_model.wallThickness) + 2]);
            _floorButton.label = text(["floorplaneditor.floors.thinnest","floorplaneditor.floors.thin","floorplaneditor.floors.normal","floorplaneditor.floors.thick"][int(_model.floorThickness) + 2]);
            _areaLabel.text = text("floorplaneditor.area.info") + ": " + _model.width * _model.height + " (" + _model.countTiles() + " " + text("floorplaneditor.habbox.area.info") + ")";
         }
         if(!_saving)
         {
            _status.text = ready ? moveHint() : text("floor22.loading");
         }
      }
      
      public static function actionTriggered(e:Object) : void
      {
         var v:Object = _buttons[e.currentTarget];
         if(v == null)
         {
            return;
         }
         e.stopImmediatePropagation();
         var a:String = v.action;
         if(a == "close")
         {
            close(e.currentTarget);
            return;
         }
         if(a == "discardClose")
         {
            close(e.currentTarget);
            return;
         }
         if(a == "discardReset")
         {
            discardConfirmation();
            reset();
            return;
         }
         if(a == "keep")
         {
            discardConfirmation();
            return;
         }
         if(a == "save")
         {
            save(e.currentTarget);
            return;
         }
         if(a == "reset")
         {
            if(_model != null && _model.changed)
            {
               confirmDiscard(true);
            }
            else
            {
               reset();
            }
            return;
         }
         if(a.indexOf("mode:") == 0)
         {
            _mode = a.substr(5);
            _panning = false;
            _pan = null;
            _stroke = null;
            _lastTile = null;
            _seen = {};
            refresh();
            return;
         }
         if(a == "editZoomIn")
         {
            zoomMap(1.25);
            return;
         }
         if(a == "editZoomOut")
         {
            zoomMap(0.8);
            return;
         }
         if(a == "previewZoomIn")
         {
            _previewZoom = Math.min(3,_previewZoom * 1.25);
            movePreviewView();
            return;
         }
         if(a == "previewZoomOut")
         {
            _previewZoom = Math.max(0.4,_previewZoom * 0.8);
            movePreviewView();
            return;
         }
         if(_model == null || _saving)
         {
            return;
         }
         if(a == "direction")
         {
            _model.rotate();
            drawDirection();
         }
         if(a == "wallThickness")
         {
            _model.wallThickness = (_model.wallThickness + 3) % 4 - 2;
         }
         if(a == "floorThickness")
         {
            _model.floorThickness = (_model.floorThickness + 3) % 4 - 2;
         }
         _model.changed = true;
         _previewDirty = true;
         refresh();
      }
      
      private static function reset() : void
      {
         if(_model == null || _original == null)
         {
            return;
         }
         _model.restore(_original);
         _model.setOccupied(_occupied);
         _previewOffset = new Point();
         _previewZoom = 1;
         centerMap();
         initialized();
      }
      
      private static function confirmDiscard(resetInstead:Boolean) : void
      {
         if(_confirm != null)
         {
            return;
         }
         _confirm = group(1200,700,0,false);
         var q:Object = quad(_confirm,0,0,1200,700,0);
         q.alpha = 0.65;
         var box:Object = group(660,200,14606046);
         box.x = 270;
         box.y = 250;
         _confirm.addChild(box);
         var old:Object = _card;
         _card = box;
         var msg:Object = label(resetInstead ? text("floor.plan.editor.revert.to.last.received.map") : text("floorplaneditor.unsavedchanges.description"),20,20,620,27);
         msg.wordWrap = true;
         msg.height = 83;
         makeButton("keep",text("floor22.keep"),20,110,295,60,1481682);
         makeButton(resetInstead ? "discardReset" : "discardClose",text("floor22.discard"),345,110,295,60,13172736);
         _card = old;
         _card.addChild(_confirm);
      }
      
      private static function discardConfirmation() : void
      {
         if(_confirm != null)
         {
            _confirm.removeFromParent(true);
            _confirm = null;
         }
      }
      
      private static function centerMap() : void
      {
         if(_model == null)
         {
            return;
         }
         var w:int = Math.min(64,_model.width + 4);
         var h:int = Math.min(64,_model.height + 4);
         _zoom = Math.max(0.25,Math.min(2,514 / (16 * (w + h)),309 / (8 * (w + h))));
         _originX = 267 - (w - h) * 8 * _zoom;
         _originY = 164 - (w + h) * 4 * _zoom;
      }
      
      public static function pointToTile(x:Number, y:Number) : Object
      {
         var sx:Number = (x - _originX) / (16 * _zoom);
         var sy:Number = (y - _originY) / (8 * _zoom);
         return {
            "x":int(Math.floor((sx + sy) / 2)),
            "y":int(Math.floor((sy - sx) / 2))
         };
      }
      
      private static function zoomMap(f:Number) : void
      {
         var old:Number = _zoom;
         _zoom = Math.max(0.25,Math.min(4,_zoom * f));
         var r:Number = _zoom / old;
         _originX = 267 + (_originX - 267) * r;
         _originY = 164 + (_originY - 164) * r;
         moveMapView();
      }
      
      public static function mapTouched(e:Object) : void
      {
         if(_model == null || !_entryReady || !_occupiedReady || _saving || _confirm != null)
         {
            return;
         }
         e.stopImmediatePropagation();
         var all:Object = e.getTouches(_editHit);
         var active:Array = [];
         for each(var t:Object in all)
         {
            if(t.phase != "ended")
            {
               active.push(t);
            }
         }
         if(active.length >= 2)
         {
            var a:Object = active[0].getLocation(_editHit);
            var b:Object = active[1].getLocation(_editHit);
            var p:Object = {
               "x":(a.x + b.x) / 2,
               "y":(a.y + b.y) / 2,
               "d":Math.max(1,Math.sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y)))
            };
            if(!_panning)
            {
               if(_stroke != null)
               {
                  _model.restore(_stroke);
                  renderMap();
                  _previewDirty = true;
                  refresh();
               }
               _panning = true;
               _stroke = null;
               _pan = p;
            }
            else
            {
               var r:Number = p.d / _pan.d;
               var z:Number = Math.max(0.25,Math.min(4,_zoom * r));
               r = z / _zoom;
               _originX = p.x + (_originX - _pan.x) * r;
               _originY = p.y + (_originY - _pan.y) * r;
               _zoom = z;
               _pan = p;
            }
            moveMapView();
            return;
         }
         if(_panning)
         {
            if(active.length == 0)
            {
               _panning = false;
               _pan = null;
            }
            _lastTile = null;
            return;
         }
         if(_mode == "move")
         {
            var hand:Object = e.getTouch(_editHit);
            if(hand == null)
            {
               return;
            }
            var hp:Object = hand.getLocation(_editHit);
            if(hand.phase == "began" || _pan == null)
            {
               _pan = {
                  "x":hp.x,
                  "y":hp.y
               };
            }
            if(hand.phase == "moved")
            {
               _originX += hp.x - _pan.x;
               _originY += hp.y - _pan.y;
               _pan = {
                  "x":hp.x,
                  "y":hp.y
               };
               moveMapView();
            }
            if(hand.phase == "ended")
            {
               _pan = null;
               _panning = false;
            }
            _stroke = null;
            _lastTile = null;
            return;
         }
         var touch:Object = e.getTouch(_editHit);
         if(touch == null)
         {
            return;
         }
         if(touch.phase == "began")
         {
            _stroke = _model.snapshot();
            _seen = {};
            _lastTile = null;
         }
         if(touch.phase != "began" && touch.phase != "moved" && touch.phase != "ended")
         {
            return;
         }
         var pos:Object = touch.getLocation(_editHit);
         if(pos.x >= 0 && pos.x < 534 && pos.y >= 0 && pos.y < 329)
         {
            var tile:Object = pointToTile(pos.x,pos.y);
            var change:Boolean = false;
            var n:int = _lastTile == null ? 1 : Math.max(1,Math.abs(tile.x - _lastTile.x),Math.abs(tile.y - _lastTile.y));
            var i:int = 1;
            while(i <= n)
            {
               var x:int = int(_lastTile == null ? tile.x : Math.round(_lastTile.x + (tile.x - _lastTile.x) * i / n));
               var y:int = int(_lastTile == null ? tile.y : Math.round(_lastTile.y + (tile.y - _lastTile.y) * i / n));
               var k:String = x + ":" + y;
               if(!_seen[k])
               {
                  _seen[k] = true;
                  if(_model.draw(x,y,_mode,_level))
                  {
                     change = true;
                  }
               }
               i++;
            }
            _lastTile = tile;
            if(change)
            {
               _previewDirty = true;
               renderMap();
               refresh();
            }
         }
         if(touch.phase == "ended")
         {
            _stroke = null;
            _lastTile = null;
            _seen = {};
         }
      }
      
      public static function heightTouched(e:Object) : void
      {
         var t:Object = e.getTouch(e.currentTarget);
         if(t == null || t.phase != "began" && t.phase != "moved")
         {
            return;
         }
         var p:Object = t.getLocation(e.currentTarget);
         _level = Math.max(0,Math.min(29,29 - Math.floor(p.y / 321 * 30)));
         refresh();
      }
      
      public static function wallHeightTouched(e:Object) : void
      {
         if(_model == null || _saving)
         {
            return;
         }
         var t:Object = e.getTouch(e.currentTarget);
         if(t == null || t.phase != "began" && t.phase != "moved")
         {
            return;
         }
         var p:Object = t.getLocation(e.currentTarget);
         _model.wallHeight = Math.max(-1,Math.min(16,16 - Math.floor(p.y / 321 * 18)));
         _model.changed = true;
         _previewDirty = true;
         refresh();
      }
      
      public static function previewTouched(e:Object) : void
      {
         if(_model == null)
         {
            return;
         }
         var t:Object = e.getTouch(_previewHit);
         if(t == null)
         {
            return;
         }
         e.stopImmediatePropagation();
         var p:Object = t.getLocation(_previewHit);
         if(t.phase == "began")
         {
            _previewPan = p;
         }
         else if(t.phase == "moved" && _previewPan != null)
         {
            _previewOffset.x += p.x - _previewPan.x;
            _previewOffset.y += p.y - _previewPan.y;
            _previewPan = p;
            movePreviewView();
         }
         else if(t.phase == "ended")
         {
            _previewPan = null;
         }
      }
      
      public static function heightColor(level:int, blocked:Boolean = false) : uint
      {
         var hue:Number = 0.6 - level / 30 * 0.85;
         if(hue < 0)
         {
            hue += 1;
         }
         var sat:Number = blocked ? 0.33 : 1;
         var light:Number = blocked ? 0.4 : 0.5;
         var c:Number = (1 - Math.abs(2 * light - 1)) * sat;
         var h:Number = hue * 6;
         var x:Number = c * (1 - Math.abs(h % 2 - 1));
         var m:Number = light - c / 2;
         var r:Number = 0;
         var g:Number = 0;
         var b:Number = 0;
         if(h < 1)
         {
            r = c;
            g = x;
         }
         else if(h < 2)
         {
            r = x;
            g = c;
         }
         else if(h < 3)
         {
            g = c;
            b = x;
         }
         else if(h < 4)
         {
            g = x;
            b = c;
         }
         else if(h < 5)
         {
            r = x;
            b = c;
         }
         else
         {
            r = c;
            b = x;
         }
         return Math.round((r + m) * 255) << 16 | Math.round((g + m) * 255) << 8 | Math.round((b + m) * 255);
      }
      
      private static function renderMap() : void
      {
         _editDirty = true;
      }
      
      private static function moveMapView() : void
      {
         if(_editImage == null)
         {
            return;
         }
         _editImage.scaleX = _editImage.scaleY = _zoom;
         _editImage.x = _originX - _mapBaseX * _zoom;
         _editImage.y = _originY;
      }
      
      private static function drawMap() : void
      {
         if(_root == null || _model == null)
         {
            return;
         }
         var w:int = Math.min(64,_model.width + 4);
         var h:int = Math.min(64,_model.height + 4);
         var data:BitmapData = new BitmapData((w + h) * 16,(w + h) * 8,true,0);
         var s:Shape = new Shape();
         var g:Object = s.graphics;
         var hw:Number = 16;
         var hh:Number = 8;
         _mapBaseX = h * 16;
         var y:int = 0;
         while(y < h)
         {
            var x:int = 0;
            while(x < w)
            {
               var px:Number = _mapBaseX + (x - y) * hw;
               var py:Number = (x + y) * hh;
               var level:int = int(_model.getHeight(x,y));
               var color:uint = level < 0 ? 2368548 : heightColor(level,_model.blocked(x,y));
               g.lineStyle(0.6,0);
               g.beginFill(color);
               g.moveTo(px,py);
               g.lineTo(px + hw,py + hh);
               g.lineTo(px,py + hh * 2);
               g.lineTo(px - hw,py + hh);
               g.lineTo(px,py);
               g.endFill();
               if(x == _model.entryX && y == _model.entryY)
               {
                  g.lineStyle(2,16777215);
                  g.moveTo(px,py + hh * 0.14);
                  g.lineTo(px + hw * 0.86,py + hh);
                  g.lineTo(px,py + hh * 1.86);
                  g.lineTo(px - hw * 0.86,py + hh);
                  g.lineTo(px,py + hh * 0.14);
               }
               x++;
            }
            y++;
         }
         data.draw(s);
         var oldT:Object = _editTexture;
         var oldD:BitmapData = _editData;
         _editData = data;
         _editTexture = klass("starling.textures::Texture").fromBitmapData(data,false,false,1);
         if(_editImage == null)
         {
            var I:Class = klass("starling.display::Image");
            _editImage = new I(_editTexture);
            _editImage.touchable = false;
            _editPanel.addChildAt(_editImage,1);
         }
         else
         {
            _editImage.texture = _editTexture;
            _editImage.readjustSize();
         }
         _editImage.smoothing = "none";
         moveMapView();
         _editDirty = false;
         release(oldT);
         release(oldD);
      }
      
      private static function drawDirection() : void
      {
         if(_directionImage == null)
         {
            return;
         }
         var s:Shape = new Shape();
         var g:Object = s.graphics;
         g.lineStyle(2,0);
         g.beginFill(6933545);
         g.moveTo(54,5);
         g.lineTo(103,30);
         g.lineTo(54,55);
         g.lineTo(5,30);
         g.lineTo(54,5);
         g.endFill();
         var a:Number = (-45 + (_model == null ? 2 : _model.direction) * 45) * Math.PI / 180;
         var dx:Number = Math.cos(a);
         var dy:Number = Math.sin(a);
         g.lineStyle(2,15204311);
         g.moveTo(54 - dx * 9 - dy * 7,30 - dy * 9 + dx * 7);
         g.lineTo(54 + dx * 10,30 + dy * 10);
         g.lineTo(54 - dx * 9 + dy * 7,30 - dy * 9 - dx * 7);
         _directionData.fillRect(_directionData.rect,0);
         _directionData.draw(s);
         _directionDirty = true;
      }
      
      private static function disposePreview() : void
      {
         var texture:Object = _previewTexture;
         var data:Object = _previewData;
         _previewImage = null;
         _previewTexture = null;
         _previewData = null;
         _previewRoom = 0;
         _previewCanvas = null;
         release(texture);
         release(data);
         klass("loginpatch::FloorPreview25").reset();
      }
      
      private static function buildPreview() : void
      {
         renderPreview();
         _previewDirty = false;
         _previewUntil = 0;
      }
      
      private static function movePreviewView() : void
      {
         if(_previewImage == null)
         {
            return;
         }
         _previewImage.scaleX = _previewImage.scaleY = _previewZoom;
         _previewImage.x = 256 * (1 - _previewZoom) + _previewOffset.x;
         _previewImage.y = 164.5 * (1 - _previewZoom) + _previewOffset.y;
      }
      
      private static function renderPreview() : void
      {
         if(_model == null || _previewHolder == null)
         {
            return;
         }
         var oldT:Object = _previewTexture;
         var oldD:BitmapData = _previewData;
         _previewData = klass("loginpatch::FloorPreview25").render(_model,512,329,1,null);
         _previewTexture = klass("starling.textures::Texture").fromBitmapData(_previewData,false,false,1);
         if(_previewImage == null)
         {
            var I:Class = klass("starling.display::Image");
            _previewImage = new I(_previewTexture);
            _previewImage.touchable = false;
            _previewImage.smoothing = "none";
            _previewHolder.addChildAt(_previewImage,1);
         }
         else
         {
            _previewImage.texture = _previewTexture;
            _previewImage.readjustSize();
         }
         movePreviewView();
         if(oldT != null)
         {
            oldT.dispose();
         }
         if(oldD != null)
         {
            oldD.dispose();
         }
      }
      
      public static function frame(e:Object = null) : void
      {
         var s:Object;
         var now:int;
         var i:int;
         if(_root == null || _closing)
         {
            return;
         }
         if(_ui == null || _ui.disposed || _ui.roomEngine == null || int(_ui.roomEngine["_-0Y"]) != _room)
         {
            close();
            return;
         }
         s = stage();
         if(_size != s.stageWidth + ":" + s.stageHeight)
         {
            layout();
         }
         now = getTimer();
         if(klass("starling.core::Starling").current.isRendering)
         {
            try
            {
               if(_assetsDirty)
               {
                  i = 0;
                  while(i < _textures.length)
                  {
                     _textures[i].root.uploadBitmapData(_bitmaps[i]);
                     i++;
                  }
                  _assetsDirty = false;
               }
               if(_directionDirty && _directionTexture != null)
               {
                  _directionTexture.root.uploadBitmapData(_directionData);
                  _directionDirty = false;
               }
               if(_editDirty)
               {
                  drawMap();
               }
               if(now - _lastFrame >= 180)
               {
                  if(_previewDirty)
                  {
                     buildPreview();
                  }
               }
            }
            catch(error:Error)
            {
               _previewUntil = 0;
               report(error);
            }
         }
         if(now - _lastFrame < 180)
         {
            return;
         }
         _lastFrame = now;
         if(_saving && now - _saveTime > 12000)
         {
            _saving = false;
            _status.text = text("floorplaneditor.saving.fail");
         }
         else if(!_saving && (!_entryReady || !_occupiedReady) && now - _waitingSince > 12000)
         {
            _status.text = text("floor22.retry");
         }
         if(!_saving)
         {
            _save.isEnabled = _model != null && _entryReady && _occupiedReady && canSave();
            _save.label = canSave() ? text("floorplaneditor.save.button") : text("floorplaneditor.bc.button");
         }
      }
      
      public static function backPressed(e:Object) : void
      {
         if(_root == null || e.keyCode != 16777238 && e.keyCode != 27)
         {
            return;
         }
         e.preventDefault();
         e.stopImmediatePropagation();
         if(_confirm != null)
         {
            discardConfirmation();
         }
         else if(!_saving && _model != null && _model.changed)
         {
            confirmDiscard(false);
         }
         else
         {
            close();
         }
      }
      
      private static function release(resource:Object) : void
      {
         if(resource != null)
         {
            try
            {
               resource.dispose();
            }
            catch(error:Error)
            {
            }
         }
      }
      
      private static function isEditorWindow(view:Object) : Boolean
      {
         return view != null && view.name != null && String(view.name).indexOf("floorPlanEditor") == 0 && String(view.name).indexOf("Card") < 0;
      }
      
      private static function windowFor(source:Object) : Object
      {
         var v:Object = source;
         while(v != null)
         {
            if(isEditorWindow(v))
            {
               return v;
            }
            v = v.parent;
         }
         return _root;
      }
      
      private static function detachDisplay(view:Object) : void
      {
         if(view == null)
         {
            return;
         }
         view.visible = false;
         view.touchable = false;
         view.alpha = 0;
         view.x = -100000;
         view.y = -100000;
         view.removeEventListener("enterFrame",frame);
         view.removeChildren(0,-1,false);
         view.removeFromParent(false);
      }
      
      private static function sweepWindows() : void
      {
         var s:Object = stage();
         var i:int = s.numChildren - 1;
         while(i >= 0)
         {
            var v:Object = s.getChildAt(i);
            if(isEditorWindow(v))
            {
               var children:Array = [];
               var j:int = 0;
               while(j < v.numChildren)
               {
                  children.push(v.getChildAt(j));
                  j++;
               }
               detachDisplay(v);
               queueRetired(v,null,children);
            }
            i--;
         }
      }
      
      private static function queueRetired(root:Object, card:Object, resources:Array) : void
      {
         _retired.push({
            "root":root,
            "card":card,
            "resources":resources,
            "frames":0
         });
         if(_retireStage == null)
         {
            _retireStage = klass("starling.core::Starling").current.nativeStage;
            _retireStage.addEventListener("enterFrame",flushRetired);
         }
      }
      
      public static function flushRetired(e:Object = null) : void
      {
         var i:int = _retired.length - 1;
         while(i >= 0)
         {
            var r:Object = _retired[i];
            var _loc5_:Object = r;
            var _loc6_:Number = Number(_loc5_.frames) + 1;
            _loc5_.frames = _loc6_;
            if(r.frames >= 2)
            {
               release(r.card);
               release(r.root);
               for each(var resource:Object in r.resources)
               {
                  release(resource);
               }
               _retired.splice(i,1);
            }
            i--;
         }
         if(_retired.length == 0 && _retireStage != null)
         {
            _retireStage.removeEventListener("enterFrame",flushRetired);
            _retireStage = null;
         }
      }
      
      public static function close(source:Object = null) : void
      {
         var root:Object;
         var card:Object;
         var previous:Object;
         var children:Array;
         var ci:int;
         var resources:Array;
         if(_closing)
         {
            return;
         }
         _closing = true;
         root = windowFor(source);
         card = _card;
         previous = _root;
         children = [];
         if(root != null)
         {
            ci = 0;
            while(ci < root.numChildren)
            {
               if(root.getChildAt(ci) !== card)
               {
                  children.push(root.getChildAt(ci));
               }
               ci++;
            }
         }
         try
         {
            detachDisplay(root);
            if(previous !== root)
            {
               detachDisplay(previous);
            }
            sweepWindows();
         }
         catch(removalError:Error)
         {
            _closing = false;
            report(removalError);
            return;
         }
         if(root != null && root.parent != null || previous != null && previous.parent != null)
         {
            _closing = false;
            return;
         }
         _root = null;
         _card = null;
         resources = children.concat(_textures,_bitmaps);
         resources.push(_editTexture,_editData,_directionTexture,_directionData,_previewTexture,_previewData);
         queueRetired(root,card,resources);
         unsubscribe();
         if(_nativeStage != null)
         {
            _nativeStage.removeEventListener("keyDown",backPressed);
            _nativeStage = null;
         }
         klass("loginpatch::FloorPreview25").reset();
         _previewImage = _previewTexture = null;
         _previewData = null;
         _previewRoom = 0;
         _previewCanvas = null;
         _editTexture = _directionTexture = null;
         _editData = _directionData = null;
         _mapBaseX = 0;
         _textures = [];
         _bitmaps = [];
         _model = _original = null;
         _ui = null;
         _room = -1;
         _confirm = null;
         _previewHolder = null;
         _editPanel = null;
         _editHit = _previewHit = null;
         _editImage = _directionImage = null;
         _drawLabel = _wallLabel = _areaLabel = _status = _save = _wallButton = _floorButton = _heightHandle = _wallHandle = null;
         _buttons = new Dictionary(true);
         _modeButtons = [];
         _stroke = _pan = _previewPan = null;
         _entry = null;
         _occupied = null;
         _panning = false;
         _lastTile = null;
         _requestSent = false;
         _saving = false;
         _entryReady = _occupiedReady = false;
         _editDirty = _previewDirty = _directionDirty = _assetsDirty = false;
         _previewUntil = 0;
         _size = "";
         _lastFrame = 0;
         _closing = false;
      }
      
      public static function isPreviewRoom(room:int) : Boolean
      {
         return _previewRoom != 0 && room == _previewRoom;
      }
      
      public static function previewRoomFor(canvas:Object) : int
      {
         return canvas != null && canvas == _previewCanvas ? _previewRoom : 0;
      }
      
      public static function roomClosed() : void
      {
         close();
         _map = "";
         _fixed = -1;
         _wall = _floor = 0;
         _entry = null;
         _occupied = null;
      }
      
      public static function resetAccount() : void
      {
         roomClosed();
         _largePlans = false;
      }
      
      public static function report(error:Object) : void
      {
         if(_status != null)
         {
            _status.text = text("floor22.retry") + " (" + error.errorID + ") " + error.message;
         }
      }
   }
}


package com.sulake.habbo.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.UnknownICoreAssets1;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.UnknownICoreRuntime4;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.core.window.UnknownICoreWindow4;
   import com.sulake.core.window.UnknownICoreWindow5;
   import com.sulake.core.window.components.IToolTipWindow;
   import com.sulake.core.window.components.UnknownICoreWindowComponents17;
   import com.sulake.core.window.components.UnknownICoreWindowComponents6;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.advertisement.UnknownIHabboAdvertisement1;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar1;
   import com.sulake.habbo.avatar.UnknownIHabboAvatar2;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.UnknownIHabboCommunication1;
   import com.sulake.habbo.communication.messages.incoming.room.bots.BotForceOpenContextMenuEvent;
   import com.sulake.habbo.communication.messages.incoming.room.bots.BotSkillListUpdateEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotForceOpenContextMenuParser;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillListUpdateParser;
   import com.sulake.habbo.freeflowchat.UnknownIHabboFreeflowchat1;
   import com.sulake.habbo.friendlist.UnknownIHabboFriendlist1;
   import com.sulake.habbo.game.UnknownIHabboGame1;
   import com.sulake.habbo.groups.UnknownIHabboGroups1;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.UnknownIHabboInventory1;
   import com.sulake.habbo.localization.UnknownIHabboLocalization1;
   import com.sulake.habbo.messenger.UnknownIHabboMessenger1;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.UnknownIHabboNavigator1;
   import com.sulake.habbo.quest.UnknownIHabboQuest1;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.UnknownIHabboSession1;
   import com.sulake.habbo.sound.UnknownIHabboSound1;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.UnknownIHabboTracking1;
   import com.sulake.habbo.ui.handler.*;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectPlaceEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.UnknownIHabboWindow1;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.ColorTransitioner;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.RoomId;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer
   {
      
      public static const STATE_UNDEFINED:int = -1;
      
      private static const RESIZE_UPDATE_TIMEOUT_MS:int = 1000;
      
      private static const SCALE_UPDATE_TIMEOUT_MS:int = 1000;
      
      private var _events:EventDispatcherWrapper;
      
      private var _windowManager:UnknownIHabboWindow1 = null;
      
      private var _roomEngine:IRoomEngine = null;
      
      private var _roomWidgetFactory:IRoomWidgetFactory = null;
      
      private var _sessionDataManager:ISessionDataManager = null;
      
      private var _roomSessionManager:IRoomSessionManager = null;
      
      private var _communicationManager:UnknownIHabboCommunication1 = null;
      
      private var _avatarRenderManager:UnknownIHabboAvatar1 = null;
      
      private var _friendList:UnknownIHabboFriendlist1 = null;
      
      private var _inventory:UnknownIHabboInventory1 = null;
      
      private var _toolbar:IHabboToolbar = null;
      
      private var _navigator:UnknownIHabboNavigator1 = null;
      
      private var _messenger:UnknownIHabboMessenger1 = null;
      
      private var _habboGroupsManager:UnknownIHabboGroups1 = null;
      
      private var _avatarEditor:UnknownIHabboAvatar2 = null;
      
      private var _catalog:IHabboCatalog = null;
      
      private var _adManager:UnknownIHabboAdvertisement1 = null;
      
      private var _localization:UnknownIHabboLocalization1 = null;
      
      private var _habboHelp:IHabboHelp = null;
      
      private var _connection:IConnection = null;
      
      private var _moderation:IHabboModeration;
      
      private var _config:UnknownICoreRuntime4;
      
      private var _soundManager:UnknownIHabboSound1;
      
      private var _habboTracking:UnknownIHabboTracking1;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var _gameManager:UnknownIHabboGame1;
      
      private var _questEngine:UnknownIHabboQuest1;
      
      private var _freeFlowChat:UnknownIHabboFreeflowchat1;
      
      private var _assets:UnknownICoreAssets1 = null;
      
      private var _roomSession:IRoomSession = null;
      
      private var UnknownVarFromRoomDesktop_Array_1:Array = [];
      
      private var UnknownVarFromRoomDesktop_Map_1:Map;
      
      private var UnknownVarFromRoomDesktop_Map_2:Map;
      
      private var UnknownVarFromRoomDesktop_Map_3:Map;
      
      private var _updateListeners:Array;
      
      private var _layoutManager:DesktopLayoutManager;
      
      private var UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1:UnknownICoreWindowComponents6;
      
      private var UnknownVarFromRoomDesktop_Boolean_1:Boolean = true;
      
      private var _pendingResources:Array;
      
      private var UnknownVarFromRoomDesktop_IToolTipWindow_1:IToolTipWindow;
      
      private var UnknownVarFromRoomDesktop_ColorTransitioner_1:ColorTransitioner = null;
      
      private var _roomColor:uint = 16777215;
      
      private var UnknownVarFromRoomDesktop_Boolean_2:Boolean = false;
      
      private var _zoomChangedMillis:int = 0;
      
      private var UnknownVarFromRoomDesktop_ColorTransitioner_2:ColorTransitioner = null;
      
      private var _roomBackgroundColor:uint = 0;
      
      private var UnknownVarFromRoomDesktop_Timer_1:Timer;
      
      private var UnknownVarFromRoomDesktop_Rectangle_1:Rectangle;
      
      private var UnknownVarFromRoomDesktop_IMessageEvent_1:IMessageEvent;
      
      private var UnknownVarFromRoomDesktop_IMessageEvent_2:IMessageEvent;
      
      private var UnknownVarFromRoomDesktop_Point_1:Point;
      
      private var UnknownVarFromRoomDesktop_Number_1:Number = 0;
      
      private var UnknownVarFromRoomDesktop_Number_2:Number = 0;
      
      private var UnknownVarFromRoomDesktop_Boolean_3:Boolean;
      
      public function RoomDesktop(param1:IRoomSession, param2:UnknownICoreAssets1, param3:IConnection)
      {
         super();
         _events = new EventDispatcherWrapper();
         _roomSession = param1;
         _assets = param2;
         _connection = param3;
         UnknownVarFromRoomDesktop_IMessageEvent_1 = new BotSkillListUpdateEvent(onBotSkillListUpdateEvent);
         _connection.addMessageEvent(UnknownVarFromRoomDesktop_IMessageEvent_1);
         UnknownVarFromRoomDesktop_IMessageEvent_2 = new BotForceOpenContextMenuEvent(onBotForceOpenContextMenuEvent);
         _connection.addMessageEvent(UnknownVarFromRoomDesktop_IMessageEvent_2);
         UnknownVarFromRoomDesktop_Map_1 = new Map();
         UnknownVarFromRoomDesktop_Map_2 = new Map();
         UnknownVarFromRoomDesktop_Map_3 = new Map();
         _layoutManager = new DesktopLayoutManager();
         checkInterrupts();
         UnknownVarFromRoomDesktop_ColorTransitioner_1 = new ColorTransitioner();
         UnknownVarFromRoomDesktop_ColorTransitioner_2 = new ColorTransitioner(0,0);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1)
         {
            UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.visible = param1;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return _roomSession;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get events() : IEventDispatcher
      {
         return _events;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get friendList() : UnknownIHabboFriendlist1
      {
         return _friendList;
      }
      
      public function get avatarRenderManager() : UnknownIHabboAvatar1
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : UnknownIHabboInventory1
      {
         return _inventory && !_inventory.disposed ? _inventory : null;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomWidgetFactory() : IRoomWidgetFactory
      {
         return _roomWidgetFactory;
      }
      
      public function get navigator() : UnknownIHabboNavigator1
      {
         return _navigator;
      }
      
      public function get habboGroupsManager() : UnknownIHabboGroups1
      {
         return _habboGroupsManager;
      }
      
      public function get communicationManager() : UnknownIHabboCommunication1
      {
         return _communicationManager;
      }
      
      public function get avatarEditor() : UnknownIHabboAvatar2
      {
         return _avatarEditor;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get localization() : UnknownIHabboLocalization1
      {
         return _localization;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get config() : UnknownICoreRuntime4
      {
         return _config;
      }
      
      public function get soundManager() : UnknownIHabboSound1
      {
         return _soundManager;
      }
      
      public function get messenger() : UnknownIHabboMessenger1
      {
         return _messenger;
      }
      
      public function get moderation() : IHabboModeration
      {
         return _moderation;
      }
      
      public function get windowManager() : UnknownIHabboWindow1
      {
         return _windowManager;
      }
      
      public function get habboTracking() : UnknownIHabboTracking1
      {
         return _habboTracking;
      }
      
      public function get session() : IRoomSession
      {
         return _roomSession;
      }
      
      public function get gameManager() : UnknownIHabboGame1
      {
         return _gameManager;
      }
      
      public function get questEngine() : UnknownIHabboQuest1
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : UnknownIHabboFreeflowchat1
      {
         return _freeFlowChat;
      }
      
      public function get roomBackgroundColor() : uint
      {
         return _roomBackgroundColor;
      }
      
      public function set catalog(param1:IHabboCatalog) : void
      {
         _catalog = param1;
      }
      
      public function set avatarEditor(param1:UnknownIHabboAvatar2) : void
      {
         _avatarEditor = param1;
      }
      
      public function set roomWidgetFactory(param1:IRoomWidgetFactory) : void
      {
         _roomWidgetFactory = param1;
      }
      
      public function set sessionDataManager(param1:ISessionDataManager) : void
      {
         _sessionDataManager = param1;
      }
      
      public function set roomSessionManager(param1:IRoomSessionManager) : void
      {
         _roomSessionManager = param1;
         checkInterrupts();
      }
      
      public function set communicationManager(param1:UnknownIHabboCommunication1) : void
      {
         _communicationManager = param1;
      }
      
      public function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents
      {
         return _userDefinedRoomEvents;
      }
      
      public function get connection() : IConnection
      {
         return _connection;
      }
      
      public function set friendList(param1:UnknownIHabboFriendlist1) : void
      {
         _friendList = param1;
         if(_friendList)
         {
            _friendList.events.addEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.addEventListener("FRE_DECLINED",processEvent);
         }
      }
      
      public function set avatarRenderManager(param1:UnknownIHabboAvatar1) : void
      {
         _avatarRenderManager = param1;
      }
      
      public function set windowManager(param1:UnknownIHabboWindow1) : void
      {
         _windowManager = param1;
      }
      
      public function set inventory(param1:UnknownIHabboInventory1) : void
      {
         _inventory = param1;
      }
      
      public function set navigator(param1:UnknownIHabboNavigator1) : void
      {
         _navigator = param1;
      }
      
      public function set adManager(param1:UnknownIHabboAdvertisement1) : void
      {
         _adManager = param1;
      }
      
      public function set localization(param1:UnknownIHabboLocalization1) : void
      {
         _localization = param1;
      }
      
      public function set habboHelp(param1:IHabboHelp) : void
      {
         _habboHelp = param1;
      }
      
      public function set moderation(param1:IHabboModeration) : void
      {
         _moderation = param1;
      }
      
      public function set config(param1:UnknownICoreRuntime4) : void
      {
         _config = param1;
      }
      
      public function set soundManager(param1:UnknownIHabboSound1) : void
      {
         _soundManager = param1;
      }
      
      public function set habboTracking(param1:UnknownIHabboTracking1) : void
      {
         _habboTracking = param1;
      }
      
      public function set userDefinedRoomEvents(param1:IHabboUserDefinedRoomEvents) : void
      {
         _userDefinedRoomEvents = param1;
      }
      
      public function set gameManager(param1:UnknownIHabboGame1) : void
      {
         _gameManager = param1;
      }
      
      public function set questEngine(param1:UnknownIHabboQuest1) : void
      {
         _questEngine = param1;
      }
      
      public function set freeFlowChat(param1:UnknownIHabboFreeflowchat1) : void
      {
         _freeFlowChat = param1;
      }
      
      public function set habboGroupsManager(param1:UnknownIHabboGroups1) : void
      {
         _habboGroupsManager = param1;
      }
      
      public function set roomEngine(param1:IRoomEngine) : void
      {
         _roomEngine = param1;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
      }
      
      public function set messenger(param1:UnknownIHabboMessenger1) : void
      {
         _messenger = param1;
      }
      
      public function set toolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
      }
      
      public function set layout(param1:XML) : void
      {
         _layoutManager.setLayout(param1,_windowManager,_config);
      }
      
      public function dispose() : void
      {
         var _loc5_:IRoomGeometry = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc1_:IRoomWidget = null;
         if(_roomEngine != null && _roomSession != null)
         {
            _loc5_ = _roomEngine.getRoomCanvasGeometry(_roomSession.roomId,getFirstCanvasId());
            if(_loc5_ != null)
            {
               trackZooming(_loc5_.isZoomedIn(),false);
            }
         }
         var _loc2_:int = 0;
         if(UnknownVarFromRoomDesktop_Array_1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromRoomDesktop_Array_1.length)
            {
               _loc4_ = int(UnknownVarFromRoomDesktop_Array_1[_loc2_]);
               _loc3_ = getWindowName(_loc4_);
               if(_windowManager)
               {
                  _windowManager.removeWindow(_loc3_);
               }
               _loc2_++;
            }
         }
         _updateListeners = null;
         if(UnknownVarFromRoomDesktop_Map_1 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromRoomDesktop_Map_1.length)
            {
               _loc1_ = UnknownVarFromRoomDesktop_Map_1.getWithIndex(_loc2_) as IRoomWidget;
               if(_loc1_ != null)
               {
                  if(_loc1_.reusable)
                  {
                     if(_layoutManager != null)
                     {
                        _layoutManager.removeWidgetWindow(_loc1_.widgetType,_loc1_.mainWindow);
                     }
                     _loc1_.release();
                  }
                  else
                  {
                     _loc1_.dispose();
                  }
               }
               _loc2_++;
            }
            UnknownVarFromRoomDesktop_Map_1.dispose();
            UnknownVarFromRoomDesktop_Map_1 = null;
         }
         if(UnknownVarFromRoomDesktop_Map_2 != null)
         {
            UnknownVarFromRoomDesktop_Map_2.dispose();
            UnknownVarFromRoomDesktop_Map_2 = null;
         }
         if(UnknownVarFromRoomDesktop_Map_3 != null)
         {
            UnknownVarFromRoomDesktop_Map_3.dispose();
            UnknownVarFromRoomDesktop_Map_3 = null;
         }
         if(_connection)
         {
            if(UnknownVarFromRoomDesktop_IMessageEvent_1 != null)
            {
               _connection.removeMessageEvent(UnknownVarFromRoomDesktop_IMessageEvent_1);
               UnknownVarFromRoomDesktop_IMessageEvent_1.dispose();
               UnknownVarFromRoomDesktop_IMessageEvent_1 = null;
            }
            if(UnknownVarFromRoomDesktop_IMessageEvent_2 != null)
            {
               _connection.removeMessageEvent(UnknownVarFromRoomDesktop_IMessageEvent_2);
               UnknownVarFromRoomDesktop_IMessageEvent_2.dispose();
               UnknownVarFromRoomDesktop_IMessageEvent_2 = null;
            }
            _connection = null;
         }
         _assets = null;
         _avatarRenderManager = null;
         UnknownVarFromRoomDesktop_Array_1 = null;
         _events = null;
         if(_friendList && _friendList.events)
         {
            _friendList.events.removeEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.removeEventListener("FRE_DECLINED",processEvent);
         }
         _friendList = null;
         _layoutManager.dispose();
         _layoutManager = null;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.removeEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
         _roomEngine = null;
         _roomSessionManager = null;
         _roomWidgetFactory = null;
         _roomSession = null;
         _sessionDataManager = null;
         _windowManager = null;
         _inventory = null;
         _localization = null;
         _config = null;
         _soundManager = null;
         _habboGroupsManager = null;
         if(_toolbar && toolbar.events)
         {
            _toolbar.events.removeEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
            _toolbar = null;
         }
         _navigator = null;
         if(UnknownVarFromRoomDesktop_IToolTipWindow_1 != null)
         {
            UnknownVarFromRoomDesktop_IToolTipWindow_1.dispose();
            UnknownVarFromRoomDesktop_IToolTipWindow_1 = null;
         }
         if(UnknownVarFromRoomDesktop_Timer_1 != null)
         {
            UnknownVarFromRoomDesktop_Timer_1.reset();
            UnknownVarFromRoomDesktop_Timer_1.removeEventListener("timer",onResizeTimerEvent);
            UnknownVarFromRoomDesktop_Timer_1 = null;
         }
         UnknownVarFromRoomDesktop_Rectangle_1 = null;
         UnknownVarFromRoomDesktop_ColorTransitioner_1 = null;
         UnknownVarFromRoomDesktop_ColorTransitioner_2 = null;
      }
      
      private function onBotSkillListUpdateEvent(param1:BotSkillListUpdateEvent) : void
      {
         var _loc2_:UnknownIHabboSession1 = null;
         var _loc3_:BotSkillListUpdateParser = param1.getParser();
         if(_roomSession != null)
         {
            _loc2_ = _roomSession.userDataManager.getRentableBotUserData(_loc3_.botId);
            _loc2_.botSkillData = param1.getParser().skillList.concat();
         }
         events.dispatchEvent(new RoomWidgetRentableBotSkillListUpdateEvent(_loc3_.botId,_loc3_.skillList));
      }
      
      private function onBotForceOpenContextMenuEvent(param1:BotForceOpenContextMenuEvent) : void
      {
         var _loc2_:BotForceOpenContextMenuParser = param1.getParser();
         events.dispatchEvent(new RoomWidgetRentableBotForceOpenContextMenuEvent(_loc2_.botId));
      }
      
      public function init() : void
      {
         if(_roomEngine != null && _roomSession != null)
         {
            _pendingResources = [];
            if(_pendingResources.length > 0)
            {
               UnknownVarFromRoomDesktop_Boolean_1 = false;
               processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUE_SHOW_LOADING_BAR"));
            }
         }
      }
      
      public function requestInterstitial() : void
      {
         if(_adManager != null)
         {
            _adManager.showInterstitial();
         }
      }
      
      private function onRoomContentLoaded(param1:RoomContentLoadedEvent) : void
      {
         if(_pendingResources == null || _pendingResources.length == 0)
         {
            return;
         }
         var _loc2_:int = _pendingResources.indexOf(param1.contentType);
         if(_loc2_ != -1)
         {
            _pendingResources.splice(_loc2_,1);
         }
         if(_pendingResources.length == 0)
         {
            UnknownVarFromRoomDesktop_Boolean_1 = true;
            checkInterrupts();
         }
      }
      
      public function createWidget(param1:String, param2:Boolean = false, param3:IRoomWidget = null) : IRoomWidget
      {
         var _loc4_:IRoomWidgetHandler = null;
         var _loc9_:ChatWidgetHandler = null;
         var _loc21_:PlayListEditorWidgetHandler = null;
         var _loc5_:SpamWallPostItWidgetHandler = null;
         var _loc8_:FurnitureContextMenuWidgetHandler = null;
         var _loc16_:FurnitureRoomLinkHandler = null;
         var _loc10_:RoomToolsWidgetHandler = null;
         var _loc22_:RoomWidgetBase = null;
         var _loc6_:FurnitureRoomLinkHandler = null;
         var _loc15_:ChatWidgetHandler = null;
         var _loc14_:FurnitureContextMenuWidgetHandler = null;
         var _loc12_:RoomToolsWidgetHandler = null;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc23_:Array = null;
         var _loc17_:RoomWidgetRoomViewUpdateEvent = null;
         if(_roomWidgetFactory == null)
         {
            return null;
         }
         var _loc7_:IRoomWidget = UnknownVarFromRoomDesktop_Map_1.getValue(param1) as IRoomWidget;
         if(_loc7_ != null)
         {
            return null;
         }
         if(_roomSession.isGameSession && !isGameWidget(param1))
         {
            return null;
         }
         var _loc11_:Boolean = param1 == "RWE_CHAT_INPUT_WIDGET" || param1 == "RWE_CHAT_WIDGET";
         if(param3 == null)
         {
            switch(param1)
            {
               case "RWE_CHAT_WIDGET":
                  _loc9_ = new ChatWidgetHandler();
                  _loc9_.connection = _connection;
                  _loc4_ = _loc9_;
                  break;
               case "RWE_INFOSTAND":
                  _loc4_ = new InfoStandWidgetHandler(_soundManager.musicController);
                  break;
               case "RWE_CHAT_INPUT_WIDGET":
                  _loc4_ = new ChatInputWidgetHandler();
                  break;
               case "RWE_ME_MENU":
                  _loc4_ = new MeMenuWidgetHandler();
                  break;
               case "RWE_FURNI_PLACEHOLDER":
                  _loc4_ = new PlaceholderWidgetHandler();
                  break;
               case "RWE_FURNI_CREDIT_WIDGET":
                  _loc4_ = new FurnitureCreditWidgetHandler();
                  break;
               case "RWE_FURNI_STICKIE_WIDGET":
                  _loc4_ = new FurnitureStickieWidgetHandler();
                  break;
               case "RWE_FURNI_PRESENT_WIDGET":
                  _loc4_ = new FurniturePresentWidgetHandler();
                  break;
               case "RWE_FURNI_TROPHY_WIDGET":
                  _loc4_ = new FurnitureTrophyWidgetHandler();
                  break;
               case "RWE_FURNI_ECOTRONBOX_WIDGET":
                  _loc4_ = new FurnitureEcotronBoxWidgetHandler();
                  break;
               case "RWE_FURNI_PET_PACKAGE_WIDGET":
                  _loc4_ = new PetPackageFurniWidgetHandler();
                  break;
               case "RWE_DOORBELL":
                  _loc4_ = new DoorbellWidgetHandler();
                  break;
               case "RWE_ROOM_QUEUE":
                  _loc4_ = new RoomQueueWidgetHandler();
                  break;
               case "RWE_LOADINGBAR":
                  _loc4_ = new LoadingBarWidgetHandler();
                  break;
               case "RWE_ROOM_POLL":
                  _loc4_ = new PollWidgetHandler();
                  break;
               case "RWE_WORD_QUIZZ":
                  _loc4_ = new WordQuizWidgetHandler();
                  break;
               case "RWE_FURNI_CHOOSER":
                  _loc4_ = new FurniChooserWidgetHandler();
                  break;
               case "RWE_USER_CHOOSER":
                  _loc4_ = new UserChooserWidgetHandler();
                  break;
               case "RWE_ROOM_DIMMER":
                  _loc4_ = new FurnitureDimmerWidgetHandler();
                  break;
               case "RWE_FRIEND_REQUEST":
                  _loc4_ = new FriendRequestWidgetHandler();
                  break;
               case "RWE_CLOTHING_CHANGE":
                  _loc4_ = new FurnitureClothingChangeWidgetHandler();
                  break;
               case "RWE_CONVERSION_TRACKING":
                  _loc4_ = new ConversionPointWidgetHandler();
                  break;
               case "RWE_AVATAR_INFO":
                  _loc4_ = new AvatarInfoWidgetHandler();
                  break;
               case "RWE_PLAYLIST_EDITOR_WIDGET":
                  _loc21_ = new PlayListEditorWidgetHandler();
                  _loc21_.connection = _connection;
                  _loc4_ = _loc21_ as IRoomWidgetHandler;
                  break;
               case "RWE_SPAMWALL_POSTIT_WIDGET":
                  _loc5_ = new SpamWallPostItWidgetHandler();
                  _loc5_.connection = _connection;
                  _loc4_ = _loc5_ as IRoomWidgetHandler;
                  break;
               case "RWE_EFFECTS":
                  _loc4_ = new EffectsWidgetHandler();
                  break;
               case "RWE_MANNEQUIN":
                  _loc4_ = new MannequinWidgetHandler();
                  break;
               case "RWE_FURNITURE_CONTEXT_MENU":
                  _loc8_ = new FurnitureContextMenuWidgetHandler();
                  _loc8_.connection = _connection;
                  _loc4_ = _loc8_ as IRoomWidgetHandler;
                  break;
               case "RWE_LOCATION_WIDGET":
                  _loc4_ = new ObjectLocationRequestHandler();
                  break;
               case "RWE_CAMERA":
                  _loc4_ = new CameraWidgetHandler(this);
                  break;
               case "RWE_ROOM_BACKGROUND_COLOR":
                  _loc4_ = new FurnitureBackgroundColorWidgetHandler();
                  break;
               case "RWE_AREA_HIDE":
                  _loc4_ = new FurnitureAreaHideWidgetHandler();
                  break;
               case "RWE_CUSTOM_USER_NOTIFICATION":
                  _loc4_ = new CustomUserNotificationWidgetHandler();
                  break;
               case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                  _loc4_ = new FurnitureBadgeDisplayWidgetHandler();
                  break;
               case "RWE_FRIEND_FURNI_CONFIRM":
                  _loc4_ = new FriendFurniConfirmWidgetHandler();
                  FriendFurniConfirmWidgetHandler(_loc4_).connection = connection;
                  break;
               case "RWE_FRIEND_FURNI_ENGRAVING":
                  _loc4_ = new FriendFurniEngravingWidgetHandler();
                  break;
               case "RWE_HIGH_SCORE_DISPLAY":
                  _loc4_ = new HighScoreFurniWidgetHandler();
                  break;
               case "RWE_INTERNAL_LINK":
                  _loc4_ = new FurnitureInternalLinkHandler();
                  break;
               case "RWE_ROOM_LINK":
                  _loc16_ = new FurnitureRoomLinkHandler();
                  _loc16_.communicationManager = _communicationManager;
                  _loc4_ = _loc16_;
                  break;
               case "RWE_CUSTOM_STACK_HEIGHT":
                  _loc4_ = new FurnitureCustomStackHeightWidgetHandler();
                  break;
               case "RWE_YOUTUBE":
                  _loc4_ = new FurnitureYoutubeDisplayWidgetHandler();
                  break;
               case "RWE_RENTABLESPACE":
                  _loc4_ = new FurnitureRentableSpaceWidgetHandler();
                  break;
               case "RWE_VIMEO":
                  _loc4_ = new FurnitureVimeoDisplayWidgetHandler();
                  break;
               case "RWE_ROOM_TOOLS":
                  _loc10_ = new RoomToolsWidgetHandler();
                  _loc10_.communicationManager = _communicationManager;
                  _loc10_.navigator = _navigator;
                  _loc4_ = _loc10_;
                  break;
               case "RWE_EXTERNAL_IMAGE":
                  _loc4_ = new ExternalImageWidgetHandler();
                  break;
               case "RWE_UI_HELP_BUBBLE":
                  _loc4_ = new UiHelpBubbleWidgetHandler();
                  break;
               case "RWE_ROOM_THUMBNAIL_CAMERA":
                  _loc4_ = new RoomThumbnailCameraWidgetHandler(this);
                  break;
               case "RWE_CRAFTING":
                  _loc4_ = new CraftingWidgetHandler(this);
            }
         }
         else
         {
            _loc22_ = param3 as RoomWidgetBase;
            if(_loc22_ != null)
            {
               _loc4_ = _loc22_.widgetHandler;
               _loc6_ = _loc4_ as FurnitureRoomLinkHandler;
               if(_loc6_ != null)
               {
                  _loc14_.connection = _connection;
               }
               _loc15_ = _loc4_ as ChatWidgetHandler;
               if(_loc15_ != null)
               {
                  _loc15_.connection = _connection;
               }
               _loc14_ = _loc4_ as FurnitureContextMenuWidgetHandler;
               if(_loc14_ != null)
               {
                  _loc14_.connection = _connection;
               }
               _loc12_ = _loc4_ as RoomToolsWidgetHandler;
               if(_loc12_ != null)
               {
                  _loc12_.communicationManager = _communicationManager;
                  _loc12_.navigator = _navigator;
               }
            }
         }
         if(_loc4_ != null)
         {
            _loc4_.container = this;
            _loc18_ = null;
            _loc19_ = _loc4_.getWidgetMessages();
            if(_loc19_ != null)
            {
               for each(var _loc13_:String in _loc19_)
               {
                  _loc18_ = UnknownVarFromRoomDesktop_Map_2.getValue(_loc13_);
                  if(_loc18_ == null)
                  {
                     _loc18_ = [];
                     UnknownVarFromRoomDesktop_Map_2.add(_loc13_,_loc18_);
                  }
                  _loc18_.push(_loc4_);
               }
            }
            _loc23_ = _loc4_.getProcessedEvents();
            if(_loc23_ != null)
            {
               _loc23_.push("RETWE_OPEN_WIDGET");
               _loc23_.push("RETWE_CLOSE_WIDGET");
               for each(var _loc20_:String in _loc23_)
               {
                  _loc18_ = UnknownVarFromRoomDesktop_Map_3.getValue(_loc20_);
                  if(_loc18_ == null)
                  {
                     _loc18_ = [];
                     UnknownVarFromRoomDesktop_Map_3.add(_loc20_,_loc18_);
                  }
                  _loc18_.push(_loc4_);
               }
            }
         }
         _loc7_ = param3 == null ? _roomWidgetFactory.createWidget(param1,_loc4_) : param3;
         if(_loc7_ == null)
         {
            return null;
         }
         _loc7_.messageListener = this;
         _loc7_.registerUpdateEvents(_events);
         _loc7_.reusable = param2;
         _loc7_.widgetType = param1;
         if(!UnknownVarFromRoomDesktop_Map_1.add(param1,_loc7_))
         {
            if(param3 == null)
            {
               _loc7_.dispose();
            }
            else
            {
               param3.release();
            }
         }
         else
         {
            if(param3 != null)
            {
               param3.reuse(this);
            }
            _layoutManager.addWidgetWindow(param1,_loc7_.mainWindow);
         }
         if(_loc11_)
         {
            param1 = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
            _loc17_ = new RoomWidgetRoomViewUpdateEvent(param1,_layoutManager.roomViewRect);
            this.events.dispatchEvent(_loc17_);
         }
         return _loc7_;
      }
      
      private function isGameWidget(param1:String) : Boolean
      {
         switch(param1)
         {
            case "RWE_CHAT_INPUT_WIDGET":
            case "RWE_CHAT_WIDGET":
            case "RWE_AVATAR_INFO":
            case "RWE_LOCATION_WIDGET":
               break;
            default:
               return false;
         }
         return true;
      }
      
      public function disposeWidget(param1:String) : void
      {
         var _loc2_:IRoomWidget = null;
         if(UnknownVarFromRoomDesktop_Map_1 != null)
         {
            _loc2_ = UnknownVarFromRoomDesktop_Map_1.remove(param1);
            if(_loc2_ != null)
            {
               if(_layoutManager != null)
               {
                  _layoutManager.removeWidgetWindow(param1,_loc2_.mainWindow);
               }
               _loc2_.dispose();
            }
         }
      }
      
      public function getWidget(param1:String) : IRoomWidget
      {
         var _loc2_:IRoomWidget = null;
         if(UnknownVarFromRoomDesktop_Map_1 != null)
         {
            _loc2_ = UnknownVarFromRoomDesktop_Map_1[param1];
         }
         return _loc2_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetUpdateEvent = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1.type == "RWZTM_ZOOM_TOGGLE")
         {
            toggleZoom();
         }
         var _loc3_:Array = UnknownVarFromRoomDesktop_Map_2.getValue(param1.type);
         if(_loc3_ != null)
         {
            for each(var _loc2_:IRoomWidgetHandler in _loc3_)
            {
               _loc4_ = _loc2_.processWidgetMessage(param1);
               if(_loc4_ != null)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:RoomEngineToWidgetEvent = null;
         if(!param1 || !UnknownVarFromRoomDesktop_Map_3)
         {
            return;
         }
         if(UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1 && param1.type == "RDMZEE_ENABLED")
         {
            checkAndEnableMouseZoomEvent(UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject());
         }
         var _loc4_:Array = UnknownVarFromRoomDesktop_Map_3.getValue(param1.type);
         if(_loc4_ != null)
         {
            for each(var _loc2_:IRoomWidgetHandler in _loc4_)
            {
               _loc3_ = true;
               if(param1.type == "RETWE_OPEN_WIDGET" || param1.type == "RETWE_CLOSE_WIDGET")
               {
                  _loc5_ = param1 as RoomEngineToWidgetEvent;
                  _loc3_ = _loc5_ != null && _loc2_.type == _loc5_.widget;
               }
               if(param1.type == "RWZTM_ZOOM_TOGGLE")
               {
                  toggleZoom();
               }
               if(_loc3_)
               {
                  _loc2_.processEvent(param1);
               }
            }
         }
      }
      
      private function isFurnitureSelectionDisabled(param1:RoomEngineObjectEvent) : Boolean
      {
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:Boolean = false;
         var _loc2_:IRoomObject = roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.getModel();
            if(_loc4_ != null)
            {
               if(_loc4_.getNumber("furniture_selection_disable") == 1)
               {
                  _loc3_ = true;
                  if(_sessionDataManager.isAnyRoomController)
                  {
                     _loc3_ = false;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc4_:String = null;
         var _loc12_:UnknownIHabboSession1 = null;
         var _loc3_:RoomEngineObjectPlacedEvent = null;
         var _loc13_:IRoomObject = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:Boolean = false;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc10_:int = param1.objectId;
         var _loc11_:int = param1.category;
         var _loc8_:RoomWidgetRoomObjectUpdateEvent = null;
         var _loc6_:RoomWidgetFurniToWidgetMessage = null;
         switch(param1.type)
         {
            case "REOE_SELECTED":
               if(!isFurnitureSelectionDisabled(param1))
               {
                  _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_SELECTED",_loc10_,_loc11_,param1.roomId);
               }
               if(_moderation != null && _loc11_ == 100)
               {
                  _loc12_ = _roomSession.userDataManager.getUserDataByIndex(_loc10_);
                  if(_loc12_ != null && _loc12_.type == 1)
                  {
                     _moderation.userSelected(_loc12_.webID,_loc12_.name);
                  }
               }
               break;
            case "REOE_PLACED":
               _loc3_ = param1 as RoomEngineObjectPlacedEvent;
               _loc8_ = new RoomWidgetRoomObjectPlaceEvent("RWROUE_OBJECT_PLACED",_loc10_,_loc11_,param1.roomId,_loc3_.wallLocation,_loc3_.x,_loc3_.y,_loc3_.z,_loc3_.direction,_loc3_.placedInRoom,_loc3_.placedOnFloor,_loc3_.placedOnWall,_loc3_.instanceData,_loc3_.placementSource);
               break;
            case "REOE_ADDED":
               switch(_loc11_)
               {
                  case 10:
                  case 20:
                     _loc4_ = "RWROUE_FURNI_ADDED";
                     break;
                  case 100:
                     _loc4_ = "RWROUE_USER_ADDED";
               }
               if(_loc4_ != null)
               {
                  _loc8_ = new RoomWidgetRoomObjectUpdateEvent(_loc4_,_loc10_,_loc11_,param1.roomId);
               }
               break;
            case "REOE_REMOVED":
               switch(_loc11_)
               {
                  case 10:
                  case 20:
                     _loc4_ = "RWROUE_FURNI_REMOVED";
                     break;
                  case 100:
                     _loc4_ = "RWROUE_USER_REMOVED";
               }
               if(_loc4_ != null)
               {
                  _loc8_ = new RoomWidgetRoomObjectUpdateEvent(_loc4_,_loc10_,_loc11_,param1.roomId);
               }
               break;
            case "REOE_DESELECTED":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_DESELECTED",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_MOUSE_ENTER":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OVER",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_MOUSE_LEAVE":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OUT",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_REQUEST_MOVE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_MOVE");
               }
               break;
            case "REOE_REQUEST_ROTATE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_ROTATE_POSITIVE");
               }
               break;
            case "REOE_REQUEST_PICKUP":
               _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_PICKUP");
               break;
            case "RETWE_REQUEST_CREDITFURNI":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CREDITFURNI",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_STICKIE":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_STICKIE",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_PRESENT":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PRESENT",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_TROPHY":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TROPHY",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_TEASER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TEASER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_ECOTRONBOX":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_ECOTRONBOX",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_DIMMER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_DIMMER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_PLACEHOLDER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLACEHOLDER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RERAE_FURNI_CLICK":
            case "RERAE_FURNI_DOUBLE_CLICK":
               handleRoomAdClick(param1);
               break;
            case "RERAE_TOOLTIP_SHOW":
            case "RERAE_TOOLTIP_HIDE":
               handleRoomAdTooltip(param1);
               break;
            case "RETWE_REQUEST_CLOTHING_CHANGE":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_PLAYLIST_EDITOR":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(_loc6_);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
               _loc13_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
               if(_loc13_ != null)
               {
                  _loc5_ = _loc13_.getModel().getNumber("furniture_owner_id");
                  _loc9_ = _sessionDataManager.userId;
                  if(_loc5_ == _loc9_)
                  {
                     _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",_loc10_,_loc11_,param1.roomId);
                     processWidgetMessage(_loc6_);
                  }
               }
               break;
            case "RETWE_OPEN_WIDGET":
            case "RETWE_CLOSE_WIDGET":
            case "RETWE_OPEN_FURNI_CONTEXT_MENU":
            case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
            case "RETWE_REMOVE_DIMMER":
            case "ROSM_JUKEBOX_DISPOSE":
            case "RETWE_REQUEST_MANNEQUIN":
            case "ROSM_USE_PRODUCT_FROM_INVENTORY":
            case "ROSM_USE_PRODUCT_FROM_ROOM":
            case "RETWE_REQUEST_BACKGROUND_COLOR":
            case "RETWE_REQUEST_AREA_HIDE":
            case "RETWE_UPDATE_STATE_AREA_HIDE":
            case "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING":
            case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_INTERNAL_LINK":
            case "RETWE_REQUEST_ROOM_LINK":
               processEvent(param1);
         }
         if(_loc8_ != null)
         {
            _loc2_ = true;
            if(_loc8_ is RoomWidgetRoomObjectUpdateEvent)
            {
               _loc7_ = (_loc8_ as RoomWidgetRoomObjectUpdateEvent).roomId;
               _loc2_ = !RoomId.isRoomPreviewerId(_loc7_);
            }
            else if(_loc8_ is RoomWidgetRoomEngineUpdateEvent)
            {
               _loc7_ = (_loc8_ as RoomWidgetRoomEngineUpdateEvent).roomId;
               _loc2_ = !RoomId.isRoomPreviewerId(_loc7_);
            }
            if(_loc2_)
            {
               events.dispatchEvent(_loc8_);
            }
         }
      }
      
      private function checkFurniManipulationRights(param1:int, param2:int, param3:int) : Boolean
      {
         return _roomSession.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController || isOwnerOfFurniture(_roomEngine.getRoomObject(param1,param2,param3)) || _roomEngine.activeRoomHasFreeFurniMovementsMode;
      }
      
      public function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:RoomWidgetUpdateEvent = null;
         switch(param1.type)
         {
            case "REE_NORMAL_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_NORMAL_MODE",param1.roomId);
               break;
            case "REE_GAME_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_GAME_MODE",param1.roomId);
         }
         if(_loc2_ != null)
         {
            events.dispatchEvent(_loc2_);
         }
      }
      
      public function createRoomView(param1:int) : void
      {
         var _loc15_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc6_:UnknownICoreWindow4 = null;
         var _loc3_:Rectangle = _layoutManager.roomViewRect;
         var _loc16_:int = _loc3_.width;
         var _loc22_:int = _loc3_.height;
         var _loc7_:int = _roomSession.isGameSession ? 32 : 64;
         if(UnknownVarFromRoomDesktop_Array_1.indexOf(param1) >= 0)
         {
            return;
         }
         if(_roomSession == null || _windowManager == null || _roomEngine == null)
         {
            return;
         }
         var _loc17_:DisplayObject = _roomEngine.createRoomCanvas(_roomSession.roomId,param1,_loc16_,_loc22_,_loc7_);
         if(_loc17_ == null)
         {
            return;
         }
         var _loc18_:RoomGeometry = _roomEngine.getRoomCanvasGeometry(_roomSession.roomId,param1) as RoomGeometry;
         if(_loc18_ != null)
         {
            _loc15_ = _roomEngine.getRoomNumberValue(_roomSession.roomId,"room_min_x");
            _loc5_ = _roomEngine.getRoomNumberValue(_roomSession.roomId,"room_max_x");
            _loc14_ = _roomEngine.getRoomNumberValue(_roomSession.roomId,"room_min_y");
            _loc4_ = _roomEngine.getRoomNumberValue(_roomSession.roomId,"room_max_y");
            _loc13_ = (_loc15_ + _loc5_) / 2;
            _loc10_ = (_loc14_ + _loc4_) / 2;
            _loc8_ = 20;
            _loc13_ += _loc8_ - 1;
            _loc10_ += _loc8_ - 1;
            _loc11_ = Math.sqrt(_loc8_ * _loc8_ + _loc8_ * _loc8_) * Math.tan(0.16666666666666666 * 3.141592653589793);
            _loc18_.location = new Vector3d(_loc13_,_loc10_,_loc11_);
         }
         var _loc20_:XmlAsset = _assets.getAssetByName("room_view_container_xml") as XmlAsset;
         if(_loc20_ == null)
         {
            return;
         }
         var _loc9_:UnknownICoreWindow5 = _windowManager.buildFromXML(_loc20_.content as XML) as UnknownICoreWindow5;
         if(_loc9_ == null)
         {
            return;
         }
         _loc9_.width = _loc16_;
         _loc9_.height = _loc22_;
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1 = _loc9_.findChildByName("room_canvas_wrapper") as UnknownICoreWindowComponents6;
         if(UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1 == null)
         {
            return;
         }
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.setDisplayObject(_loc17_);
         if(_roomSession.isGameSession)
         {
            _loc17_.addEventListener("click",mouseEventHandler);
         }
         checkAndEnableMouseZoomEvent(_loc17_);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_CLICK",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_DOUBLE_CLICK",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_MOVE",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_DOWN",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_UP",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WME_UP_OUTSIDE",canvasMouseHandler);
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.addEventListener("WE_RESIZED",onRoomViewResized);
         var _loc19_:Sprite = new Sprite();
         _loc19_.mouseEnabled = false;
         _loc19_.blendMode = "multiply";
         var _loc21_:UnknownICoreWindowComponents6 = _loc9_.findChildByName("colorizer_wrapper") as UnknownICoreWindowComponents6;
         if(_loc21_ == null)
         {
            return;
         }
         _loc21_.setDisplayObject(_loc19_);
         _loc21_.addEventListener("WE_RESIZED",resizeColorizer);
         var _loc2_:Sprite = new Sprite();
         _loc2_.mouseEnabled = false;
         var _loc12_:UnknownICoreWindowComponents6 = _loc9_.findChildByName("background_wrapper") as UnknownICoreWindowComponents6;
         if(_loc12_ == null)
         {
            return;
         }
         _loc12_.setDisplayObject(_loc2_);
         _loc12_.addEventListener("WE_RESIZED",resizeBackgroundColorizer);
         if(_roomSession.isSpectatorMode)
         {
            _loc6_ = getSpectatorModeVisualization();
            if(_loc6_ != null)
            {
               _loc6_.width = _loc9_.width;
               _loc6_.height = _loc9_.height;
               _loc9_.addChild(_loc6_);
            }
         }
         _layoutManager.addRoomView(_loc9_);
         UnknownVarFromRoomDesktop_Array_1.push(param1);
      }
      
      public function initCameraLocation(param1:int) : void
      {
         var _loc5_:Vector3d = null;
         var _loc2_:Number = _roomEngine.getRoomNumberValue(_roomSession.roomId,"camera_init_x");
         var _loc4_:Number = _roomEngine.getRoomNumberValue(_roomSession.roomId,"camera_init_y");
         var _loc3_:Number = _roomEngine.getRoomNumberValue(_roomSession.roomId,"camera_init_z");
         if(!isNaN(_loc2_) && !isNaN(_loc4_) && !isNaN(_loc3_))
         {
            _loc5_ = new Vector3d(_loc2_,_loc4_,_loc3_);
            _roomEngine.runUpdate();
            _roomEngine.updateRoomCamera(_roomSession.roomId,param1,_loc5_,1);
         }
      }
      
      public function enterAfterSpectate() : void
      {
         var _loc2_:UnknownICoreWindow5 = _layoutManager.getRoomView() as UnknownICoreWindow5;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:UnknownICoreWindow4 = _loc2_.findChildByName("spectator_mode_container");
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_.removeChild(_loc1_);
         _loc1_.dispose();
      }
      
      private function checkAndEnableMouseZoomEvent(param1:DisplayObject) : void
      {
         param1.removeEventListener("mouseWheel",mouseWheelHandler);
         if(_sessionDataManager.isPerkAllowed("MOUSE_ZOOM"))
         {
            param1.addEventListener("mouseWheel",mouseWheelHandler);
         }
      }
      
      private function mouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1.ctrlKey && !param1.altKey && !param1.shiftKey)
         {
            var _temp_3:* = §§findproperty(UnknownVarFromRoomDesktop_Number_2);
            UnknownVarFromRoomDesktop_Number_2 += param1.delta == 0 ? 0 : (param1.delta < 0 ? -20 : 20);
            _loc3_ = new Point();
            UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getGlobalPosition(_loc3_);
            _loc2_ = param1.stageX - _loc3_.x;
            _loc4_ = param1.stageY - _loc3_.y;
            UnknownVarFromRoomDesktop_Point_1 = new Point(_loc2_,_loc4_);
         }
      }
      
      private function resizeColorizer(param1:WindowEvent) : void
      {
         var _loc2_:UnknownICoreWindowComponents6 = param1.target as UnknownICoreWindowComponents6;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Sprite = _loc2_.getDisplayObject() as Sprite;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.graphics.clear();
         _loc3_.graphics.beginFill(_roomColor);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc3_.graphics.endFill();
      }
      
      private function resizeBackgroundColorizer(param1:WindowEvent) : void
      {
         var _loc2_:UnknownICoreWindowComponents6 = param1.target as UnknownICoreWindowComponents6;
         if(_loc2_ == null)
         {
            return;
         }
         fillBackgroundColorizer(_loc2_);
      }
      
      private function fillBackgroundColorizer(param1:UnknownICoreWindowComponents6) : void
      {
         var _loc2_:Sprite = param1.getDisplayObject() as Sprite;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.graphics.clear();
         _loc2_.graphics.beginFill(_roomBackgroundColor);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
      }
      
      public function setRoomViewColor(param1:uint, param2:int) : void
      {
         if(UnknownVarFromRoomDesktop_ColorTransitioner_1)
         {
            UnknownVarFromRoomDesktop_ColorTransitioner_1.startTransition(param1,param2,getTimer());
         }
      }
      
      private function updateColor() : void
      {
         if(UnknownVarFromRoomDesktop_ColorTransitioner_1 && UnknownVarFromRoomDesktop_ColorTransitioner_1.updateColor(getTimer()))
         {
            _roomColor = UnknownVarFromRoomDesktop_ColorTransitioner_1.color;
            drawRoomColor();
         }
         if(UnknownVarFromRoomDesktop_ColorTransitioner_2 && UnknownVarFromRoomDesktop_ColorTransitioner_2.updateColor(getTimer()))
         {
            _roomBackgroundColor = UnknownVarFromRoomDesktop_ColorTransitioner_2.color;
            drawRoomBackgroundColor();
         }
      }
      
      private function drawRoomColor() : void
      {
         var _loc2_:UnknownICoreWindow5 = _layoutManager.getRoomView() as UnknownICoreWindow5;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:UnknownICoreWindowComponents6 = _loc2_.getChildByName("colorizer_wrapper") as UnknownICoreWindowComponents6;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Sprite = _loc3_.getDisplayObject() as Sprite;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(_roomColor);
         _loc1_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
         _loc1_.graphics.endFill();
      }
      
      public function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void
      {
         if(UnknownVarFromRoomDesktop_ColorTransitioner_2)
         {
            UnknownVarFromRoomDesktop_ColorTransitioner_2.startTransition(ColorConverter.hslToRGB(((param1 & 0xFF) << 16) + ((param2 & 0xFF) << 8) + (param3 & 0xFF)),param3,getTimer());
         }
      }
      
      private function drawRoomBackgroundColor() : void
      {
         var _loc1_:UnknownICoreWindow5 = _layoutManager.getRoomView() as UnknownICoreWindow5;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:UnknownICoreWindowComponents6 = _loc1_.getChildByName("background_wrapper") as UnknownICoreWindowComponents6;
         if(_loc2_ == null)
         {
            return;
         }
         if(roomBackgroundColor == 0)
         {
            _loc2_.visible = false;
         }
         else
         {
            _loc2_.visible = true;
            fillBackgroundColorizer(_loc2_);
         }
      }
      
      public function getFirstCanvasId() : int
      {
         if(UnknownVarFromRoomDesktop_Array_1 != null)
         {
            if(UnknownVarFromRoomDesktop_Array_1.length > 0)
            {
               return UnknownVarFromRoomDesktop_Array_1[0];
            }
         }
         return 0;
      }
      
      public function getRoomViewRect() : Rectangle
      {
         if(!_layoutManager)
         {
            return null;
         }
         return _layoutManager.roomViewRect;
      }
      
      public function addListenerToStage(param1:String, param2:Function) : void
      {
         if(!UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1 || !UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject() || !UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject().stage)
         {
            return;
         }
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject().stage.addEventListener(param1,param2,false,0,true);
      }
      
      public function removeListenerFromStage(param1:String, param2:Function) : void
      {
         if(!UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1 || !UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject() || !UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject().stage)
         {
            return;
         }
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getDisplayObject().stage.removeEventListener(param1,param2);
      }
      
      public function canvasMouseHandler(param1:WindowEvent) : void
      {
         var _loc5_:Point = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Point = null;
         if(_roomEngine == null || _roomSession == null)
         {
            return;
         }
         var _loc4_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:String = "";
         switch(_loc4_.type)
         {
            case "WME_CLICK":
               _loc8_ = "click";
               break;
            case "WME_DOUBLE_CLICK":
               _loc8_ = "doubleClick";
               break;
            case "WME_DOWN":
               _loc8_ = "mouseDown";
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               _loc8_ = "mouseUp";
               break;
            case "WME_MOVE":
               _loc8_ = "mouseMove";
               break;
            default:
               return;
         }
         var _loc2_:UnknownICoreWindowComponents6 = _loc4_.target as UnknownICoreWindowComponents6;
         if(_loc2_ == _loc4_.target)
         {
            _loc5_ = new Point();
            _loc2_.getGlobalPosition(_loc5_);
            _loc3_ = _loc4_.stageX - _loc5_.x;
            _loc7_ = _loc4_.stageY - _loc5_.y;
            _roomEngine.setActiveRoom(_roomSession.roomId);
            _roomEngine.handleRoomCanvasMouseEvent(UnknownVarFromRoomDesktop_Array_1[0],_loc3_,_loc7_,_loc8_,_loc4_.altKey,_loc4_.ctrlKey,_loc4_.shiftKey,_loc4_.buttonDown);
         }
         if(_loc8_ == "mouseMove" && UnknownVarFromRoomDesktop_IToolTipWindow_1 != null)
         {
            _loc6_ = new Point(_loc4_.stageX,_loc4_.stageY);
            _loc6_.offset(-UnknownVarFromRoomDesktop_IToolTipWindow_1.width / 2,15);
            UnknownVarFromRoomDesktop_IToolTipWindow_1.setGlobalPosition(_loc6_);
         }
      }
      
      private function mouseEventHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = new Point();
         UnknownVarFromRoomDesktop_UnknownICoreWindowComponents6_1.getGlobalPosition(_loc3_);
         var _loc2_:int = param1.stageX - _loc3_.x;
         var _loc4_:int = param1.stageY - _loc3_.y;
         _roomEngine.setActiveRoom(_roomSession.roomId);
         param1.stopImmediatePropagation();
         _roomEngine.handleRoomCanvasMouseEvent(UnknownVarFromRoomDesktop_Array_1[0],_loc2_,_loc4_,param1.type,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
      }
      
      private function onRoomViewResized(param1:WindowEvent) : void
      {
         var _loc2_:UnknownICoreWindow4 = param1.window;
         UnknownVarFromRoomDesktop_Rectangle_1 = _loc2_.rectangle;
         _roomEngine.modifyRoomCanvas(_roomSession.roomId,UnknownVarFromRoomDesktop_Array_1[0],_loc2_.width,_loc2_.height);
         if(UnknownVarFromRoomDesktop_Timer_1 == null)
         {
            UnknownVarFromRoomDesktop_Timer_1 = new Timer(1000,1);
            UnknownVarFromRoomDesktop_Timer_1.addEventListener("timer",onResizeTimerEvent);
         }
         else
         {
            UnknownVarFromRoomDesktop_Timer_1.reset();
         }
         UnknownVarFromRoomDesktop_Timer_1.start();
      }
      
      private function onResizeTimerEvent(param1:TimerEvent) : void
      {
         var _loc2_:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
         events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent(_loc2_,UnknownVarFromRoomDesktop_Rectangle_1));
      }
      
      private function trackZooming(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(UnknownVarFromRoomDesktop_Boolean_2)
         {
            _loc3_ = getTimer();
            _loc4_ = Math.round((_loc3_ - _zoomChangedMillis) / 1000);
            if(_habboTracking != null)
            {
               if(param1)
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","out");
                  }
                  _habboTracking.trackGoogle("zoomEnded","in",_loc4_);
               }
               else
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","in");
                  }
                  _habboTracking.trackGoogle("zoomEnded","out",_loc4_);
               }
            }
            _zoomChangedMillis = _loc3_;
         }
      }
      
      private function onToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTIE_ICON_ZOOM")
         {
            toggleZoom();
         }
      }
      
      private function toggleZoom() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:IRoomGeometry = null;
         if(_roomSession != null)
         {
            if((_roomEngine as Component).getBoolean("zoom.enabled"))
            {
               _loc1_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
               _loc2_ = _loc1_ == 1 ? 0.5 : 1;
               _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId,getFirstCanvasId(),_loc2_);
            }
            else
            {
               _loc3_ = _roomEngine.getRoomCanvasGeometry(_roomSession.roomId,getFirstCanvasId());
               if(_loc3_ != null)
               {
                  trackZooming(_loc3_.isZoomedIn(),true);
                  _loc3_.performZoom();
               }
            }
         }
      }
      
      public function update() : void
      {
         var _loc6_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:IRoomWidgetHandler = null;
         var _loc1_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         if(_updateListeners == null)
         {
            return;
         }
         var _loc3_:int = int(_updateListeners.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _updateListeners[_loc4_] as IRoomWidgetHandler;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc4_++;
         }
         if(Math.abs(UnknownVarFromRoomDesktop_Number_2) > 0.01)
         {
            _loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
            _loc1_ = hibit(_loc6_);
            _loc7_ = (_loc1_ > 1 ? _loc1_ << 1 : 1) / 10;
            _loc5_ = UnknownVarFromRoomDesktop_Number_2 > 0 ? _loc6_ - _loc7_ : _loc6_ + _loc7_;
            _loc5_ = Math.max(0.5,_loc5_);
            UnknownVarFromRoomDesktop_Boolean_3 = true;
            UnknownVarFromRoomDesktop_Number_2 *= 0.05;
            _roomEngine.setRoomCanvasScale(_roomSession.roomId,getFirstCanvasId(),_loc5_,UnknownVarFromRoomDesktop_Point_1,null,false,true);
         }
         else if(UnknownVarFromRoomDesktop_Boolean_3)
         {
            UnknownVarFromRoomDesktop_Boolean_3 = false;
            _loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
            if(_loc6_ < 0.75)
            {
               _roomEngine.setRoomCanvasScale(_roomSession.roomId,getFirstCanvasId(),0.5,UnknownVarFromRoomDesktop_Point_1,null,false,true);
            }
            else
            {
               _roomEngine.setRoomCanvasScale(_roomSession.roomId,getFirstCanvasId(),Math.round(_loc6_),UnknownVarFromRoomDesktop_Point_1,null,false,true);
            }
         }
         updateColor();
      }
      
      private function hibit(param1:int) : int
      {
         param1 |= param1 >> 1;
         param1 |= param1 >> 2;
         param1 |= param1 >> 4;
         param1 |= param1 >> 8;
         param1 |= param1 >> 16;
         return param1 - (param1 >> 1);
      }
      
      private function getWindowName(param1:int) : String
      {
         return "Room_Engine_Window_" + param1;
      }
      
      private function createFilter(param1:int, param2:int) : Array
      {
         var _loc3_:BlurFilter = new BlurFilter(2,2);
         return [];
      }
      
      private function getBitmapFilter(param1:int, param2:int) : BitmapFilter
      {
         var _loc9_:BitmapData = new BitmapData(param1,param2);
         _loc9_.perlinNoise(param1,param2,5,Math.random() * 2000000000,true,false);
         var _loc6_:Point = new Point(0,0);
         var _loc12_:uint;
         var _loc11_:uint = _loc12_ = 1;
         var _loc3_:Number = param1 / 20;
         var _loc5_:Number = -param1 / 25;
         var _loc4_:String = "color";
         var _loc8_:uint = 0;
         var _loc10_:Number = 0;
         return new DisplacementMapFilter(_loc9_,_loc6_,_loc12_,_loc11_,_loc3_,_loc5_,_loc4_,_loc8_,_loc10_);
      }
      
      private function checkInterrupts() : Boolean
      {
         if(_roomSessionManager != null && _roomSession != null && UnknownVarFromRoomDesktop_Boolean_1)
         {
            _roomSessionManager.startSession(_roomSession);
            processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUW_HIDE_LOADING_BAR"));
            return true;
         }
         return false;
      }
      
      private function handleRoomAdClick(param1:RoomEngineObjectEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObject = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel() as IRoomObjectModel;
         var _loc2_:String = _loc3_.getString("furniture_ad_url");
         if(_loc2_ == null || _loc2_.indexOf("http") != 0)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_FURNI_CLICK":
               if(_roomSession.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
               break;
            case "RERAE_FURNI_DOUBLE_CLICK":
               if(!_roomSession.roomControllerLevel >= 1 && !_sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
         }
      }
      
      private function handleRoomAdTooltip(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc4_:String = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc2_:String = null;
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_TOOLTIP_SHOW":
               if(UnknownVarFromRoomDesktop_IToolTipWindow_1 != null)
               {
                  return;
               }
               _loc3_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
               if(_loc3_ == null)
               {
                  return;
               }
               _loc4_ = _localization.getLocalization(_loc3_.getType() + ".tooltip","${ads.roomad.tooltip}");
               if(_loc4_ == null)
               {
                  _loc5_ = _loc3_.getModel() as IRoomObjectModel;
                  _loc2_ = _loc5_.getString("furniture_ad_url");
                  if(_loc2_ != null && _loc2_.indexOf("http") == 0)
                  {
                     _loc4_ = _loc2_;
                  }
               }
               if(_loc4_ == null)
               {
                  return;
               }
               UnknownVarFromRoomDesktop_IToolTipWindow_1 = _windowManager.createWindow("room_ad_tooltip",_loc4_,8,0,32) as IToolTipWindow;
               UnknownVarFromRoomDesktop_IToolTipWindow_1.setParamFlag(1,false);
               UnknownVarFromRoomDesktop_IToolTipWindow_1.visible = true;
               UnknownVarFromRoomDesktop_IToolTipWindow_1.center();
               break;
            case "RERAE_TOOLTIP_HIDE":
               if(UnknownVarFromRoomDesktop_IToolTipWindow_1 == null)
               {
                  return;
               }
               UnknownVarFromRoomDesktop_IToolTipWindow_1.dispose();
               UnknownVarFromRoomDesktop_IToolTipWindow_1 = null;
         }
      }
      
      private function getSpectatorModeVisualization() : UnknownICoreWindow4
      {
         var _loc2_:XmlAsset = _assets.getAssetByName("spectator_mode_xml") as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:UnknownICoreWindow5 = _windowManager.buildFromXML(_loc2_.content as XML) as UnknownICoreWindow5;
         if(_loc1_ == null)
         {
            return null;
         }
         setBitmap(_loc1_.findChildByName("top_left"),"spec_top_left_png");
         setBitmap(_loc1_.findChildByName("top_middle"),"spec_top_middle_png");
         setBitmap(_loc1_.findChildByName("top_right"),"spec_top_right_png");
         setBitmap(_loc1_.findChildByName("middle_left"),"spec_middle_left_png");
         setBitmap(_loc1_.findChildByName("middle_right"),"spec_middle_right_png");
         setBitmap(_loc1_.findChildByName("bottom_left"),"spec_bottom_left_png");
         setBitmap(_loc1_.findChildByName("bottom_middle"),"spec_bottom_middle_png");
         setBitmap(_loc1_.findChildByName("bottom_right"),"spec_bottom_right_png");
         return _loc1_;
      }
      
      private function setBitmap(param1:UnknownICoreWindow4, param2:String) : void
      {
         var _loc4_:UnknownICoreWindowComponents17 = param1 as UnknownICoreWindowComponents17;
         if(_loc4_ == null || _assets == null)
         {
            return;
         }
         var _loc5_:BitmapDataAsset = _assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc5_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_.bitmap = _loc3_.clone();
      }
      
      public function getWidgetState(param1:String) : int
      {
         var _loc2_:IRoomWidget = UnknownVarFromRoomDesktop_Map_1[param1];
         if(_loc2_ == null)
         {
            Logger.log("Requested the state of an unknown widget " + param1);
            return -1;
         }
         return _loc2_.state;
      }
      
      public function addUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            _updateListeners = [];
         }
         if(_updateListeners.indexOf(param1) == -1)
         {
            _updateListeners.push(param1);
         }
      }
      
      public function removeUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            return;
         }
         var _loc2_:int = _updateListeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            _updateListeners.splice(_loc2_,1);
         }
      }
      
      public function isOwnerOfFurniture(param1:IRoomObject) : Boolean
      {
         var _loc4_:int = sessionDataManager.userId;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = _loc3_.getNumber("furniture_owner_id");
         return _loc2_ == _loc4_;
      }
      
      public function getFurnitureOwnerId(param1:IRoomObject) : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getNumber("furniture_owner_id");
            if(!isNaN(_loc2_))
            {
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function isOwnerOfPet(param1:UnknownIHabboSession1) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = sessionDataManager.userId;
         return _loc2_ == param1.ownerId;
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:AvatarInfoWidget = UnknownVarFromRoomDesktop_Map_1["RWE_AVATAR_INFO"] as AvatarInfoWidget;
         if(!_loc5_)
         {
            return;
         }
         _loc5_.showGamePlayerName(param1,param2,param3,param4);
      }
      
      public function get layoutManager() : DesktopLayoutManager
      {
         return _layoutManager;
      }
      
      public function mouseEventPositionHasInputEventWindow(param1:MouseEvent, param2:int) : Boolean
      {
         var _loc3_:Array = new Array(0);
         var _loc4_:Point = new Point(param1.stageX,param1.stageY);
         _windowManager.getDesktop(param2).groupParameterFilteredChildrenUnderPoint(_loc4_,_loc3_,1);
         return _loc3_.length > 1;
      }
   }
}


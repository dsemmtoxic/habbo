package com.sulake.habbo.ui.widget.furniture.backgroundcolor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.UnknownICoreWindow4;
   import com.sulake.core.window.UnknownICoreWindow5;
   import com.sulake.core.window.components.UnknownICoreWindowComponents17;
   import com.sulake.core.window.events.WindowEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class BackgroundColorWidgetSlider
   {
      
      private static const UnknownConstFromBackgroundColorWidgetSlider_Int_1:int = 0;
      
      private static const UnknownConstFromBackgroundColorWidgetSlider_Int_2:int = 255;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_BackgroundColorFurniWidget_1:BackgroundColorFurniWidget;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1:UnknownICoreWindow5;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_String_1:String;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1:BitmapData;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2:BitmapData;
      
      private var _referenceWidth:int;
      
      private var UnknownVarFromBackgroundColorWidgetSlider_Int_1:int;
      
      public function BackgroundColorWidgetSlider(param1:BackgroundColorFurniWidget, param2:String, param3:UnknownICoreWindow5, param4:int = 0)
      {
         var _loc5_:BitmapDataAsset = null;
         super();
         UnknownVarFromBackgroundColorWidgetSlider_BackgroundColorFurniWidget_1 = param1;
         UnknownVarFromBackgroundColorWidgetSlider_String_1 = param2;
         UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1 = param3;
         _loc5_ = BitmapDataAsset(param1.assets.getAssetByName("dimmer_slider_base"));
         UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1 = BitmapData(_loc5_.content);
         _loc5_ = BitmapDataAsset(param1.assets.getAssetByName("dimmer_slider_button"));
         UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2 = BitmapData(_loc5_.content);
         displaySlider();
         setValue(param4);
      }
      
      public function dispose() : void
      {
         UnknownVarFromBackgroundColorWidgetSlider_BackgroundColorFurniWidget_1 = null;
         UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1 = null;
         UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1 = null;
         UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2 = null;
      }
      
      public function setValue(param1:int) : void
      {
         if(UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1 == null)
         {
            return;
         }
         var _loc2_:UnknownICoreWindow4 = UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1.findChildByName("slider_button");
         if(_loc2_ != null)
         {
            _loc2_.x = getSliderPosition(param1);
         }
      }
      
      private function getSliderPosition(param1:int) : int
      {
         return int(_referenceWidth * ((param1 - 0) / (255 - 0)));
      }
      
      private function getValue(param1:Number) : int
      {
         return int(param1 / _referenceWidth * (255 - 0)) + 0;
      }
      
      private function buttonProcedure(param1:WindowEvent, param2:UnknownICoreWindow4) : void
      {
         UnknownVarFromBackgroundColorWidgetSlider_BackgroundColorFurniWidget_1.setParameterCallback(UnknownVarFromBackgroundColorWidgetSlider_String_1,getValue(param2.x));
      }
      
      private function displaySlider() : void
      {
         var _loc2_:UnknownICoreWindow5 = null;
         var _loc1_:UnknownICoreWindowComponents17 = null;
         if(UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1 == null)
         {
            return;
         }
         _loc1_ = UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1.findChildByName("slider_base") as UnknownICoreWindowComponents17;
         if(_loc1_ != null && UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1 != null)
         {
            _loc1_.bitmap = new BitmapData(UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1.width,UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1.height,true,16777215);
            _loc1_.bitmap.copyPixels(UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1,UnknownVarFromBackgroundColorWidgetSlider_BitmapData_1.rect,new Point(0,0),null,null,true);
         }
         _loc2_ = UnknownVarFromBackgroundColorWidgetSlider_UnknownICoreWindow5_1.findChildByName("slider_movement_area") as UnknownICoreWindow5;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.findChildByName("slider_button") as UnknownICoreWindowComponents17;
            if(_loc1_ != null && UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2 != null)
            {
               _loc1_.bitmap = new BitmapData(UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2.width,UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2.height,true,16777215);
               _loc1_.bitmap.copyPixels(UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2,UnknownVarFromBackgroundColorWidgetSlider_BitmapData_2.rect,new Point(0,0),null,null,true);
               _loc1_.procedure = buttonProcedure;
               _referenceWidth = _loc2_.width - _loc1_.width;
            }
         }
      }
   }
}


package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRoomBackgroundColorDataComposer implements IMessageComposer
   {
      
      private var UnknownVarFromSetRoomBackgroundColorDataComposer_Int_1:int;
      
      private var UnknownVarFromSetRoomBackgroundColorDataComposer_Int_2:int;
      
      private var UnknownVarFromSetRoomBackgroundColorDataComposer_Int_3:int;
      
      private var UnknownVarFromSetRoomBackgroundColorDataComposer_Int_4:int;
      
      public function SetRoomBackgroundColorDataComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         UnknownVarFromSetRoomBackgroundColorDataComposer_Int_1 = param1;
         UnknownVarFromSetRoomBackgroundColorDataComposer_Int_2 = param2;
         UnknownVarFromSetRoomBackgroundColorDataComposer_Int_3 = param3;
         UnknownVarFromSetRoomBackgroundColorDataComposer_Int_4 = param4;
      }
      
      public function getMessageArray() : Array
      {
         return [UnknownVarFromSetRoomBackgroundColorDataComposer_Int_1,UnknownVarFromSetRoomBackgroundColorDataComposer_Int_2,UnknownVarFromSetRoomBackgroundColorDataComposer_Int_3,UnknownVarFromSetRoomBackgroundColorDataComposer_Int_4];
      }
      
      public function dispose() : void
      {
      }
   }
}


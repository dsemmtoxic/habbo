package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.friendlist.MessageHistoryEntry;
   
   [SecureSWF(rename="true")]
   public class ConsoleMessageHistoryMessageParser implements IMessageParser
   {
      
      private var _chatId:int;
      
      private var _historyFragment:Array;
      
      public function ConsoleMessageHistoryMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         this._chatId = param1.readInteger();
         _historyFragment = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            this._historyFragment.push(new MessageHistoryEntry(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get chatId() : int
      {
         return _chatId;
      }
      
      public function get historyFragment() : Array
      {
         return _historyFragment;
      }
   }
}


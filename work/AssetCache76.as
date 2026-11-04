package loginpatch {
 import flash.events.Event;
 import flash.events.IOErrorEvent;
 import flash.events.SecurityErrorEvent;
 import flash.filesystem.File;
 import flash.filesystem.FileStream;
 import flash.utils.ByteArray;

 public final class AssetCache76 {
  private static const MAX_WRITES:int=8;
  private static const _writing:Object={};
  private static var _count:int=0;

  private var _path:String;
  private var _loader:Object;
  private var _length:uint;
  private var _destination:File;
  private var _temporary:File;
  private var _stream:FileStream;

  public static function store(path:String, data:ByteArray, loader:Object):void {
   if(_writing[path]||_count>=MAX_WRITES)return;
   var job:AssetCache76=new AssetCache76();
   job._path=path;
   job._loader=loader;
   job._length=data.length;
   _writing[path]=job;
   _count++;
   job.start(data);
  }

  private function start(data:ByteArray):void {
   try {
    var root:File=File.cacheDirectory;
    _destination=root.resolvePath("com.sulake.habbo/"+_path);
    _temporary=root.resolvePath("com.sulake.habbo/"+_path+".pending");
    var parent:File=_destination.parent;
    if(!parent.exists)parent.createDirectory();
    _stream=new FileStream();
    _stream.addEventListener(Event.CLOSE,commit);
    _stream.addEventListener(IOErrorEvent.IO_ERROR,abort);
    _stream.addEventListener(SecurityErrorEvent.SECURITY_ERROR,abort);
    _stream.openAsync(_temporary,"write");
    // AIR owns the buffered bytes after writeBytes returns.
    _stream.writeBytes(data);
    _stream.close();
   } catch(error:Error) {
    abort(null);
   }
  }

  private function commit(event:Event):void {
   try {
    if(_loader.ready&&_temporary.size==_length){
     _temporary.moveTo(_destination,true);
     _temporary=null;
    }
   } catch(error:Error) {
    // The downloaded asset can still be displayed when local storage fails.
   }
   finish();
  }

  private function abort(event:Event):void {
   if(_stream!=null){
    _stream.removeEventListener(Event.CLOSE,commit);
    _stream.removeEventListener(IOErrorEvent.IO_ERROR,abort);
    _stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,abort);
    try{_stream.close();}catch(error:Error){}
   }
   finish();
  }

  private function finish():void {
   if(_stream!=null){
    _stream.removeEventListener(Event.CLOSE,commit);
    _stream.removeEventListener(IOErrorEvent.IO_ERROR,abort);
    _stream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,abort);
    _stream=null;
   }
   if(_temporary!=null){
    try{if(_temporary.exists)_temporary.deleteFile();}catch(error:Error){}
   }
   delete _writing[_path];
   _count--;
  }
 }
}

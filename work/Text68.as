package loginpatch {
 public final class Text68 {
  private static var _language:String="en";
  private static const LANGS:Array=["pt","en","de","fr","es","it","nl","fi","tr"];
  private static const ROWS:Object=__TEXT68_ROWS__;
  public static function select(language:String):void {_language=LANGS.indexOf(language)>=0?language:"en";}
  public static function get(key:String,language:String=""):String {
   if(key==null)return null;var index:int=LANGS.indexOf(language==""?_language:language);if(index<0)index=1;
   var row:Array=ROWS[key] as Array;return clean(row==null?key:String(row[index]));
  }
  public static function clean(value:String):String {
   if(value==null)return null;
   if(value=="|")return get("Barra vertical");if(value=="ª")return get("Indicador feminino");
   value=value.split("nº").join("n.").replace(/(\d+)º/g,"$1");
   return value.split("|").join(" / ").split("•").join(" - ").split("¥").join("JPY").split("—").join("-").split("–").join("-").split("÷").join("/").split("ª").join("a").split("º").join("o").split("…").join("...");
  }
 }
}

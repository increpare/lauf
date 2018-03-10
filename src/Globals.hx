package;
import haxegon.*;

class Globals
{
  public static var PAL = {
      fg : Col.WHITE,   
      bg : Col.BLACK,

      buttonTextCol : Col.WHITE,
      buttonBorderCol : Col.WHITE,
      buttonCol : Col.BLACK,
      buttonHighlightCol : 0x444444,
      buttonHighlightCol2 : 0xcccccc,
      titelFarbe: Col.WHITE,
  };

  public static var GUI = {
      smalltextsize:1,
      textsize:1,
      buttonTextSize:1,
      buttonPaddingX : 40,
      buttonPaddingY : 5,
      linethickness : 2,
      titleTextSize:2,
      subTitleTextSize:2,
      vpadding:10,
      healthbarheight:20,
      subSubTitleTextSize:2,
      
      screenPaddingTop:30,
      
      font:"dos",
  };

  public static var state = {
      sprache:0,
      auserwaehlte:0,
      ort:0,
  };

  public static function S(de:String,en:String):String{
      if (state.sprache==0){
          return de;
      } else {
        return en;
      }
  }
}
package game
{
    import flash.display.Sprite;

//    import game.hero.Hero;

    import org.flixel.FlxPoint;

    import pixelsean.message.Switchboard;

    /**
     * global registry class
     */
    public class SeanG
    {
        // [Message System]
        public static var switchboard:Switchboard;
        
//        public static var player:Hero;
        public static var playerMidPoint:FlxPoint;

        // [Debugger]
        public static var theTopGameSprite:Sprite;
        
        public function SeanG() {}
        
        /**
         * call this to release some global attributes
         */
        public static function erase():void
        {
            // clean temp attribute objects here
        }
    }
}

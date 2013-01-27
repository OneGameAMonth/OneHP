package game
{
    import flash.display.Sprite;

    import game.enemies.Boss;

    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;

    import pixelsean.message.Switchboard;

    /**
     * global registry class
     */
    public class SeanG
    {
        // [Message System]
        public static var switchboard:Switchboard = new Switchboard();

        // major objects
        public static var player:Player;
        public static var playerMidPoint:FlxPoint;
        public static var boss:Boss;
        public static var bossMidPoint:FlxPoint;

        // major groups
        public static var bullets:FlxGroup;
        public static var blocks:FlxGroup;
        public static var platforms:FlxGroup;
        public static var enemies:FlxGroup;

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

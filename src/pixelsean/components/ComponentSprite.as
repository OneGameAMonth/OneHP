/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.components
{
    import org.flixel.FlxBasic;
    import org.flixel.FlxPoint;
    import org.flixel.FlxSprite;

    public class ComponentSprite extends FlxSprite implements IComponent
    {
        public var name:String;
        public var attachOffset:FlxPoint = new FlxPoint();

        protected var _parent:FlxBasic;

        public function ComponentSprite()
        {
            super();
        }

        public function getName():String
        {
            return name;
        }

        public function initWithParent(parent:FlxBasic, attachOffsetX:Number, attachOffsetY:Number):void
        {
            _parent = parent;

            attachOffset.x = attachOffsetX;
            attachOffset.y = attachOffsetY;
        }

        public function sync(parentX:Number, parentY:Number):void
        {
            x = parentX + attachOffset.x - origin.x;
            y = parentY + attachOffset.y - origin.y;
        }
    }
}

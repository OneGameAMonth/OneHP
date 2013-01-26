/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.components
{
    import org.flixel.FlxBasic;

    public interface IComponent
    {
        // every component has a unique name
        function getName():String;
//        // add child component
//        function attachComponent(child:IComponent, attachPointX:Number, attachPointY:Number):IComponent;
        // set attach point
        function initWithParent(parent:FlxBasic, attachOffsetX:Number, attachOffsetY:Number):void;
        // sync child component's position
        function sync(parentX:Number, parentY:Number):void;
    }
}

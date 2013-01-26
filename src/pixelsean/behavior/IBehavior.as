/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.behavior
{
    public interface IBehavior
    {
        /**
         * Name of the behavior [Behaviors MUST have unique name!]
         * @return name of this behavior
         */
        function getName():String;
        /**
         * Make this enabled.
         */
        function enable():void;
        /**
         * Disable this behavior.
         */
        function disable():void;
        /**
         * Whether this behavior is enabled.
         */
        function isEnabled():Boolean;

        /**
         * Initialize the behavior with behavior container.
         * @param owner behavior container contains this
         */
        function init(owner:BehaviorManager):void;

        /**
         * Update every frame.
         * @param obj the object this behavior affects.
         */
        function update(obj:Object):void;
    }
}

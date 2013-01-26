/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.behavior
{
    public class Behavior implements IBehavior
    {
        private var _enable:Boolean = true;
        private var _owner:BehaviorManager;

        public function Behavior() {}

        public function init(owner:BehaviorManager):void
        {
            _owner = owner;
        }

        public function update(obj:Object):void
        {
            if (!_enable)
                return;
        }

        public function enable():void
        {
            _enable = true;
        }

        public function disable():void
        {
            _enable = false;
        }

        public function isEnabled():Boolean
        {
            return _enable;
        }

        public function getName():String
        {
            return "Behavior";
        }
    }
}

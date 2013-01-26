/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.behavior
{
    import flash.utils.Dictionary;

    public class BehaviorManager
    {
        /**
         * Owner and the object will be modified by behaviors.
         */
        public var owner:Object;

        private var _behaviors:Dictionary;

        public function BehaviorManager(owner:Object)
        {
            this.owner = owner;
            _behaviors = new Dictionary();
        }

        /**
         * Add a new behavior.
         * @param newBehavior behavior to be added
         * @return the new behavior if it's not added before, or the existed one
         */
        public function addBehavior(newBehavior:IBehavior):IBehavior
        {
            _behaviors[newBehavior.getName()] = newBehavior;
            newBehavior.init(this);
            return newBehavior;
        }

        /**
         * Whether this container has the behavior.
         * @param name name of the behavior
         * @return true if a behavior with the given name found
         */
        public function hasBehavior(name:String):Boolean
        {
            return (_behaviors[name] != null);
        }

        /**
         * Get behavior with a given name.
         * @param name the name of the behavior
         * @return behavior with given name or null if not found
         */
        public function getBehavior(name:String):IBehavior
        {
            return _behaviors[name];
        }

        /**
         * Enable the behavior means it will be updated every frame.
         * @param name name of the behavior you want to enable
         */
        public function enableBehavior(name:String):void
        {
            var beh:IBehavior = _behaviors[name];
            beh.enable();
        }

        /**
         * Disable the behavior means this behavior will not updated
         * until you enable it.
         * @param name name of the behavior you want to disable
         */
        public function disableBehavior(name:String):void
        {
            var beh:IBehavior = _behaviors[name];
            beh.disable();
        }

        /**
         * Update every frame, called be the host.
         */
        public function update():void
        {
            for each (var beh:IBehavior in _behaviors)
            {
                beh.update(owner);
            }
        }

        /**
         * Destroy everything here.
         */
        public function destroy():void
        {
            owner = null;
            _behaviors = null;
        }
    }
}

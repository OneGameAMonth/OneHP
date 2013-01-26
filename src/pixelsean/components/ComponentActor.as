/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package pixelsean.components
{
    import flash.utils.Dictionary;

    import org.flixel.FlxBasic;
    import org.flixel.FlxG;
    import org.flixel.FlxGroup;
    import org.flixel.FlxPoint;
    import org.flixel.FlxU;

    public class ComponentActor extends FlxGroup
    {
        /**
         * Stores pixelsean.components to this dictionary.
         */
        protected var _components:Dictionary = new Dictionary();
        /**
         * X position of the upper left corner of this object in world space.
         */
        public var x:Number;
        /**
         * Y position of the upper left corner of this object in world space.
         */
        public var y:Number;
        /**
         * Basic speed of this actor.
         */
        public var velocity:FlxPoint;
        /**
         * How fast the speed of this object is changing.
         * Useful for smooth movement and gravity.
         */
        public var acceleration:FlxPoint;
        /**
         * This isn't drag exactly, more like deceleration that is only applied
         * when acceleration is not affecting the sprite.
         */
        public var drag:FlxPoint;
        /**
         * If you are using <code>acceleration</code>, you can use <code>maxVelocity</code> with it
         * to cap the speed automatically (very useful!).
         */
        public var maxVelocity:FlxPoint;
        /**
         * Set the angle of a sprite to rotate it.
         */
        public var angle:Number;
        /**
         * This is how fast you want this sprite to spin.
         */
        public var angularVelocity:Number;
        /**
         * How fast the spin speed should change.
         */
        public var angularAcceleration:Number;
        /**
         * Like <code>drag</code> but for spinning.
         */
        public var angularDrag:Number;
        /**
         * Use in conjunction with <code>angularAcceleration</code> for fluid spin speed control.
         */
        public var maxAngular:Number;
        /**
         * Should always represent (0,0) - useful for different things, for avoiding unnecessary <code>new</code> calls.
         */
        static protected const _pZero:FlxPoint = new FlxPoint();

        /**
         * Handy for storing health percentage or armor points or whatever.
         */
        public var health:Number;

        public function ComponentActor(X:Number = 0, Y:Number = 0)
        {
            super();

            x = X;
            y = Y;

            health = 1;

            velocity = new FlxPoint();
            acceleration = new FlxPoint();
            drag = new FlxPoint();
            maxVelocity = new FlxPoint(10000,10000);

            angle = 0;
            angularVelocity = 0;
            angularAcceleration = 0;
            angularDrag = 0;
            maxAngular = 10000;
        }

        /**
         * Attach a child component.
         * WARNING: child is currently forced to be a FlxBasic
         * @param child         child component you want to attach to this
         * @param attachPointX  x offset of the attach point from its x position
         * @param attachPointY  y offset of the attach point from its y position
         * @return
         */
        public function attachComponent(child:IComponent, attachPointX:Number, attachPointY:Number):IComponent
        {
            if (child == null)
            {
                FlxG.log("WARNING: Cannot add a `null` object to a ComponentActor.");
                return null;
            }

            var childName:String = child.getName();

            // Don't bother adding an object twice, return the exist one.
            if (childName in _components)
                return _components[childName];

            child.initWithParent(this, attachPointX, attachPointY);
            _components[childName] = child;

            add(child as FlxBasic);

            // [Debug]
//            FlxG.log("attach component");

            return child;
        }

        public function detachComponent(name:IComponent):void
        {
            remove(_components[name] as FlxBasic);
            _components[name] = null;
            FlxG.log("Component \"" + name + "\" removed.");
        }

        public function getComponent(name:String):IComponent
        {
            return _components[name];
        }

        override public function destroy():void
        {
            _components = null;

            velocity = null;
            acceleration = null;
            drag = null;
            maxVelocity = null;
            super.destroy();
        }

        /**
         * Automatically goes through and calls update on everything you added.
         */
        override public function update():void
        {
            var basic:FlxBasic;
            for each (var child:IComponent in _components)
            {
                basic = child as FlxBasic;

                basic.preUpdate();
                basic.update();
                child.sync(x, y);
                basic.postUpdate();
            }
        }

        override public function postUpdate():void
        {
            var delta:Number;
            var velocityDelta:Number;

            velocityDelta = (FlxU.computeVelocity(angularVelocity,angularAcceleration,angularDrag,maxAngular) - angularVelocity)/2;
            angularVelocity += velocityDelta;
            angle += angularVelocity*FlxG.elapsed;
            angularVelocity += velocityDelta;

            velocityDelta = (FlxU.computeVelocity(velocity.x,acceleration.x,drag.x,maxVelocity.x) - velocity.x)/2;
            velocity.x += velocityDelta;
            delta = velocity.x*FlxG.elapsed;
            velocity.x += velocityDelta;
            x += delta;

            velocityDelta = (FlxU.computeVelocity(velocity.y,acceleration.y,drag.y,maxVelocity.y) - velocity.y)/2;
            velocity.y += velocityDelta;
            delta = velocity.y*FlxG.elapsed;
            velocity.y += velocityDelta;
            y += delta;
        }
    }
}

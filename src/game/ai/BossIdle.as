/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.ai
{

    import org.flixel.FlxG;

    import pixelsean.fsm.IState;
    import pixelsean.message.Message;

    import game.enemies.Boss;

    public class BossIdle implements IState
    {
        public var floatMotionCycle:Number = 4; // how much time a floating up-down motion cycle cost
        public var floatAcc:Number = 2;         // y acceleration of motion

        private var _timeCounter:Number = 0;
        private var _movingDir:Number = 1;      // 1: forward, -1: backward

        public function BossIdle()
        {
        }

        public function enter(Obj:Object):void
        {
            _timeCounter = 0;
            _movingDir = 1;

            (Obj as Boss).play("idle");
        }

        public function update(Obj:Object):void
        {
            _timeCounter += FlxG.elapsed;
            if (_timeCounter > floatMotionCycle/2)
            {
                _movingDir = - _movingDir;
                _timeCounter = 0;
                (Obj as Boss).velocity.y = 0;
            }
            (Obj as Boss).acceleration.y = floatAcc * _movingDir;
        }

        public function exit(Obj:Object):void
        {
            (Obj as Boss).acceleration.y = 0;
        }

        public function onMessage(Obj:Object, Msg:Message):Boolean
        {
            return false;
        }
    }
}

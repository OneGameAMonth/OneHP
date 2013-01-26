/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.ai
{
    import com.greensock.TimelineLite;
    import com.greensock.TweenLite;
    import com.greensock.easing.Circ;

    import pixelsean.fsm.IState;
    import pixelsean.message.Message;

    import game.enemies.Boss;

    public class BossIdle implements IState
    {
        public var floatMotionCycle:Number = 3; // how much time a floating up-down motion cycle cost
        public var floatAmplitude:Number = 5;   // how many pixels will the floating motion move

        private var _idleTween:TweenLite;

        public function BossIdle()
        {
        }

        public function enter(Obj:Object):void
        {
            _idleTween = new TweenLite(Obj, floatMotionCycle, {y:floatAmplitude, ease:Circ.easeInOut, yoyo:true, repeat:-1});
            (Obj as Boss).play("idle");
        }

        public function update(Obj:Object):void
        {

        }

        public function exit(Obj:Object):void
        {
            _idleTween.pause();
            _idleTween = null;
        }

        public function onMessage(Obj:Object, Msg:Message):Boolean
        {
            return false;
        }
    }
}

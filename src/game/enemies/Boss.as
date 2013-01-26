/**
 * Sean Clover, 01/2013.
 * All rights received.
 */
package game.enemies
{
    import org.flixel.FlxSprite;

    import pixelsean.behavior.BehaviorManager;
    import pixelsean.behavior.IBehaviorManagerHost;
    import pixelsean.fsm.IStateMachineHost;
    import pixelsean.fsm.StateMachine;
    import pixelsean.message.IMessageListener;
    import pixelsean.message.Message;

    import game.Assets;
    import game.ai.BossIdle;

    public class Boss extends FlxSprite implements IBehaviorManagerHost, IStateMachineHost, IMessageListener
    {
        private var _behaviorManager:BehaviorManager;
        private var _stateMachine:StateMachine;

        public function Boss(X:Number = 0, Y:Number = 0)
        {
            super(X, Y);
            loadGraphic(Assets.Img_BossMantis, true, false, 64, 64);

            // [Animation]
            addAnimation("idle", [0]);

            // [System] Behavior System
            _behaviorManager = new BehaviorManager(this);

            // [System] State Machine
            _stateMachine = new StateMachine(this, new BossIdle());
        }

        override public function destroy():void
        {
            super.destroy();

            _behaviorManager = null;
            _stateMachine = null;
        }

        override public function update():void
        {
            super.update();
            getMidpoint(_point);

            // [System] State Machine
            _stateMachine.update();

            // [System] Behavior System
            _behaviorManager.update();
        }

        public function handleMessage(msg:Message):void
        {
            _stateMachine.handleMessage(msg);
        }

        public function getBehaviorManager():BehaviorManager
        {
            return _behaviorManager;
        }

        public function getStateMachine():StateMachine
        {
            return _stateMachine;
        }
    }
}

package pixelsean.fsm
{
    import pixelsean.message.Message;
    
    public class StateMachine
    {
        public var owner:Object;
        public var currentState:IState;
        public var globalState:IState;
        
        public function StateMachine(Owner:Object, InitState:IState, GlobalState:IState=null)
        {
            owner = Owner;
            currentState = InitState;
            globalState = GlobalState;
            if (currentState != null)
                currentState.enter(owner);
        }
        
        public function update():void
        {
            if (globalState != null)
                globalState.update(owner);
            if (currentState != null)
                currentState.update(owner);
        }
        
        public function handleMessage(Msg:Message):Boolean
        {
            if (currentState && currentState.onMessage(owner, Msg))
                return true;
            if (globalState && globalState.onMessage(owner, Msg))
                return true;
            // pixelsean.message cannot be handled by this FSM
            return false;
        }
        
        public function changeState(NewState:IState):void
        {
            currentState.exit(owner);
            currentState = NewState;
            currentState.enter(owner);
        }

        public function destroy():void
        {
            owner = null;
            currentState = null;
            globalState = null;
        }
    }
}

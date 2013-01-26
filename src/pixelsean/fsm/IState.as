package pixelsean.fsm
{
    import pixelsean.message.Message;
    
    public interface IState
    {
        /**
         * enter state
         * @param Obj the object who on the state
         */
        function enter(Obj:Object):void;
        /**
         * update state every frame
         * @param Obj the object who on the state
         */
        function update(Obj:Object):void;
        /**
         * exit state
         * @param Obj the object who on the state
         */
        function exit(Obj:Object):void;
        /**
         * enter state
         * @param Obj the object who on the state
         * @param Msg message passed to the state
         */
        function onMessage(Obj:Object, Msg:Message):Boolean;
    }
}

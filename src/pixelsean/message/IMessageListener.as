package pixelsean.message
{
    public interface IMessageListener
    {
        function handleMessage(Msg:Message):void;
    }
}

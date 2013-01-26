package pixelsean.message
{
    import de.polygonal.ds.Prioritizable;
    
    public class Message implements Prioritizable
    {
        public var name:String;
        public var receiver:IMessageListener;
        public var sender:Object;
        public var _dispatchTime:Number;
        public var extraInfo:Object;
        
        // prioritizable interface var
        public var position:int;
        public var priority:Number;
        
        public function Message(Name:String, 
                            Receiver:IMessageListener,
                              Sender:Object,  
                        DispatchTime:Number, 
                           ExtraInfo:Object)
        {
            name = Name;
            sender = Sender;
            receiver = Receiver;
            _dispatchTime = DispatchTime;
            extraInfo = ExtraInfo;
            
            position = 0;
            priority = _dispatchTime;
        }
        
        // dispatchTime getter and setter
        public function get dispatchTime():Number
        {
            return _dispatchTime;
        }
        
        public function set dispatchTime(Value:Number):void
        {
            priority = Value;
            _dispatchTime = Value;
        }

        public static function newMessage(Name:String,
                                      Receiver:IMessageListener,
                                        Sender:Object,
                                  DispatchTime:Number,
                                     ExtraInfo:Object):Message
        {
            // TODO: Use object pool and recycle to performance.
            return new Message(Name, Receiver, Sender, DispatchTime, ExtraInfo);
        }
    }
}

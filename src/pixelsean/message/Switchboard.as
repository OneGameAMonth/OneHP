package pixelsean.message
{
    import de.polygonal.ds.PriorityQueue;

    import org.flixel.FlxU;
    
    public class Switchboard
    {
        private var priorityQueue:PriorityQueue;
        
        public function Switchboard()
        {
            priorityQueue = new PriorityQueue(true);
        }
        
        /**
         * Send a pixelsean.message is just like dispatch a flash event.
         * 
         * @param Name major info of this pixelsean.message
         * @param Receiver who's going to receive this pixelsean.message
         * @param Sender you can set sender to tell reciever who send this
         * @param Delay dispatch delay in seconds
         * @param ExtraInfo you can add an extra object with this pixelsean.message
         */
        public function sendMessage(Name:String, 
                                Receiver:IMessageListener,
                                  Sender:Object=null, 
                                   Delay:Number=0, 
                               ExtraInfo:Object=null):void
        {
            var msg:Message = new Message(Name, Receiver, Sender, Delay, ExtraInfo);
            if (Delay == 0)
            {
                Receiver.handleMessage(msg);
            }
            else
            {
                // add to priority queue based on Dispatch Time
                msg.dispatchTime = Delay + FlxU.getTicks() / 1000;
                priorityQueue.enqueue(msg);
            }
        }
        
        /**
         * ADD THIS TO THE MAIN LOGIC LOOP to make 
         * switchboard actually work. 
         */
        public function update():void
        {
            var currTime:Number = FlxU.getTicks() / 1000;
            if (!priorityQueue.isEmpty())
            {
                var first:Message = priorityQueue.peek() as Message;
                while (first.dispatchTime < currTime)
                {
                    first.receiver.handleMessage(first);
                    priorityQueue.dequeue();
                    first = null;
                    if (priorityQueue.isEmpty())
                        break;
                    first = priorityQueue.peek() as Message;
                }
            }
        }
    }
}

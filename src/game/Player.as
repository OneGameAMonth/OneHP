package game
{
    import flash.geom.ColorTransform;

    import org.flixel.FlxG;
    import org.flixel.FlxSprite;

    import pixelsean.message.Message;
    import pixelsean.message.IMessageListener;

    import game.damagers.Bullet;
    import game.Assets;
    import game.SeanG;

    public class Player extends FlxSprite implements IMessageListener
    {
        // [Behavior] controllable var
        public var controllable:Boolean = true;
        
        // [Behavior] walk var
        private var _isWalking:Boolean;         // walkning or not
    public var maxWalkSpeed:uint = 148;         // config: L/R moving speed
        public var walkAcceleration:uint;       // config: general acceleration
        
        // [Behavior] jump var
        private var _isJumping:Boolean;
        private var _jumpingUp:Boolean;
        private var _fallingDown:Boolean;
        private var _jumpKeyRelease:Boolean;
        
        protected var _gravity:int;
        protected var _minJumpSpeed:int;
        protected var _jumpHoldAcceptableTime:Number;   // hold key for higher jumper within this time
        protected var _jumpForce:int;                   // just jump power
        private var _jumpTimeCounter:Number;            // start to count while jump

        // [Behavior] shoot
        private var _aim:uint;
        
        public function Player(X:Number, Y:Number)
        {
            super(X, Y);
            loadGraphic(Assets.Img_Hero, true, true, 8, 8);
            
            // bounding box tweaks
            width = 4;
            height = 7;
            offset.x = 2;
            offset.y = 1;
            
            // [Physics] graviy
            _gravity = 420;                 // config
            acceleration.y = _gravity;
            
            // [Behavior] health
            health = 1;                     // config
            
            // [Behavior] walk init
            maxVelocity.x = maxWalkSpeed;
            walkAcceleration = maxWalkSpeed * 16;
            drag.x = maxWalkSpeed * 8;		// walkning deacceleration
            
            // [Behavior] jump init
            _isJumping = false;
            _jumpingUp = false;
            _fallingDown = false;
            _minJumpSpeed = 160;            // config
            _jumpHoldAcceptableTime = 0.25; // config
            _jumpForce = 200;               // config
            _jumpTimeCounter = 0;
            maxVelocity.y = _jumpForce;
            
            // [Behavior] animation init
            addAnimation("idle", [0], 1.67, true);
            addAnimation("walk", [0], 6.25, true);
            addAnimation("jump", [0]);
            addAnimation("fall", [0], 10, true);
        }
        
        override public function destroy():void
        {
            super.destroy();
		}
        
        override public function update():void
        {
            // init useful variables
            getMidpoint(_point);

            // [Behavior] walk update
            if (controllable)
            {
                if (FlxG.keys.LEFT && !FlxG.keys.RIGHT)
                {
                    // walk left
                    walk(LEFT);
                }
                else if (!FlxG.keys.LEFT && FlxG.keys.RIGHT)
                {
                    // walk right
                    walk(RIGHT);
                }
                else // hold both or none
                {
                    // stop walkning
                    stop();                    
                }
            }
			
            // [Behavior] jump update 
            // TODO: balance jump variables
            acceleration.y = _gravity;  // gravity effect
            if (velocity.y < 0)         // direction: jumping or falling
            {
                _isJumping = true;
                _jumpingUp = true;
                _fallingDown = false;
            }
            else if (velocity.y > 0)
            {
                _isJumping = true;
                _jumpingUp = false;
                _fallingDown = true;
            }
            if (controllable)          // jump action
            {
                if (FlxG.keys.justPressed("X"))
                {
                    // jump
                    if (isTouching(FLOOR))
                    {
                        _jumpKeyRelease = false;
                        _isJumping = true;
                        _jumpingUp = true;
                        velocity.y = -_minJumpSpeed;
                        
                        _jumpTimeCounter = 0;
                    }
                }
                else if (FlxG.keys.X)   // hold jump in the air or air-jump
                {
                    // hold jump in the air
                    _jumpTimeCounter += FlxG.elapsed;
                    if (_jumpTimeCounter < _jumpHoldAcceptableTime)
                    {
                        acceleration.y -= _jumpForce;
                    }
                }
            }

            // aiming
            _aim = facing;
            
            // [Behavior] animation update
            if (_jumpingUp || _fallingDown)
            {
	            if (_fallingDown)
	            {
	                play("fall");
	            }
	            else if (_jumpingUp)
	            {
	                play("jump");
	            }
            }
            else if (_isWalking) 
            {
                play("walk");
            }
            else
            {
                play("idle");
            }
            
            // [Behavior] shooting update
            if (FlxG.keys.justPressed("C"))
            {
                Bullet.shoot(_point, _aim);
                FlxG.play(Assets.Snd_Shoot);
			}
            
            // [Event] handle collision
            if (isTouching(FLOOR))
            {
                _isJumping = false;
                _jumpingUp = false;
                _fallingDown = false;
            }
        }
        
        override public function hurt(Damage:Number):void
        {
            SeanG.switchboard.sendMessage("hurt", this);
            super.hurt(Damage);
            
            // [Behavior] invincible white flicker
            _colorTransform = new ColorTransform();
            _colorTransform.color = 0xFFFFFF;
            calcFrame();
        }
        
        public function handleMessage(Msg:Message):void
        {
            if (Msg.name == "hurt")
            {
                SeanG.switchboard.sendMessage("PlayerKilled", FlxG.state as IMessageListener);
            }
        }
        
        public function walk(walkDir:uint):void
        {
            // walk logic
            if (walkDir == LEFT)
            {
                _isWalking = true;
                facing = LEFT;
                acceleration.x = -walkAcceleration;
            }
            else if (walkDir == RIGHT)
            {
                _isWalking = true;
                facing = RIGHT;
                acceleration.x = walkAcceleration;
            }
        }
        
        public function stop():void
        {
            _isWalking = false;
            acceleration.x = 0;
            // Optional: if onGround, ground slow down, else air slow down.
        }
    }
}

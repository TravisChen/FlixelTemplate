package
{
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source="data/darwin.png")] private var ImgDarwin:Class;
		
		public var startTime:Number;
		
		private var jumpPower:int;
		private var lastVelocityY:int;
		private var jumping:Boolean;
		public var landing:Boolean;
		public var roundOver:Boolean;
		
		public function Player(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgDarwin,true,true,32,32);
			
			// Bounding box tweaks
			width = 16;
			height = 16;
			offset.x = 8;
			offset.y = 16;
			
			// Init
			jumping = false;
			roundOver = false;
			
			// Start time
			startTime = 0.5;
			
			lastVelocityY = velocity.y;
			
			// Basic player physics
			var runSpeed:uint = 140;
			drag.x = runSpeed*8;
			jumpPower = 180;
			maxVelocity.x = runSpeed;
			maxVelocity.y = jumpPower;
			
			// Gravity
			acceleration.y = 0;
			
			addAnimation("idle", [0]);
			addAnimation("run", [1,2,3,4], 18);
			addAnimation("dig", [5,6,7], 32);
			addAnimation("jump", [8,9,10], 18, false);
			addAnimation("land", [8], 20);
			addAnimation("stun", [11,12], 15);
		}

		override public function update():void
		{			
			super.update();

			if( startTime > 0 )
			{
				startTime -= FlxG.elapsed;
				return;
			}
			
			if( roundOver )
			{
				play("idle");
				return;
			}

			if( landing ) 
			{
				play("land");
				if(finished)
				{
					landing = false;					
				}
				return;
			}	
			
			// MOVEMENT Left, Right
			acceleration.x = 0;
			if(FlxG.keys.LEFT || FlxG.keys.A)
			{
				facing = LEFT;
				acceleration.x -= drag.x;
			}
			else if(FlxG.keys.RIGHT || FlxG.keys.D)
			{
				facing = RIGHT;
				acceleration.x += drag.x;
			}
			
			// MOVEMENT Jump
//			if( FlxG.keys.UP || FlxG.keys.W)
//			{
//				if( !velocity.y && !jumping )
//				{
//					play("jump");
//					velocity.y = -jumpPower;
//				}
//				jumping = true;
//			}
//			else
//			{
//				jumping = false;
//			}
			
			// Animation
			if( !velocity.y )
			{
				if(velocity.x == 0)
				{
					play("idle");
				}
				else
				{
					play("run");
				}
			}

			// Landing
			if( lastVelocityY != 0 && velocity.y == 0 )
			{
				landing = true;
				lastVelocityY = 0;		
			}
			else
			{
				lastVelocityY = velocity.y;
			}
		}
	}
}
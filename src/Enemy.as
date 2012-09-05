package
{
	import org.flixel.*;
	
	public class Enemy extends FlxSprite
	{
		[Embed(source="data/priest.png")] private var ImgPriest:Class;
		private var jumpPower:int;
		public var left:Boolean;
		public var right:Boolean;
		
		public var startTime:Number;

		public const WALK_SPEED:Number = 40;
		public const RUN_SPEED:Number = 72;
		
		public function Enemy(X:int,Y:int)
		{
			super(X,Y);
			loadGraphic(ImgPriest,true,true,32,32);
			
			// Bounding box tweaks
			width = 32;
			height = 16;
			offset.x = 0;
			offset.y = 16;

			startTime = 1.0;
			
			// Enemy physics
			var speed:uint = WALK_SPEED;
			drag.x = speed*8;
			jumpPower = 180;
			maxVelocity.x = RUN_SPEED;
			maxVelocity.y = jumpPower;
			
			// Gravity
			acceleration.y = 0;
				
			addAnimation("idle", [0]);
			addAnimation("walk", [0,1,2], 10);
			addAnimation("run", [3,4], 10);
		}

		override public function update():void
		{	
			//UPDATE POSITION AND ANIMATION
			super.update();
			
			if( startTime > 0 )
			{
				startTime -= FlxG.elapsed;
				return;
			}
			
			//MOVEMENT
			acceleration.x = 0;
			if(left)
			{
				facing = RIGHT;
				acceleration.x -= drag.x;
			}
			else if(right)
			{
				facing = LEFT;
				acceleration.x += drag.x;
			}
			
			//ANIMATION
			if(velocity.x == 0)
			{
				play("idle");
			}
			else
			{
				play("walk");
			}
		}
	}
}
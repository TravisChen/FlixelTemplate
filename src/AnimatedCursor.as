package
{
	import org.flixel.*;
	
	public class AnimatedCursor extends FlxSprite
	{
		[Embed(source="../data/game-cursor.png")] private var imgGameCursor:Class;
		
		public function AnimatedCursor()
		{
			super();
			loadGraphic(imgGameCursor, true, true, 12, 12);
			addAnimation("normal", [0,1,2,1], 5);
		}
		
		override public function update():void
		{
			super.update();
			
			play("normal");
			
			x = FlxG.mouse.x - 3;
			y = FlxG.mouse.y - 3;
			FlxG.mouse.hide();
		}
	}
}
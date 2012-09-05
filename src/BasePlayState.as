package
{
	import flash.display.*;
	
	import org.flixel.*;
	
	public class BasePlayState extends FlxState
	{
		public static var levelArray:Array = [
			Level_Menu,
			Level_Main
		]
		
		public function BasePlayState():void
		{
		}
	}
}

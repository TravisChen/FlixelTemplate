package
{
	import org.flixel.*;
	
	public class PlayState extends BasePlayState
	{
		public static var _currLevel:Level;
		
		public static var groupBackground:FlxGroup;
		public static var groupTilemap:FlxGroup;
		public static var groupCollects:FlxGroup;
		public static var groupPlayer:FlxGroup;
		public static var groupForeground:FlxGroup;
		
		function PlayState():void
		{
			super();

			groupBackground = new FlxGroup;
			groupTilemap = new FlxGroup;
			groupPlayer = new FlxGroup;
			groupCollects = new FlxGroup;
			groupForeground = new FlxGroup;
			
			// Create the level
			var currLevelClass:Class = levelArray[FlixelTemplate.currLevelIndex];
			_currLevel = new currLevelClass( groupBackground );
			
			this.add(groupBackground);
			this.add(groupTilemap);
			this.add(groupPlayer);
			this.add(groupCollects);
			this.add(groupForeground);
		}
		
		override public function update():void
		{			
			// Camera
			if( _currLevel.player != null )
			{
				FlxG.camera.follow(_currLevel.player, FlxCamera.STYLE_PLATFORMER);
				FlxG.camera.width = FlxG.width;
				FlxG.camera.setBounds(0,0,_currLevel.levelSizeX,_currLevel.levelSizeY);
			}
			
			// Update level
			_currLevel.update();
			
			// Next level
			if( _currLevel.nextLevel() )
			{
				nextLevel();				
			}
			
			super.update();
		}
		
		public function nextLevel():void
		{
			FlixelTemplate.currLevelIndex++;
			if( FlixelTemplate.currLevelIndex > levelArray.length - 1 )
			{
				FlixelTemplate.currLevelIndex = 0;
			}
			FlxG.switchState(new PlayState());
		}
		
		override public function create():void
		{
		}

		override public function destroy():void
		{
			// Update level
			_currLevel.destroy();
			
			super.destroy();
		}
	}
}
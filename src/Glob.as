package
{
	import org.flixel.FlxSave;
	
	public class Glob
	{
		//public static const kDebugOn:Boolean = true;
		public static const kDebugOn:Boolean = false;
		
		public static var controller:GController = new GController();
		public static var audioHandler:GAudioHandler = new GAudioHandler();
		public static var leveler:GLeveler = new GLeveler();
		public static var spritinator:GSpritinator = new GSpritinator();
		
		// Save Data
		private static var save:FlxSave;
		private static var loaded:Boolean = false;
		public static function load():void {
			save = new FlxSave();
			loaded = save.bind("saveData");
			if (loaded && save.data.highScore == null) {
				save.data.highScore = highScoreTmp;
			}
		}
		private static var kHighScoreDefault:uint = 0;
		private static var highScoreTmp:uint = kHighScoreDefault;
		public static function get highScore():uint {
			if (loaded) {
				return save.data.highScore;
			} else {
				return highScoreTmp;
			}
		}
		public static function set highScore(tmpHighScore:uint):void {
			if (loaded) {
				save.data.highScore = tmpHighScore;
				save.flush();
			}
			else {
				highScoreTmp = tmpHighScore;
			}
		}
		
		public function clearData():void {
			highScore = kHighScoreDefault;
		}
	}
}
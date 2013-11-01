package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSound;

	public class GAudioHandler
	{
		[Embed(source="assets/song_level.mp3")] private static const kSongLevelMP3:Class;
		public static const kSongLevel:FlxSound = new FlxSound().loadEmbedded(kSongLevelMP3,true);
		
		[Embed(source="assets/sfx_death.mp3")] private static const kDeathMP3:Class;
		public static const kDeath:FlxSound = new FlxSound().loadEmbedded(kDeathMP3,false);
		
		[Embed(source="assets/sfx_candy.mp3")] private static const kCandyMP3:Class;
		public static const kCandy:FlxSound = new FlxSound().loadEmbedded(kCandyMP3,false);
		
		[Embed(source="assets/sfx_house.mp3")] private static const kHouseMP3:Class;
		public static const kHouse:FlxSound = new FlxSound().loadEmbedded(kHouseMP3,false);
		
		[Embed(source="assets/sfx_light_shrink.mp3")] private static const kLightShrinkMP3:Class;
		public static const kLightShrink:FlxSound = new FlxSound().loadEmbedded(kLightShrinkMP3,false);
		
		[Embed(source="assets/sfx_horror.mp3")] private static const kHorrorMP3:Class;
		public static const kHorror:FlxSound = new FlxSound().loadEmbedded(kHorrorMP3,false);
		
		public function play(tmpSound:FlxSound,tmpForceRestart:Boolean=false):void {
			tmpSound.play(tmpForceRestart);
		}
		
		public function stop(tmpSound:FlxSound):void {
			tmpSound.stop();
		}
	}
}
package
{
	import org.flixel.FlxGame;
	import flash.events.Event;
	
	[SWF(width="640", height="640", backgroundColor="#222222")]
	
	public class Main extends FlxGame
	{
		public function Main()
		{
			super(640,640,StMenu,1,60,60,true);
			Glob.load();
			forceDebugger = Glob.kDebugOn;
		}
		
		override protected function create(FlashEvent:Event):void {
			super.create(FlashEvent);
			stage.removeEventListener(Event.DEACTIVATE,onFocusLost);
			stage.removeEventListener(Event.ACTIVATE,onFocus);
			stage.align = "TOP";
		}
	}
}
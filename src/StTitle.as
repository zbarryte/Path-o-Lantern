package
{
	import flash.sampler.StackFrame;
	
	import org.flixel.FlxG;
	
	public class StTitle extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		public function StTitle()
		{
			super();
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.select)) {
				switchToStateWithFade(StMenu,kFadeDuration,kFadeColor);
			}
		}
	}
}
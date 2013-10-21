package
{
	import org.flixel.FlxG;
	
	public class StPlay extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		private var mnuPause:ZMenu;
		
		public function StPlay()
		{
			super();
		}
		
		override protected function createObjects():void {
			initPauseMenu();
		}
		
		private function initPauseMenu():void {
			mnuPause = new ZMenu();
			
			var margin:int = 2;
			
			// START
			var callbackContinue:Function = function():void {
				resume();
			};
			var txtContinue:String = "Continue";
			var btnContinue:BtnBasic = new BtnBasic(callbackContinue,txtContinue);
			btnContinue.centerX();
			btnContinue.placeAtScreenYPercentage(0.44);
			mnuPause.addButton(btnContinue);
			
			// OPTIONS
			var callbackExit:Function = function():void {
				switchToStateWithFade(StMenu,kFadeDuration,kFadeColor);
			};
			var txtExit:String = "EXIT";
			var btnExit:BtnBasic = new BtnBasic(callbackExit,txtExit);
			btnExit.placeBelowSprite(btnContinue,margin);
			mnuPause.addButton(btnExit);
			
			add(mnuPause);
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.pause)) {
				pause();
			}
		}
		
		override protected function updatePlay():void {
			
		}
		
		override protected function updatePause():void {
			
			if (Glob.controller.justPressed(GController.pause)) {
				resume();
			}
			if (Glob.controller.justPressed(GController.curseForward)) {
				mnuPause.curseForward();
			}
			if (Glob.controller.justPressed(GController.curseBackwards)) {
				mnuPause.curseBackwards();
			}
			if (Glob.controller.justPressed(GController.select)) {
				mnuPause.select();
			}
		}
		
		override public function pause():void {
			mnuPause.reset();
			mnuPause.visible = true;
			super.pause();
		}
		
		override public function resume():void {
			mnuPause.visible = false;
			super.resume();
		}
	}
}
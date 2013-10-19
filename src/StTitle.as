package
{
	import flash.sampler.StackFrame;
	
	import org.flixel.FlxG;
	
	public class StTitle extends ZState
	{
		private var mnu:ZMenu;
		
		public function StTitle()
		{
			super();
		}
		
		override protected function createObjects():void {
			addMenu();
		}
		
		private function addMenu():void {
			mnu = new ZMenu();
			
			var margin:int = 2;
			
			// START
			var callbackStart:Function = function():void {
				FlxG.log("START");
			};
			var txtStart:String = "START";
			var btnStart:BtnBasic = new BtnBasic(callbackStart,txtStart);
			btnStart.centerX();
			btnStart.placeAtScreenYPercentage(0.44);
			mnu.addButton(btnStart);
			
			// OPTIONS
			var callbackOptions:Function = function():void {
				FlxG.log("OPTIONS");
			};
			var txtOptions:String = "OPTIONS";
			var btnOptions:BtnBasic = new BtnBasic(callbackOptions,txtOptions);
			btnOptions.placeBelowSprite(btnStart,margin);
			mnu.addButton(btnOptions);
			
			// CONTROLS
			var callbackControls:Function = function():void {
				FlxG.log("CONTROLS");
			};
			var txtControls:String = "Controls";
			var btnControls:BtnBasic = new BtnBasic(callbackControls,txtControls);
			btnControls.placeBelowSprite(btnOptions,margin);
			mnu.addButton(btnControls);
			
			// CREDITS
			var callbackCredits:Function = function():void {
				FlxG.log("CREDITS");
			};
			var txtCredits:String = "CREDITS";
			var btnCredits:BtnBasic = new BtnBasic(callbackCredits,txtCredits);
			btnCredits.placeBelowSprite(btnControls,margin);
			mnu.addButton(btnCredits);
			
			add(mnu);
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.curseForward)) {
				mnu.curseForward();
			}
			if (Glob.controller.justPressed(GController.curseBackwards)) {
				mnu.curseBackwards();
			}
			if (Glob.controller.justPressed(GController.select)) {
				mnu.select();
			}
		}
	}
}
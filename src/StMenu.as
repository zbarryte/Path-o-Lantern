package
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class StMenu extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		private var mnu:ZMenu;
		private var darkness:SprDarkness;
		
		public function StMenu()
		{
			super();
		}
		
		override protected function createObjects():void {
			addMenu();
			addOverlay();
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
		
		private function addOverlay():void {
			darkness = new SprDarkness();
			add(darkness);
			drawHoleInDarknessOverButton();
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.curseForward)) {
				mnu.curseForward();
				drawHoleInDarknessOverButton();
			}
			if (Glob.controller.justPressed(GController.curseBackwards)) {
				mnu.curseBackwards();
				drawHoleInDarknessOverButton();
			}
			if (Glob.controller.justPressed(GController.select)) {
				mnu.select();
			}
			if (Glob.controller.justPressed(GController.back)) {
				switchToStateWithFade(StTitle,kFadeDuration,kFadeColor);
			}
		}
		
		private function drawHoleInDarknessOverButton():void {
			var tmpPoint:FlxPoint = new FlxPoint(mnu.button.x+mnu.button.width/2.0,mnu.button.y+mnu.button.height/2.0);
			darkness.drawHole(tmpPoint,mnu.button.width/3.0);
		}
	}
}
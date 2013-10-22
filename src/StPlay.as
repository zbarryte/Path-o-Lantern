package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	
	public class StPlay extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		private var mnuPause:ZMenu;
		
		private var lvlFunc:FlxTilemap;
		private var wallGroup:FlxGroup;
		private var pumpkin:SprPumpkin;
		
		public function StPlay()
		{
			super();
		}
		
		override protected function createObjects():void {
			initFunctionalLevel();
			addWalls();
			addPumpkin();
			addPauseMenu();
		}
		
		
		private function initFunctionalLevel():void {
			lvlFunc = Glob.leveler.levelFunc;
			GLeveler.center(lvlFunc);
			if (Glob.kDebugOn) {add(lvlFunc);}
		}
		
		private function addWalls():void {
			wallGroup = GLeveler.groupFromSpawn(GLeveler.kArraySpawnWall,SprWall,lvlFunc);
			add(wallGroup);
		}
		
		private function addPumpkin():void {
			pumpkin = GLeveler.groupFromSpawn(GLeveler.kArraySpawnPumpkin,SprPumpkin,lvlFunc).members[0];
			add(pumpkin);
		}
		
		private function addPauseMenu():void {
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
		
		override protected function updateControls():void
		{				
			if (Glob.controller.justPressed(GController.pause)) {
				pause();
			}
			
			if (Glob.controller.pressedAfter(GController.left,GController.right)) {
				pumpkin.moveLeft();
			}
			else if (Glob.controller.pressedAfter(GController.right,GController.left)) {
				pumpkin.moveRight();
			}
			
			if (Glob.controller.pressedAfter(GController.up,GController.down)) {
				pumpkin.moveUp();
			}
			else if (Glob.controller.pressedAfter(GController.down,GController.up)) {
				pumpkin.moveDown();
			}
		}
		
		override protected function updatePlay():void {
			FlxG.collide(wallGroup,pumpkin);
		}
		
		override protected function updatePause():void
		{
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
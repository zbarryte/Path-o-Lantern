package
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxCamera;
	
	public class StPlay extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		private var mnuPause:ZMenu;
		
		private var lvlFunc:FlxTilemap;
		private var wallGroup:FlxGroup;
		private var houseGroup:FlxGroup;
		private var pumpkin:SprPumpkin;
		
		public function StPlay()
		{
			super();
		}
		
		override protected function createObjects():void {
			initFunctionalLevel();
			addWalls();
			addHouse();
			addPumpkin();
			addPauseMenu();
			setupCamera();
		}
		
		
		private function initFunctionalLevel():void {
			lvlFunc = Glob.leveler.levelFunc;
			//GLeveler.center(lvlFunc);
			if (Glob.kDebugOn) {add(lvlFunc);}
			FlxG.worldBounds.width = lvlFunc.width;
			FlxG.worldBounds.height = lvlFunc.height;
		}
		
		private function addWalls():void {
			wallGroup = GLeveler.groupFromSpawn(GLeveler.kArraySpawnWall,SprWall,lvlFunc);
			add(wallGroup);
		}
		
		private function addHouse():void {
			houseGroup = GLeveler.groupFromSpawn(GLeveler.kArraySpawnHouse,SprHouse,lvlFunc);
			add(houseGroup);
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
		
		private function setupCamera():void {
			FlxG.camera.follow(pumpkin,FlxCamera.STYLE_TOPDOWN);
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
			checkForPumpkinOverlappingHouse();
		}
		
		private function checkForPumpkinOverlappingHouse():void {
			for (var i:uint = 0; i < houseGroup.length; i++) {
				var tmpHouse:SprHouse = houseGroup.members[i];
				if (tmpHouse.overlaps(pumpkin)) {
					win();
				}
			}
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
		
		private function win():void {
			Glob.leveler.lvlNum ++;
			switchToStateWithFade(StPlay,kFadeDuration,kFadeColor);
		}
	}
}
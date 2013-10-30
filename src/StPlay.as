package
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	
	public class StPlay extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		private const kFadeColor:uint = 0xffff4444;
		
		private var mnuPause:ZMenu;
		
		private var lvlFunc:FlxTilemap;
		private var wallGroup:FlxGroup;
		private var houseGroup:FlxGroup;
		private var pumpkin:SprPumpkin;
		private var darkness:SprDarkness;
		private var horrorGroup:FlxGroup;
		
		private var lightTimer:ZTimer;
		
		public function StPlay()
		{
			super();
		}
		
		override protected function createObjects():void {
			initFunctionalLevel();
			addWalls();
			addHouses();
			addDarkness();
			addPumpkin();
			addHorrors();
			addPauseMenu();
			setupCamera();
			setupLightTimer();
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
		
		private function addHouses():void {
			houseGroup = GLeveler.groupFromSpawn(GLeveler.kArraySpawnHouse,SprHouse,lvlFunc);
			add(houseGroup);
		}
		
		private function addPumpkin():void {
			pumpkin = GLeveler.groupFromSpawn(GLeveler.kArraySpawnPumpkin,SprPumpkin,lvlFunc).members[0];
			add(pumpkin);
		}
		
		private function addDarkness():void {
			darkness = new SprDarkness();
			add(darkness);
		}
		
		private function addHorrors():void {
			horrorGroup = GLeveler.groupFromSpawn(GLeveler.kArraySpawnHorror,SprHorror,lvlFunc);
			add(horrorGroup);
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
		
		private function setupLightTimer():void {
			var tmpEvent:Function = function():void {
				pumpkin.shrinkRadius();
			};
			lightTimer = new ZTimer(5.0,tmpEvent,true,true);
			add(lightTimer);
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
			FlxG.collide(wallGroup,horrorGroup);
			checkForPumpkinOverlappingHouse();
			moveHorrorsTowardsPumpkin();
			drawHolesInDarkness();
			hideSomeHorrors();
			checkForPumpkinOverlappedByHorror();
			//shrinkPumpkinRadius();
		}
		
		private function checkForPumpkinOverlappingHouse():void {
			for (var i:uint = 0; i < houseGroup.length; i++) {
				var tmpHouse:SprHouse = houseGroup.members[i];
				if (tmpHouse.overlaps(pumpkin)) {
					win();
				}
			}
		}
		
		private function moveHorrorsTowardsPumpkin():void {
			for (var i:uint = 0; i < horrorGroup.length; i++) {
				var tmpHorror:SprHorror = horrorGroup.members[i];
				tmpHorror.moveTowards(pumpkin);
			}
		}
		
		private function drawHolesInDarkness():void {
			darkness.fillHoles();
			darkness.drawHoleAtNode(pumpkin,pumpkin.radius);
			for (var i:uint = 0; i < houseGroup.length; i++) {
				var tmpHouse:SprHouse = houseGroup.members[i];
				darkness.drawHoleAtNode(tmpHouse,tmpHouse.radius);
			}
		}
		
		private function hideSomeHorrors():void {
			for (var i:uint = 0; i < horrorGroup.length; i++) {
				var tmpHorror:SprHorror = horrorGroup.members[i];
				if (pumpkin.radius > 0 && (horrorIsInPumpkinRadius(tmpHorror) || horrorIsInHouseRadius(tmpHorror))){// || tmpHorror.isStationary()) {
					tmpHorror.hide();
				} else if (tmpHorror.isHidden()) {
					tmpHorror.show();
				}
			}
		}
		
		private function horrorIsInHouseRadius(tmpHorror:SprHorror):Boolean {
			for (var i:uint = 0; i < houseGroup.length; i++) {
				var tmpHouse:SprHouse = houseGroup.members[i];
				var distSq:Number = Math.pow(tmpHorror.x - tmpHouse.x,2) + Math.pow(tmpHorror.y - tmpHouse.y,2);
				if (distSq <= Math.pow(tmpHouse.radius + tmpHorror.width,2)) {
					return true
				}
			}
			return false;
		}
		
		private function horrorIsInPumpkinRadius(tmpHorror:SprHorror):Boolean {
			var distSq:Number = Math.pow(tmpHorror.x - pumpkin.x,2) + Math.pow(tmpHorror.y - pumpkin.y,2);
			return distSq <= Math.pow(pumpkin.radius + tmpHorror.width,2);
		}
		
		/*
		private function shrinkPumpkinRadius():void {
			pumpkin.shrinkRadius();
		}
		*/
		
		private function checkForPumpkinOverlappedByHorror():void {
			for (var i:uint = 0; i < horrorGroup.length; i++) {
				var tmpHorror:SprHorror = horrorGroup.members[i];
				if (tmpHorror.visible && pumpkin.overlaps(tmpHorror)) {
					lose();
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
			disableUpdate();
			Glob.leveler.lvlNum ++;
			//Glob.leveler.log();
			switchToStateWithFade(StPlay,kFadeDuration,kFadeColor);
		}
		
		private function lose():void {
			disableUpdate();
			FlxG.log("LOSE");
			switchToStateWithFade(StMenu,kFadeDuration,kFadeColor);
		}
	}
}
package
{
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	
	public class StMenu extends ZState
	{
		private const kFadeDuration:Number = 0.22;
		//private const kFadeColor:uint = 0xffff4444;
		private const kFadeColor:uint = 0xff000000;
		
		private var title:ZNode;
		private var prompt:FlxText;
		private var highScore:FlxText;
		private var mnuPause:ZMenu;
		private var flashTitle:ZTimer;
		//private var darkness:SprDarkness;
		
		public function StMenu()
		{
			super();
			
		}
		
		override protected function createObjects():void {
			addTitle();
			addStartPrompt();
			addHighScore();
			addPauseMenu();
			//addOverlay();
		}
		
		private function addTitle():void {
			title = new ZNode();
			title.loadGraphic(GSpritinator.kTitleSheet);
			title.centerX();
			title.placeAtScreenYPercentage(0.22);
			add(title);
			
			var tmpEvent:Function = function():void {
				title.alpha = 1.0 - Number(Math.random()*0.22);
				prompt.alpha = 1.0 - Number(Math.random()*0.22);
			}
			flashTitle = new ZTimer(0.22,tmpEvent);
		}
		
		private function addStartPrompt():void {
			prompt = new FlxText(0,0,FlxG.width);
			prompt.scale.x = 3;
			prompt.scale.y = 3;
			prompt.x = title.x;
			prompt.y = title.y + title.height + 22;
			prompt.text = "PRESS 'SPACE' TO BEGIN";
			prompt.alignment = "center";
			prompt.color = 0xffff8800;
			add(prompt);
		}
		
		private function addHighScore():void {
			highScore = new FlxText(0,0,FlxG.width);
			highScore.scale.x = 4.4;
			highScore.scale.y = 4.4;
			highScore.x = prompt.x;
			highScore.y = prompt.y + prompt.height + 222;
			highScore.text = "HIGH SCORE:\n"+Glob.highScore;
			highScore.alignment = "center";
			highScore.color = 0xffff8800;
			add(highScore);
		}
		
		private function addPauseMenu():void {
			mnuPause = new ZMenu();
			
			var margin:int = 2;
			
			/*
			// START
			var callbackStart:Function = function():void {
				switchToStateWithFade(StPlay,kFadeDuration,kFadeColor);
			};
			var txtStart:String = "START";
			var btnStart:BtnBasic = new BtnBasic(callbackStart,txtStart);
			btnStart.centerX();
			btnStart.placeAtScreenYPercentage(0.44);
			mnuPause.addButton(btnStart);
			*/
			
			// OPTIONS
			var callbackOptions:Function = function():void {
				FlxG.log("OPTIONS");
			};
			var txtOptions:String = "OPTIONS";
			var btnOptions:BtnBasic = new BtnBasic(callbackOptions,txtOptions);
			//btnOptions.placeBelowSprite(btnStart,margin);
			btnOptions.centerX();
			btnOptions.placeAtScreenYPercentage(0.44);
			mnuPause.addButton(btnOptions);
			
			// HIGH SCORES
			var callbackScores:Function = function():void {
				FlxG.log("HIGH SCORES");
			};
			var txtScores:String = "HIGH SCORES";
			var btnScores:BtnBasic = new BtnBasic(callbackScores,txtScores);
			btnScores.placeBelowSprite(btnOptions,margin);
			mnuPause.addButton(btnScores);
			
			// CONTROLS
			var callbackControls:Function = function():void {
				FlxG.log("CONTROLS");
			};
			var txtControls:String = "CONTROLS";
			var btnControls:BtnBasic = new BtnBasic(callbackControls,txtControls);
			btnControls.placeBelowSprite(btnScores,margin);
			mnuPause.addButton(btnControls);
			
			// CREDITS
			var callbackCredits:Function = function():void {
				FlxG.log("CREDITS");
			};
			var txtCredits:String = "CREDITS";
			var btnCredits:BtnBasic = new BtnBasic(callbackCredits,txtCredits);
			btnCredits.placeBelowSprite(btnControls,margin);
			mnuPause.addButton(btnCredits);
			
			add(mnuPause);
		}
		
		/*
		private function addOverlay():void {
			darkness = new SprDarkness();
			add(darkness);
			drawHoleInDarknessOverButton();
		}
		*/
		
		// using this instead of updatePlay for things that should update even when the options screen is up
		override public function update():void {
			super.update();
			flashTitle.update();
		}
		
		override protected function updateControls():void {
			if (Glob.controller.justPressed(GController.pause)) {
				pause();
			}
			if (Glob.controller.justPressed(GController.select)) {
				startGame();
			}
		}
		
		override protected function updatePause():void {
			if (Glob.controller.justPressed(GController.pause)) {
				resume();
			}
			if (Glob.controller.justPressed(GController.curseForward)) {
				mnuPause.curseForward();
				//drawHoleInDarknessOverButton();
			}
			if (Glob.controller.justPressed(GController.curseBackwards)) {
				mnuPause.curseBackwards();
				//drawHoleInDarknessOverButton();
			}
			if (Glob.controller.justPressed(GController.select)) {
				mnuPause.select();
			}
			/*if (Glob.controller.justPressed(GController.back)) {
				switchToStateWithFade(StTitle,kFadeDuration,kFadeColor);
			}*/
		}
		
		/*
		private function drawHoleInDarknessOverButton():void {
			var tmpPoint:FlxPoint = new FlxPoint(mnu.button.x+mnu.button.width/2.0,mnu.button.y+mnu.button.height/2.0);
			
			darkness.fillHoles();
			darkness.drawHole(tmpPoint,222);
		}
		*/
		
		override public function pause():void {
			mnuPause.reset();
			mnuPause.visible = true;
			super.pause();
		}
		
		override public function resume():void {
			mnuPause.visible = false;
			super.resume();
		}
		
		private function startGame():void {
			Glob.leveler.reset();
			switchToStateWithFade(StPlay,kFadeDuration,kFadeColor);
		}
	}
}
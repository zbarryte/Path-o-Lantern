package
{	
	import org.flixel.FlxG;
	
	public class SprHorror extends ZNode
	{	
		private const kMoveAccel:Number = GLeveler.kTileLength;
		private const kDrag:Number = kMoveAccel;
		private const kVelMax:Number = GLeveler.kTileLength*(1 + Math.random()*1);
		
		private const kAnimBlink:String = "kAnimBlink";
		
		private var blinkTimer:Number;
		private const kBlinkPeriod:Number = 2.2 + Math.random()*2;
		
		public function SprHorror(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{
			super(tmpX, tmpY);
			loadGraphic(GSpritinator.kHorrorSheet,true,false,16,16);
			
			drag.x = kDrag;
			drag.y = kDrag;
			
			maxVelocity.x = kVelMax;
			maxVelocity.y = kVelMax;
			
			frame = 0;
			addAnimation(kAnimBlink,[1,2,3,0],10,false);
			
			resetBlinkTimer();
		}
		
		public function moveTowards(tmpNode:ZNode):void {
			if (tmpNode.x < x) {
				moveLeft();
			} else if (tmpNode.x > x) {
				moveRight();
			}
			
			if (tmpNode.y < y) {
				moveUp();
			} else if (tmpNode.y > y) {
				moveDown();
			}
		}
		
		public function hide():void {
			visible = false;
		}
		
		public function show():void {
			visible = true;
		}
		
		private function moveLeft():void {
			acceleration.x = -kMoveAccel;
		}
		
		private function moveRight():void {
			acceleration.x = kMoveAccel;
		}
		
		private function moveUp():void {
			acceleration.y = -kMoveAccel;
		}
		
		private function moveDown():void {
			acceleration.y = kMoveAccel;
		}
		
		public function isHidden():Boolean {
			return !visible;
		}
		
		public function isStationary():Boolean {
			return (velocity.x == 0 && velocity.y == 0);
		}
		
		override public function update():void {
			super.update();
			
			blinkTimer += FlxG.elapsed;
			if (blinkTimer >= kBlinkPeriod) {
				resetBlinkTimer();
				maybeBlink();
			}
		}
		
		private function resetBlinkTimer():void {
			blinkTimer = 0;
		}
		
		private function maybeBlink():void {
			if (isStationary() && Math.random()*3 > 1.5) {
				play(kAnimBlink);
			}
		}
	}
}
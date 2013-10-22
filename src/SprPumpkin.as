package
{
	import org.flixel.FlxG;
	
	public class SprPumpkin extends ZNode
	{
		private const kMoveAccel:Number = GLeveler.kTileLength*22;
		private const kDrag:Number = kMoveAccel;
		private const kVelMax:Number = GLeveler.kTileLength*5;
		
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var isLeft:Boolean;
		private var isRight:Boolean;
		
		public function SprPumpkin(tmpX:Number=0,tmpY:Number=0)
		{
			super(tmpX,tmpY,GSpritinator.kPumpkinSheet);
			
			drag.x = kDrag;
			drag.y = kDrag;
			maxVelocity.x = kVelMax;
			maxVelocity.y = kVelMax;
		}
		
		override protected function updateMechanics():void {			
			acceleration.x = 0;
			acceleration.y = 0;
			
			if (isUp) {
				acceleration.y -= kMoveAccel;
			}
			else if (isDown) {
				acceleration.y += kMoveAccel;
			}
			
			if (isLeft) {
				acceleration.x -= kMoveAccel;
			}
			else if (isRight) {
				acceleration.x += kMoveAccel;
			}
		}
		
		override public function update():void {
			super.update();
			
			isLeft = false;
			isRight = false;
			isUp = false;
			isDown = false;
		}
		
		public function moveLeft():void {
			isLeft = true;
		}
		
		public function moveRight():void {
			isRight = true;
		}
		
		public function moveUp():void {
			isUp = true;
		}
		
		public function moveDown():void {
			isDown = true;
		}
	}
}
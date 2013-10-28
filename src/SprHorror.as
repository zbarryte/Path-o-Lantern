package
{	
	import org.flixel.FlxG;
	
	public class SprHorror extends ZNode
	{	
		private const kMoveAccel:Number = GLeveler.kTileLength*2;
		private const kDrag:Number = kMoveAccel;
		private const kVelMax:Number = GLeveler.kTileLength*9;
		
		public function SprHorror(tmpX:Number=0, tmpY:Number=0, tmpSimpleGraphic:Class=null)
		{
			super(tmpX, tmpY, GSpritinator.kHorrorSheet);
			
			drag.x = kDrag;
			drag.y = kDrag;
			
			maxVelocity.x = kVelMax;
			maxVelocity.y = kVelMax;
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
			
			/*
			if (velocity.x == 0 && velocity.y == 0) {
				visible = false;
			} else {
				visible = true;
			}
			*/
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
	}
}
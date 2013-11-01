package
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class SprPumpkin extends ZNode
	{
		private const kRadiusMax:Number = 88;
		protected var _radius:Number;
		private const kRadiusIncrement:Number = kRadiusMax/7.0;
		
		private const kMoveAccel:Number = GLeveler.kTileLength*44;
		private const kDrag:Number = kMoveAccel;
		private const kVelMax:Number = GLeveler.kTileLength*11;
		
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var isLeft:Boolean;
		private var isRight:Boolean;
		
		private var eyes:ZNode;
		private var legs:ZNode;
		
		private var kAnimLegsIdle:String = "kAnimLegsIdle";
		private var kAnimLegsWalk:String = "kAnimLegsWalk";
		
		public function SprPumpkin(tmpX:Number=0,tmpY:Number=0)
		{
			super(tmpX,tmpY,GSpritinator.kPumpkinSheet);
			alpha = 0;
			
			drag.x = kDrag;
			drag.y = kDrag;
			maxVelocity.x = kVelMax;
			maxVelocity.y = kVelMax;
			
			legs = new ZNode();
			legs.loadGraphic(GSpritinator.kPumpkinLegsSheet,true,false,16,16);
			legs.addAnimation(kAnimLegsIdle,[0]);
			legs.addAnimation(kAnimLegsWalk,[1,2,3,4],22);
			add(legs);
			
			var tmpBody:FlxSprite = new FlxSprite();
			tmpBody.loadGraphic(GSpritinator.kPumpkinBodySheet);
			tmpBody.x = width/2.0 - tmpBody.width/2.0;
			tmpBody.y = height/2.0 - tmpBody.height/2.0;
			add(tmpBody);
			
			eyes = new ZNode();
			eyes.loadGraphic(GSpritinator.kPumpkinEyesSheet);
			add(eyes);
			eyes.x = tmpBody.x;
			eyes.y = tmpBody.y + 1;
			
			_radius = kRadiusMax;
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
			
			eyes.alpha = Math.random()*(radius/kRadiusMax)*0.22 + (radius/kRadiusMax)*0.78;
			
			if (velocity.x != 0 || velocity.y != 0) {
				legs.play(kAnimLegsWalk);
			} else {
				legs.play(kAnimLegsIdle);
			}
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
		
		public function get radius():Number {
			return _radius; // arbitrary for now
		}
		
		public function shrinkRadius():void {
			Glob.audioHandler.play(GAudioHandler.kLightShrink,true);
			_radius -= kRadiusIncrement;
			if (_radius <= width) {
				_radius = 0;
			}
		}
	}
}
package
{
	import flash.events.MouseEvent;
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.behaviors.display.StandardAnimation;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author Kevin Cao
	 */
	public class StandardAnimationTest extends Sprite
	{
		public var mc : MovieClip;
		private var sa : StandardAnimation;
		private var isIn : Boolean;
		
		public function StandardAnimationTest()
		{
			isIn = false;
			
			mc.buttonMode = true;
			sa = new StandardAnimation(mc, false);
//			sa.animationIn();

			sa.skin.addEventListener(MouseEvent.CLICK, clickHandler);
			
			sa.addEventListener(AnimationEvent.ANIMATION_IN, animationEventHandler);
			sa.addEventListener(AnimationEvent.ANIMATION_IN_COMPLETE, animationEventHandler);
			sa.addEventListener(AnimationEvent.ANIMATION_OUT, animationEventHandler);
			sa.addEventListener(AnimationEvent.ANIMATION_OUT_COMPLETE, animationEventHandler);
		}

		private function animationEventHandler(event : AnimationEvent) : void
		{
			trace(event.type);
			if(event.type == AnimationEvent.ANIMATION_IN_COMPLETE)
			{
				isIn = true;
			}
		}

		private function clickHandler(event : MouseEvent) : void
		{
			if(!isIn)
			{
				sa.animationIn();
			}
			else
			{
				sa.animationOut();
			}
		}
		
	}
}

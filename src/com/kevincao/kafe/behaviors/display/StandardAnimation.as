/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors.display
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;

	[Event(name="animationIn", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationInComplete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationOut", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationOutComplete", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class StandardAnimation extends MovieClipSkinBehavior implements IStandardAnimation
	{
		private var inFrame : int;
		private var outFrame : int;
		private var inCompleteFrame : int;
		private var outCompleteFrame : int;

		private var autoPlay : Boolean;
		private var autoLock : Boolean;
		private var autoDestroy : Boolean;

		/**
		 * @param autoLock :	
		 */
		public function StandardAnimation(target : MovieClip, autoPlay : Boolean = true, autoLock : Boolean = true, autoDestroy : Boolean = true)
		{
			this.autoPlay = autoPlay;
			this.autoLock = autoLock;
			this.autoDestroy = autoDestroy;
			
			super(target);
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			inFrame = getFrame(_skin, "animationIn");
			outFrame = getFrame(_skin, "animationOut");
			inCompleteFrame = getFrame(_skin, "animationInComplete");
			outCompleteFrame = getFrame(_skin, "animationOutComplete");

			if (inFrame == -1 || inCompleteFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			_skin.addFrameScript(inFrame - 1, frameDispatchAnimationIn);
			_skin.addFrameScript(inCompleteFrame - 1, frameDispatchAnimationInComplete);

			if (outFrame != -1)
			{
				_skin.addFrameScript(outFrame - 1, frameDispatchAnimationOut);
			}

			if (outCompleteFrame != -1)
			{
				_skin.addFrameScript(outCompleteFrame - 1, frameDispatchAnimationOutComplete);
			}

			setupEventListeners();

			if (autoPlay)
			{
				animationIn();
			}
			else
			{
				_skin.stop();
			}
		}

		override public function destroy() : void
		{
			setupEventListeners(false);
			super.destroy();
		}

		public function animationIn() : void
		{
			_skin.gotoAndPlay(inFrame);
		}

		public function animationOut() : void
		{
			if (outFrame != -1)
			{
				_skin.gotoAndPlay(outFrame);
			}
		}

		// ----------------------------------
		// animation event handlers
		// ----------------------------------

		private function setupEventListeners(b : Boolean = true) : void
		{
			if (b)
			{
				_skin.addEventListener(AnimationEvent.ANIMATION_IN, animationInHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_IN_COMPLETE, animationInCompleteHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_OUT, animationOut, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_OUT_COMPLETE, animationOutCompleteHandler, false, 0, true);
			}
			else
			{
				_skin.removeEventListener(AnimationEvent.ANIMATION_IN, animationInHandler);
				_skin.removeEventListener(AnimationEvent.ANIMATION_IN_COMPLETE, animationInCompleteHandler);
				_skin.removeEventListener(AnimationEvent.ANIMATION_OUT, animationOut);
				_skin.removeEventListener(AnimationEvent.ANIMATION_OUT_COMPLETE, animationOutCompleteHandler);
			}
		}

		private function animationInHandler(event : AnimationEvent) : void
		{
			if (autoLock)
			{
				_skin.mouseEnabled = false;
				_skin.mouseChildren = false;
			}

			dispatchEvent(event);
		}

		private function animationInCompleteHandler(event : AnimationEvent) : void
		{
			if (autoLock)
			{
				_skin.mouseEnabled = true;
				_skin.mouseChildren = true;
			}

			_skin.stop();

			dispatchEvent(event);
		}

		private function animationOutHandler(event : AnimationEvent) : void
		{
			if (autoLock)
			{
				_skin.mouseEnabled = false;
				_skin.mouseChildren = false;
			}

			dispatchEvent(event);
		}

		private function animationOutCompleteHandler(event : AnimationEvent) : void
		{
			_skin.stop();

			dispatchEvent(event);

			if (autoDestroy)
				destroy();
		}

		// ----------------------------------
		// frame scripts
		// ----------------------------------

		private function frameDispatchAnimationIn() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATION_IN));
		}

		private function frameDispatchAnimationInComplete() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATION_IN_COMPLETE));
		}

		private function frameDispatchAnimationOut() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATION_OUT));
		}

		private function frameDispatchAnimationOutComplete() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.ANIMATION_OUT_COMPLETE));
		}

	}
}

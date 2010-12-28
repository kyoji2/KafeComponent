/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;

	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="intro_complete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="outro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="outro_complete", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class StandardAnimation extends Behavior
	{
		private var introFrame : int;
		private var outroFrame : int;
		private var introCompleteFrame : int;
		private var outroCompleteFrame : int;

		private var autoLock : Boolean;

		/**
		 * @param autoLock :	在intro和outro播放的时候是否允许鼠标交互
		 */
		public function StandardAnimation(skin : MovieClip, autoLock : Boolean = true)
		{
			super(skin);

			this.autoLock = autoLock;
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			introFrame = getFrame(_skin, "intro");
			outroFrame = getFrame(_skin, "outro");
			introCompleteFrame = getFrame(_skin, "intro complete");
			outroCompleteFrame = getFrame(_skin, "outro complete");

			if(introFrame == -1 || introCompleteFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			_skin.addFrameScript(introFrame - 1, frameDispatchIntroStart);
			_skin.addFrameScript(introCompleteFrame - 1, frameDispatchOutroStart);
			
			if(outroFrame != -1)
			{
				_skin.addFrameScript(outroFrame - 1, frameDispatchIntroComplete);
			}

			if(outroCompleteFrame != -1)
			{
				_skin.addFrameScript(outroCompleteFrame - 1, frameDispatchOutroComplete);
			}

			setupEventListeners();

			// auto play intro
			_skin.gotoAndPlay(introFrame);
		}

		// ----------------------------------
		// animation event handlers
		// ----------------------------------

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b)
			{
				_skin.addEventListener(AnimationEvent.INTRO_START, introStartHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.INTRO_COMPLETE, introCompleteHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.OUTRO_START, outroStartHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.OUTRO_COMPLETE, outroCompleteHandler, false, 0, true);
			}
			else
			{
				_skin.removeEventListener(AnimationEvent.INTRO_START, introStartHandler);
				_skin.removeEventListener(AnimationEvent.INTRO_COMPLETE, introCompleteHandler);
				_skin.removeEventListener(AnimationEvent.OUTRO_START, outroStartHandler);
				_skin.removeEventListener(AnimationEvent.OUTRO_COMPLETE, outroCompleteHandler);
			}
		}

		private function introStartHandler(event : AnimationEvent) : void
		{
			if(autoLock)
			{
				_skin.mouseEnabled = false;
				_skin.mouseChildren = false;
			}

			dispatchEvent(event);
		}

		private function introCompleteHandler(event : AnimationEvent) : void
		{
			if(autoLock)
			{
				_skin.mouseEnabled = true;
				_skin.mouseChildren = true;
			}

			dispatchEvent(event);
		}

		private function outroStartHandler(event : AnimationEvent) : void
		{
			if(autoLock)
			{
				_skin.mouseEnabled = false;
				_skin.mouseChildren = false;
			}

			dispatchEvent(event);
		}

		private function outroCompleteHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);
			// auto destroy when outro complete
			destroy();
		}

		// ----------------------------------
		// frame scripts
		// ----------------------------------

		private function frameDispatchIntroStart() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.INTRO_START));
		}

		private function frameDispatchIntroComplete() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.INTRO_COMPLETE));
		}

		private function frameDispatchOutroStart() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.OUTRO_START));
		}

		private function frameDispatchOutroComplete() : void
		{
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.OUTRO_COMPLETE));
		}


	}
}

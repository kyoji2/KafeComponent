package com.kevincao.kafe.behaviors.display
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="animationIn", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationInComplete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationOut", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="animationOutComplete", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class AniButton extends ButtonBase implements IStandardAnimation
	{

		private var normalFrame : int;
		private var overCompleteFrame : int;
		private var animationOutFrame : int;
		private var animationOutCompleteFrame : int;
		private var animationInFrame : int;
		private var downCompleteFrame : int;
		private var disabledFrame : int;
		private var downFrame : int;

		private var easyMode : Boolean;

		private var _locked : Boolean;
		private var outCompleteFrame : int;


		protected function get locked() : Boolean
		{
			return _locked;
		}

		protected function set locked(locked : Boolean) : void
		{
			_locked = locked;
			draw();
		}

		public var lockMouseDownState : Boolean = true;

		/**
		 * 
		 */
		public function AniButton(target : MovieClip)
		{
			super(target);
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			normalFrame = getFrame(_skin, "over") - 1;
			downFrame = getFrame(_skin, "down");
			animationInFrame = getFrame(_skin, "animationIn");
			disabledFrame = getFrame(_skin, "disabled");

			if(normalFrame == -2 || downFrame == -1 || animationInFrame == -1 || disabledFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			overCompleteFrame = getFrame(_skin, "out") - 1;

			// easyMode means there is no "out" label
			if(overCompleteFrame == -2)
			{
				easyMode = true;
				overCompleteFrame = downFrame - 1;
			}
			else
			{
				outCompleteFrame = downFrame - 1;
			}

			animationOutFrame = getFrame(_skin, "animationOut");

			downCompleteFrame = animationOutFrame == -1 ? disabledFrame - 1 : animationOutFrame - 1;
			
			// note : addFrameScript() use zero base
			_skin.addFrameScript(animationInFrame - 1, frameDispatchAnimationIn);
			_skin.addFrameScript(normalFrame - 2, frameDispatchAnimationInComplete);
			_skin.addFrameScript(downCompleteFrame - 1, frameStop);

			// add stop frames
			if(!easyMode)
			{
				_skin.addFrameScript(normalFrame - 1, frameStop);
				_skin.addFrameScript(overCompleteFrame - 1, frameStop);
				_skin.addFrameScript(outCompleteFrame - 1, frameStop);
			}

			// animationOut is optional
			if(animationOutFrame != -1)
			{
				animationOutCompleteFrame = disabledFrame - 1;
				_skin.addFrameScript(animationOutFrame - 1, frameDispatchAnimationOut);
				_skin.addFrameScript(animationOutCompleteFrame - 1, frameDispatchAnimationOutComplete);
			}

			setupEventListeners();

			// auto play intro
			_skin.gotoAndPlay(animationInFrame);
		}

		override protected function draw() : void
		{
			_skin.buttonMode = _enabled && !_locked;
			_skin.mouseEnabled = _enabled && !_locked;

			if(!_locked)
			{
				if(_enabled)
				{
					_skin.gotoAndStop(_isRollOver ? overCompleteFrame : normalFrame);
					if(easyMode)
					{
						_skin.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
					}
				}
				else
				{
					_skin.gotoAndStop(disabledFrame);
					if(easyMode)
					{
						_skin.removeEventListener(Event.ENTER_FRAME, tick);
					}
				}
			}
		}

		// ----------------------------------
		// override handlers
		// ----------------------------------

		override protected function rollOverHandler(event : MouseEvent) : void
		{
			super.rollOverHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			if(!easyMode)
			{
				_skin.gotoAndPlay("over");
			}
		}

		override protected function rollOutHandler(event : MouseEvent) : void
		{
			super.rollOutHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			if(!easyMode && _enabled && !_locked)
			{
				_skin.gotoAndPlay("out");
			}
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndPlay(downFrame);
		}

		override protected function mouseUpHandler(event : MouseEvent) : void
		{
			super.mouseUpHandler(event);
			draw();
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			goto();

			// auto play outro
			animationOut();
		}

		private function tick(event : Event) : void
		{
			if(!_isMouseDown)
			{
				if(_isRollOver)
				{
					if(_skin.currentFrame < overCompleteFrame)
					{
						_skin.nextFrame();
					}
				}
				else
				{
					if(_skin.currentFrame > normalFrame)
					{
						_skin.prevFrame();
					}
				}
			}
		}

		// ----------------------------------
		// animation event handlers
		// ----------------------------------

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b)
			{
				_skin.addEventListener(AnimationEvent.ANIMATION_IN, animationInHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_IN_COMPLETE, animationInCompleteHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_OUT, animationOutHandler, false, 0, true);
				_skin.addEventListener(AnimationEvent.ANIMATION_OUT_COMPLETE, animationOutCompleteHandler, false, 0, true);
			}
			else
			{
				_skin.removeEventListener(AnimationEvent.ANIMATION_IN, animationInHandler);
				_skin.removeEventListener(AnimationEvent.ANIMATION_IN_COMPLETE, animationInCompleteHandler);
				_skin.removeEventListener(AnimationEvent.ANIMATION_OUT, animationOutHandler);
				_skin.removeEventListener(AnimationEvent.ANIMATION_OUT_COMPLETE, animationOutCompleteHandler);
			}
		}

		private function animationInHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);

			locked = true;
		}

		private function animationInCompleteHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);

			locked = false;
		}

		private function animationOutHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);

			locked = true;

			if(easyMode)
			{
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		private function animationOutCompleteHandler(event : AnimationEvent) : void
		{
			_skin.stop();
			
			dispatchEvent(event);
			
			// auto destroy when outro complete
			destroy();
		}
		
		//----------------------------------
		//  public method
		//----------------------------------
		
		public function animationIn() : void
		{
			_skin.gotoAndPlay(animationInFrame);
		}

		public function animationOut() : void
		{
			if (animationOutFrame != -1)
			{
				_skin.gotoAndPlay(animationOutFrame);
			}
		}



		override public function destroy() : void
		{
			if(easyMode)
			{
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}
			setupEventListeners(false);
			super.destroy();
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

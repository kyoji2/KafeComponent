package com.kevincao.kafe.behaviors
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class AniButton extends ButtonBase
	{

		private var upFrame : int;
		private var normalFrame1 : int;
		private var normalFrame2 : int;
		private var outFrame : int;
		private var outCompleteFrame : int;
		private var inFrame : int;
		private var downCompleteFrame : int;
		private var disabledFrame : int;

		private var easyMode : Boolean;

		private var _locked : Boolean;


		protected function get locked() : Boolean
		{
			return _locked;
		}

		protected function set locked(locked : Boolean) : void
		{
			_locked = locked;
			drawNow();
		}

		public var lockMouseDownState : Boolean = true;

		/**
		 * 
		 */
		public function AniButton(skin : MovieClip)
		{
			super(skin);
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			_locked = true;

			upFrame = getFrame(_skin, "out") - 1;
			normalFrame1 = getFrame(_skin, "over") - 1;
			normalFrame2 = getFrame(_skin, "down") - 1;
			inFrame = getFrame(_skin, "intro");
			outFrame = getFrame(_skin, "outro");
			disabledFrame = getFrame(_skin, "disabled");
			downCompleteFrame = outFrame - 1;
			outCompleteFrame = disabledFrame - 1;

			if(normalFrame1 == -2 || normalFrame2 == -2 || inFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			setupEventListeners();

			// easyMode means there is no "out" label
			easyMode = upFrame == -2;

			_skin.addFrameScript(normalFrame1 - 2, frameDispatchIntroComplete);
			_skin.addFrameScript(downCompleteFrame - 1, frameStop);

			// add stop frames
			if(!easyMode)
			{
				_skin.addFrameScript(upFrame - 1, frameStop);
				_skin.addFrameScript(normalFrame1 - 1, frameStop);
				_skin.addFrameScript(normalFrame2 - 1, frameStop);
			}

			// auto play intro
			_skin.addFrameScript(inFrame - 1, frameDispatchIntroStart);
			_skin.gotoAndPlay(inFrame);

			// outro is optional
			if(outFrame != -1)
			{
				_skin.addFrameScript(outFrame - 1, frameDispatchOutroStart);
				_skin.addFrameScript(outCompleteFrame - 1, frameDispatchOutroComplete);
			}
		}

		override protected function draw() : void
		{
			_skin.buttonMode = _enabled && !_locked;
			_skin.mouseEnabled = _enabled && !_locked;

			if(!_locked)
			{
				if(_enabled)
				{
					if(easyMode)
					{
						_skin.gotoAndStop(_isRollOver ? normalFrame2 : normalFrame1);
						_skin.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
					}
					else
					{
						_skin.gotoAndStop(_isRollOver ? upFrame : normalFrame1);
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
			_skin.gotoAndPlay("down");
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
			if(outFrame != -1)
			{
				_skin.gotoAndPlay(outFrame);
			}
		}

		private function tick(event : Event) : void
		{
			if(!_isMouseDown)
			{
				if(_isRollOver)
				{
					if(_skin.currentFrame < normalFrame2)
					{
						_skin.nextFrame();
					}
				}
				else
				{
					if(_skin.currentFrame > normalFrame1)
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
			locked = true;

			dispatchEvent(event);
		}

		private function introCompleteHandler(event : AnimationEvent) : void
		{
			locked = false;

			dispatchEvent(event);
		}

		private function outroStartHandler(event : AnimationEvent) : void
		{
			locked = true;

			if(easyMode)
			{
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}

			dispatchEvent(event);
		}

		private function outroCompleteHandler(event : AnimationEvent) : void
		{
			// auto destroy when outro complete
			destroy();

			dispatchEvent(event);
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

package com.kevincao.kafe.behaviors
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="intro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="intro_complete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="outro_start", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="outro_complete", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class AniButton extends ButtonBase
	{

		private var normalFrame : int;
		private var overCompleteFrame : int;
		private var outroFrame : int;
		private var outroCompleteFrame : int;
		private var introFrame : int;
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
		public function AniButton(skin : MovieClip)
		{
			super(skin);
		}

		override protected function initSkin() : void
		{
			super.initSkin();
			
			normalFrame = getFrame(_skin, "over") - 1;
			downFrame = getFrame(_skin, "down");
			introFrame = getFrame(_skin, "intro");
			disabledFrame = getFrame(_skin, "disabled");
			
			if(normalFrame == -2 || downFrame == -1 || introFrame == -1 || disabledFrame == -1)
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
			
			outroFrame = getFrame(_skin, "outro");
			
			downCompleteFrame = outroFrame == -1 ? disabledFrame - 1 : outroFrame - 1;
			
			_skin.addFrameScript(introFrame - 1, frameDispatchIntroStart);
			_skin.addFrameScript(normalFrame - 2, frameDispatchIntroComplete);
			_skin.addFrameScript(downCompleteFrame - 1, frameStop);

			// add stop frames
			if(!easyMode)
			{
				_skin.addFrameScript(normalFrame - 1, frameStop);
				_skin.addFrameScript(overCompleteFrame - 1, frameStop);
				_skin.addFrameScript(outCompleteFrame - 1, frameStop);
			}

			// outro is optional
			if(outroFrame != -1)
			{
				outroCompleteFrame = disabledFrame - 1;
				_skin.addFrameScript(outroFrame - 1, frameDispatchOutroStart);
				_skin.addFrameScript(outroCompleteFrame - 1, frameDispatchOutroComplete);
			}
			
			setupEventListeners();
			
			// auto play intro
			_skin.gotoAndPlay(introFrame);
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
			if(outroFrame != -1)
			{
				_skin.gotoAndPlay(outroFrame);
			}
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
			dispatchEvent(event);
			
			locked = true;
		}

		private function introCompleteHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);
			
			locked = false;
		}

		private function outroStartHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);
			
			locked = true;

			if(easyMode)
			{
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		private function outroCompleteHandler(event : AnimationEvent) : void
		{
			dispatchEvent(event);
			// auto destroy when outro complete
			destroy();
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
			_skin.stop();
			_skin.dispatchEvent(new AnimationEvent(AnimationEvent.OUTRO_COMPLETE));
		}
	}
}

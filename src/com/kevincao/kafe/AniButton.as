/**
 * com.kevincao.kafe.AniButton
 * @version 1.0.0
 * @author Kevin Cao
 * Copyright (C) 2010  kevincao.com
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
package com.kevincao.kafe 
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="complete", type="flash.events.Event")]

	/**
	 * @author Kevin Cao
	 */
	public class AniButton extends ButtonBase 
	{

		private var upFrame : int;
		private var normalFrame1 : int;
		private var normalFrame2 : int;
		private var outFrame : int;
		private var inFrame : int;

		private var easyMode : Boolean;

		public var lockMouseDownState : Boolean = true;

		/**
		 * 
		 */
		public function AniButton(skin : Object)
		{
			super(skin);
			// set enabled to false while intro is playing
			enabled = false;
		}

		override protected function initSkin() : void 
		{
			super.initSkin();
			
			upFrame = getFrame(_skin, "out") - 1;
			normalFrame1 = getFrame(_skin, "over") - 1;
			normalFrame2 = getFrame(_skin, "down") - 1;
			
			if(normalFrame1 == -2 || normalFrame2 == -2) {
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}
			
			// easyMode means there is no "out" label
			easyMode = upFrame == -2;
			
			// init button after intro finished
			_skin.addFrameScript(normalFrame1 - 2, frameInit);
			
			// add stop frames
			if(!easyMode) {
				_skin.addFrameScript(upFrame - 1, frameStop);
				_skin.addFrameScript(normalFrame1 - 1, frameStop);
				_skin.addFrameScript(normalFrame2 - 1, frameStop);
			}
			
			inFrame = getFrame(_skin, "intro");
			outFrame = getFrame(_skin, "outro");
			
			// play intro
			if(inFrame != -1) {
				_skin.gotoAndPlay(inFrame);
			} else {
				_skin.gotoAndPlay(1);
			}
			
			// handle outro finished
			if(outFrame != -1) {
				_skin.addFrameScript(_skin.totalFrames - 1, frameDispatch);
				addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			}
		}

		override protected function rollOverHandler(event : MouseEvent) : void
		{
			super.rollOverHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			if(!easyMode) {
				_skin.gotoAndPlay("over");
			}
		}

		override protected function rollOutHandler(event : MouseEvent) : void
		{
			super.rollOutHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			if(!easyMode) {
				_skin.gotoAndPlay("out");
			}
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndStop("down");
		}

		override protected function mouseUpHandler(event : MouseEvent) : void
		{
			super.mouseUpHandler(event);
			if(_isRollOver) {
				if(!easyMode) {
					_skin.gotoAndStop(upFrame);
				} else {
					_skin.gotoAndStop(normalFrame2);
				}
			} else {
				_skin.gotoAndStop(normalFrame1);
			}
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			goto();
			
			// play outro
			if(outFrame != -1) {
				enabled = false;
				if(easyMode) {
					_skin.removeEventListener(Event.ENTER_FRAME, tick);
				}
				_skin.gotoAndPlay(outFrame);
			}
		}

		private function completeHandler(event : Event) : void
		{
			removeEventListener(Event.COMPLETE, completeHandler);
			destroy();
		}

		private function tick(event : Event) : void
		{
			if(!_isMouseDown) {
				if(_isRollOver) {
					if(_skin.currentFrame < normalFrame2) {
						_skin.nextFrame();
					}
				} else {
					if(_skin.currentFrame > normalFrame1) {
						_skin.prevFrame();
					}
				}
			}
		}

		
		// frame scripts

		
		private function frameStop() : void 
		{
			_skin.stop();
		}

		private function frameInit() : void 
		{
			enabled = true;
			
			if(easyMode) {
				_skin.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			} else {
				if(_isRollOver) {
					_skin.gotoAndPlay("over");
				}
			}
		}

		private function frameDispatch() : void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}

		
		
		override public function destroy() : void
		{
			if(easyMode) {
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}
			super.destroy();
		}
	}
}

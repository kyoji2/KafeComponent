package com.kevincao.kafe.behaviors.display
{
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Kevin Cao
	 */
	public class EasyButton extends ButtonBase
	{

		private var overCompleteFrame : int;
		private var normalFrame : int;
		private var downFrame : int;
		private var disabledFrame : int;
		private var downCompleteFrame : int;

		/**
		 * 
		 */
		public function EasyButton(target : MovieClip)
		{
			super(target);
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			normalFrame = 1;
			downFrame = getFrame(_skin, "down");
			overCompleteFrame = downFrame - 1;
			disabledFrame = getFrame(_skin, "disabled");
			downCompleteFrame = disabledFrame - 1;

			if(downFrame == -1 || disabledFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			_skin.addFrameScript(downCompleteFrame - 1, frameStop);
		}

		override protected function draw() : void
		{
			super.draw();

			if(_enabled)
			{
				_skin.gotoAndStop(_isRollOver ? overCompleteFrame : normalFrame);
				_skin.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			}
			else
			{
				_skin.gotoAndStop(disabledFrame);
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
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

		override public function destroy() : void
		{
			_skin.removeEventListener(Event.ENTER_FRAME, tick);
			super.destroy();
		}
	}
}
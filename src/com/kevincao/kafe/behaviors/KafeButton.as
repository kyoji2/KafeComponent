package com.kevincao.kafe.behaviors
{
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="change", type="flash.events.Event")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeButton extends ButtonBase implements IKafeButton
	{

		protected var _selected : Boolean;
		protected var _toggle : Boolean;

		private var overCompleteFrame : int;
		private var outCompleteFrame : int;
		private var downCompleteFrame : int;
		private var selectedOverCompleteFrame : int;
		private var selectedOutCompleteFrame : int;
		private var selectedDownCompleteFrame : int;

		public var lockMouseDownState : Boolean = true;

		public function get selected() : Boolean
		{
			return _selected;
		}

		public function set selected(value : Boolean) : void
		{
			if(_selected == value) return;

			_selected = value;
			dispatchEvent(new Event(Event.CHANGE));
			invalidate();
		}

		public function get toggle() : Boolean
		{
			return _toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			_toggle = value;
		}

		/**
		 * 
		 */
		public function KafeButton(skin : MovieClip)
		{
			super(skin);
		}

		// ----------------------------------
		// override functions
		// ----------------------------------

		override protected function initSkin() : void
		{
			super.initSkin();

			overCompleteFrame = getFrame(_skin, "out") - 1;
			outCompleteFrame = getFrame(_skin, "down") - 1;
			downCompleteFrame = getFrame(_skin, "disabled") - 1;
			selectedOverCompleteFrame = getFrame(_skin, "selected out") - 1;
			selectedOutCompleteFrame = getFrame(_skin, "selected down") - 1;
			selectedDownCompleteFrame = getFrame(_skin, "selected disabled") - 1;

			if(overCompleteFrame == -2 || outCompleteFrame == -2 || selectedOverCompleteFrame == -2 || selectedOutCompleteFrame == -2)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			_skin.addFrameScript(overCompleteFrame - 1, frameStop);
			_skin.addFrameScript(outCompleteFrame - 1, frameStop);
			_skin.addFrameScript(downCompleteFrame - 1, frameStop);
			_skin.addFrameScript(selectedOverCompleteFrame - 1, frameStop);
			_skin.addFrameScript(selectedOutCompleteFrame - 1, frameStop);
			_skin.addFrameScript(selectedDownCompleteFrame - 1, frameStop);
		}

		override protected function draw() : void
		{
			super.draw();
			
			if(_enabled)
			{
				if(_isRollOver)
				{
					_skin.gotoAndStop(_selected ? selectedOverCompleteFrame : overCompleteFrame);
				}
				else
				{
					_skin.gotoAndStop(_selected ? "selected" : outCompleteFrame);
				}
			}
			else
			{
				_skin.gotoAndStop(_selected ? "selected disabled" : "disabled");
			}
		}

		// ----------------------------------
		// handlers
		// ----------------------------------

		override protected function rollOverHandler(event : MouseEvent) : void
		{
			super.rollOverHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			_skin.gotoAndPlay(_selected ? "selected over" : "over");
		}

		override protected function rollOutHandler(event : MouseEvent) : void
		{
			super.rollOutHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			
			// 在这里要排除因mouseEnabled=false而产生的rollOut事件
			if(_enabled)
			{
				_skin.gotoAndPlay(_selected ? "selected out" : "out");
			}
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndPlay(_selected ? "selected down" : "down");
		}

		override protected function mouseUpHandler(event : MouseEvent) : void
		{
			super.mouseUpHandler(event);
			draw();
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			if(_toggle)
			{
				selected = !selected;
			}
			else
			{
				goto();
			}
		}
	}
}

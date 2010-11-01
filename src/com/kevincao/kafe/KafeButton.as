package com.kevincao.kafe
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="change", type="flash.events.Event")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeButton extends ButtonBase
	{

		protected var _selected : Boolean;		protected var _toggle : Boolean;

		private var upFrame : int;
		private var normalFrame : int;
		private var selectedUpFrame : int;
		private var selectedNormalFrame : int;

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
		public function KafeButton(skin : Object)
		{
			super(skin);
		}

		override protected function initSkin() : void 
		{
			super.initSkin();
			
			upFrame = getFrame(_skin, "out") - 1;
			normalFrame = getFrame(_skin, "down") - 1;
			selectedUpFrame = getFrame(_skin, "selected out") - 1;
			selectedNormalFrame = getFrame(_skin, "selected down") - 1;
			
			if(upFrame == -2 || normalFrame == -2 || selectedUpFrame == -2 || selectedNormalFrame == -2) 
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}
			
			_skin.addFrameScript(upFrame - 1, frameStop);
			_skin.addFrameScript(normalFrame - 1, frameStop);
			_skin.addFrameScript(selectedUpFrame - 1, frameStop);
			_skin.addFrameScript(selectedNormalFrame - 1, frameStop);
		}

		override protected function draw() : void 
		{
			super.draw();
			if(_enabled) 
			{
				if(_isRollOver) 
				{
					_skin.gotoAndStop(selected ? selectedUpFrame : upFrame);
				} 
				else 
				{
					_skin.gotoAndStop(selected ? "selected" : normalFrame);
				}
			} 
			else 
			{
				_skin.gotoAndStop(selected ? "selected disabled" : "disabled");
			}
		}

		override protected function rollOverHandler(event : MouseEvent) : void
		{
			super.rollOverHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			_skin.gotoAndPlay(selected ? "selected over" : "over");
		}

		override protected function rollOutHandler(event : MouseEvent) : void
		{
			super.rollOutHandler(event);
			if(_isMouseDown && lockMouseDownState) return;
			_skin.gotoAndPlay(selected ? "selected out" : "out");
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndStop(selected ? "selected down" : "down");
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

		private function frameStop() : void 
		{
			_skin.stop();
		}
	}
}

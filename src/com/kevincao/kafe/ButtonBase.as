package com.kevincao.kafe 
{
	import com.kevincao.kafe.core.KafeBase;
	import com.kevincao.kafe.events.KafeEvent;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.Timer;

	/**
	 * @author Kevin Cao
	 */
	public class ButtonBase extends KafeBase 
	{

		public static var PRESS_TIME : Number = 500;
		public static var REPEAT_INTERVAL : Number = 35;

		protected var _isRollOver : Boolean = false;
		protected var _isMouseDown : Boolean = false;
		protected var _autoRepeat : Boolean = false;

		protected var _href : String;
		protected var _window : String;

		private var pressTimer : Timer;

		public function get isRollOver() : Boolean 
		{
			return _isRollOver;
		}

		public function get isMouseDown() : Boolean 
		{
			return _isMouseDown;
		}

		public function get href() : String 
		{
			return _href;
		}

		public function set href(value : String) : void 
		{
			_href = value;
		}

		public function get window() : String 
		{
			return _window;
		}

		public function set window(value : String) : void 
		{
			_window = value;
		}

		public function get autoRepeat() : Boolean 
		{
			return _autoRepeat;
		}

		public function set autoRepeat(value : Boolean) : void 
		{
			_autoRepeat = value;
		}

		/**
		 * 
		 */
		public function ButtonBase(skin : Object)
		{
			super(skin);
			
			pressTimer = new Timer(1, 0);
			pressTimer.addEventListener(TimerEvent.TIMER, tick, false, 0, true);
		}

		override protected function initSkin() : void 
		{
			super.initSkin();
			
			_skin.mouseChildren = false;
			_skin.stop();
		}
		
		override protected function draw() : void 
		{
			if(_enabled) 
			{
				// check isRollOver
				var point : Point = new Point(_skin.mouseX, _skin.mouseY);
				point = _skin.localToGlobal(point);
				if(_skin.hitArea) {
					_isRollOver = _skin.hitArea.hitTestPoint(point.x, point.y);
				} else {
					_isRollOver = _skin.hitTestPoint(point.x, point.y);
				}
			}
			
			setupEventListeners(_enabled);
			
			_skin.buttonMode = _enabled;
			_skin.mouseEnabled = _enabled;
			
			super.draw();
		}

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b) 
			{
				addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
				addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
				addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
				addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			} 
			else 
			{
				removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				removeEventListener(MouseEvent.CLICK, clickHandler);
			}
		}

		protected function clickHandler(event : MouseEvent) : void
		{
			goto();
		}

		protected function rollOverHandler(event : MouseEvent) : void
		{
			_isRollOver = true;
		}

		protected function rollOutHandler(event : MouseEvent) : void
		{
			_isRollOver = false;
		}

		protected function mouseDownHandler(event : MouseEvent) : void
		{
			_isMouseDown = true;
			startPress();
			_skin.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
		}

		protected function mouseUpHandler(event : MouseEvent) : void
		{
			_isMouseDown = false;
			endPress();
			_skin.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}

		protected function startPress() : void 
		{
			if (_autoRepeat) 
			{
				pressTimer.delay = PRESS_TIME;
				pressTimer.start();
			}
			dispatchEvent(new KafeEvent(KafeEvent.BUTTON_DOWN, true));
		}

		internal function endPress() : void 
		{
			pressTimer.reset();
		}

		private function tick(event : TimerEvent) : void 
		{
			if (!autoRepeat) 
			{ 
				endPress(); 
				return; 
			}
			if (pressTimer.currentCount == 1) 
			{ 
				pressTimer.delay = REPEAT_INTERVAL; 
			}
			dispatchEvent(new KafeEvent(KafeEvent.BUTTON_DOWN, true));
		}		

		protected function getFrame(target : MovieClip, label : String) : int 
		{
			var labels : Array = target.currentLabels;
			var l : int = labels.length;
			
			while (l--)
				if (labels[l].name == label)
					return labels[l].frame;
			
			return -1;
		}

		override public function destroy() : void 
		{
			_skin.stop();
			_skin.buttonMode = false;
			_skin.mouseEnabled = false;
			if(_skin.stage) 
			{
				_skin.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			}
			
			setupEventListeners(false);
			pressTimer.stop();
			pressTimer.removeEventListener(TimerEvent.TIMER, tick);
			
			super.destroy();
		}

		public function goto() : void 
		{
			if(_href && _href != "") 
			{
				navigateToURL(new URLRequest(_href), _window || "_self");
			}
		}
	}
}

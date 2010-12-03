package com.kevincao.kafe.behaviors
{
	import com.kevincao.kafe.events.KafeEvent;
	import com.kevincao.kafe.events.ScrollEvent;
	import com.kevincao.kafe.utils.NumberHelper;

	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	[Event(name="scroll",type="com.kevincao.kafe.events.ScrollEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class ScrollBarBase extends Behavior implements IScrollBar
	{
		static public const HORIZONTAL : String = "horizontal";
		static public const VERTICAL : String = "vertical";

		private var _pageSize : Number = 10;
		private var _pageScrollSize : Number = 0;
		private var _lineScrollSize : Number = 1;
		private var _minScrollPosition : Number = 0;
		private var _maxScrollPosition : Number = 0;
		private var _scrollPosition : Number = 0;
		private var _minThumbSize : Number = 12;

		private var _direction : String;
		private var _size : Number;

		private var scaleThumb : Boolean;

		private var prop : String;
		private var dir : String;
		private var thumbScrollOffset : Number;
		private var inDrag : Boolean = false;

		protected var upArrow : IButton;
		protected var downArrow : IButton;
		protected var thumb : IButton;
		protected var track : IButton;

		/**
		 * 
		 */
		public function get size() : Number
		{
			return _size;
		}

		public function set size(value : Number) : void
		{
			_size = value;
			drawLayout();
		}

		/**
		 * 
		 */
		public function get scrollPosition() : Number
		{
			return _scrollPosition;
		}

		public function set scrollPosition(newScrollPosition : Number) : void
		{
			setScrollPosition(newScrollPosition, true);
		}

		/**
		 * 
		 */
		public function get minScrollPosition() : Number
		{
			return _minScrollPosition;
		}

		public function set minScrollPosition(value : Number) : void
		{
			// This uses setScrollProperties because it needs to update thumb and enabled.
			setScrollProperties(_pageSize, value, _maxScrollPosition);
		}

		/**
		 * 
		 */
		public function get maxScrollPosition() : Number
		{
			return _maxScrollPosition;
		}

		public function set maxScrollPosition(value : Number) : void
		{
			// This uses setScrollProperties because it needs to update thumb and enabled.
			setScrollProperties(_pageSize, _minScrollPosition, value);
		}

		/**
		 * 
		 */
		public function get pageSize() : Number
		{
			return _pageSize;
		}

		public function set pageSize(value : Number) : void
		{
			if(value > 0)
			{
				_pageSize = value;
			}
		}

		/**
		 * 
		 */
		public function get pageScrollSize() : Number
		{
			return (_pageScrollSize == 0) ? _pageSize : _pageScrollSize;
		}

		public function set pageScrollSize(value : Number) : void
		{
			if(value >= 0)
			{
				_pageScrollSize = value;
			}
		}

		/**
		 * 
		 */
		public function get lineScrollSize() : Number
		{
			return _lineScrollSize;
		}

		public function set lineScrollSize(value : Number) : void
		{
			if(value > 0)
			{
				_lineScrollSize = value;
			}
		}

		/**
		 * 
		 */
		override public function set enabled(value : Boolean) : void
		{
			value = value && minScrollPosition < maxScrollPosition;
			super.enabled = value;
		}

		/**
		 * 
		 */
		public function ScrollBarBase(skin : MovieClip, direction : String = "vertical")
		{
			super(skin);

			_direction = direction;
			if(_direction == ScrollBarBase.HORIZONTAL)
			{
				prop = "width";
				dir = "x";
			}
			else
			{
				prop = "height";
				dir = "y";
			}

			drawLayout();
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			_skin.mouseEnabled = false;

			upArrow = getAsset("upArrow") || getAsset("leftArrow");
			downArrow = getAsset("downArrow") || getAsset("rightArrow");
			track = getAsset("track");
			thumb = getAsset("thumb");

			if(upArrow)
			{
				upArrow.autoRepeat = true;
			}
			if(downArrow)
			{
				downArrow.autoRepeat = true;
			}
			if(track)
			{
				track.autoRepeat = true;
			}
			if(thumb)
			{
				// 如果没有九宫格设置，则不缩放thumb
				scaleThumb = thumb.skin.scale9Grid != null;
			}

			setupEventListeners();
		}

		override protected function draw() : void
		{
			if(upArrow) upArrow.enabled = _enabled;
			if(downArrow) downArrow.enabled = _enabled;
			if(track) track.enabled = _enabled;
			if(thumb) thumb.enabled = _enabled;

			_skin.mouseChildren = enabled;

			super.draw();
		}

		protected function setupEventListeners(b : Boolean = true) : void
		{
			if(upArrow)
			{
				b ? upArrow.addEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true) : upArrow.removeEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler);
			}
			if(downArrow)
			{
				b ? downArrow.addEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true) : downArrow.removeEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler);
			}
			if(track)
			{
				b ? track.addEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler, false, 0, true) : track.removeEventListener(KafeEvent.BUTTON_DOWN, scrollPressHandler);
			}
			if(thumb)
			{
				b ? thumb.skin.addEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true) : thumb.skin.removeEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler);
			}
		}

		private function getAsset(key : String) : EasyButton
		{
			if(key != "" && _skin.getChildByName(key))
			{
				return new EasyButton(MovieClip(_skin.getChildByName(key)));
			}
			else
			{
				return null;
			}
		}

		protected function drawLayout() : void
		{
			if(!_size) _size = _skin[prop];

			if(downArrow && upArrow)
			{
				upArrow.skin[dir] = downArrow.skin[dir] = 0;
				downArrow.skin[dir] = Math.max(upArrow.skin[prop], size - downArrow.skin[prop]);
			}

			if(track)
			{

				if(downArrow && upArrow)
				{
					track.skin[dir] = upArrow.skin[prop];
					track.skin[prop] = Math.max(0, size - (downArrow.skin[prop] + upArrow.skin[prop]));
				}
				else
				{
					track.skin[dir] = 0;
					track.skin[prop] = Math.max(0, size);
				}
			}

			updateThumb();
		}

		protected function updateThumb() : void
		{
			if(!track || !thumb) return;

			var per : Number = _maxScrollPosition - _minScrollPosition + _pageSize;
			if(track.skin[prop] <= _minThumbSize || _maxScrollPosition <= _minScrollPosition || (per == 0 || isNaN(per)))
			{
				if(scaleThumb) thumb.skin[prop] = _minThumbSize;
				thumb.skin.visible = false;
			}
			else
			{
				if(scaleThumb) thumb.skin[prop] = Math.round(Math.max(_minThumbSize + 1, _pageSize / per * track.skin[prop]));
				thumb.skin[dir] = track.skin[dir] + (track.skin[prop] - thumb.skin[prop]) * ((_scrollPosition - _minScrollPosition) / (_maxScrollPosition - _minScrollPosition));
				thumb.skin.visible = enabled;
			}
		}

		protected function scrollPressHandler(event : KafeEvent) : void
		{
			if(event.currentTarget == upArrow)
			{
				setScrollPosition(_scrollPosition - _lineScrollSize);
			}
			else if(event.currentTarget == downArrow)
			{
				setScrollPosition(_scrollPosition + _lineScrollSize);
			}
			else
			{
				var mouse : Number = _direction == ScrollBarBase.HORIZONTAL ? _skin.mouseX : _skin.mouseY;
				// var mousePosition : Number = (mouse - track[dir]) / track[prop] * (_maxScrollPosition - _minScrollPosition) + _minScrollPosition;
				var mousePosition : Number = NumberHelper.map(mouse - track.skin[dir], 0, track.skin[prop], _minScrollPosition, _maxScrollPosition);

				var pgScroll : Number = pageScrollSize;
				if(_scrollPosition < mousePosition)
				{
					if(_scrollPosition + pgScroll > mousePosition)
					{
						event.target.endPress();
					}
					setScrollPosition(_scrollPosition + pgScroll);
				}
				else if(_scrollPosition > mousePosition)
				{
					if(_scrollPosition - pgScroll < mousePosition)
					{
						event.target.endPress();
					}
					setScrollPosition(_scrollPosition - pgScroll);
				}
			}
		}

		protected function thumbPressHandler(event : MouseEvent) : void
		{
			inDrag = true;
			var mouse : Number = _direction == ScrollBarBase.HORIZONTAL ? _skin.mouseX : _skin.mouseY;
			thumbScrollOffset = mouse - thumb.skin[dir];
			_skin.stage.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler, false, 0, true);
			_skin.stage.addEventListener(MouseEvent.MOUSE_UP, upHandler, false, 0, true);
		}

		protected function upHandler(event : MouseEvent) : void
		{
			inDrag = false;
			_skin.stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			_skin.stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
		}

		protected function moveHandler(event : MouseEvent) : void
		{
			var mouse : Number = _direction == ScrollBarBase.HORIZONTAL ? _skin.mouseX : _skin.mouseY;
			var pos : Number = NumberHelper.constrain(mouse - track.skin[dir] - thumbScrollOffset, 0, track.skin[prop] - thumb.skin[prop]);
			setScrollPosition(NumberHelper.map(pos, 0, track.skin[prop] - thumb.skin[prop], _minScrollPosition, _maxScrollPosition));
		}

		// ----------------------------------
		// public functions
		// ----------------------------------

		public function setScrollPosition(newScrollPosition : Number, fireEvent : Boolean = true) : void
		{
			var oldPosition : Number = scrollPosition;
			_scrollPosition = NumberHelper.constrain(newScrollPosition, _minScrollPosition, _maxScrollPosition);
			if(oldPosition == _scrollPosition)
			{
				return;
			}
			if(fireEvent)
			{
				dispatchEvent(new ScrollEvent(_direction, scrollPosition - oldPosition, scrollPosition));
			}

			updateThumb();
		}

		public function setScrollProperties(pageSize : Number, minScrollPosition : Number, maxScrollPosition : Number, pageScrollSize : Number = 0) : void
		{
			this.pageSize = pageSize;
			_minScrollPosition = minScrollPosition;
			_maxScrollPosition = maxScrollPosition;
			if(pageScrollSize >= 0)
			{
				_pageScrollSize = pageScrollSize;
			}
			enabled = (_maxScrollPosition > _minScrollPosition);
			// ensure our scroll position is still in range:
			setScrollPosition(_scrollPosition, false);

			updateThumb();
		}

		override public function destroy() : void
		{
			setupEventListeners(false);

			if(upArrow)
			{
				upArrow.destroy();
			}
			if(downArrow)
			{
				downArrow.destroy();
			}
			if(track)
			{
				track.destroy();
			}
			if(thumb)
			{
				thumb.destroy();
			}

			upArrow = null;
			downArrow = null;
			thumb = null;
			track = null;

			super.destroy();
		}
	}
}

package com.kevincao.kafe.behaviors.display
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
	public class ScrollBarBase extends MovieClipSkinBehavior implements IScrollBar
	{

		protected var _pageSize : Number = 10;
		protected var _pageScrollSize : Number = 0;
		protected var _lineScrollSize : Number = 1;
		protected var _minScrollPosition : Number = 0;
		protected var _maxScrollPosition : Number = 0;
		protected var _scrollPosition : Number = 0;
		protected var _minThumbSize : Number = 12;

		protected var _direction : String;

		protected var scaleThumb : Boolean;
		
		protected var _enabled : Boolean = true;

		protected var prop : String;
		protected var dir : String;
		protected var thumbScrollOffset : Number;
		protected var inDrag : Boolean = false;

		protected var upArrow : IButton;
		protected var downArrow : IButton;
		protected var thumb : IButton;
		protected var track : IButton;

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
			// This uses setScrollProperties because it needs to update thumb.
			setScrollProperties(value, _minScrollPosition, _maxScrollPosition);
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
		public function get enabled() : Boolean
		{
			return _enabled;
		}

		
		public function set enabled(value : Boolean) : void
		{
			value = value && minScrollPosition < maxScrollPosition;
			
			if(_enabled == value) return;

			_enabled = value;
			
			invalidate();
		}

		/**
		 * 
		 */
		public function ScrollBarBase(target : MovieClip, direction : String = "vertical")
		{
			super(target);

			_direction = direction;
			if(_direction == ScrollBarDirection.HORIZONTAL)
			{
				prop = "width";
				dir = "x";
			}
			else
			{
				prop = "height";
				dir = "y";
			}
		}

		override protected function initSkin() : void
		{
			super.initSkin();

			_skin.mouseEnabled = false;

			upArrow = getSkinPart("upArrow") || getSkinPart("leftArrow");
			downArrow = getSkinPart("downArrow") || getSkinPart("rightArrow");
			track = getSkinPart("track");
			thumb = getSkinPart("thumb");

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
				scaleThumb = thumb.target.scale9Grid != null;
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
				b ? upArrow.addEventListener(KafeEvent.BUTTON_DOWN, arrowPressHandler, false, 0, true) : upArrow.removeEventListener(KafeEvent.BUTTON_DOWN, arrowPressHandler);
			}
			if(downArrow)
			{
				b ? downArrow.addEventListener(KafeEvent.BUTTON_DOWN, arrowPressHandler, false, 0, true) : downArrow.removeEventListener(KafeEvent.BUTTON_DOWN, arrowPressHandler);
			}
			if(track)
			{
				b ? track.addEventListener(KafeEvent.BUTTON_DOWN, trackPressHandler, false, 0, true) : track.removeEventListener(KafeEvent.BUTTON_DOWN, trackPressHandler);
			}
			if(thumb)
			{
				b ? thumb.target.addEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler, false, 0, true) : thumb.target.removeEventListener(MouseEvent.MOUSE_DOWN, thumbPressHandler);
			}
		}

		protected function getSkinPart(key : String) : IButton
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


		protected function updateThumb() : void
		{
			if(!track || !thumb) return;

			var per : Number = _maxScrollPosition - _minScrollPosition + _pageSize;
			if(track.target[prop] <= _minThumbSize || _maxScrollPosition <= _minScrollPosition || (per == 0 || isNaN(per)))
			{
				if(scaleThumb) thumb.target[prop] = _minThumbSize;
				thumb.target.visible = false;
			}
			else
			{
				if(scaleThumb) thumb.target[prop] = Math.round(Math.max(_minThumbSize + 1, _pageSize / per * track.target[prop]));
				thumb.target[dir] = track.target[dir] + (track.target[prop] - thumb.target[prop]) * ((_scrollPosition - _minScrollPosition) / (_maxScrollPosition - _minScrollPosition));
				thumb.target.visible = enabled;
			}
		}

		protected function arrowPressHandler(event : KafeEvent) : void
		{
			if(event.currentTarget == upArrow)
			{
				setScrollPosition(_scrollPosition - _lineScrollSize);
			}
			else if(event.currentTarget == downArrow)
			{
				setScrollPosition(_scrollPosition + _lineScrollSize);
			}
		}

		protected function trackPressHandler(event : KafeEvent) : void
		{
			var mouse : Number = _direction == ScrollBarDirection.HORIZONTAL ? _skin.mouseX : _skin.mouseY;

			var mousePosition : Number = NumberHelper.map(mouse - track.target[dir], 0, track.target[prop], _minScrollPosition, _maxScrollPosition);

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

		protected function thumbPressHandler(event : MouseEvent) : void
		{
			inDrag = true;
			var mouse : Number = _direction == ScrollBarDirection.HORIZONTAL ? _skin.mouseX : _skin.mouseY;
			thumbScrollOffset = mouse - thumb.target[dir];
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
			var mouse : Number = _direction == ScrollBarDirection.HORIZONTAL ? _skin.mouseX : _skin.mouseY;
			var pos : Number = NumberHelper.constrain(mouse - track.target[dir] - thumbScrollOffset, 0, track.target[prop] - thumb.target[prop]);
			setScrollPosition(NumberHelper.map(pos, 0, track.target[prop] - thumb.target[prop], _minScrollPosition, _maxScrollPosition));
		}

		// ----------------------------------
		// public functions
		// ----------------------------------

		/**
		 * 
		 */
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

		/**
		 * 
		 */
		public function setScrollProperties(pageSize : Number, minScrollPosition : Number, maxScrollPosition : Number, pageScrollSize : Number = 0) : void
		{
			if(pageSize > 0)
			{
				_pageSize = pageSize;
			}
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

		/**
		 * @param size :	按照给定的大小重绘滚动条的各个元件
		 */
		public function setSkinSize(size : Number) : void
		{
			if(downArrow && upArrow)
			{
				upArrow.target[dir] = downArrow.target[dir] = 0;
				downArrow.target[dir] = Math.max(upArrow.target[prop], size - downArrow.target[prop]);
			}

			if(track)
			{
				if(downArrow && upArrow)
				{
					track.target[dir] = upArrow.target[prop];
					track.target[prop] = Math.max(0, size - (downArrow.target[prop] + upArrow.target[prop]));
				}
				else
				{
					track.target[dir] = 0;
					track.target[prop] = Math.max(0, size);
				}
			}

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

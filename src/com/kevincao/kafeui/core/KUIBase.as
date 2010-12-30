package com.kevincao.kafeui.core
{
	import com.kevincao.kafeui.events.KUIEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	[Event(name="draw", type="com.kevincao.kafeui.events.KUIEvent")]

	[Event(name="change", type="com.kevincao.kafeui.events.KUIEvent")]

	[Event(name="resize", type="com.kevincao.kafeui.events.KUIEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class KUIBase extends Sprite
	{

		protected var avatarWidth : Number;
		protected var avatarHeight : Number;

		protected var _x : Number;
		protected var _y : Number;

		protected var _width : Number = 0;
		protected var _height : Number = 0;

		protected var invalidateSizeFlag : Boolean;
		protected var invalidateChildrenFlag : Boolean;
		protected var invalidatePropFlag : Boolean;

		/**
		 * Sets/gets the width of the component.
		 */
		override public function set width(value : Number) : void
		{
			if(_width == value) return;
			_width = value;
			setSize(value, _height);
		}

		override public function get width() : Number
		{
			return _width;
		}

		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height(value : Number) : void
		{
			if(_height == value) return;
			_height = value;
			setSize(_width, value);
		}

		override public function get height() : Number
		{
			return _height;
		}

		/**
		 * Sets/gets the x of the component.
		 */
		override public function set x(value : Number) : void
		{
			if(_x == value) return;
			move(value, _y);
		}

		override public function get x() : Number
		{
			return (isNaN(_x)) ? super.x : _x;
		}

		/**
		 * Sets/gets the y of the component.
		 */
		override public function set y(value : Number) : void
		{
			if(_y == value) return;
			move(_x, value);
		}

		override public function get y() : Number
		{
			return (isNaN(_y)) ? super.y : _y;
		}

		/**
		 * 
		 */
		public function KUIBase()
		{
			init();
			invalidateAll();
		}

		protected function init() : void
		{
			var r : Number = rotation;
			rotation = 0;

			avatarWidth = Math.round(super.width);
			avatarHeight = Math.round(super.height);
			// default size
			if(avatarWidth == 0) avatarWidth = 200;
			if(avatarHeight == 0) avatarHeight = 200;
			setSize(avatarWidth, avatarHeight);

			move(super.x, super.y);

			rotation = r;
			
			scaleX = scaleY = 1;

			// remove avatar
			while(numChildren) removeChildAt(0);
		}

		protected function validateChildren() : void
		{
			invalidateChildrenFlag = false;
			dispatchEvent(new KUIEvent(KUIEvent.DRAW));
		}

		protected function validateSize() : void
		{
			invalidateSizeFlag = false;
			dispatchEvent(new KUIEvent(KUIEvent.RESIZE));
		}

		protected function validateProp() : void
		{
			invalidatePropFlag = false;
			dispatchEvent(new KUIEvent(KUIEvent.CHANGE));
		}

		protected function invalidateChildren() : void
		{
			invalidateChildrenFlag = true;
			invalidate();
		}

		protected function invalidateSize() : void
		{
			invalidateSizeFlag = true;
			invalidate();
		}

		protected function invalidateProp() : void
		{
			invalidatePropFlag = true;
			invalidate();
		}

		protected function invalidateAll() : void
		{
			invalidateChildren();
			invalidateSize();
			invalidateProp();
		}

		protected function invalidate() : void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate, false, 0, true);
		}

		protected function onInvalidate(event : Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}

		protected function draw() : void
		{
			if(invalidateChildrenFlag)
			{
				validateChildren();
			}
			if(invalidateSizeFlag)
			{
				validateSize();
			}
			if(invalidatePropFlag)
			{
				validateProp();
			}
		}


		// ----------------------------------
		// public functions
		// ----------------------------------


		/**
		 * Moves the component to the specified position.
		 * @param x: the x position to move the component
		 * @param y: the y position to move the component
		 */
		public function move(x : Number, y : Number) : void
		{
			_x = x;
			_y = y;
			super.x = Math.round(x);
			super.y = Math.round(y);
			dispatchEvent(new KUIEvent(KUIEvent.MOVE));
		}

		/**
		 * Sets the size of the component.
		 * @param width: The width of the component.
		 * @param height: The height of the component.
		 */
		public function setSize(width : Number, height : Number) : void
		{
			_width = width;
			_height = height;
			invalidateSize();
		}

		/**
		 * 
		 */
		public function validateNow() : void
		{
			invalidateAll();
			drawNow();
		}

		/**
		 * 
		 */
		public function drawNow() : void
		{
			onInvalidate(null);
		}

		/**
		 * Abstract destroy function.
		 */
		public function destroy() : void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
		}
	}
}

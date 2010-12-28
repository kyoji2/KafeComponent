package com.kevincao.kafeui.core
{
	import com.kevincao.kafeui.events.KUIEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;


	[Event(name="draw", type="com.kevincao.kafe.events.KafeEvent")]

	[Event(name="resize", type="com.kevincao.kafe.events.KafeEvent")]

	/**
	 * KafeUI
	 * 可视化组件
	 * @author Kevin Cao
	 */
	public class KUIBase extends Sprite
	{

		protected var avatarWidth : Number;
		protected var avatarHeight : Number;

		protected var _width : Number = 0;
		protected var _height : Number = 0;

		protected var invalidateDic : Dictionary;

		override public function set width(w : Number) : void
		{
			_width = w;
			invalidateSize();
		}

		override public function get width() : Number
		{
			return _width;
		}

		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height(h : Number) : void
		{
			_height = h;
			invalidateSize();
		}

		override public function get height() : Number
		{
			return _height;
		}

		/**
		 * Overrides the setter for x to always place the component on a whole pixel.
		 */
		override public function set x(value : Number) : void
		{
			super.x = Math.round(value);
		}

		/**
		 * Overrides the setter for y to always place the component on a whole pixel.
		 */
		override public function set y(value : Number) : void
		{
			super.y = Math.round(value);
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
			invalidateDic = new Dictionary(true);
			_width = avatarWidth = Math.round(super.width);
			_height = avatarHeight = Math.round(super.height);
			// default size
			if(_width == 0) _width = 200;
			if(_height == 0) _height = 200;
			scaleX = scaleY = 1;
			rotation = 0;
			x = Math.round(x);
			y = Math.round(y);
			// remove avatar
			if(numChildren) removeChildAt(0);
		}

		/**
		 * override
		 */
		protected function addChildren() : void
		{
		}

		/**
		 * override
		 */
		protected function removeChildren() : void
		{
		}

		protected function validateChildren() : void
		{
			removeChildren();
			addChildren();
			delete invalidateDic["children"];
			dispatchEvent(new KUIEvent(KUIEvent.CREATE));
		}

		protected function validateSize() : void
		{
			delete invalidateDic["size"];
			dispatchEvent(new KUIEvent(KUIEvent.RESIZE));
		}

		protected function validateProp() : void
		{
			delete invalidateDic["prop"];
			dispatchEvent(new KUIEvent(KUIEvent.CHANGE));
		}

		protected function invalidateChildren() : void
		{
			if(!invalidateDic["children"])
			{
				invalidateDic["children"] = validateChildren;
				invalidate();
			}
		}

		protected function invalidateSize() : void
		{
			if(!invalidateDic["size"])
			{
				invalidateDic["size"] = validateSize;
				invalidate();
			}
		}

		protected function invalidateProp() : void
		{
			if(!invalidateDic["prop"])
			{
				invalidateDic["prop"] = validateProp;
				invalidate();
			}
		}

		protected function invalidateAll() : void
		{
			invalidateChildren();
			invalidateProp();
			invalidateSize();
			invalidate();
		}

		protected function invalidate() : void
		{
			addEventListener(Event.ENTER_FRAME, onInvalidate);
		}

		protected function onInvalidate(event : Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}


		// ----------------------------------
		// public functions
		// ----------------------------------


		/**
		 * Moves the component to the specified position.
		 * @param xpos the x position to move the component
		 * @param ypos the y position to move the component
		 */
		public function move(xpos : Number, ypos : Number) : void
		{
			x = Math.round(xpos);
			y = Math.round(ypos);
		}

		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		public function setSize(w : Number, h : Number) : void
		{
			_width = w;
			_height = h;
			invalidateSize();
		}

		/**
		 * Abstract draw function.
		 */
		public function draw() : void
		{
			for(var key : String in invalidateDic)
			{
				invalidateDic[key].call();
			}
			dispatchEvent(new KUIEvent(KUIEvent.DRAW));
		}

		/**
		 * Abstract destroy function.
		 */
		public function destroy() : void
		{
			invalidateDic = null;
		}
	}
}

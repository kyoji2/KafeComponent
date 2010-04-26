package com.kevincao.kafeui.core 
{
	import com.kevincao.kafe.events.KafeEvent;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	/**
	 * KafeUI
	 * 可视化组件
	 * @author Kevin Cao
	 */
	public class KafeUIBase extends Sprite 
	{

		protected var avatarWidth : Number;
		protected var avatarHeight : Number;

		protected var _width : Number = 0;
		protected var _height : Number = 0;

		protected var previewInfo : TextField;

		override public function set width(w : Number) : void
		{
			_width = w;
			invalidate();
			dispatchEvent(new KafeEvent(KafeEvent.RESIZE));
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
			invalidate();
			dispatchEvent(new KafeEvent(KafeEvent.RESIZE));
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
		public function KafeUIBase()
		{
			init();
			invalidate();
		}

		protected function init() : void
		{
			width = avatarWidth = Math.round(super.width);
			height = avatarHeight = Math.round(super.height);
			if(width == 0) width = 200;			if(height == 0) height = 200;
			scaleX = scaleY = 1;
			rotation = 0;
			x = Math.round(x);
			y = Math.round(y);
			if(numChildren) removeChildAt(0);
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

		protected function getDisplayObjectInstance(key : Object) : DisplayObject 
		{
			var classDef : Object = null;
			if (key is Class) { 
				return (new key()) as DisplayObject; 
			} else if (key is DisplayObject) {
				(key as DisplayObject).x = 0;
				(key as DisplayObject).y = 0;
				return key as DisplayObject;
			}
			
			try 
			{
				classDef = getDefinitionByName(key.toString());
			} catch(e : Error) 
			{
				try 
				{
					classDef = loaderInfo.applicationDomain.getDefinition(key.toString()) as Object;
				} catch (e : Error) 
				{
					// Nothing
				}
			}
			
			if (classDef == null) {
				return null;
			}
			return (new classDef()) as DisplayObject;
		}

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
			invalidate();
		}

		/**
		 * Abstract draw function.
		 */
		public function draw() : void
		{
			dispatchEvent(new KafeEvent(KafeEvent.DRAW));
		}
	}
}

package com.kevincao.kafe.core 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Kevin Cao
	 */
	public class KafeBase extends EventDispatcher
	{

		protected var _skin : MovieClip;
		protected var _enabled : Boolean = true;

		public function get enabled() : Boolean 
		{
			return _enabled;
		}

		public function set enabled(value : Boolean) : void 
		{
			_enabled = value;
		}

		public function get skin() : MovieClip 
		{
			return _skin;
		}

		//----------------------------------
		//  proxy properties
		//----------------------------------

		public function get x() : Number 
		{
			return skin.x;
		}

		public function set x(value : Number) : void 
		{
			skin.x = value;
		}

		public function get y() : Number 
		{
			return skin.y;
		}

		public function set y(value : Number) : void 
		{
			skin.y = value;
		}

		public function get width() : Number 
		{
			return skin.width;
		}

		public function set width(value : Number) : void 
		{
			skin.width = value;
		}

		public function get height() : Number 
		{
			return skin.height;
		}

		public function set height(value : Number) : void 
		{
			skin.height = value;
		}

		public function get scaleX() : Number 
		{
			return skin.scaleX;
		}

		public function set scaleX(value : Number) : void 
		{
			skin.scaleX = value;
		}

		public function get scaleY() : Number 
		{
			return skin.scaleY;
		}

		public function set scaleY(value : Number) : void 
		{
			skin.scaleY = value;
		}

		public function get rotation() : Number 
		{
			return skin.rotation;
		}

		public function set rotation(value : Number) : void 
		{
			skin.rotation = value;
		}

		public function get mouseX() : Number 
		{
			return skin.mouseX;
		}

		public function get mouseY() : Number 
		{
			return skin.mouseY;
		}

		public function get alpha() : Number 
		{
			return skin.alpha;
		}

		public function set alpha(value : Number) : void 
		{
			skin.alpha = value;
		}

		public function get visible() : Boolean 
		{
			return skin.visible;
		}

		public function set visible(value : Boolean) : void 
		{
			skin.visible = value;
		}

		/**
		 * @param skin	可以是场景上的实例名，也可以是类的名称。
		 */
		public function KafeBase(skin : Object)
		{
			_skin = getMovieClip(skin);
			
			initSkin();
		}

		/**
		 * 子类覆盖自己的初始化方法
		 */
		protected function initSkin() : void 
		{
			var hitArea : Sprite = Sprite(_skin.getChildByName("_hit"));
			if(hitArea) {
				_skin.hitArea = hitArea;
				hitArea.visible = false;
				hitArea.mouseEnabled = false;
			}
			setupEventListeners(true);
		}

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b) {
				_skin.addEventListener(MouseEvent.MOUSE_DOWN, dispatchEvent, false, 0, true);
				_skin.addEventListener(MouseEvent.MOUSE_UP, dispatchEvent, false, 0, true);
				_skin.addEventListener(MouseEvent.ROLL_OVER, dispatchEvent, false, 0, true);
				_skin.addEventListener(MouseEvent.ROLL_OUT, dispatchEvent, false, 0, true);
				_skin.addEventListener(MouseEvent.CLICK, dispatchEvent, false, 0, true);
			} else {
				_skin.removeEventListener(MouseEvent.MOUSE_DOWN, dispatchEvent);
				_skin.removeEventListener(MouseEvent.MOUSE_UP, dispatchEvent);
				_skin.removeEventListener(MouseEvent.ROLL_OVER, dispatchEvent);
				_skin.removeEventListener(MouseEvent.ROLL_OUT, dispatchEvent);
				_skin.removeEventListener(MouseEvent.CLICK, dispatchEvent);
			}
		}

		protected function getMovieClip(key : Object) : MovieClip 
		{
			var classDef : Object = null;
			if (key is Class) { 
				return (new key()) as MovieClip; 
			} else if (key is MovieClip) {
				return key as MovieClip;
			}
			
			try 
			{
				classDef = getDefinitionByName(key.toString());
			} catch(e : Error) 
			{
			}
			
			if (classDef == null) {
				return null;
			}
			return (new classDef()) as MovieClip;
		}

		protected function getClassName() : String 
		{
			return getQualifiedClassName(this).split("::")[1];
		}

		public function destroy() : void 
		{
			setupEventListeners(false);
			if(_skin.parent) {
				_skin.parent.removeChild(_skin);
			}
			_skin = null;
		}
	}
}

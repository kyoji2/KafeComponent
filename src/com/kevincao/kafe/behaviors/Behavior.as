package com.kevincao.kafe.behaviors
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Kevin Cao
	 */
	public class Behavior extends EventDispatcher implements IBehavior
	{

		protected var _skin : MovieClip;
		protected var _enabled : Boolean = true;

		// ----------------------------------
		// getters and setters
		// ----------------------------------

		public function get enabled() : Boolean
		{
			return _enabled;
		}

		public function set enabled(value : Boolean) : void
		{
			if(_enabled == value) return;

			_enabled = value;

			invalidate();
		}


		public function get skin() : MovieClip
		{
			return _skin;
		}

		public function set skin(skin : MovieClip) : void
		{
			if(_skin)
			{
				destroy();
			}

			_skin = skin;

			initSkin();

			invalidate();
		}


		/**
		 * @param skin	MovieClip, String or Class
		 * 				可以是场景上的实例名，也可以是类的名称。
		 */
		public function Behavior(skin : MovieClip)
		{
			this.skin = skin;
			
			enabled = true;
		}

		/**
		 * override
		 * 初始化skin
		 */
		protected function initSkin() : void
		{
			var hitArea : Sprite = Sprite(_skin.getChildByName("_hit"));
			if(hitArea)
			{
				_skin.hitArea = hitArea;
				hitArea.visible = false;
				hitArea.mouseEnabled = false;
			}
		}

		/**
		 * override
		 */
		protected function draw() : void
		{
		}

		protected function onInvalidate(event : Event) : void
		{
			drawNow();
		}

		// ----------------------------------
		// public functions
		// ----------------------------------
		
		/**
		 * 下一帧重绘
		 */
		public function invalidate() : void
		{
			_skin.addEventListener(Event.ENTER_FRAME, onInvalidate, false, 0, true);
		}

		/**
		 * 立即重绘，无需等待下一帧
		 */
		public function drawNow() : void
		{
			_skin.removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
		}

		public function destroy() : void
		{
			_skin.removeEventListener(Event.ENTER_FRAME, onInvalidate);
			_skin = null;
		}
	}
}

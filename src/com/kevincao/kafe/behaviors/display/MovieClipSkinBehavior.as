package com.kevincao.kafe.behaviors.display
{
	import com.kevincao.kafe.behaviors.AbstractBehavior;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Kevin Cao
	 */
	public class MovieClipSkinBehavior extends AbstractBehavior
	{
		protected var _skin : MovieClip;

		public function get skin() : MovieClip
		{
			return _skin;
		}

		/**
		 * @param target :	MovieClip
		 */
		public function MovieClipSkinBehavior(target : MovieClip)
		{
			super(target);

			if(!(target is MovieClip))
			{
				throw new Error(this + " :: target must be MovieClip.");
			}

			_skin = MovieClip(_target);

			initSkin();

			invalidate();
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
			_skin.removeEventListener(Event.ENTER_FRAME, onInvalidate);
			draw();
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
			onInvalidate(null);
		}


		// ----------------------------------
		// destroy
		// ----------------------------------

		override public function destroy() : void
		{
			_skin.removeEventListener(Event.ENTER_FRAME, onInvalidate);
			_skin = null;

			super.destroy();
		}
	}
}

package com.kevincao.kafe 
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author Kevin Cao
	 */
	public class EasyButton extends ButtonBase 
	{

		private var upFrame : int;
		private var normalFrame : int;		private var downFrame : int;		private var disabledFrame : int;

		override public function set enabled(value : Boolean) : void 
		{
			super.enabled = value;
			updateState();
		}

		/**
		 * 
		 */
		public function EasyButton(skin : Object)
		{
			super(skin);
		}

		override protected function initSkin() : void 
		{
			super.initSkin();
			
			normalFrame = 1;
			downFrame = getFrame(_skin, "down");
			upFrame = downFrame - 1;
			disabledFrame = getFrame(_skin, "disabled");
			
			if(downFrame == -1 || disabledFrame == -1) {
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}
		}

		protected function updateState() : void 
		{
			if(enabled) {
				_skin.gotoAndStop(normalFrame);
				_skin.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			} else {
				_skin.gotoAndStop(disabledFrame);
				_skin.removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndStop(downFrame);
		}

		override protected function mouseUpHandler(event : MouseEvent) : void
		{
			super.mouseUpHandler(event);
			if(_isRollOver) {
				_skin.gotoAndStop(upFrame);
			} else {
				_skin.gotoAndStop(normalFrame);
			}
		}

		private function tick(event : Event) : void
		{
			if(!_isMouseDown) {
				if(_isRollOver) {
					if(_skin.currentFrame < upFrame) {
						_skin.nextFrame();
					}
				} else {
					if(_skin.currentFrame > normalFrame) {
						_skin.prevFrame();
					}
				}
			}
		}

		override public function destroy() : void 
		{
			_skin.removeEventListener(Event.ENTER_FRAME, tick);
			super.destroy();
		}
	}
}

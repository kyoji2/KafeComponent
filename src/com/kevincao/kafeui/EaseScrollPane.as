package com.kevincao.kafeui 
{
	import com.kevincao.kafe.events.ScrollEvent;
	import com.kevincao.kafeui.KafeScrollPane;

	import flash.events.Event;

	[IconFile("../../../../footage/EaseScrollPane.png")]

	/**
	 * @author Kevin Cao
	 */
	public class EaseScrollPane extends KafeScrollPane 
	{

		private var tx : Number = 0;
		private var ty : Number = 0;

		[Inspectable(defaultValue=0.25, type="Number")]
		public var ease : Number = 0.25;

		/**
		 * 
		 */
		public function EaseScrollPane() 
		{
			super();
		}

		override protected function init() : void
		{
			super.init();
		}

		override public function draw() : void
		{
			super.draw();
			
			if(source == null || source == "") return;
			sourceInstance.x = hScrollBar ? tx : 0;
			sourceInstance.y = vScrollBar ? ty : 0;
			tx = ty = 0;
			if(sourceInstance.height - height > 0 || sourceInstance.width - width > 0) {
				addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			} else {
				removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		private function tick(event : Event) : void
		{
			var dx : Number = tx - sourceInstance.x;
			var dy : Number = ty - sourceInstance.y;
			if(Math.abs(dx) < 0.1) {
				sourceInstance.x = tx;
			} else {
				sourceInstance.x += (tx - sourceInstance.x) * ease;
			}
			if(Math.abs(dy) < 0.1) {
				sourceInstance.y = ty;
			} else {
				sourceInstance.y += (ty - sourceInstance.y) * ease;
			}
			if(_roundProp) {
				sourceInstance.x = Math.round(sourceInstance.x);				sourceInstance.y = Math.round(sourceInstance.y);
			}
		}

		override protected function vScrollHandler(event : ScrollEvent) : void
		{
			ty = -event.position;
		}

		override protected function hScrollHandler(event : ScrollEvent) : void
		{
			tx = -event.position;
		}

		override public function destroy() : void
		{
			removeEventListener(Event.ENTER_FRAME, tick);
			super.destroy();
		}
	}
}

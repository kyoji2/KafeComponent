package com.kevincao.kafeui
{
	import com.kevincao.kafe.events.ScrollEvent;
	import com.kevincao.kafe.utils.NumberHelper;

	import flash.events.Event;

	[IconFile("KUIEaseScrollPane.png")]

	/**
	 * @author Kevin Cao
	 */
	public class KUIEaseScrollPane extends KUIScrollPane
	{

		private var tx : Number = 0;
		private var ty : Number = 0;

		[Inspectable(defaultValue=0.25, type="Number")]
		public var ease : Number = 0.25;

		/**
		 * 
		 */
		public function KUIEaseScrollPane()
		{
			super();
		}

		// ----------------------------------
		// override method
		// ----------------------------------

		override protected function validateChildren() : void
		{
			super.validateChildren();

			tx = ty = 0;
		}

		override protected function validateSize() : void
		{
			super.validateSize();

			if((vScrollBar && vScrollBar.enabled) || (hScrollBar && hScrollBar.enabled))
			{
//				addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			}
			else
			{
				removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		// ----------------------------------
		// handlers
		// ----------------------------------

		private function tick(event : Event) : void
		{
			var dx : Number = tx - sourceInstance.x;
			var dy : Number = ty - sourceInstance.y;
			if(Math.abs(dx) < 0.1)
			{
				sourceInstance.x = tx;
			}
			else
			{
				sourceInstance.x += (tx - sourceInstance.x) * ease;
			}
			if(Math.abs(dy) < 0.1)
			{
				sourceInstance.y = ty;
			}
			else
			{
				sourceInstance.y += (ty - sourceInstance.y) * ease;
			}
			if(_roundProp)
			{
				sourceInstance.x = Math.round(sourceInstance.x);
				sourceInstance.y = Math.round(sourceInstance.y);
			}
			if(sourceInstance.x == tx && sourceInstance.y == ty)
			{
				removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		override protected function vScrollHandler(event : ScrollEvent) : void
		{
			ty = -event.position;
			_vScrollPosition = NumberHelper.normalize(event.position, vScrollBar.minScrollPosition, vScrollBar.maxScrollPosition);
			
			addEventListener(Event.ENTER_FRAME, tick);
			
			dispatchEvent(event);
		}

		override protected function hScrollHandler(event : ScrollEvent) : void
		{
			tx = -event.position;
			_hScrollPosition = NumberHelper.normalize(event.position, hScrollBar.minScrollPosition, hScrollBar.maxScrollPosition);
			
			addEventListener(Event.ENTER_FRAME, tick);
			
			dispatchEvent(event);
		}

		// ----------------------------------
		// destroy
		// ----------------------------------

		override public function destroy() : void
		{
			removeEventListener(Event.ENTER_FRAME, tick);
			super.destroy();
		}
	}
}

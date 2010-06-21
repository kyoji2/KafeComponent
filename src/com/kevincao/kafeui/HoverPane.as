package com.kevincao.kafeui 
{
	import com.kevincao.kafe.utils.NumberHelper;
	import com.kevincao.kafe.utils.getDisplayObjectInstance;
	import com.kevincao.kafeui.core.KafeUIBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[IconFile("HoverPane.png")]

	/**
	 * @author Kevin Cao
	 */
	public class HoverPane extends KafeUIBase 
	{

		protected var canvas : Sprite;
		protected var sourceInstance : DisplayObject;

		private var isRollOver : Boolean;
		private var tx : Number = 0;
		private var ty : Number = 0;

		private var _source : Object;
		private var _edgeRange : Number = 0.1;

		[Inspectable(defaultValue=0.2)]
		public var ease : Number = 0.2;

		/**
		 * 鼠标距离边缘还有多少的时候内容已经移动到极值
		 * 如果为0。1，表示鼠标距离边缘还有10%距离
		 * 0-0.5
		 */
		[Inspectable(defaultValue=0.1)]

		public function get edgeRange() : Number
		{
			return _edgeRange;
		}

		public function set edgeRange(value : Number) : void
		{
			_edgeRange = NumberHelper.constrain(value, 0, 0.5);
		}

		[Inspectable(defaultValue="", type="String")]

		public function get source() : Object 
		{
			return _source;
		}

		public function set source(value : Object) : void 
		{
			if(_source == value) return;
			
			_source = value;
			invalidateAll();
		}

		/**
		 * 
		 */
		public function HoverPane()
		{
			super();
		}

		override protected function addChildren() : void
		{
			if(source == null || source == "") return;			
			
			sourceInstance = getDisplayObjectInstance(_source);
			sourceInstance.x = tx;
			sourceInstance.y = ty;
			tx = ty = 0;
			
			canvas = new Sprite();
			addChild(canvas);
			canvas.scrollRect = new Rectangle(0, 0, width, height);
			canvas.addChild(sourceInstance);
		}

		
		override protected function removeChildren() : void 
		{
			if(canvas) 
			{
				if(canvas.parent) 
				{
					canvas.parent.removeChild(canvas);
				}
				if(sourceInstance) 
				{
					canvas.removeChild(sourceInstance);
				}
			}
		}

		
		override protected function validateSize() : void 
		{
			if(sourceInstance) 
			{
				if(width < sourceInstance.width || height < sourceInstance.height) 
				{
					setupEventListeners(true);
				} 
				else 
				{
					setupEventListeners(false);
				}
			}
			
			super.validateSize();
		}

		//----------------------------------
		//  handlers
		//----------------------------------

		private function rollOverHandler(event : MouseEvent) : void
		{
			isRollOver = true;
		}

		private function rollOutHandler(event : MouseEvent) : void
		{
			isRollOver = false;
		}

		protected function tick(event : Event) : void 
		{
			var mx : Number = width - sourceInstance.width;
			var my : Number = height - sourceInstance.height;
			
			if(isRollOver) 
			{
				tx = NumberHelper.map(mouseX, width * edgeRange, width * (1 - edgeRange), 0, mx);				ty = NumberHelper.map(mouseY, height * edgeRange, height * (1 - edgeRange), 0, my);
			}
			
			if(mx < 0) 
			{
				sourceInstance.x += (tx - sourceInstance.x) * ease;
				sourceInstance.x = NumberHelper.constrain(sourceInstance.x, 0, mx);
			}
			
			if(my < 0) 
			{
				sourceInstance.y += (ty - sourceInstance.y) * ease;
				sourceInstance.y = NumberHelper.constrain(sourceInstance.y, 0, my);
			}
		}

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b) 
			{
				canvas.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
				canvas.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
				canvas.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			} 
			else 
			{
				canvas.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				canvas.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				canvas.removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		//----------------------------------
		//  destroy
		//----------------------------------

		override public function destroy() : void
		{
			setupEventListeners(false);
			canvas = null;
			_source = null;
			sourceInstance = null;
			super.destroy();
		}
	}
}

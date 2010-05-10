package com.kevincao.kafeui 
{
	import com.kevincao.kafeui.core.KafeUIBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[IconFile("../../../../footage/HoverPane.png")]

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
			_edgeRange = constrain(value, 0, 0.5);
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
			invalidate();
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
			super.addChildren();
			
			canvas = new Sprite();
			addChild(canvas);
		}

		private function rollOverHandler(event : MouseEvent) : void
		{
			isRollOver = true;
		}

		private function rollOutHandler(event : MouseEvent) : void
		{
			isRollOver = false;
		}

		override public function draw() : void
		{
			super.draw();
			
			if(source == null || source == "") return;
			
			sourceInstance = getDisplayObjectInstance(_source);
			sourceInstance.x = tx;
			sourceInstance.y = ty;
			tx = ty = 0;
			
			if(canvas.numChildren) canvas.removeChildAt(0);
			canvas.scrollRect = new Rectangle(0, 0, width, height);
			canvas.addChild(sourceInstance);
			
			if(width < sourceInstance.width || height < sourceInstance.height) {
				setupEventListeners(true);
			} else {
				setupEventListeners(false);
			}
		}

		protected function tick(event : Event) : void 
		{
			var mx : Number = width - sourceInstance.width;
			var my : Number = height - sourceInstance.height;
			
			if(isRollOver) {
				tx = map(mouseX, width * edgeRange, width * (1 - edgeRange), 0, mx);				ty = map(mouseY, height * edgeRange, height * (1 - edgeRange), 0, my);
			}
			
			if(mx < 0) {
				sourceInstance.x += (tx - sourceInstance.x) * ease;
				sourceInstance.x = constrain(sourceInstance.x, 0, mx);
			}
			
			if(my < 0) {
				sourceInstance.y += (ty - sourceInstance.y) * ease;
				sourceInstance.y = constrain(sourceInstance.y, 0, my);
			}
		}

		private function setupEventListeners(b : Boolean = true) : void
		{
			if(b) {
				canvas.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
				canvas.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
				canvas.addEventListener(Event.ENTER_FRAME, tick, false, 0, true);
			} else {
				canvas.removeEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
				canvas.removeEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
				canvas.removeEventListener(Event.ENTER_FRAME, tick);
			}
		}

		private function constrain(value : Number, firstValue : Number, secondValue : Number) : Number 
		{
			return Math.min(Math.max(value, Math.min(firstValue, secondValue)), Math.max(firstValue, secondValue));
		}

		private function map(value : Number, fromMin : Number, fromMax : Number, toMin : Number, toMax : Number) : Number 
		{
			return toMin + (toMax - toMin) * (value - fromMin) / (fromMax - fromMin);
		}

		public function destroy() : void
		{
			setupEventListeners(false);
		}
	}
}

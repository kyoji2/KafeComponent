package com.kevincao.kafeui
{
	import com.kevincao.kafe.utils.NumberHelper;
	import com.kevincao.kafe.utils.getDisplayObjectInstance;
	import com.kevincao.kafeui.core.KUIBase;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[IconFile("KUIHoverPane.png")]

	/**
	 * @author Kevin Cao
	 */
	public class KUIHoverPane extends KUIBase
	{

		protected var canvas : Sprite;
		protected var sourceInstance : DisplayObject;

		protected var isRollOver : Boolean;
		protected var tx : Number = 0;
		protected var ty : Number = 0;

		protected var _source : Object;
		protected var _edgeRange : Number = 0.1;

		protected var _hScrollPosition : Number = 0;
		protected var _vScrollPosition : Number = 0;

		protected var _roundProp : Boolean = true;

		[Inspectable(defaultValue=0.2)]
		public var ease : Number = 0.2;

		/**
		 * 鼠标距离边缘还有多少的时候内容已经移动到极值
		 * 如果为0.1，表示鼠标距离边缘还有10%距离
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

		[Inspectable(defaultValue="0", type="Number")]

		/**
		 * 
		 * @return	0~1
		 */
		public function get vScrollPosition() : Number
		{
			return _vScrollPosition;
		}

		/**
		 * 
		 * @param value:	0~1
		 */
		public function set vScrollPosition(value : Number) : void
		{
			if(_vScrollPosition == value)
				return;

			_vScrollPosition = value;
			invalidateProp();

		}


		[Inspectable(defaultValue="0", type="Number")]

		/**
		 * 
		 * @return	0~1
		 */
		public function get hScrollPosition() : Number
		{
			return _hScrollPosition;
		}

		/**
		 * 
		 * @param value:	0~1
		 */
		public function set hScrollPosition(value : Number) : void
		{
			if(_hScrollPosition == value)
				return;

			_hScrollPosition = value;
			invalidateProp();
		}

		[Inspectable(defaultValue=true)]

		public function get roundProp() : Boolean
		{
			return _roundProp;
		}

		public function set roundProp(value : Boolean) : void
		{
			_roundProp = value;
		}

		/**
		 * 
		 */
		public function KUIHoverPane()
		{
			super();
		}


		// ----------------------------------
		// override method
		// ----------------------------------

		override protected function init() : void
		{
			super.init();

			canvas = new Sprite();
			addChild(canvas);
		}

		override protected function validateChildren() : void
		{
			if(source == null || source == "") return;

			if(sourceInstance)
			{
				canvas.removeChild(sourceInstance);
			}

			sourceInstance = getDisplayObjectInstance(_source);
			if(!sourceInstance)
			{
				throw new Error(this + " :: can't find source!");
			}
			sourceInstance.x = tx;
			sourceInstance.y = ty;
			tx = ty = 0;

			canvas.scrollRect = new Rectangle(0, 0, width, height);
			canvas.addChild(sourceInstance);

			invalidateSizeFlag = true;
			invalidatePropFlag = true;

			super.validateChildren();
		}

		override protected function validateSize() : void
		{
			canvas.scrollRect = new Rectangle(0, 0, width, height);
			canvas.graphics.clear();
			canvas.graphics.beginFill(0, 0);
			canvas.graphics.drawRect(0, 0, width, height);
			canvas.graphics.endFill();

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


		override protected function validateProp() : void
		{
			if(sourceInstance)
			{
				if(width < sourceInstance.width)
				{
					tx = NumberHelper.interpolate(_hScrollPosition, 0, width - sourceInstance.width);
				}
				if(height < sourceInstance.height)
				{
					ty = NumberHelper.interpolate(_vScrollPosition, 0, height - sourceInstance.height);
				}
			}

			super.validateProp();
		}


		// ----------------------------------
		// handlers
		// ----------------------------------

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
				tx = NumberHelper.map(mouseX, width * edgeRange, width * (1 - edgeRange), 0, mx);
				ty = NumberHelper.map(mouseY, height * edgeRange, height * (1 - edgeRange), 0, my);
				_hScrollPosition = NumberHelper.normalize(tx, 0, width - sourceInstance.width);
				_vScrollPosition = NumberHelper.normalize(ty, 0, height - sourceInstance.height);
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

			if(_roundProp)
			{
				sourceInstance.x = Math.round(sourceInstance.x);
				sourceInstance.y = Math.round(sourceInstance.y);
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


		// ----------------------------------
		// destroy
		// ----------------------------------

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

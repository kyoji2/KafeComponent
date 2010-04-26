package com.kevincao.kafeui 
{
	import com.kevincao.kafe.VScrollBar;
	import com.kevincao.kafe.events.ScrollEvent;
	import com.kevincao.kafeui.core.KafeUIBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	[IconFile("../../../../footage/KafeScrollPane.png")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeScrollPane extends KafeUIBase 
	{

		public static const AUTO : String = "auto";
		public static const ALWAYS : String = "always";		public static const HIDE : String = "hide";

		protected var vScrollBar : VScrollBar;		protected var hScrollBar : VScrollBar;

		protected var canvas : Sprite;
		protected var sourceInstance : DisplayObject;

		protected var _scrollBar : Object;
		protected var _source : Object;
		protected var _horizontal : String = AUTO;
		protected var _vertical : String = AUTO;
		protected var _roundProp : Boolean = true;

		[Inspectable(defaultValue="ScrollBarSkin", type="String")]

		public function get scrollBar() : Object 
		{
			return _scrollBar;
		}

		public function set scrollBar(value : Object) : void 
		{
			if(_scrollBar == value) return;
			_scrollBar = value;
			invalidate();
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

		[Inspectable(defaultValue="auto", type="List", enumeration="auto,always,hide")]

		public function get horizontal() : String 
		{
			return _horizontal;
		}

		public function set horizontal(value : String) : void 
		{
			_horizontal = value;
			invalidate();
		}

		[Inspectable(defaultValue="auto", type="List", enumeration="auto,always,hide")]

		public function get vertical() : String 
		{
			return _vertical;
		}

		public function set vertical(value : String) : void 
		{
			_vertical = value;
			invalidate();
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
		public function KafeScrollPane()
		{
			super();
		}

		override public function draw() : void
		{
			destroyAssets();
			
			if(_source == null || _source == "") return;
			sourceInstance = getDisplayObjectInstance(_source);
			sourceInstance.x = sourceInstance.y = 0;
			
			initCanvas();
			canvas.addChild(sourceInstance);
			
			if(_vertical == ALWAYS || (_vertical == AUTO && sourceInstance.height - height > 0)) {
				vScrollBar = new VScrollBar(getScrollBarSkin(_scrollBar));
				vScrollBar.size = height;
				vScrollBar.x = width;
				vScrollBar.setScrollProperties(height, 0, sourceInstance.height - height);
				vScrollBar.lineScrollSize = height * 0.1;
				vScrollBar.addEventListener(ScrollEvent.SCROLL, vScrollHandler, false, 0, true);
				vScrollBar.setScrollPosition(0);
				addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
				addChild(vScrollBar.skin);
			}
			
			if(_horizontal == ALWAYS || (_horizontal == AUTO && sourceInstance.width - width > 0)) {
				hScrollBar = new VScrollBar(getScrollBarSkin(_scrollBar));
				hScrollBar.size = width;
				hScrollBar.y = height;
				//rotate
				hScrollBar.rotation = 90;
				hScrollBar.scaleY = -1;
				hScrollBar.setScrollProperties(width, 0, sourceInstance.width - width);
				hScrollBar.lineScrollSize = width * 0.1;
				hScrollBar.addEventListener(ScrollEvent.SCROLL, hScrollHandler, false, 0, true);
				hScrollBar.setScrollPosition(0);
				addChild(hScrollBar.skin);
			}
			
			super.draw();
		}

		protected function destroyAssets() : void 
		{
			if(canvas) {
				removeChild(canvas);
				if(canvas.numChildren) canvas.removeChildAt(0);
			}
			
			if(vScrollBar) {
				removeChild(vScrollBar.skin);
				vScrollBar.removeEventListener(ScrollEvent.SCROLL, vScrollHandler);
				removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
				vScrollBar.destroy();
				vScrollBar = null;
			}
			if(hScrollBar) {
				removeChild(hScrollBar.skin);
				hScrollBar.removeEventListener(ScrollEvent.SCROLL, hScrollHandler);
				hScrollBar.destroy();
				hScrollBar = null;
			}
		}

		protected function initCanvas() : void 
		{
			canvas = new Sprite();
			canvas.scrollRect = new Rectangle(0, 0, width, height);
			canvas.graphics.beginFill(0, 0);
			canvas.graphics.drawRect(0, 0, width, height);
			canvas.graphics.endFill();
			addChild(canvas);
		}

		
		protected function mouseWheelHandler(event : MouseEvent) : void 
		{
			vScrollBar.setScrollPosition(vScrollBar.scrollPosition + (event.delta > 0 ? -1 : 1) * vScrollBar.lineScrollSize);
		}

		protected function vScrollHandler(event : ScrollEvent) : void
		{
			sourceInstance.y = _roundProp ? Math.round(-event.position) : -event.position;
		}

		protected function hScrollHandler(event : ScrollEvent) : void
		{
			sourceInstance.x = _roundProp ? Math.round(-event.position) : -event.position;
		}

		protected function getScrollBarSkin(key : Object) : MovieClip 
		{
			if(key is DisplayObject) {
				var c : Class = Class(getDefinitionByName(getQualifiedClassName(key)));
				return MovieClip(new c());
			} else {
				return MovieClip(super.getDisplayObjectInstance(key));
			}
		}

		public function destroy() : void 
		{
			destroyAssets();
			_scrollBar = null;
			_source = null;
			sourceInstance = null;
		}
	}
}

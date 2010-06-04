package com.kevincao.kafeui 
{
	import com.kevincao.kafeui.core.KafeUIBase;

	import flash.display.DisplayObject;
	import flash.geom.Rectangle;

	/**
	 * @author Kevin Cao
	 */
	public class LoopScrollPane extends KafeUIBase
	{
		static public const HORIZONTAL : String = "horizontal";
		static public const VERTICAL : String = "vertical";

		protected var _scroll : Number = 0;
		protected var _source : Object;

		protected var numTiles : Number;
		protected var tileSize : Number;

		protected var tiles : Array;
		protected var dir : String;
		protected var prop : String;

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

		[Inspectable(defaultValue=0, type="Number")]

		public function get scroll() : Number
		{
			return _scroll;
		}

		public function set scroll(distance : Number) : void 
		{
			_scroll = distance;
			
			tiles[0][dir] = _scroll % tileSize;
			
			for (var i : int = 1;i < numTiles;i++)
			{
				tiles[i][dir] = i * tileSize + tiles[0][dir];
			}
			
			if(tiles[0][dir] > 0) 
			{
				tiles[numTiles - 1][dir] = tiles[0][dir] - tileSize;
			}
		}

		public function LoopScrollPane(direction : String = "vertical") 
		{
			dir = direction == VERTICAL ? "y" : "x";
			prop = direction = VERTICAL ? "height" : "width";
			super();
		}

		override public function setSize(w : Number, h : Number) : void 
		{
			super.setSize(w, h);
			
			scrollRect = new Rectangle(0, 0, w, h);
			
			invalidateAll();
		}

		override protected function addChildren() : void 
		{
			var tile : DisplayObject = getDisplayObjectInstance(_source);
			
			tileSize = tile[prop];
			
			numTiles = Math.ceil(_width / tileSize) + 1;
			
//			trace('numTiles: ' + (numTiles));
			
			tiles[0] = tile;
			addChild(tile);
			
			for (var i : int = 1;i < numTiles;i++)
			{
				tiles[i] = tile = getDisplayObjectInstance(_source);
				tile[dir] = i * tileSize;
				addChild(tile);
			}
		}

		override protected function removeChildren() : void 
		{
			while(numChildren) 
			{
				removeChildAt(0);
			}
			tiles = [];
		}
	}
}

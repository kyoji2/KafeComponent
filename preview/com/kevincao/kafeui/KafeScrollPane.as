package com.kevincao.kafeui 
{

	/**
	 * @author Kevin Cao
	 */
	public class KafeScrollPane extends PanePreview 
	{

		protected var _source : Object;
		protected var _scrollBar : Object;

		public function get source() : Object
		{
			return _source;
		}

		public function set source(value : Object) : void
		{
			_source = value;
			draw();
		}

		public function get scrollBar() : Object
		{
			return _scrollBar;
		}

		public function set scrollBar(value : Object) : void
		{
			_scrollBar = value;
			draw();
		}

		public function KafeScrollPane() 
		{
			headerColor = 0x281208;
		}

		override public function draw() : void
		{
			super.draw();
			
			var str : String = "";
			
			if(_source) {
				str += "\n<span class='green'>source: " + _source + "</span>";
			} else {
				str += "\n<span class='red'>source: " + _source + "</span>";
			}
			
			if(_scrollBar) {
				str += "\n<span class='green'>scrollBar: " + _scrollBar + "</span>";
			} else {
				str += "\n<span class='red'>scrollBar: " + _scrollBar + "</span>";
			}
			
			previewInfo.htmlText += str;
		}
	}
}

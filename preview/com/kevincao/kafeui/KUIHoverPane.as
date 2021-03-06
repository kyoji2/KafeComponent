package com.kevincao.kafeui 
{
	import com.kevincao.kafeui.PanePreview;

	/**
	 * @author Kevin Cao
	 */
	public class KUIHoverPane extends PanePreview 
	{
		protected var _source : Object;

		public function get source() : Object
		{
			return _source;
		}

		public function set source(value : Object) : void
		{
			_source = value;
			draw();
		}
		
		public function KUIHoverPane()
		{
			headerColor = 0x222535;
		}
		
		override public function draw() : void
		{
			super.draw();
			
			var str : String;
			
			if(_source) {
				str = "\n<span class='green'>source: " + _source + "</span>";
			} else {
				str = "\n<span class='red'>source: " + _source + "</span>";
			}
			
			previewInfo.htmlText += str;
		}
	}
}

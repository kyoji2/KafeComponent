package com.kevincao.kafeui 
{
	import flash.text.StyleSheet;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Kevin Cao
	 */
	public class PanePreview extends Sprite 
	{

		protected var previewInfo : TextField;
		protected var header : String;		protected var lineColor : int = 0x999999;		protected var backgroundColor : int = 0xeeeeee;		protected var backgroundAlpha : Number = 0.7;		protected var headerColor : Number = 0x111111;

		protected var style : StyleSheet;

		public function PanePreview() 
		{
			previewInfo = new TextField();
			addChild(previewInfo);
			previewInfo.autoSize = TextFieldAutoSize.LEFT;
			previewInfo.selectable = false;
			previewInfo.multiline = true;
			previewInfo.embedFonts = true;
			previewInfo.defaultTextFormat = new TextFormat("PF Ronda Seven", 8, 0xdddddd);
			previewInfo.x = 6;
			previewInfo.y = 3;
			
			style = new StyleSheet();
			style.setStyle(".green", {color:"#90d030"});			style.setStyle(".red", {color:"#ff3333"});
			
			previewInfo.styleSheet = style;
			
			header = "[" + getQualifiedClassName(this).split("::")[1] + "]";
			previewInfo.text = header;
		}

		public function setSize(width : Number, height : Number) : void
		{
			drawPane(width, height);
		}

		public function draw() : void
		{
			previewInfo.htmlText = header;
		}

		protected function drawPane(width : Number, height : Number) : void
		{
			if(width < 60) width = 60;
			if(height < 60) height = 60;
			graphics.clear();
			graphics.lineStyle(1, lineColor, 1, true, LineScaleMode.NONE);
			graphics.beginFill(backgroundColor, backgroundAlpha);
			graphics.drawRect(0, 0, width, height);
			graphics.lineStyle(0);
			graphics.beginFill(headerColor);
			graphics.drawRect(3, 3, width - 6, 44);
			graphics.endFill();
		}
	}
}

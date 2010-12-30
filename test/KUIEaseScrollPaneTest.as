package  
{
	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.kevincao.kafeui.*;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	/**
	 * @author Kevin Cao
	 */

	public class KUIEaseScrollPaneTest extends Sprite 
	{
		private var esp : KUIEaseScrollPane;

		public function KUIEaseScrollPaneTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

//			esp = KUIEaseScrollPane(getChildByName("_esp"));
			
			esp = new KUIEaseScrollPane();
			esp.move(100, 100);
			esp.setSize(200, 200);
			esp.source = "content";
			esp.scrollBar = "SimpleScrollBarSkin";
			addChild(esp);
			
			var hbox : HBox = new HBox(this, 10, 10);
			new PushButton(hbox, 0, 0, "setSize", clickHandler);
			new PushButton(hbox, 0, 0, "source", clickHandler);
			new PushButton(hbox, 0, 0, "vscroll", clickHandler);
			new PushButton(hbox, 0, 0, "hscroll", clickHandler);
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			switch(event.target.label)
			{
				case "setSize":
					esp.setSize(120, 120);
					break;
				case "source":
					esp.source = "content2";
					break;
				case "vscroll":
					esp.vScrollPosition = .5;
					break;
				case "hscroll":
					esp.hScrollPosition = 1;
					break;
			}
		}
	}
}

package  
{
	import flash.events.MouseEvent;

	import com.bit101.components.PushButton;
	import com.bit101.components.HBox;
	import com.kevincao.kafeui.*;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author Kevin Cao
	 */

	public class KUIHoverPaneTest extends Sprite 
	{
		private var khp : KUIHoverPane;

		public function KUIHoverPaneTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
						khp = new KUIHoverPane();
			khp.move(100, 100);
			khp.setSize(200, 200);
			khp.source = "content";
			khp.hScrollPosition = .5;
			khp.vScrollPosition = .5;
			addChild(khp);
			
			var hbox : HBox = new HBox(this, 10, 10);
			new PushButton(hbox, 0, 0, "setSize", clickHandler);
			new PushButton(hbox, 0, 0, "source", clickHandler);
			new PushButton(hbox, 0, 0, "vscroll", clickHandler);			new PushButton(hbox, 0, 0, "hscroll", clickHandler);
		}

		private function clickHandler(event : MouseEvent) : void 
		{
			switch(event.target.label)
			{
				case "setSize":
					khp.setSize(120, 120);
					break;
				case "source":
					khp.source = "content2";
					break;
				case "vscroll":
					khp.vScrollPosition = .5;
					break;
				case "hscroll":
					khp.hScrollPosition = 1;
					break;
			}
		}
	}
}

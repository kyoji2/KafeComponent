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

	public class KUIScrollPaneTest extends Sprite 
	{
		private var ksp : KUIScrollPane;

		public function KUIScrollPaneTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//			ksp = KUIScrollPane(getChildByName("_ksp"));
			
			ksp = new KUIScrollPane();
			ksp.move(100, 100);
			ksp.setSize(200, 200);
			ksp.source = "content";
			ksp.scrollBar = "KUIScrollBarSkin";
			ksp.vScrollPosition = .5;
			addChild(ksp);
			
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
					ksp.setSize(120, 120);
					break;
				case "source":
					ksp.source = "content2";
					break;
				case "vscroll":
					ksp.vScrollPosition = .5;
					break;
				case "hscroll":
					ksp.hScrollPosition = 1;
					break;
			}
		}
	}
}

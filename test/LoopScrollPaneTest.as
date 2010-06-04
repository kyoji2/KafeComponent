package  
{
	import com.kevincao.kafeui.*;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * @author Kevin Cao
	 */

	public class LoopScrollPaneTest extends Sprite 
	{
		private var lsp : LoopScrollPane;

		public function LoopScrollPaneTest()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			lsp = new HLoopScrollPane();			lsp = new VLoopScrollPane();
			lsp.setSize(1000, 700);
			lsp.source = "content";
			addChild(lsp);
			
			addEventListener(Event.ENTER_FRAME, tick);
			
			stage.addEventListener(Event.RESIZE, resizeHandler);
		}

		private function resizeHandler(event : Event) : void 
		{
			lsp.setSize(stage.stageWidth, stage.stageHeight);
		}

		private function tick(event : Event) : void 
		{
			lsp.scroll += 2;
		}
	}
}

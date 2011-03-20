package com.kevincao.kafe.behaviors.display
{
	import com.kevincao.kafe.events.AnimationEvent;
	import com.kevincao.kafe.utils.getClassName;
	import com.kevincao.kafe.utils.getFrame;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[Event(name="change", type="flash.events.Event")]
	[Event(name="over", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="overComplete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="out", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="outComplete", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="down", type="com.kevincao.kafe.events.AnimationEvent")]
	[Event(name="downComplete", type="com.kevincao.kafe.events.AnimationEvent")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeButton extends ButtonBase implements ISelectableButton
	{

		protected var _selected : Boolean;
		protected var _toggle : Boolean;
		protected var _mirror : Boolean;
		
		private var overFrame : int;
		private var outFrame : int;
		private var downFrame : int;
		private var disabledFrame : int;
		private var selectedOverFrame : int;
		private var selectedOutFrame : int;
		private var selectedDownFrame : int;
		private var selectedDisabledFrame : int;

		private var overCompleteFrame : int;
		private var outCompleteFrame : int;
		private var downCompleteFrame : int;
		private var selectedOverCompleteFrame : int;
		private var selectedOutCompleteFrame : int;
		private var selectedDownCompleteFrame : int;

		public var lockMouseDownState : Boolean = true;


		public function get selected() : Boolean
		{
			return _selected;
		}

		public function set selected(value : Boolean) : void
		{
			if (_selected == value) return;

			_selected = value;
			dispatchEvent(new Event(Event.CHANGE));
			invalidate();
		}

		public function get toggle() : Boolean
		{
			return _toggle;
		}

		public function set toggle(value : Boolean) : void
		{
			_toggle = value;
		}

		public function get mirror() : Boolean
		{
			return _mirror;
		}

		public function set mirror(value : Boolean) : void
		{
			_mirror = value;
		}

		/**
		 * 
		 */
		public function KafeButton(target : MovieClip)
		{
			super(target);
		}

		// ----------------------------------
		// override functions
		// ----------------------------------

		override protected function initSkin() : void
		{
			super.initSkin();
			
			overFrame = getFrame(_skin, "over");
			outFrame = getFrame(_skin, "out");
			downFrame = getFrame(_skin, "down");
			disabledFrame = getFrame(_skin, "disabled");
			overCompleteFrame = outFrame - 1;
			outCompleteFrame = downFrame - 1;
			downCompleteFrame = disabledFrame - 1;
			selectedOverFrame = getFrame(_skin, "selected over");
			selectedOutFrame = getFrame(_skin, "selected out");
			selectedDownFrame = getFrame(_skin, "selected down");
			selectedDisabledFrame = getFrame(_skin, "selected disabled");
			selectedOverCompleteFrame = selectedOutFrame - 1;
			selectedOutCompleteFrame = selectedDownFrame - 1;
			selectedDownCompleteFrame = selectedDisabledFrame - 1;
			
			// check required frames
			if (overFrame == -1 || outFrame == -1 || selectedOverFrame == -1 || selectedOutFrame == -1)
			{
				trace(getClassName() + " :: Skin Error : " + _skin.name);
			}

			initFrameScript();
		}

		

		override protected function draw() : void
		{
			super.draw();

			if (_enabled)
			{
				if (_isRollOver)
				{
					_skin.gotoAndStop(_selected ? selectedOverCompleteFrame : overCompleteFrame);
				}
				else
				{
					_skin.gotoAndStop(_selected ? "selected" : "normal");
				}
			}
			else
			{
				_skin.gotoAndStop(_selected ? "selected disabled" : "disabled");
			}
		}

		// ----------------------------------
		// handlers
		// ----------------------------------

		override protected function rollOverHandler(event : MouseEvent) : void
		{
			super.rollOverHandler(event);
			if (_isMouseDown && lockMouseDownState) return;
			var frame : int = getFrame(_skin, _selected ? "selected over" : "over");
			var offset : int = 0;
			if (_mirror)
			{
				if(!_selected)
				{
					if(_skin.currentFrame >= outFrame && _skin.currentFrame < outCompleteFrame)
					{
						offset = outCompleteFrame - _skin.currentFrame;
					}
				}
				else
				{
					if(_skin.currentFrame >= selectedOutFrame && _skin.currentFrame < selectedOutCompleteFrame)
					{
						offset = selectedOutCompleteFrame - _skin.currentFrame;
					}
				}
			}
			offset = offset < 0 ? 0 : offset;
			_skin.gotoAndPlay(frame + offset);
		}

		override protected function rollOutHandler(event : MouseEvent) : void
		{
			super.rollOutHandler(event);
			if (_isMouseDown && lockMouseDownState) return;

			// 在这里要排除因mouseEnabled=false而产生的rollOut事件
			if (_enabled)
			{
				var frame : int = getFrame(_skin, _selected ? "selected out" : "out");
				var offset : int = 0;
				if (_mirror)
				{
					if(!_selected)
					{
						if(_skin.currentFrame >= overFrame && _skin.currentFrame < overCompleteFrame)
						{
							offset = overCompleteFrame - _skin.currentFrame;
						}
					}
					else
					{
						if(_skin.currentFrame >= selectedOverFrame && _skin.currentFrame < selectedOverCompleteFrame)
						{
							offset = selectedOverCompleteFrame - _skin.currentFrame;
						}
					}
				}
				offset = offset < 0 ? 0 : offset;
				_skin.gotoAndPlay(frame + offset);
			}
		}

		override protected function mouseDownHandler(event : MouseEvent) : void
		{
			super.mouseDownHandler(event);
			_skin.gotoAndPlay(_selected ? "selected down" : "down");
		}

		override protected function mouseUpHandler(event : MouseEvent) : void
		{
			super.mouseUpHandler(event);
			draw();
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			if (_toggle)
			{
				selected = !selected;
			}
			else
			{
				goto();
			}
		}
		
		private function initFrameScript() : void
		{
			// note : addFrameScript() use zero base
			_skin.addFrameScript(overFrame, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OVER));
			});
			_skin.addFrameScript(overCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OVER_COMPLETE));
				_skin.stop();
			});
			_skin.addFrameScript(outFrame, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OUT));
			});
			_skin.addFrameScript(outCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OUT_COMPLETE));
				_skin.gotoAndStop("normal");
			});
			_skin.addFrameScript(downFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.DOWN));
			});
			_skin.addFrameScript(downCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.DOWN_COMPLETE));
				_skin.stop();
			});
			_skin.addFrameScript(selectedOverFrame, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OVER));
			});
			_skin.addFrameScript(selectedOverCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OVER_COMPLETE));
				_skin.stop();
			});
			_skin.addFrameScript(selectedOutFrame, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OUT));
			});
			_skin.addFrameScript(selectedOutCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.OUT_COMPLETE));
				_skin.gotoAndStop("selected");
			});
			_skin.addFrameScript(selectedDownFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.DOWN));
			});
			_skin.addFrameScript(selectedDownCompleteFrame - 1, function() : void
			{
				dispatchEvent(new AnimationEvent(AnimationEvent.DOWN_COMPLETE));
				_skin.stop();
			});
		}
	}
}

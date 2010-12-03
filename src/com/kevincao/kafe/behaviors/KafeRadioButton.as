package com.kevincao.kafe.behaviors
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	/**
	 * @author Kevin Cao
	 */
	public class KafeRadioButton extends KafeButton
	{
		protected static var buttons : Array;

		protected var _groupName : String = "defaultGroupName";

		public function KafeRadioButton(skin : MovieClip)
		{
			super(skin);

			KafeRadioButton.addButton(this);
		}

		protected static function addButton(rb : KafeRadioButton) : void
		{
			if(buttons == null)
			{
				buttons = [];
			}
			buttons.push(rb);
		}

		protected static function removeButton(rb : KafeRadioButton) : void
		{
			buttons.splice(buttons.indexOf(rb), 1);
		}

		/**
		 * Unselects all RadioButtons in the group, except the one passed.
		 * @param rb The RadioButton to remain selected.
		 */
		protected static function select(rb : KafeRadioButton) : void
		{
			for(var i : uint = 0;i < buttons.length;i++)
			{
				if(buttons[i] != rb && buttons[i].groupName == rb.groupName)
				{
					buttons[i].selected = false;
				}
			}
		}

		override protected function clickHandler(event : MouseEvent) : void
		{
			selected = true;
		}

		/**
		 * Sets / gets the group name, which allows groups of RadioButtons to function seperately.
		 */
		public function get groupName() : String
		{
			return _groupName;
		}

		public function set groupName(value : String) : void
		{
			_groupName = value;
		}

		/**
		 * toggle always be false
		 */
		override public function set toggle(value : Boolean) : void
		{
			_toggle = false;
		}

		/**
		 * 
		 */
		override public function set selected(value : Boolean) : void
		{
			super.selected = value;

			if(_selected)
			{
				KafeRadioButton.select(this);
			}
		}


		override public function destroy() : void
		{
			KafeRadioButton.removeButton(this);
			super.destroy();
		}
	}
}

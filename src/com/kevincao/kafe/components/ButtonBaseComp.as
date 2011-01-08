package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.display.IButton;

	/**
	 * @author Kevin Cao
	 */
	public class ButtonBaseComp extends CompBase
	{
		[Inspectable(defaultValue=true, verbose=1)]

		public function get enabled() : Boolean
		{
			return IButton(behavior).enabled;
		}

		public function set enabled(value : Boolean) : void
		{
			IButton(behavior).enabled = value;
		}

		[Inspectable(type="String", defaultValue="")]

		public function get href() : String
		{
			return IButton(behavior).href;
		}

		public function set href(value : String) : void
		{
			IButton(behavior).href = value;
		}

		[Inspectable(type="String", defaultValue="_blank")]

		public function get window() : String
		{
			return IButton(behavior).window;
		}

		public function set window(value : String) : void
		{
			IButton(behavior).window = value;
		}

		/**
		 * 
		 */
		public function ButtonBaseComp(component : IButton)
		{
			super(component);
		}
	}
}

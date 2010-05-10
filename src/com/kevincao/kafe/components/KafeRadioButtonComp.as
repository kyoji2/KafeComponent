package com.kevincao.kafe.components 
{
	import com.kevincao.kafe.KafeRadioButton;

	import flash.display.MovieClip;
	
	[IconFile("../../../../../footage/KafeRadioButton.png")]

	/**
	 * @author Kevin Cao
	 */
	public class KafeRadioButtonComp extends ButtonBaseComp 
	{

		[Inspectable(defaultValue=false)]

		public function get selected() : Boolean 
		{
			return KafeRadioButton(component).selected;
		}

		public function set selected(value : Boolean) : void 
		{
			KafeRadioButton(component).selected = value;
		}

		[Inspectable(defaultValue="defaultGroupName")]

		public function get groupName() : String 
		{
			return KafeRadioButton(component).groupName;
		}

		public function set groupName(value : String) : void 
		{
			KafeRadioButton(component).groupName = value;
		}

		/**
		 * 
		 */
		public function KafeRadioButtonComp()
		{
			super(new KafeRadioButton(MovieClip(parent)));
		}
	}
}

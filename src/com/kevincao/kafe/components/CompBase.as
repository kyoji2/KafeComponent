package com.kevincao.kafe.components
{
	import com.kevincao.kafe.behaviors.IBehavior;

	import flash.display.Sprite;

	/**
	 * CompBase
	 * 用复合方式构建的组件
	 * @author Kevin Cao
	 */
	public class CompBase extends Sprite implements IComponent
	{

		private var _behavior : IBehavior;

		public function get behavior() : IBehavior
		{
			return _behavior;
		}

		[Inspectable(defaultValue=true, verbose=1)]

		public function get enabled() : Boolean
		{
			return _behavior.enabled;
		}

		public function set enabled(value : Boolean) : void
		{
			_behavior.enabled = value;
		}

		/**
		 * 
		 */
		public function CompBase(behavior : IBehavior)
		{
			_behavior = behavior;

			init();
		}

		protected function init() : void
		{
			// remove avatar
			removeChildAt(0);

			mouseEnabled = false;
			mouseChildren = false;
			visible = false;

//			_behavior.enabled = _behavior.enabled;
		}

		public function destroy() : void
		{
			_behavior.destroy();
			_behavior = null;
		}
	}
}

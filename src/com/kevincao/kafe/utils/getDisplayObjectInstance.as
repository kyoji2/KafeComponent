package com.kevincao.kafe.utils
{
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Kevin Cao
	 */
	public function getDisplayObjectInstance(key : *) : DisplayObject
	{
		var classDef : Object = null;
		if(key is Class)
		{
			return (new key()) as DisplayObject;
		}
		else if(key is DisplayObject)
		{
			return key as DisplayObject;
		}

		try
		{
			classDef = getDefinitionByName(key.toString());
			return (new classDef()) as DisplayObject;
		}
		catch(e : Error)
		{
		}

		return null;
	}
}

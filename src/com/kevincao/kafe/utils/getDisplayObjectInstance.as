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
		if (key is Class)
		{
			return (new key()) as DisplayObject;
		}
		else if (key is DisplayObject)
		{
//			(key as DisplayObject).x = 0;
//			(key as DisplayObject).y = 0;
			return key as DisplayObject;
		}

		try
		{
			classDef = getDefinitionByName(key.toString());
		}
		catch(e : Error)
		{
//			try
//			{
//				classDef = loaderInfo.applicationDomain.getDefinition(key.toString()) as Object;
//			}
//			catch (e : Error)
//			{
//				// Nothing
//			}
		}

		if (classDef == null)
		{
			return null;
		}
		return (new classDef()) as DisplayObject;
	}
}

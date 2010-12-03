/*
 * 
 * Copyright (c) 2010 kevincao.com, All Rights Reserved
 * @author		Kevin Cao
 * @email	 	kevin@kevincao.com
 * 
 */
package com.kevincao.kafe.behaviors
{
	/**
	 * @author Kevin Cao
	 */
	public interface IScrollBar extends IBehavior
	{
		function get size() : Number;

		function set size(value : Number) : void;

		function get scrollPosition() : Number;

		function set scrollPosition(newScrollPosition : Number) : void;

		function get minScrollPosition() : Number;

		function set minScrollPosition(value : Number) : void;

		function get maxScrollPosition() : Number;

		function set maxScrollPosition(value : Number) : void;

		function get pageSize() : Number;

		function set pageSize(value : Number) : void;

		function get pageScrollSize() : Number;

		function set pageScrollSize(value : Number) : void;

		function get lineScrollSize() : Number;

		function set lineScrollSize(value : Number) : void;

		function setScrollPosition(newScrollPosition : Number, fireEvent : Boolean = true) : void;

		function setScrollProperties(pageSize : Number, minScrollPosition : Number, maxScrollPosition : Number, pageScrollSize : Number = 0) : void;


	}
}

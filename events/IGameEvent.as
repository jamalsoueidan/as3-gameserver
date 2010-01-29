package org.soueidan.game.events
{
	public interface IGameEvent 
	{
		// so every event can filter the data as they want.
		function set data(value:Object):void;
	}
}
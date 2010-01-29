package org.soueidan.game.events
{
	import flash.events.Event;

	public class GameEvent extends Event implements IGameEvent
	{	
		public static const STATUS:String = "gameEventStatus";
		
		private var _data:Object;
				
		public function get isConnected():Boolean {
			return _data["success"];	
		}
			
		public function GameEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public function set data(value:Object):void {
			_data = value;	
		}		
	}
}
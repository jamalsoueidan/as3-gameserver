package org.soueidan.game.events
{
	import flash.events.Event;

	public class GameObjectEvent extends Event implements IGameEvent
	{
		public static const UPDATE:String = "gameObjectEventUpdate";
		
		private var _data:Object;
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get object():Object {
			return _data;	
		}
		
		public function get from():Object {
			return _data["from"];
		}
		
		public function GameObjectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
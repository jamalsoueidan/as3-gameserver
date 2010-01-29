package org.soueidan.game.events
{
	import flash.events.Event;

	public class UserlistEvent extends Event implements IGameEvent
	{
		public function UserlistEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public static const UPDATE:String = "userlistEventUpdated";
		
		private var _data:Object;
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get users():Array {
			return _data["users"];
		}
	}
}
package org.soueidan.game.events
{
	import flash.events.Event;

	public class JoinEvent extends Event implements IGameEvent
	{
		public static const RESPONSE:String = "joinEventResponse";
		
		private var _data:Object;
		
		public function set data(value:Object):void {
			_data = value;	
		}
		
		public function get isJoined():Boolean {
			if ( _data["success"] == "true" ) {
				return true;
			} else {
				return false;
			}
		}
		
		public function JoinEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
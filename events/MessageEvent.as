package org.soueidan.game.events
{
	import flash.events.Event;

	public class MessageEvent extends Event implements IGameEvent
	{
		public static const RECEIVED:String = "received";
		
		private var _data:Object;
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get text():String {
			return _data["text"];	
		}
		
		public function get from():Object {
			return _data["from"];
		}
		
		public function MessageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}
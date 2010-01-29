package org.soueidan.game.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.rubyforge.dango.DangoClientFramework;
	import org.rubyforge.dango.DangoErrorEvent;
	import org.rubyforge.dango.DangoReceiveEvent;
	import org.soueidan.game.events.*;
	import org.soueidan.game.requests.*;

	[Event(name="connected", type="org.soueidan.events.GameEvent")]
	[Event(name="error", type="org.soueidan.events.GameEvent")]
	[Event(name="response", type="org.soueidan.events.JoinEvent")]
	[Event(name="response", type="org.soueidan.events.JoinGameEvent")]
	[Event(name="update", type="org.soueidan.events.UserlistEvent")]
	[Event(name="received", type="org.soueidan.events.MessageEvent")]

	public class Game implements IEventDispatcher
	{
		
		private static var _instance:Game;
		
		private var _debug:Boolean;
		private var _dango:DangoClientFramework;
		
		private var _host:String = "localhost";
		private var _port:int = 15000;
		
		private var _dispatcher:EventDispatcher;
		
		private var _current:int;
		private var _users:Array = [];
		
		public function get current():int {
			return _current;
		}
		
		public function get users():Array {
			return _users;
		}
		
		public static function getInstance():Game {
			if ( !_instance ) {
				_instance = new Game(false);
			}
			
			return _instance;
		}
		
		public function Game(debug:Boolean=false)
		{
			if ( !_instance ) {
				_instance = this;
			}
			
			_debug = debug;
			_dispatcher = new EventDispatcher(this); 
		}
		
		public function connect():void 
		{
			try {
				_dango = new DangoClientFramework({"server_host":_host, "server_port":_port, "debug":false});
			} catch(err:Error) {
				trace(err.message);
			}
			
			_dango.addEventListener("DangoError", connectionError);
			_dango.addEventListener("dango__connect" , connectionEstablished);
			_dango.addEventListener("dango_notice", objectReceived);
			
		}
		
		public function close():void {
			_dango.connection.close();
		}
		
		private function newUser(evt:DangoReceiveEvent):void {
			_users = evt.receive_data["sids"];
			trace(evt.receive_data["sids"], evt.receive_data["is_connect"], evt.receive_data["_from_sid"]);
		}

		private function connectionEstablished(evt:DangoReceiveEvent):void 
		{
			_current = _dango.sid;
			
			dispatchGameEvent(true);
		}
		
		private function dispatchGameEvent(success:Boolean=false):void {
			var evt:GameEvent = new GameEvent(GameEvent.STATUS)
			evt.data = {"success": success};
			dispatchEvent(evt);
		}
		
		private function connectionError(evt:DangoErrorEvent):void 
		{
			if ( _debug ) {
				trace(evt.message);
			}
			
			dispatchGameEvent();
		}
		
		public function send(request:IRequests):void {
			_dango.send_action("send_object", request.toObject());
		}
		
		private function objectReceived(evt:DangoReceiveEvent):void {
			if ( _debug ) {
				
				var object:Object = evt.receive_data;
				var notice:String = object["notice"];
				
				trace("objectReceived: ", notice);
				
				var event:IGameEvent;
				
				if ( notice == "join_request" ) {
					event = new JoinEvent(JoinEvent.RESPONSE);
					_users = object["users"];
				}
				
				if ( notice == "message_request" ) {
					event = new MessageEvent(MessageEvent.RECEIVED);
				}
				
				if ( notice == "userlist_request" ) {
					event = new UserlistEvent(UserlistEvent.UPDATE);
				}
				
				if ( notice == "join_game_request" ) {
					event = new JoinGameEvent(JoinGameEvent.RESPONSE);
				}
				
				if ( notice == "game_object_request" ) {
					event = new GameObjectEvent(GameObjectEvent.UPDATE);
				}
				
				//if ( notice != "unknown_request" ) {
				if ( event ) { 
					//trace(ObjectUtil.toString(object));
					event.data = object;
					dispatchEvent(event as Event);
				} else {
					trace("error unknown request", notice);
				}
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean
		{
			return _dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean
		{
			return _dispatcher.willTrigger(type);
		}
		
	}
}
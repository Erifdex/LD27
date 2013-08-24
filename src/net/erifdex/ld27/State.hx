package net.erifdex.ld27;

import ash.core.Engine;

class State {

	public var stateManager	: StateManager;
	public var engine 		: Engine;

	public function new() : Void {
	}

	public function prepareSystems() : Void {
		trace("Testing - systems");
	}

	public function prepareEntities() : Void {
		trace("Testing - entities");
	}
	
}
package net.erifdex.ld27.entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class FadeableText extends Entity {

	public var text : Text;
	public var opacity : Float;

	public function new(text : String, ?x : Float, ?y : Float, ?width : Int, ?height : Int, ?options : Dynamic) { 
		super();
		this.text = new Text(text, x, y, width, height, options);
		addGraphic(this.text);
		this.opacity = 1;
	}

	public override function update() : Void {
		text.alpha = opacity;
		super.update();
	}

}
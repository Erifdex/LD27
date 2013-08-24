package net.erifdex.ld27.entities;

import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import net.erifdex.ld27.other.GFX;

class Button extends Entity {

	public var callback		: Void->Void;
	public var text 		: String;
	public var map 			: Spritemap;
	public var pressed		: Bool;
	public var textGraphic	: Text;

	public function new(x : Float, y : Float, text : String, callback : Void->Void) { 
		super(x, y);
		this.callback = callback;
		this.text = text;
		this.map = new Spritemap(GFX.BUTTON, 128, 64);
		this.map.add("normal", [0]);
		this.map.add("pressed", [1]);
		this.graphic = this.map;
		textGraphic = new Text(text, 64, 12, 0, 0, {font:"font/font.ttf"});
		textGraphic.color = 0x30346d;
		textGraphic.size = 20;
		textGraphic.x -= textGraphic.textWidth / 2;
		this.addGraphic(textGraphic);
		this.map.play("normal");
		this.setHitbox(128, 64);
	}

	public override function added() : Void {
	}

	public override function update() : Void {
		if(Input.mouseDown) {
			if(this.collidePoint(x, y, Input.mouseX, Input.mouseY)) {
				this.pressed = true;
				this.map.play("pressed");
				textGraphic.y = 19;
			} else {
				this.map.play("normal");
				textGraphic.y = 12;
			}
		} else {
			if(this.pressed) {
				this.callback();
				this.pressed = false;
			}
			this.map.play("normal");
			textGraphic.y = 12;
		}
	}

}
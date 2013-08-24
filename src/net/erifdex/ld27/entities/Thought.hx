package net.erifdex.ld27.entities;

import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Draw;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.graphics.Text;
import net.erifdex.ld27.other.GFX;
import net.erifdex.ld27.other.Words;

class Thought extends Entity {

	public var callback		: Word->Void;
	public var word 		: Word;
	public var text 		: String;
	public var pressed		: Bool;
	public var textGraphic	: Text;

	public function new(x : Float, y : Float, word : Word, callback : Word->Void) { 
		super(x, y);
		this.callback = callback;
		this.word = word;
		this.text = word.word;
		textGraphic = new Text(text, 64, 12, 0, 0, {font:"font/font_thought.ttf"});
		textGraphic.color = 0x30346d;
		textGraphic.size = 20;
		textGraphic.centerOrigin();
		this.addGraphic(textGraphic);
		this.setHitbox(textGraphic.textWidth, 64);
	}

	public override function added() : Void {
	}

	public override function update() : Void {
		if(Input.mouseDown) {
			if(this.collidePoint(x, y, Input.mouseX, Input.mouseY)) {
				this.pressed = true;
				textGraphic.y = 19;
			} else {
				textGraphic.y = 12;
			}
		} else {
			if(this.pressed) {
				this.callback(this.word);
				this.pressed = false;
			}
			textGraphic.y = 12;
		}
	}

	public override function render() : Void {
		Draw.rect(Math.round(x-textGraphic.textWidth / 2), Math.round(y-textGraphic.textHeight / 2), textGraphic.textWidth, textGraphic.textHeight, 0xd37d2c, 1);
		Draw.hitbox(this);
		super.render();
	}

}
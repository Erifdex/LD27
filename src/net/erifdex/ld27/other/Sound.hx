package net.erifdex.ld27.other;

import openfl.Assets;

class Sound {

	public static var beat : flash.media.SoundChannel;
	public static var beep : flash.media.SoundChannel;
	public static var select : flash.media.SoundChannel;
	public static var tada : flash.media.SoundChannel;
	public static var drum : flash.media.SoundChannel;
	public static var music : flash.media.SoundChannel;

	public static function playBeat() : Void {
		music.stop();
		beat = Assets.getSound("sfx/beat.wav").play(0, 999);
	}

	public static function stopBeat() : Void {
		beat.stop();
		playMusic();
	}

	public static function playBeep() : Void {
		beep = Assets.getSound("sfx/beep.wav").play();
	}

	public static function playSelect() : Void {
		select = Assets.getSound("sfx/select.wav").play();
	}

	public static function playTada() : Void {
		tada = Assets.getSound("sfx/tada.wav").play();
	}

	public static function playDrum() : Void {
		drum = Assets.getSound("sfx/drum.wav").play();
	}

	public static function playMusic() : Void {
		music = Assets.getSound("sfx/music.wav").play(0, 99999);
	}

}
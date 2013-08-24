package net.erifdex.ld27.other;

import openfl.Assets;
import flash.display.BitmapData;

class GFX {
	public static var BUTTON : BitmapData;
	public static var MANAGER : BitmapData;
	public static var MANAGER_FIRE : BitmapData;
	public static var FOOTBALL : BitmapData;
	public static var OVERLAY : BitmapData;
	public static var PLAYER : BitmapData;
	public static var SHADOW : BitmapData;

	public static function init() : Void {
		GFX.BUTTON = Assets.getBitmapData("gfx/button.png");
		GFX.MANAGER = Assets.getBitmapData("gfx/manager.png");
		GFX.MANAGER_FIRE = Assets.getBitmapData("gfx/manager_promo.png");
		GFX.FOOTBALL = Assets.getBitmapData("gfx/football.png");
		GFX.OVERLAY = Assets.getBitmapData("gfx/overlay.png");
		GFX.PLAYER = Assets.getBitmapData("gfx/player.png");
		GFX.SHADOW = Assets.getBitmapData("gfx/shadow.png");
	}
}
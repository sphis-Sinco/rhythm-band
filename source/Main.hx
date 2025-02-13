package;

import flixel.FlxGame;
import openfl.display.Sprite;

/**
 * Main Class, runs on start, and will probably initalize things
 */
class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, play.PlayState));
	}
}

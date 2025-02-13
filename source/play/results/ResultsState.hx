package play.results;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import music.MusicState;
import play.components.Stats;

/**
 * Results State
 */
class ResultsState extends MusicState
{
	/**
	 * Stats of the song that was played
	 */
	public var STATS:Stats = {
		song: "Test",
		beatsTotal: 100,
		beatsHit: 50,
		beatsMissed: 50
	};

	/**
	 * The rank class storing the rank
	 */
	public var RANK_CLASS:Rank;

	/**
	 * Current percentage
	 */
	public var PERCENT:Float = 0.0;

	/**
	 * The percent earned
	 */
	public var TARGET_PERCENT:Null<Float> = 100.0;

	/**
	 * This is if we have arrived at the `TARGET_PERCENT` TARGET
	 */
	public var REACHED_TARGET_PERCENT:Bool = false;

	/**
	 * The current tick increment until `PERCENT_TICK_GOAL`
	 */
	public var PERCENT_TICK:Int = 0;

	/**
	 * The `PERCENT_TICK` when `PERCENT` should increase closer to `TARGET_PERCENT`
	 */
	public var PERCENT_TICK_GOAL:Int = 5;

	/**
	 * This is the text that will say your grade, i.e. "YOU DID GOOD"
	 */
	public var RANK_GRADE_TEXT:FlxText;

	/**
	 * This is the text that will say your percentage while being below the `RANK_GRADE_TEXT`
	 */
	public var RANK_PERCENT_TEXT:FlxText;

	override public function new(gameplayStats:Stats)
	{
		TARGET_PERCENT = (gameplayStats.beatsHit / gameplayStats.beatsTotal) * 100;
		RANK_CLASS = new Rank((TARGET_PERCENT == null) ? 0 : TARGET_PERCENT);

		RANK_GRADE_TEXT = new FlxText(10, 10, 0, 'YOU DID...', 64);

		RANK_PERCENT_TEXT = new FlxText(0, 0, 0, '0%', 32);
		RANK_PERCENT_TEXT.screenCenter(XY);

		super();
	}

	override public function create():Void
	{
		add(RANK_GRADE_TEXT);
		add(RANK_PERCENT_TEXT);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (PERCENT < TARGET_PERCENT)
		{
			rankBuildUpTick();
		}
		else if (PERCENT_TICK == PERCENT_TICK_GOAL * 2)
		{
			rankBuildUpComplete();
		}

		PERCENT_TICK++;

		super.update(elapsed);
	}

	/**
	 * This executes when `PERCENT < TARGET_PERCENT` is true
	 */
	public function rankBuildUpTick():Void
	{
		if (PERCENT_TICK == PERCENT_TICK_GOAL)
		{
			PERCENT_TICK = 0;
			PERCENT += (PERCENT < 1) ? 1 : (PERCENT / TARGET_PERCENT) * 50;
		}

		if (PERCENT > TARGET_PERCENT) PERCENT = TARGET_PERCENT;

		RANK_PERCENT_TEXT.text = '${FlxMath.roundDecimal(PERCENT, 0)}%';
		RANK_PERCENT_TEXT.screenCenter(XY);
	}

	/**
	 * This executes once `PERCENT < TARGET_PERCENT` isn't true and `PERCENT_TICK == PERCENT_TICK_GOAL * 2`
	 */
	public function rankBuildUpComplete():Void
	{
		if (!REACHED_TARGET_PERCENT) trace('Rank Target Made!'); else return;

		FlxG.camera.flash();

		RANK_GRADE_TEXT.text = 'YOU DID ${RANK_CLASS.RANK.toUpperCase()}!';
                RANK_PERCENT_TEXT.setPosition(10, RANK_GRADE_TEXT.y + RANK_GRADE_TEXT.height + 8);
                RANK_PERCENT_TEXT.color = FlxColor.GRAY;

		REACHED_TARGET_PERCENT = true;
	}
}

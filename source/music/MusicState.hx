package music;

import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import music.Conductor.BPMChangeEvent;

/**
 * The main music state: has all the beat stuff
 */
class MusicState extends FlxUIState
{
	// thankyouninjamuffin99
	var oldBeat:Float = 0;
	var oldStep:Float = 0;

	var curStep:Int = 0;
	var curBeat:Int = 0;

	override public function new()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		super();
	}

	override public function create():Void
	{
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		oldStep = curStep;

		updateCurStep();
		updateBeat();

		if (oldStep != curStep && curStep > 0)
		{
			stepHit();
		}

		super.update(elapsed);
	}

	function updateBeat():Void
	{
		curBeat = Math.floor(curStep / 4);
	}

	function updateCurStep():Void
	{
		var lastChange:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: 0
		}
		for (i in 0...Conductor.bpmChangeMap.length)
		{
			if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime)
			{
				lastChange = Conductor.bpmChangeMap[i];
			}
		}

		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}

	/**
	 * This is when the step increases: runs `beatHit` when `curStep % 4 == 0`
	 */
	public function stepHit():Void
	{
		if (curStep % 4 == 0)
		{
			beatHit();
		}
	}

	/**
	 * This is when the beat increases
	 */
	public function beatHit():Void
	{
		// do literally nothing dumbass
	}
}

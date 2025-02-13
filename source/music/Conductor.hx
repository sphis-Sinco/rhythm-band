package music;

/**
 * This is just an event that controls when a BPM Change happens and the new BPM
 */
typedef BPMChangeEvent =
{
	var stepTime:Int;
	var songTime:Float;
	var bpm:Float;
}

/**
 * This controls `MusicState` majorly
 */
class Conductor
{
	/**
	 * beats per minute
	 */
	public static var bpm:Float = 100;

	/**
	 * beats in milliseconds
	 */
	public static var crochet:Float = ((60 / bpm) * 1000);

	/**
	 * steps in milliseconds
	 */
	public static var stepCrochet:Float = crochet / 4;

	/**
	 * Song Position
	 */
	public static var songPosition:Float = 0;

	/**
	 * Last Song Position
	 */
	public static var lastSongPos:Float;

	/**
	 * Song Position Offset
	 */
	public static var songPosOffset:Float = 0;

	/**
	 * When bpm changes happen
	 */
	public static var bpmChangeMap:Array<BPMChangeEvent> = [];

	public function new(bpm:Float = 100):Void
	{
		changeBPM(bpm);
	}

	/**
	 * Changes the bpm to `newBpm`
	 * @param newBpm the new set for the bpm
	 */
	public static function changeBPM(newBpm:Float):Void
	{
		bpm = newBpm;

		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / 4;
	}

	/**
	 * This just sets `bpmChangeMap` so that all the bpm events are tracked
	 * @param song the song you are getting the bpmChangeMap from
	 */
	public static function mapBPMChanges(song:Song):Void
	{
		bpmChangeMap = [];

		// todo for if a song needs a bpm change

		var curBPM:Float = song.bpm;

		var event:BPMChangeEvent = {
			stepTime: 0,
			songTime: 0,
			bpm: curBPM
		}

		bpmChangeMap.push(event);
	}
}

package play;

import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import music.Conductor;
import music.MusicState;
import music.Song;
import play.components.Stats;
import play.results.ResultsState;

class PlayState extends MusicState
{
	/**
	 * This is the song json file controlling all the song info, notes, bpm, song name, etc.
	 */
	public var SONG_JSON:Song;
	/**
	 * This is the stats for the song, this gets changed during gameplay.
	 */
	public var SONG_STATS:Stats;

	/**
	 * This is the tracker for if the song has started
	 */
	public var SONG_STARTED:Bool = false;

	/**
	 * This is the tracker for if the song has ended
	 */
	public var SONG_ENDED:Bool = false;

	/**
	 * This is a debug text-field for song position
	 */
	public var SONG_POSITION_DEBUG_TEXT:FlxText;

	override public function new()
	{
		SONG_JSON = {
			name: "Test",
			bpm: 150
		}

		SONG_STATS = {
			song: SONG_JSON.name,
			beatsTotal: 0,
			beatsHit: 0,
			beatsMissed: 0
		}

		Conductor.mapBPMChanges(SONG_JSON);
		Conductor.changeBPM(SONG_JSON.bpm);

		FlxG.sound.playMusic('assets/music/Test.wav', 1.0, false);
		FlxG.sound.music.onComplete = endSong;
		FlxG.sound.pause();

		Conductor.songPosition = 0; // -5000 for a countdown

		SONG_POSITION_DEBUG_TEXT = new FlxText(0, 0, 0, "Hello", 16);
		super();
	}

	override public function create()
	{
		add(SONG_POSITION_DEBUG_TEXT);
		
		super.create();
	}

	override public function update(elapsed:Float)
	{
		songProgress(elapsed);
		
		super.update(elapsed);
	}

	/**
	 * This executes when the song needs to update
	 * @param elapsed this should just be set to `update`'s `elapsed` variable
	 */
	public function songProgress(elapsed:Float)
        {
		if (!SONG_ENDED)
			Conductor.songPosition += elapsed * 1000;

		if (Conductor.songPosition > 0 && !SONG_STARTED)
		{
			SONG_STARTED = true;
			FlxG.sound.music.resume();
		}

		var MUSIC_LENGTH_SECONDS:Float = FlxG.sound.music.length / 1000;
		var TIME_LEFT_SECONDS:Float = FlxMath.roundDecimal(MUSIC_LENGTH_SECONDS - Conductor.songPosition / 1000, 0);

		if (TIME_LEFT_SECONDS > MUSIC_LENGTH_SECONDS)
			TIME_LEFT_SECONDS = MUSIC_LENGTH_SECONDS; // countdown time doesnt add to the length

		SONG_POSITION_DEBUG_TEXT.text = 'Song Pos: $TIME_LEFT_SECONDS';
        }

	/**
	 * This executes when the song ends and should only end when the song ends
	 */
	public function endSong()
	{
		SONG_ENDED = true;
		FlxG.switchState(() -> new ResultsState(SONG_STATS));
	}

	override public function stepHit()
	{
		super.stepHit();
	}

	override public function beatHit()
	{
		super.beatHit();
	}
}
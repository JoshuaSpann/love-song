import Random;
enum ScaleType {
	Major;
	Minor;
	Chromatic;
	Ionian;
	Dorian;
	Locrian;
	Lydian;
	Mixolidian;
	Phrygian;
}
enum Complexity {
	Complex;
	Normal;
	Simple;
}

class LoveSong {
	private var _timestamp:Float;
	//private var _octaves = [0,1,2,3,4,5,6,7,8,9,10];
	private var _octaves = [3,4,5,6,7];
	private var _notes:Array<String>;
	private var _octave:Int;
	private var _noteTypes = ['w','h','q','e','s','t','.','r'];
	private var _rests = false;
	private var _complexity: Complexity;
	private var _songString: String = '';

	public function new(?complexity:Complexity, ?rests:Bool, ?octave:Int)
	{
		this.main();
		this._octaves = [3,4,5,6,7]; // TODO - REM
		this._noteTypes = ['q','e','s','r']; // TODO - REM
		this._complexity = Complexity.Complex; // TODO - REM
	}

	function main(?complexity:Complexity, ?rests:Bool, ?octave:Int) {
		this._timestamp = new Date(2019,9,2,9,55,32).getTime();

		if (complexity != null) this._complexity = complexity;
		else this._complexity = Random.fromArray([Complexity.Complex, Complexity.Normal, Complexity.Simple]);

		if (rests != null) this._rests = rests
		else this._rests = Random.fromArray([true, false]);

		if (octave != null) this._octave = octave;
		else this._octave = Random.fromArray(this._octaves);

		var bars = 4;
		var barLengthTicks = 32;
		var randomNotes = [];
		var randomNotesNames = [];
		var limit = bars*barLengthTicks;
		var scaleType = ScaleType.Ionian;
		var key = 'C';
		var remainingNotesInBar = 4;
		var lastOctave = this._octave;
		var lastNoteLen = '';
		this._songString += lastOctave;

		for (limit_i in 0...limit) {
			// Get Note Name
			var randomNoteNumber = getRandomNoteAsNumber(scaleType);
			randomNotes.push(randomNoteNumber);
			var noteName = getNoteNameFromKey(randomNoteNumber, key);
			randomNotesNames.push(noteName);

			var currentSongStr = '';

			// Get Octave
			var currentOctave = Random.fromArray(this._octaves);
			if (limit_i > 0 && currentOctave != lastOctave
				&& (currentOctave == this._octave+1 || currentOctave == this._octave-1)
			) currentSongStr += currentOctave;

			// Get Note Type and Finish String


			var noteTicks = 0;
			var curNoteLen = getRandomNoteType(complexity);
			noteTicks = getNoteLengthTicks(curNoteLen);
			var newBarLengthTicks = barLengthTicks - noteTicks;
			if (newBarLengthTicks < 0) {
				while (newBarLengthTicks < 0) {
					noteTicks = 0;
					curNoteLen = getRandomNoteType(complexity);
					noteTicks = getNoteLengthTicks(curNoteLen);
					newBarLengthTicks = barLengthTicks - noteTicks;
trace(newBarLengthTicks,'TST');
				}
			}
			barLengthTicks = newBarLengthTicks;

			if (lastNoteLen != curNoteLen) {
				currentSongStr += curNoteLen;
				lastNoteLen = curNoteLen;
			}


			if (curNoteLen != 'r') currentSongStr += noteName;
			this._songString += currentSongStr;
		}

		_notes = randomNotesNames;
		return randomNotesNames;
	}

	function getNoteLengthTicks(noteLength) {
		var noteTicks = 0;
		if (noteLength == 'w') noteTicks = 32;
		if (noteLength == 't') noteTicks = 16;
		if (noteLength == 'h') noteTicks = 8;
		if (noteLength == 'q') noteTicks = 4;
		if (noteLength == 'e') noteTicks = 2;
		if (noteLength == 's') noteTicks = 1;
		return noteTicks;
	}

	function getRandomNoteAsNumber(scaleType:ScaleType) {
		var chromaticScale = [1,2,3,4,5,6,7,8,9,10,11,12];
		var notes = chromaticScale;

		if (scaleType == ScaleType.Chromatic) {
		}
		if (scaleType == ScaleType.Ionian || scaleType == ScaleType.Major) {
			notes.remove(2);
			notes.remove(4);
			notes.remove(7);
			notes.remove(9);
			notes.remove(11);
		}
		if (scaleType == ScaleType.Lydian || scaleType == ScaleType.Minor) {
			notes.remove(2);
			notes.remove(5);
			notes.remove(10);
			notes.remove(12);
		}

		var randomNote = Random.fromArray(notes);
		return randomNote;
	}

	function getRandomNoteType(complexity:Complexity) {
		var currentNoteType = Random.fromArray(this._noteTypes);
		var availableTypes = ['q','w','h'];
		if (this._rests == true) availableTypes.push('r');

		if (complexity == Complexity.Simple) {
			// Have quarter notes, half notes, whole notes
		}
		if (complexity == Complexity.Normal) {
			// Have 8th notes and rests
			availableTypes.push('e');
		}
		if (complexity == Complexity.Complex) {
			// Have 16th notes and rests
			availableTypes.push('e');
			availableTypes.push('s');
		}

// TODO - Go back to complexity for types
availableTypes = ['q','e','s','t'];

		while (availableTypes.indexOf(currentNoteType) < 0)
			currentNoteType = Random.fromArray(this._noteTypes);
		return currentNoteType;
	}

	function getNoteNameFromKey(noteNumber:Int, key:String) {
		var noteNamesSharps = ["C","C#", "D","D#", "E", "F","F#", "G","G#", "A","A#", "B"];
		var noteNamesFlats = ["C", "Db", "D", "Eb","E", "F", "Gb","G", "Ab","A", "Bb","B"];
		var noteNames = noteNamesFlats;
		var rootNoteIndex = 0;
		var noteName = "X";

		if (key.indexOf("#") >= 0) {
			noteNames = noteNamesSharps;
		}

		//TODO - Shift array elements where key shifts the given note to index 0 then select the noteNumber-1 as index

		rootNoteIndex = noteNames.indexOf(key);
		for (curNote in noteNames) {
			if (noteNames.indexOf(curNote) >= rootNoteIndex) break;
			noteNames.push(noteNames.shift());
		}

		noteName = noteNames[noteNumber-1];

		return noteName;
	}

	public function toString() {
		return this._songString;
	}
}

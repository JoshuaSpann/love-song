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
	private var _octaves = [0,1,2,3,4,5,6,7,8,9,10];

	public function new(?complexity:Complexity, ?rests:Bool, ?octave:Int)
	{
		this.main();
	}

	function main(?complexity:Complexity, ?rests:Bool, ?octave:Int) {
		this._timestamp = new Date(2019,9,2,9,55,32).getTime();

		if (complexity == Complexity.Simple) {
			// Have quarter notes, half notes, whole notes
		}
		if (complexity == Complexity.Normal) {
			// Have 8th notes and rests
		}
		if (complexity == Complexity.Complex) {
			// Have 16th notes and rests
		}

		var bars = 4;
		var randomNotes = [];
		var randomNotesNames = [];
		var limit = 8;
		var scaleType = ScaleType.Ionian;
		var key = 'C';

		for (limit_i in 0...limit) {
			var randomNoteNumber = getRandomNoteAsNumber(scaleType);
			randomNotes.push(randomNoteNumber);
			var noteName = getNoteNameFromKey(randomNoteNumber, key);
			randomNotesNames.push(noteName);
		}

		trace(randomNotes);
		trace(randomNotesNames);
		return randomNotes;
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
}

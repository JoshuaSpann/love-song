class Main {
	public static function main()
	{
		var sql = 'echo "select word from entries order by random() limit 1;" | sqlite3 ~/Downloads/Dictionary.db';
		Sys.command(sql);
		var ts = Date.now();
		var name = '${ts.getFullYear()}${ts.getMonth()+1}${ts.getDate()}${ts.getHours()}${ts.getMinutes()}${ts.getSeconds()}';
		var gs = new LoveSong();
		var lstr = '$$SO,"${name}",A="${gs.toString()}"$$';
		Sys.print(lstr);
		sys.io.File.saveContent(name, lstr);
	}
			
}

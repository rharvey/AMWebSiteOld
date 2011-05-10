package am

class csvParser {
	def parseCSV(file,closure) {
		def lineCount = 0
		file.eachLine() { line ->
			def field = line.tokenize(";")
			lineCount++
			closure(lineCount,field)
		}
	}
}

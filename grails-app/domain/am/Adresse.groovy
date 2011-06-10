package am

class Adresse {
	int id
	String no_civic
	String rue
	String code_postale
	String ville
	
	static mapping = {
		version false
	}

	static constraints = {
		version:false
    }
	
	def toString = {
		"${id} ${no_civic} ${rue} ${ville} ${code_postale}"
	}
}

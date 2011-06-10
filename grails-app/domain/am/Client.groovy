package am

class Client {
	int id
	String numero
	String raison_social
	String courriel
	Adresse adresse
	
	static mapping = {
		version false
		id column : 'id',generetor: 'increment'
	}
    static constraints = {
		numero(unique:true)
		courriel(email:true, nullable:true)
		adresse(nullable: true)
    }
	
	String toString() {
		"${numero} ${raison_social} ${courriel}"
	}
}

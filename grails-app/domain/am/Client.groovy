package am

class Client {
	int id
	String numero
	String raison_social
	String courriel
	
    static constraints = {
    }
	
	String toString() {
		return raison_social
	}
}

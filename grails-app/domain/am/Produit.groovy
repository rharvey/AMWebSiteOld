package am

class Produit {

	int id
	String code
	String description
	String upc
	float prix
	float coutant
	int inventaire
	int achat
	int commande
	int disponible
	String emballage
	String format
	Integer marque_id	
	Integer categorieId
	Date date_maj
	Date date_creation
	Integer image_id
	
	static hasMany = [image: Image]
	
	static mapping = {
		version false
		
	}
	
	String toString() {
		description		
	}
	
}

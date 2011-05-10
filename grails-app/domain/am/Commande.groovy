package am

class Commande {
	int id
	Date date_commande
	Date date_livraison
	Client client
	static hasMany = [produits : Commande_Produit]
	
	static mapping = {
		client column: "client_id"	
	}
	
	static constraints = {
    }
}

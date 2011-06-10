package am

class Commande {

	Date date_commande
	Date date_livraison
	Client client
	String statut
	static hasMany = [commande_produits : Commande_Produit]
	static fetchMode = [commande_produits : 'eager']
	Date dateCreated
	Date lastUpdated
	
	static mapping = {
		commande_produits cascade: "all-delete-orphan"
		version false
	}
	
	static constraints = {
    }
}

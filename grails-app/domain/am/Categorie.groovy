package am

class Categorie {
	int id
	String nom
	
	static hasmany = [produits : Produit]

	static constraints = {
    }
}

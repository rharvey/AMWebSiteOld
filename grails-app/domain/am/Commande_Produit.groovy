package am

import java.io.Serializable;

class Commande_Produit implements Serializable {
	
	int id
	Commande commande
	Produit produit
	
	int nbr_caisse
	//float prix_vendu
	//float prix_detail_suggere	
	
	static mapping = {
		version false
	}
	
    static constraints = {
    }
}

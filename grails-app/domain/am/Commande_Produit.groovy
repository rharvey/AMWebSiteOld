package am

import java.io.Serializable;

class Commande_Produit implements Serializable {
	
	static belongsTo = [commande: Commande]
	Produit produit
	
	int nbr_caisse
	float prix_vendu
	float prix_detail_suggere	
	
	static mapping = {
		version false
	}
	
    static constraints = {
		nbr_caisse(min:0)
    }
}

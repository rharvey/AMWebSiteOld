package am

import java.sql.SQLException;
import groovy.sql.Sql

class maj_produit {

	static void main(String[] args) {
		def nbrUpdated = 0
		def nbrInserted = 0
		def nbrInvalid = 0

		def sql = Sql.newInstance("jdbc:mysql://localhost:3306/am", "root",
			"harr\$0909", "com.mysql.jdbc.Driver")

		def date_maj = new Date()
/*		use(csvParser.class) {
			File file = new File("d:\\dev\\actionmarketing\\data\\produits.csv")
			file.parseCSV { index,field ->
								
				if (index > 2) {
					if (field.size ==9) {
						try {
							def update = sql.executeUpdate("update produit set prix=?, coutant=?,inventaire=?, achat=?, commande=?, disponible=?, date_maj=?  where code = ?", 
												[field[3][1..-1],field[4][1..-1],field[5],field[6],field[7],field[8], date_maj, field[0] ]) 
							if (update == 0) {
								def insert = sql.executeInsert("insert into produit (code,upc,description,prix,coutant,inventaire,achat,commande,disponible,date_maj,date_creation) VALUES(?,?,?,?,?,?,?,?,?,?,?)",
																field[0],field[1],field[2],field[3][1..-1],field[4][1..-1],field[5],field[6],field[7],field[8],date_maj, date_maj)
								nbrInserted++
							} else {
								nbrUpdated++
							}
							if (index % 100 == 0) {
								println "."
							}							
							print "."
						} catch (SQLException ex)  {
							println "row: ${index} | ${field[0]} ${field[1]} ${field[2]}"
							nbrInvalid++							
						}
					} else {
						nbrInvalid++
					}
				}
			}
			println "/n/r****"
			println "nombre de produits mises a jour ${nbrUpdated}"
			println "nombre de nouveaux produits ${nbrInserted}"
			println "nombre de produits invalides ${nbrInvalid}"

		}
		*/
	}

}

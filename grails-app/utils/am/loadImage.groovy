package am
import groovy.sql.Sql

import java.sql.SQLException

class loadImage {
  
	static void main(String[] args) {
		
		def sql = Sql.newInstance("jdbc:mysql://localhost:3306/am", "root",
	           "harr\$0909", "com.mysql.jdbc.Driver")
		
		sql.execute("delete from produit_image")		
	    sql.eachRow("select * from produit"){ row ->
	      println row.code + " --- " + row.description
		   
		   def f = new File('d:/dev/ActionMarketing/petit dossier/').eachFileMatch( ~".*${row.code}.*jpg" ) { f ->
			   def fis = new FileInputStream(f)

			   try {
				   sql.execute("insert produit_image (idproduit, image) values(${row.idproduit}, ${fis})")
			   } 
			   catch (SQLException ex) {
			   		println f.name + " unable to load " + ex.message					   
			   }
			   println "image -> " + f.name + " has been inserted"
			}
		 
		}
	}
}

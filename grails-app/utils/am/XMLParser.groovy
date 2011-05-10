package am

class XMLParser {

	static main(args) {
		
		def tickets = new XmlParser().parse("D:\\data\\TicketsExport_20110426.xml")
		
		println "date extraction = ${tickets.attribute("Extract_Date")}"
		tickets.incidents.tickets.each{
		  println it.attribute.("Ticket_Number")
		}
	}

}

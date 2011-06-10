package am

import grails.converters.JSON;

class ClientController {
	def clientService
	
	def scaffold = true

	def defaultAction = 'list'

		def editClient = {
		def client
		def adresse
		def message = ""
		def state = ""
		def id

		// determine our action. Grid will pass a param called "oper"
		switch (params.oper) {
			// Delete Request
			case 'del':
				client = Client.get(params.id)
				if (client) {
					client.delete()
					message = "Client '${client}' Deleted"
					state = "OK"
				}
				break;
			// Add Request
			case 'add':
				client = new Client(params)
				client.adresse = new Adresse(params)
				message = clientService.save(client)
	
				break;
			// Edit Request
			case 'edit':
				// add or edit instruction sent
				client = Client.get(params.id)				
				client.properties = params
								
				if (!client.adresse) {
					client.adresse = new Adresse(params)				
				}				
				client.adresse?.properties = params				
				
				message = clientService.save(client)
				break;
		}

		if (message == "" || message == "OK") {
			state = "OK"
		} else {
			state = "FAIL"
		}

		//render [message:message, state:state, id:id] as JSON
		def jsonData = [message: message, state: state, id: id]
		render jsonData as JSON
	}

	
	def listClient = {
		def sortIndex = params.sidx ?: 'numero'
		def sortOrder  = params.sord ?: 'asc'

		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1

		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def clients = Client.createCriteria().list(max: maxRows, offset: rowOffset) {

			if (params.numero)
				ilike('numero', '%' + params.numero + '%')

			if (params.raison_social)
				ilike('raison_social', '%' + params.raison_social + '%')

			if (params.courriel)
				ilike('courriel', '%' + params.courriel + '%')

			order(sortIndex, sortOrder).ignoreCase()
		}

		def totalRows = clients.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)

		def jsonCells = clients?.collect {
			[
				 cell: [
					it.numero,
					it.raison_social,
					it.adresse?.no_civic,
					it.adresse?.rue,
					it.adresse?.ville,
					it.adresse?.code_postale,
					it.courriel,
					it.adresse?.id
				],
				 id: it.id,
			]
		}

		def jsonData= [rows: jsonCells,
					   page: currentPage,
					   records: totalRows,
					   total: numberOfPages]

		render jsonData as JSON
	}

}

package am

import grails.converters.JSON;

class ClientController {

	def scaffold = true
	
	def defaultAction = 'list'

		def editClient = {
		def result
		def message = ""
		def state = "FAIL"
		def id

		// determine our action. Grid will pass a param called "oper"
		switch (params.oper) {
			// Delete Request
			case 'del':
				result = Client.get(params.id)
				if (result) {
					result.delete()
					message = "Client'${result.numero}' Deleted"
					state = "OK"
				}
				break;
			// Add Request
			case 'add':
				result = new Client(params)
				break;
			// Edit Request
			case 'edit':
				// add or edit instruction sent
				result = Client.get(params.id)
				result.properties = params
				break;
		}

		// If we aren't deleting the object then we need to validate and save.
		// Capture any validation messages to display on the client side
		if (result && params.oper != "del") {
			if (!result.hasErrors() && result.save(flush: true)) {
				message = "Client  '${result.numero}' " + (params.oper == 'add') ? "Added" : "Updated"
				id = result.id
				state = "OK"
			} else {
				message = "<ul>"
				result.errors.allErrors.each {
					message += "<li>${messageSource.getMessage(it)}</li>"
				}
				message += "</ul>"
			}
		}

		//render [message:message, state:state, id:id] as JSON
		def jsonData = [messsage: message, state: state, id: id]
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
					it.courriel
				],
				 id: it.id
			]
		}

		def jsonData= [rows: jsonCells,
					   page: currentPage,
					   records: totalRows,
					   total: numberOfPages]

		render jsonData as JSON
	}

}

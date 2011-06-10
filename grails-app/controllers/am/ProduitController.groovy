package am

import grails.converters.JSON

class ProduitController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST", confirmerCommande:"POST"]
	
	def CommandeService commandeService

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def model = [produitInstanceList: Produit.list(params),
					 produitInstanceTotal: Produit.count(), Client: Client]

		model
		 
    }

	def setClient = {
		def resultat
		def nbr_caisse = 0
		def pds = 0
		def coutant = 0
		
		println "setClient params --> ${params}"
		def client = Client.get(params.client_id)

		def commande = Commande.findByClientAndStatut(client, 'En cours')
		if (commande == null) {
			commande = commandeService.createCommande(client)
			flash.message = "Commande creer avec succes!!!"
		}
		
		if (client == null) {
			resultat = [resultat: 'failure']
		} else {
			resultat = [success: 'success',
						commande: commande, 
						totalCommande: commandeService.getTotalCommande(commande)]		
		}
		
		println resultat
		render resultat as JSON
	}

	def confirmerCommande = {
		commandeService.comfirmerCommande(Commande.get(params.commande_id))		
        flash.message = "Commande ${params.commande_id} confirmé, un représentant prendra contact avec vous."
	}	
	
	def annulerCommande = {
		commandeService.annulerCommande(Commande.get(params.commande_id))
		flash.message = "Commande ${params.commande_id} annuler."		
	}
	
    def create = {
        def produitInstance = new Produit()
        produitInstance.properties = params
        return [produitInstance: produitInstance]
    }

    def save = {
        def produitInstance = new Produit(params)
        if (produitInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'produit.label', default: 'Produit'), produitInstance.id])}"
            redirect(action: "show", id: produitInstance.id)
        }
        else {
            render(view: "create", model: [produitInstance: produitInstance])
        }
    }

    def show = {
        def produitInstance = Produit.get(params.id)
        if (!produitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
            redirect(action: "list")
        }
        else {
            [produitInstance: produitInstance]
        }
    }

    def edit = {
        def produitInstance = Produit.get(params.id)
        if (!produitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [produitInstance: produitInstance]
        }
    }

    def update = {
        def produitInstance = Produit.get(params.id)
        if (produitInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (produitInstance.version > version) {
                    
                    produitInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'produit.label', default: 'Produit')] as Object[], "Another user has updated this Produit while you were editing")
                    render(view: "edit", model: [produitInstance: produitInstance])
                    return
                }
            }
            produitInstance.properties = params
            if (!produitInstance.hasErrors() && produitInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'produit.label', default: 'Produit'), produitInstance.id])}"
                redirect(action: "show", id: produitInstance.id)
            }
            else {
                render(view: "edit", model: [produitInstance: produitInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def produitInstance = Produit.get(params.id)
        if (produitInstance) {
            try {
                produitInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'produit.label', default: 'Produit'), params.id])}"
            redirect(action: "list")
        }
    }
	
	def viewImage = {
		
	  def image = Image.findByProduit_id( params.id )
		  
		  if (image != null) {
			  byte[] bimage = image.image
			  response.outputStream << bimage
		  }
	}
	
	def majCommande = {
		println "majCommande params--> ${params}"
		def rep
		def resultat = [res:'success']
		def commande
		
		if (params.commande_id) {
			commande = Commande.get(params.commande_id)
		} else {
			commande = Commande.findByClientAndStatut(Client.get(params.client_id),'En cours')
			if (commande == null){
				commande = commandeService.createCommande(Client.get(params.client_id))
			}
		}
		
		commande = commandeService.majCommande(commande, params.code, params.commande as int)
		
		println "majCommande params --> ${params}"
		rep = [resultat: resultat, commande: commande, totalCommande: commandeService.getTotalCommande(commande)]
		
		render rep as JSON
	}
		
	def updateCommande = {		
		def state = "OK"
		def message = "ti gui dou!!!"
		def rowId = params.id
		
		def jsonData = [message: message, state: state, id: rowId]
		render jsonData as JSON
	}
	
	def listCommande = {
		println "listCommande params --> ${params}"
		def float zero = 0
		def sortIndex = params.sidx ?: 'name'
		def sortOrder  = params.sord ?: 'asc'
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def produits = Produit.createCriteria().list(max: maxRows, offset: rowOffset) {
			
			isNotNull("description")
			gt('prix', zero)
			gt('coutant', zero)
			
			if (params.description)
				ilike('description', "%${params.description}%")
			
			if (params.format) {
				ilike('format', "%${params.format}%")
			}
			if (params.code) {
				ilike('code', "%${params.code}%")
			}
			if (params.upc) {
				ilike('upc', "%${params.upc}%")
			}
			
			
			order(sortIndex, sortOrder).ignoreCase()
		}
		
		def commande
		if (!params.commande_id) {
			if (params.client_id) {
				commande = Commande.findByClientAndStatut(Client.get(params.client_id),'En cours')
			}
		} else {
			commande = Commande.get(params.commande_id)
		}
			
		def totalRows = produits.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def results = produits?.collect {
			def commande_produit = commande?.commande_produits.find { cp -> cp.produit.code == it.code }
			
			def nbr_caisse = (commande_produit == null) ? 0 : commande_produit.nbr_caisse
			[
				cell: [it.description, it.code, it.emballage, it.format, it.upc, nbr_caisse, it.prix, it.coutant ],
				 id: it.id
			]
		}
		
		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages, commande: commande]
				render jsonData as JSON
    }
	
	def editCommande = {
		def result
		def message = ""
		def state = "FAIL"
		def id

		// determine our action. Grid will pass a param called "oper"
		switch (params.oper) {
			// Delete Request
			case 'del':
				result = Produit.get(params.id)
				if (result) {
					result.delete()
					message = "Produit '${result.code}' Deleted"
					state = "OK"
				}
				break;
			// Add Request
			case 'add':
				result = new Produit(params)
				break;
			// Edit Request
			case 'edit':
				// add or edit instruction sent
				result = Produit.get(params.id)
				result.properties = params
				break;
		}

		// If we aren't deleting the object then we need to validate and save.
		// Capture any validation messages to display on the client side
		if (result && params.oper != "del") {
			if (!result.hasErrors() && result.save(flush: true)) {
				message = "Produit  '${result.code}' " + (params.oper == 'add') ? "Added" : "Updated"
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

}
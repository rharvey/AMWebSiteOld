package am

import grails.converters.JSON

class ProduitController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
		def model = [produitInstanceList: Produit.list(params),
					 produitInstanceTotal: Produit.count(), categories:
					 Categorie.list().sort().nom]

		model
		 
    }
	def updateList = {
		def categorie = Categorie.findByNom(params.categorieSelected)
		
		println "categorie.id --> ${categorie.id}"
		[produitInstanceList: Produit.findAllByCategorieId(categorie?.id).sort(),
			    produitInstanceTotal: Produit.findAllByCategorieId(categorie?.id).count()]

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
	def updateNbrCaisse = {		

		def cumulCaisse = 0
		println "Total caisse avant: ${params.totCaisse}"
		
		if (params.totCaisse.isInteger()) {
			cumulCaisse = params.totCaisse.toInteger() + params.nbrCaisses.toInteger()
		} else {
			cumulCaisse = params.nbrCaisses
		}
		
		render cumulCaisse.toString()
	}
	
	def listCommande = {
		def sortIndex = params.sidx ?: 'name'
		def sortOrder  = params.sord ?: 'asc'
		def maxRows = Integer.valueOf(params.rows)
		def currentPage = Integer.valueOf(params.page) ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		def produits = Produit.createCriteria().list(max: maxRows, offset: rowOffset) {
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
		
		def totalRows = produits.totalCount
		def numberOfPages = Math.ceil(totalRows / maxRows)
		
		def results = produits?.collect {
			[
				 cell: [it.description, it.code, it.emballage, it.format, it.upc, it.prix, it.coutant],
				 id: it.id
			]
		}
		
		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
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
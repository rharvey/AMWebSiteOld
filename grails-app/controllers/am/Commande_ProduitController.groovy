package am

class Commande_ProduitController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [commande_ProduitInstanceList: Commande_Produit.list(params), commande_ProduitInstanceTotal: Commande_Produit.count()]
    }

    def create = {
        def commande_ProduitInstance = new Commande_Produit()
        commande_ProduitInstance.properties = params
        return [commande_ProduitInstance: commande_ProduitInstance]
    }

    def save = {
        def commande_ProduitInstance = new Commande_Produit(params)
        if (commande_ProduitInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), commande_ProduitInstance.id])}"
            redirect(action: "show", id: commande_ProduitInstance.id)
        }
        else {
            render(view: "create", model: [commande_ProduitInstance: commande_ProduitInstance])
        }
    }

    def show = {
        def commande_ProduitInstance = Commande_Produit.get(params.id)
        if (!commande_ProduitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
            redirect(action: "list")
        }
        else {
            [commande_ProduitInstance: commande_ProduitInstance]
        }
    }

    def edit = {
        def commande_ProduitInstance = Commande_Produit.get(params.id)
        if (!commande_ProduitInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [commande_ProduitInstance: commande_ProduitInstance]
        }
    }

    def update = {
        def commande_ProduitInstance = Commande_Produit.get(params.id)
        if (commande_ProduitInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commande_ProduitInstance.version > version) {
                    
                    commande_ProduitInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'commande_Produit.label', default: 'Commande_Produit')] as Object[], "Another user has updated this Commande_Produit while you were editing")
                    render(view: "edit", model: [commande_ProduitInstance: commande_ProduitInstance])
                    return
                }
            }
            commande_ProduitInstance.properties = params
            if (!commande_ProduitInstance.hasErrors() && commande_ProduitInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), commande_ProduitInstance.id])}"
                redirect(action: "show", id: commande_ProduitInstance.id)
            }
            else {
                render(view: "edit", model: [commande_ProduitInstance: commande_ProduitInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def commande_ProduitInstance = Commande_Produit.get(params.id)
        if (commande_ProduitInstance) {
            try {
                commande_ProduitInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande_Produit.label', default: 'Commande_Produit'), params.id])}"
            redirect(action: "list")
        }
    }
}

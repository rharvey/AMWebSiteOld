package am

class CommandeController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [commandeInstanceList: Commande.list(params), commandeInstanceTotal: Commande.count()]
    }

    def create = {
        def commandeInstance = new Commande()
        commandeInstance.properties = params
        return [commandeInstance: commandeInstance]
    }

    def save = {
        def commandeInstance = new Commande(params)
        if (commandeInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'commande.label', default: 'Commande'), commandeInstance.id])}"
            redirect(action: "show", id: commandeInstance.id)
        }
        else {
            render(view: "create", model: [commandeInstance: commandeInstance])
        }
    }

    def show = {
        def commandeInstance = Commande.get(params.id)
        if (!commandeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
            redirect(action: "list")
        }
        else {
            [commandeInstance: commandeInstance]
        }
    }

    def edit = {
        def commandeInstance = Commande.get(params.id)
        if (!commandeInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [commandeInstance: commandeInstance]
        }
    }

    def update = {
        def commandeInstance = Commande.get(params.id)
        if (commandeInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (commandeInstance.version > version) {
                    
                    commandeInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'commande.label', default: 'Commande')] as Object[], "Another user has updated this Commande while you were editing")
                    render(view: "edit", model: [commandeInstance: commandeInstance])
                    return
                }
            }
            commandeInstance.properties = params
            if (!commandeInstance.hasErrors() && commandeInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'commande.label', default: 'Commande'), commandeInstance.id])}"
                redirect(action: "show", id: commandeInstance.id)
            }
            else {
                render(view: "edit", model: [commandeInstance: commandeInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def commandeInstance = Commande.get(params.id)
        if (commandeInstance) {
            try {
                commandeInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'commande.label', default: 'Commande'), params.id])}"
            redirect(action: "list")
        }
    }
}

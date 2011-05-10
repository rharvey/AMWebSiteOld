package am

class CategorieController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index = {
        redirect(action: "list", params: params)
    }

    def list = {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [categorieInstanceList: Categorie.list(params), categorieInstanceTotal: Categorie.count()]
    }

    def create = {
        def categorieInstance = new Categorie()
        categorieInstance.properties = params
        return [categorieInstance: categorieInstance]
    }

    def save = {
        def categorieInstance = new Categorie(params)
        if (categorieInstance.save(flush: true)) {
            flash.message = "${message(code: 'default.created.message', args: [message(code: 'categorie.label', default: 'Categorie'), categorieInstance.id])}"
            redirect(action: "show", id: categorieInstance.id)
        }
        else {
            render(view: "create", model: [categorieInstance: categorieInstance])
        }
    }

    def show = {
        def categorieInstance = Categorie.get(params.id)
        if (!categorieInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
            redirect(action: "list")
        }
        else {
            [categorieInstance: categorieInstance]
        }
    }

    def edit = {
        def categorieInstance = Categorie.get(params.id)
        if (!categorieInstance) {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
            redirect(action: "list")
        }
        else {
            return [categorieInstance: categorieInstance]
        }
    }

    def update = {
        def categorieInstance = Categorie.get(params.id)
        if (categorieInstance) {
            if (params.version) {
                def version = params.version.toLong()
                if (categorieInstance.version > version) {
                    
                    categorieInstance.errors.rejectValue("version", "default.optimistic.locking.failure", [message(code: 'categorie.label', default: 'Categorie')] as Object[], "Another user has updated this Categorie while you were editing")
                    render(view: "edit", model: [categorieInstance: categorieInstance])
                    return
                }
            }
            categorieInstance.properties = params
            if (!categorieInstance.hasErrors() && categorieInstance.save(flush: true)) {
                flash.message = "${message(code: 'default.updated.message', args: [message(code: 'categorie.label', default: 'Categorie'), categorieInstance.id])}"
                redirect(action: "show", id: categorieInstance.id)
            }
            else {
                render(view: "edit", model: [categorieInstance: categorieInstance])
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
            redirect(action: "list")
        }
    }

    def delete = {
        def categorieInstance = Categorie.get(params.id)
        if (categorieInstance) {
            try {
                categorieInstance.delete(flush: true)
                flash.message = "${message(code: 'default.deleted.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
                redirect(action: "list")
            }
            catch (org.springframework.dao.DataIntegrityViolationException e) {
                flash.message = "${message(code: 'default.not.deleted.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
                redirect(action: "show", id: params.id)
            }
        }
        else {
            flash.message = "${message(code: 'default.not.found.message', args: [message(code: 'categorie.label', default: 'Categorie'), params.id])}"
            redirect(action: "list")
        }
    }
}

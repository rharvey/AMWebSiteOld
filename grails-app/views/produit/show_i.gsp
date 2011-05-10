
<%@ page import="am.Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produit.label', default: 'Produit')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
				<table id="data">
		        	<tbody>                    
		                	<tr class="prop">
		                    	<td valign="top" class="name"><g:message code="produit.id.label" default="Id" /></td>
		                        <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "id")}</td>
		                    </tr>
							<tr class="prop">
		                    	<td valign="top" class="name"><g:message code="produit.achat.label" default="Achat" /></td>
		                        <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "achat")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.code.label" default="Code" /></td>
	                           	<td valign="top" class="value">${fieldValue(bean: produitInstance, field: "code")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.commande.label" default="Commande" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "commande")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.coutant.label" default="Coutant" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "coutant")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.description.label" default="Description" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "description")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.disponible.label" default="Disponible" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "disponible")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.image.label" default="Image" /></td>
	                            <td valign="top" style="text-align: left;" class="value">
	                                <ul>
	                                <g:each in="${produitInstance.image}" var="i">
	                                    <li><g:link controller="image" action="show" id="${i.id}">${i?.encodeAsHTML()}</g:link></li>
	                                </g:each>
	                                </ul>
	                            </td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.inventaire.label" default="Inventaire" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "inventaire")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.prix.label" default="Prix" /></td>
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "prix")}</td>
	                        </tr>
	                        <tr class="prop">
	                            <td valign="top" class="name"><g:message code="produit.upc.label" default="Upc" /></td>
	                            
	                            <td valign="top" class="value">${fieldValue(bean: produitInstance, field: "upc")}</td>
	                            
	                        </tr>
		            	</tbody>
				</table> 
                <table id="image">
					<tbody>
	                	<tr>
			                <td>
								<img src="${createLink(action:'viewImage', id: produitInstance.id)}" width="100" height="100" alt="Pas d'image"/>                            
			              	</td>
		              	</tr>
	              	</tbody>
              	</table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${produitInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>

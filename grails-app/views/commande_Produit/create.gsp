

<%@ page import="am.Commande_Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'commande_Produit.label', default: 'Commande_Produit')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${commande_ProduitInstance}">
            <div class="errors">
                <g:renderErrors bean="${commande_ProduitInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commande"><g:message code="commande_Produit.commande.label" default="Commande" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commande_ProduitInstance, field: 'commande', 'errors')}">
                                    <g:select name="commande.id" from="${am.Commande.list()}" optionKey="id" value="${commande_ProduitInstance?.commande?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="nbr_caisse"><g:message code="commande_Produit.nbr_caisse.label" default="Nbrcaisse" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commande_ProduitInstance, field: 'nbr_caisse', 'errors')}">
                                    <g:textField name="nbr_caisse" value="${fieldValue(bean: commande_ProduitInstance, field: 'nbr_caisse')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="produit"><g:message code="commande_Produit.produit.label" default="Produit" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commande_ProduitInstance, field: 'produit', 'errors')}">
                                    <g:select name="produit.id" from="${am.Produit.list()}" optionKey="id" value="${commande_ProduitInstance?.produit?.id}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>

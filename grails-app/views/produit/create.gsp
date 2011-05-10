

<%@ page import="am.Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produit.label', default: 'Produit')}" />
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
            <g:hasErrors bean="${produitInstance}">
            <div class="errors">
                <g:renderErrors bean="${produitInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="achat"><g:message code="produit.achat.label" default="Achat" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'achat', 'errors')}">
                                    <g:textField name="achat" value="${fieldValue(bean: produitInstance, field: 'achat')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="code"><g:message code="produit.code.label" default="Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'code', 'errors')}">
                                    <g:textField name="code" value="${produitInstance?.code}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="commande"><g:message code="produit.commande.label" default="Commande" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'commande', 'errors')}">
                                    <g:textField name="commande" value="${fieldValue(bean: produitInstance, field: 'commande')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="coutant"><g:message code="produit.coutant.label" default="Coutant" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'coutant', 'errors')}">
                                    <g:textField name="coutant" value="${fieldValue(bean: produitInstance, field: 'coutant')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="produit.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${produitInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="disponible"><g:message code="produit.disponible.label" default="Disponible" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'disponible', 'errors')}">
                                    <g:textField name="disponible" value="${fieldValue(bean: produitInstance, field: 'disponible')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="inventaire"><g:message code="produit.inventaire.label" default="Inventaire" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'inventaire', 'errors')}">
                                    <g:textField name="inventaire" value="${fieldValue(bean: produitInstance, field: 'inventaire')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="prix"><g:message code="produit.prix.label" default="Prix" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'prix', 'errors')}">
                                    <g:textField name="prix" value="${fieldValue(bean: produitInstance, field: 'prix')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="upc"><g:message code="produit.upc.label" default="Upc" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: produitInstance, field: 'upc', 'errors')}">
                                    <g:textField name="upc" value="${produitInstance?.upc}" />
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



<%@ page import="am.Commande" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'commande.label', default: 'Commande')}" />
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
            <g:hasErrors bean="${commandeInstance}">
            <div class="errors">
                <g:renderErrors bean="${commandeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="client"><g:message code="commande.client.label" default="Client" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commandeInstance, field: 'client', 'errors')}">
                                    <g:select name="client.id" from="${am.Client.list()}" optionKey="id" value="${commandeInstance?.client?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="date_commande"><g:message code="commande.date_commande.label" default="Datecommande" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commandeInstance, field: 'date_commande', 'errors')}">
                                    <g:datePicker name="date_commande" precision="day" value="${commandeInstance?.date_commande}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="date_livraison"><g:message code="commande.date_livraison.label" default="Datelivraison" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: commandeInstance, field: 'date_livraison', 'errors')}">
                                    <g:datePicker name="date_livraison" precision="day" value="${commandeInstance?.date_livraison}"  />
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

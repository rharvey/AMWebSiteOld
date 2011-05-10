
<%@ page import="am.Commande_Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'commande_Produit.label', default: 'Commande_Produit')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'commande_Produit.id.label', default: 'Id')}" />
                        
                            <th><g:message code="commande_Produit.commande.label" default="Commande" /></th>
                        
                            <g:sortableColumn property="nbr_caisse" title="${message(code: 'commande_Produit.nbr_caisse.label', default: 'Nbrcaisse')}" />
                        
                            <th><g:message code="commande_Produit.produit.label" default="Produit" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${commande_ProduitInstanceList}" status="i" var="commande_ProduitInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${commande_ProduitInstance.id}">${fieldValue(bean: commande_ProduitInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: commande_ProduitInstance, field: "commande")}</td>
                        
                            <td>${fieldValue(bean: commande_ProduitInstance, field: "nbr_caisse")}</td>
                        
                            <td>${fieldValue(bean: commande_ProduitInstance, field: "produit")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${commande_ProduitInstanceTotal}" />
            </div>
        </div>
    </body>
</html>


<%@ page import="am.Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produit.label', default: 'Produit')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'produit.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="achat" title="${message(code: 'produit.achat.label', default: 'Achat')}" />
                        
                            <g:sortableColumn property="code" title="${message(code: 'produit.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="commande" title="${message(code: 'produit.commande.label', default: 'Commande')}" />
                        
                            <g:sortableColumn property="coutant" title="${message(code: 'produit.coutant.label', default: 'Coutant')}" />
                        
                            <g:sortableColumn property="description" title="${message(code: 'produit.description.label', default: 'Description')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${produitInstanceList}" status="i" var="produitInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${produitInstance.id}">${fieldValue(bean: produitInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: produitInstance, field: "achat")}</td>
                        
                            <td>${fieldValue(bean: produitInstance, field: "code")}</td>
                        
                            <td>${fieldValue(bean: produitInstance, field: "commande")}</td>
                        
                            <td>${fieldValue(bean: produitInstance, field: "coutant")}</td>
                        
                            <td>${fieldValue(bean: produitInstance, field: "description")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${produitInstanceTotal}" />
            </div>
        </div>
    </body>
</html>

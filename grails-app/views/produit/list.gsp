
<%@ page import="am.Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produit.label', default: 'Produit')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:javascript library="jquery" plugin="jquery"/>
		<jq:resources />
        <jqui:resources /> 
        <jqgrid:resources />
		<script type="text/javascript" >
			    $(document).ready(function() {
				    <jqgrid:grid
				        id="commande"
				        url="'${createLink(action: 'listCommande')}'"
				        editurl="'${createLink(action: 'editCommande')}'"
				        colNames="'Description', 'Code', 'Emb', 'Format', 'UPC', 'Prix Vendu', 'Prix Coutant', 'id'"
				        colModel="{name:'description', editable:true},
				                        {name:'code', editable:true},
				                        {name:'emballage', editable:true},
				                        {name:'format', editable:true},
				                        {name:'upc', editable:true},
				                        {name:'prix', formatter:'number'},
				                         {name:'coutant', formatter:'currency'},
				                        {name:'id', hidden: true}"
				        sortname="'description'"
				        caption="'Liste des produits'"
				        height="350"
					    autowidth="false"
				        scrollOffset="0"
				        viewrecords="true"
					    showPager="true"
				        datatype="'json'"
						rowNum="12"
						cellEdit="true"						
				  		hidegrid="true">
				        <jqgrid:searchButton id="commande" />
				        <jqgrid:filterToolbar id="commande" searchOnEnter="false" />
				        <jqgrid:navigation id="commande" add="true" edit="true" 
				              del="true" search="true" refresh="true" />
				        <jqgrid:resize id="commande" resizeOffset="-2" />
					</jqgrid:grid>
		
			    });
		</script>

    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <div>
            	<g:select name="catogories" 
            			from="${categories}" 
            			onchange="${remoteFunction(action:'updateList', 
            									   params:'\'categorieSelected=\' + escape(this.value)',
            										update:'produits')}"/>	
            </div>
			<table>
			<tr>
				<td>
		            <div id="produits" class="list">
		            	<h1><g:message code="default.list.label" args="[entityName]" /></h1>
		            		<g:if test="${flash.message}">
		            			<div class="message">${flash.message}</div>		            		
			         		</g:if>
			         </div>
			        <div id="grid">
						<jqgrid:wrapper id="commande"/>
			        </div>					
				<td/>
		            <td valign="top">
			            <div>
			            	<h1>Section Commande</h1>
				         </div>		            		            
			            <table border="1">
			            	<tr>
			            		<th>Nombre de Caisses : </th>
			            		<td>0</td>
			            	</tr>
			            	<tr>
			            		<th>Total Payé : </th>
			            		<td align="center">1024$</td>
			            	</tr>            	
			            	<tr>
			            		<th>Total Vendu : </th>
			            		<td>866$</td>
			            	</tr>            	
			            	<tr>
			            		<th color="#FF0000">Profit Net : </th>
			            		<td color="#FF0000">158$</td>
			            	</tr>            	
			            	<tr>
			            		<th color="#FF0000">Profit Net : </th>
			            		<td color="#FF0000">27%</td>
			            	</tr>            	
			            </table>
		            </td>	            	
	            </tr>
            </table>

        </div>
    </body>
</html>

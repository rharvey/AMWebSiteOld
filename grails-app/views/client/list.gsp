<%@ page import="am.Client" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'client.label', default: 'Client')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <jqgrid:cssResources />
        
        <jq:resources />
        <jqui:resources />
        <jqgrid:resources />

        <script type="text/javascript">
        function onDblClickRow(id) {
            if (id) {
                var url = "${createLink(action: 'show')}";
                $(location).attr('href', url + "/" + id);
            }
        }
      
          $(document).ready(
			function () {
				<jqgrid:grid
	            id="client"
			    url="'${createLink(action: 'listClient')}'"
	            editurl="'${createLink(action: 'editClient')}'"
				colNames="'Numero', 'Raison Social', 'Courriel', 'id'"
	            colModel="{name:'numero'},
	                      {name:'raison_social', editable: true},
	                      {name:'courriel', editable: true},
	                      {name:'id', hidden: true}"
				sortName="'numero'"
   	            caption="'${entityName} List'"
   	            height="300"
   	            viewRecords="true"
			    datatype="'json'"
   	            searchOnEnter="false"
   	            	cellEdit="true"
   	   	            	cellurl="'${createLink(action: 'editClient')}'"
					rowNum="5"
						showPager="true"
   	   	   	            	            
   	            onDblClickRow="onDblClickRow">
         	            <jqgrid:deleteButton
         	                id="client"
         	                url="${createLink(action: 'editClient')}" />

         	            <jqgrid:editButton
         	                id="client"
         	                url="${createLink(action: 'editClient')}" />

         	            <jqgrid:addButton
         	                id="client"
         	                url="${createLink(action: 'create')}" />
         	            <jqgrid:searchButton id="client" />
				        <jqgrid:navigation id="client" add="true" edit="true" 
				              del="true" search="true" refresh="true" />
				      <jqgrid:filterToolbar id="client" searchOnEnter="false" />
         	            
				</jqgrid:grid>

			});
          </script>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <br />
        <div class="body" style="width:95%;">
            <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
            </g:if>

            <jqgrid:wrapper id="client" />
        </div>
    </body>
</html>

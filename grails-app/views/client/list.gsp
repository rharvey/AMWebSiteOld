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

        function afterSubmitEvent(response, postdata) {
            var success = true;
        
            var json = eval('(' + response.responseText + ')');
            var message = json.message;
        
            if(json.state == 'FAIL') {
                success = false;
            } else {
              $('#message').html(message);
              $('#message').show().fadeOut(10000);
            }
            
            var new_id = json.id
            return [success,message,new_id];
        }      

        $(document).ready(
			function () {
				<jqgrid:grid
	            id="client"
			    url="'${createLink(action: 'listClient')}'"
	            editurl="'${createLink(action: 'editClient')}'"
				colNames="'Numero', 'Raison Social', 'No Civic', 'Rue', 'Ville', 'Code Postale', 'Courriel', 'adresse_id', 'id', "
	            colModel="{name:'numero', width:60, align:'center', editable: true},
	                      {name:'raison_social', width:300, editable: true},
	                      {name:'no_civic', width:60, editable: true, align:'center'},	                      
	                      {name:'rue', width:200, editable: true},	                      
	                      {name:'ville', editable: true},	                      
	                      {name:'code_postale', width:80, editable: true, align:'center'},	                      
	                      {name:'courriel', editable: true, width:100},
	                      {name:'adresse_id', hidden: true},
	                      {name:'id', hidden: true}"
				sortName="'numero'"
   	            caption="'${entityName} List'"
   	            height="350"
				scrollOffset="0"
   	   	        autowidth="true"
   	            viewRecords="true"
			    datatype="'json'"
   	            searchOnEnter="false"
				rowNum="10"
				showPager="true"
   	   	   	            	            
   	            onDblClickRow="onDblClickRow">
        	            <jqgrid:deleteButton
        	                id="client"
        	                url="${createLink(action: 'editClient')}" />

         	            <jqgrid:editButton
         	            	caption="Modifier client"
         	                id="client"
         	                url="${createLink(action: 'editClient')}" />

         	            <jqgrid:addButton
         	                id="client"
         	                url="${createLink(action: 'editClient')}"/>

             	        <jqgrid:searchButton id="client" />

				        <jqgrid:navigation id="client" add="true" edit="true"
				              del="true" search="true" refresh="true"
				              />
			              
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
        <div class="body" style="width:98%;">
            <g:if test="${flash.message}">
              <div class="message">${flash.message}</div>
            </g:if>

            <jqgrid:wrapper id="client" />
        </div>
    </body>
</html>

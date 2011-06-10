
<%@ page import="am.Produit" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'produit.label', default: 'Produit')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
		<g:javascript library="prototype"/>
		<g:javascript library="jquery" plugin="jquery"/>
		<script type="text/javascript" >
			var client_id
			var commande
			
			function formatCurrency(num) {
				num = num.toString().replace(/\$|\,/g,'');
				if(isNaN(num))
				num = "0";
				sign = (num == (num = Math.abs(num)));
				num = Math.floor(num*100+0.50000000001);
				cents = num%100;
				num = Math.floor(num/100).toString();
				if(cents<10)
				cents = "0" + cents;
				for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
				num = num.substring(0,num.length-(4*i+3))+','+
				num.substring(num.length-(4*i+3));
				return (((sign)?'':'-') + '$' + num + '.' + cents);
			}
			 
			function getCommande() {
				if (commande == null) {
					return ''
				} else {
					return commande.id;
				}
			}

			function getClient() {
				if (client_id == null) {
					return ''
				} else {
					return client_id;
				}
			}

			function setClient(data) {
				commande = data.responseJSON.commande
				client_id = commande.client.id;
				$("#commandeGrid").trigger("reloadGrid");
	    		$("#commande_id").text(data.responseJSON.commande.id);	    		
	    		setupSectionCommande(data.responseJSON.totalCommande);
			}
			
			function updateCommande(rowid,cellname,value,iRow,iCol) 
			{
				var rowData = jQuery("#commandeGrid").getRowData(rowid);
				
				rowData['client_id'] = client_id
				if (commande != null) {
					rowData['commande_id'] = commande.id
				}
				
			    $.post('majCommande', rowData, 
					    function(rep){
				    		$('#commande_id').text(rep.commande.id);
							commande = rep.commande;
							setupSectionCommande(rep.totalCommande);				
				    	}, 
				  	'json');
				var cp
			    
			}

			function setupSectionCommande(totalCommande) {
				$('#totCaisse').text(totalCommande.nbr_caisse);
				$('#totPaye').text(formatCurrency(totalCommande.coutant)).css('color', 'red');				
				$('#totVendu').text(formatCurrency(totalCommande.pds)).css('color', 'red');  				
				$('#profitNet').text(formatCurrency(totalCommande.profitNet)).css('color', 'red');  				
				$('#profitNetPct').text(totalCommande.profitPct.toFixed(0)+'%').css('color', 'red');
				$('#message').text(flash.message)				
			}

			$(function() {
			    			    
		    	$('#btn_confirmer').button({icons: {primary:'ui-icon-cart'}}).click(function() {
  					var data = {}
  					data['commande_id'] = commande.id
  					$.post('confirmerCommande', data, function(rep) { }, 'json');  	  					
  					$("#commandeGrid").trigger("reloadGrid");
  					initCommande("0", "0", "0");
				});
				
			    $('#btn_annuler').button({icons: {primary:'ui-icon-cancel'}}).click(function() {
  					var data = {}
  					data['commande_id'] = commande.id
  				    $.post('annulerCommande', data, function(rep) { }, 'json');  	  					
  					$("#commandeGrid").trigger("reloadGrid");
  					initCommande("0", "0", "0");
				});
			});
			
			$(document).ready(function() {
			    	
			    	<jqgrid:grid
				        id="commande"
				        url="'${createLink(action: 'listCommande')}'"
				        editurl="'${createLink(action: 'editCommande')}'"
				        colNames="'Description', 'Code', 'Emb', 'Format', 'UPC', 'Commande','Prix Vendu', 'Prix Coutant', 'id'"
				        colModel="{name:'description', width:'300'},
				                        {name:'code',width:'80', align:'center'},
				                        {name:'emballage',width:'80'},
				                        {name:'format', width:'80'},
				                        {name:'upc',width:'100', align:'center'},
				                        {name:'commande', width:'80', align:'center', formatter: 'numeric',  editrules:{number:true, minValue:0}, editable:true},
				                        {name:'prix', formatter: 'currency', formatoptions:{prefix:'\$ '}, width:'80', align:'center'},
				                        {name:'coutant', formatter: 'currency', formatoptions:{prefix:'\$ '},width:'100', align:'center'},
				                        {name:'id', hidden: true}"
				        sortname="'description'"
				        caption="'Liste des produits'"
				        height="350"
					    autowidth="false"
				        viewrecords="true"
					    showPager="true"
				        datatype="'json'"
						rowNum="12"
						cellEdit="true"
						cellurl="'updateCommande'"
						hidegrid="false"
				  		afterSaveCell='updateCommande'
						postData='{commande_id: getCommande, client_id: getClient}'>
				  		
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
        </div>
      
      <g:form method="POST" >

        <div class="body">
			<g:select name="client.raison_social"
					  from="${Client.list(sort:'raison_social')}" 
					  optionKey="id"
					  optionValue="${{it.raison_social?.toUpperCase()}}"
					  onchange="${remoteFunction(
					  				action:'setClient',
					  				update:[success:'#success', failure:'ohno'], 
					  				params:'\'client_id=\' + escape(this.value)',
					  				onSuccess:'setClient(e)')}"/>          		  
			<table>
			<tr>
				<td>
		            <div id="produits" class="list">
	            		<g:if test="${flash.message}">
	            			<div class="message">${flash.message}</div>		            		
		         		</g:if>
				        <div id="grid">
							<jqgrid:wrapper id="commande"/>
				        </div>					
			         </div>
				<td/>
		            <td valign="top">
			            <div>
			            	<h1>Section Commande</h1>
				         </div>		            		            
			            <table border="1">
			            	<tr>
			            		<th>Commande Numéro: </th>
			            		<td><div id="commande_id" align="center"></div></td>
			            	</tr>
			            	<tr>
			            		<th>Nombre de Caisses : </th>
			            		<td><div id="totCaisse" align="center">0</div></td>
			            	</tr>
			            	<tr>
			            		<th>Total Payé : </th>
			            		<td><div id="totPaye" align="center">0</div></td>
			            	</tr>            	
			            	<tr>
			            		<th>Total Vendu : </th>
			            		<td><div id="totVendu" align="center">0</div></td>
			            	</tr>            	
			            	<tr>
			            		<th>Profit Net : </th>
			            		<td><div id="profitNet" align="center">0</div></td>
			            	</tr>            	
			            	<tr>
			            		<th>Profit Net : </th>
			            		<td ><div id="profitNetPct" align="center">0</div></td>
			            	</tr>            	
			            </table>
		            </td>	            	
	            </tr>
            </table>
            <div class="buttons">
				<button id="btn_confirmer">Confirmer Commande</button>
				<button id="btn_annuler">Annuler Commande</button>
			</div>
        </div>	
			</g:form>
    </body>
</html>
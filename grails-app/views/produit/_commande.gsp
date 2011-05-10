<table class="ajax">
                
	<thead>
    	<tr>                    
			<g:sortableColumn disabled="true" property="id" title="${message(code: 'produit.id.label', default: 'Id')}" />
           
			<g:sortableColumn property="achat" title="${message(code: 'produit.achat.label', default: 'Achat')}" />
           
            <g:sortableColumn property="code" title="${message(code: 'produit.code.label', default: 'Code')}" />
        
            <g:sortableColumn property="commande" title="${message(code: 'produit.commande.label', default: 'Commande')}" />
        
            <g:sortableColumn property="coutant" title="${message(code: 'produit.coutant.label', default: 'Coutant')}" />
        
            <g:sortableColumn property="description" title="${message(code: 'produit.description.label', default: 'Description')}" />
           
			<th>Commande<th/>
			
            <g:sortableColumn property="image" title="${message(code: 'produit.description.label', default: 'Image')}" />
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
               <td>
               <g:textField 	maxlength="5"
               					id="nbrCaisse" 
               					name="nbrCaisse" 
               					onchange="${remoteFunction(	action:'updateNbrCaisse', 
                    							params:'\'nbrCaisses=\' + escape(this.value)+ \'&totCaisse=\' + escape(document.getElementById(\'totCaisse\').value)', 
                   								update:'updTotCaisse')}"/>	
           	</td>	                        
           	<td><img src="${createLink(action:'viewImage', id: produitInstance.id)}" width="100" height="100" alt="Pas d'image"/></td>                         
           </tr>
       </g:each>                    
       </tbody>
   </table>
<div class="paginateButtons">
    <g:paginate total="${produitInstanceTotal}" />
</div>            

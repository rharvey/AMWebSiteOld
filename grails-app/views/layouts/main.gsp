<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
		<jq:resources />
        <jqgrid:resources/>
        <jqgrid:scriptResources/>
        <jqui:resources themeCss="../css/cupertino/jquery-ui-1.8.13.custom.css"/>         
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <div id="amLogo"><img src="${resource(dir:'images',file:'AM_Logo.jpg')}" width="8%" alt="Action Marketing" border="0" /></div>
        <g:layoutBody />
    </body>
</html>
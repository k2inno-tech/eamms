<%@include file="/common/header.jsp" %>

<c:set var="w" value="${widget}" />
<table width="100%" cellpadding="1" cellspacing="0" class="contentBgColor">
<tr>
	<td>
		<table width="100%" cellpadding="0" cellspacing="0" class="classBackground">
   			<tr>
        		<td>
					<table width="100%" cellpadding="3" cellspacing="1">
                		<jsp:include page="../form_header.jsp" flush="true"/>
						 <tr>
						     <td class="classRowLabel" width="20%" valign="top" align="right">
						         <fmt:message key='po.label.country'/> *
						     </td>
						     <td class="classRow" width="80%" valign="top">
						         <x:display name="${w.country.absoluteName}" />
						     </td>
						 </tr>
						 <tr>
						     <td class="classRowLabel" width="20%" valign="top" align="right">
						         <fmt:message key='po.menu.currency'/> *
						     </td>
						     <td class="classRow" width="80%" valign="top">
						         <x:display name="${w.currency.absoluteName}" />
						     </td>
						 </tr>
						  <tr>
						     <td class="classRowLabel" width="20%" valign="top" align="right">
						         
						     </td>
						     <td class="classRow" width="80%" valign="top">
						         <x:display name="${w.btnPanel.absoluteName}" />
						     </td>
						 </tr>
                		<jsp:include page="../form_footer.jsp" flush="true"/>
					</table>
        		</td>
			</tr>
		</table>
	</td>
</tr>
</table>


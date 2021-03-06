<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>

 
<c:set var="form" value="${widget}"/>   

<jsp:include page="../form_header.jsp" flush="true"/>
<c:choose>
<c:when test="${form.type == 'View'}">
	<table border="1" cellpadding="2" cellspacing="0" class="formStyle" width="<c:out value="${form.width}"/>">
		<tr>
			<td valign="top" width="25%"><b><fmt:message key='sfa.message.categoryName'/>:&nbsp;</b></td>
			<td valign="top" width="75%"><x:display name="${form.absoluteName}.lbCategoryName"/></td>
		</tr> 
		
	</table>
</c:when>
<c:when test="${form.type == 'Edit' or form.type == 'Add'}">
	<table border="1" cellpadding="2" cellspacing="0" class="formStyle" width="<c:out value="${form.width}"/>">
		<tr>
			<td valign="top" width="25%"><b><fmt:message key='sfa.label.categoryName'/>:&nbsp; *</b></td>
			<td valign="top" width="75%"><x:display name="${form.absoluteName}.categoryName"/></td>
		</tr>
		<tr>
			<td align="center" colspan="2">
				<x:display name="${form.absoluteName}.submit"/>
				<c:if test="${form.type == 'Edit'}">
					<x:display name="${form.absoluteName}.cancel"/>
				</c:if>
			</td>
		</tr>
	</table>
</c:when>
</c:choose>
<jsp:include page="../form_footer.jsp" flush="true"/>

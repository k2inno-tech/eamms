<%@ include file="/common/header.jsp" %>


<x:config>
  <page name="fms_postProductionPage">
    	<com.tms.fms.engineering.ui.PostProductionForm name="edit" width="100%"/>
  </page>
</x:config>

<c:set var="type" value="Edit"/>
<c:choose>
  <c:when test="${not empty(param.id)}">
    <c:set var="id" value="${param.id}"/>
  </c:when>
  <c:otherwise>
    <c:set var="id" value="${widgets['fms_postProductionPage.edit'].id}"/>
  </c:otherwise>
</c:choose>
<x:set name="fms_postProductionPage.edit" property="id" value="${id}"/>
<x:set name="fms_postProductionPage.edit" property="type" value="${type}"/>

<c:choose>
  <c:when test="${forward.name == 'ADDED'}">
    <script>alert('<fmt:message key="fms.facility.msg.postProductionBookingUpdated"/>'); 
    	window.opener.location="requestDetails.jsp";
    	window.close();
    </script>
  </c:when>
  <c:when test="${forward.name == 'EXISTS'}">
    <script>alert('<fmt:message key="fms.facility.msg.postProductionBookingExists"/>');</script>
  </c:when>
  <c:when test="${forward.name == 'FAILED'}">
    <script>alert('<fmt:message key="fms.facility.msg.postProductionBookingNotUpdate"/>');</script>
  </c:when>
  <c:when test="${forward.name == 'MODIFIED'}">
    <script>
		alert('<fmt:message key="fms.facility.msg.bookingAdded"/>'); 
	    window.opener.location="requestServiceModify.jsp";
    	window.close();
    </script>
  </c:when>
</c:choose>
<%@include file="/ekms/includes/linkCSS.jsp" %>
<jsp:include page="includes/header.jsp" />
<table width="100%" border="0" cellspacing="0" cellpadding="5">
    <tr valign="middle">
        <td height="22" bgcolor="#003366" class="contentTitleFont"><b><font color="#FFCF63" class="contentTitleFont"><fmt:message key="fms.facility.msg.postProductionBooking"/></font></b></td>
        <td align="right" bgcolor="#003366" class="contentTitleFont">&nbsp;</td>
    </tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor">

        <x:display name="fms_postProductionPage.edit"/>
    
    </td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#CCCCCC" class="contentStrapColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="15"></td></tr>
</table>

<jsp:include page="includes/footer.jsp" />

<%@include file="includes/taglib.jsp" %>
<%@ page import="com.tms.collab.messaging.ui.NewPop3AccountForm"%>

<x:config>
    <page name="newPop3AccountPage">
        <com.tms.collab.messaging.ui.NewPop3AccountForm name="form"/>
    </page>
</x:config>

<c-rt:set var="forwardSuccess" value="<%= NewPop3AccountForm.FORWARD_SUCCESS %>"/>
<c:if test="${forward.name eq forwardSuccess}">
    <c:redirect url="pop3AccountList.jsp" />
</c:if>

<c-rt:set var="forwardError" value="<%= NewPop3AccountForm.FORWARD_ERROR %>" />
<c:if test="${forward.name eq forwardError}">
    <c:redirect url="error.jsp" />
</c:if>

<%@include file="includes/header.jsp" %>


<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="MIDDLE">
    <td height="22" bgcolor="#003366" class="contentTitleFont"><b><font color="#FFCF63" class="contentTitleFont">
      &nbsp;<fmt:message key='messaging.label.pOP3AccountListing'/> > <fmt:message key='messaging.label.newPOP3Account'/>
    </font></b></td>
    <td align="right" bgcolor="#003366" class="contentTitleFont">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP">
        <x:display name="newPop3AccountPage.form" />
    </td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#CCCCCC" class="contentStrapColor">
      <img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="15"> </td>
  </tr>
</table>


<%@include file="includes/footer.jsp" %>

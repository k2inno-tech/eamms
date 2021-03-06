<%@ page import="com.tms.collab.directory.ui.FolderNewForm,
                 com.tms.collab.directory.ui.ContactNewForm,
                 com.tms.collab.directory.ui.ContactView"%>
<%@include file="/common/header.jsp" %>

<x:config>
    <page name="abViewContact">
        <com.tms.collab.directory.ui.ContactView name="form" />
    </page>
</x:config>

<%@include file="includes/folderTreeAction.jsp" %>

<c:choose>
<c:when test="${forward.name == 'sendMessage'}">
    <c:redirect url="/ekms/messaging/composeMessage.jsp" />
</c:when>
<c:when test="${forward.name == 'viewIntranet'}">
    <c:redirect url="/ekms/addressbook/udViewContact.jsp?id=${param.id}" />
</c:when>
<c:when test="${!empty param.id}">
    <x:set name="abViewContact.form" property="id" value="${param.id}"/>
</c:when>
</c:choose>

<%@include file="includes/header.jsp" %>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr valign="MIDDLE">
    <td height="22" bgcolor="#003366" class="contentTitleFont"><b><font color="#FFCF63" class="contentTitleFont">
      &nbsp;<fmt:message key='addressbook.label.viewPersonalContact'/>
    </font></b></td>
    <td align="right" bgcolor="#003366" class="contentTitleFont">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td>
  </tr>
  <%--display form--%>
  <tr>
    <td colspan="2" valign="TOP">
        <x:display name="abViewContact.form" />
    </td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td>
  </tr>
  <%--display buttons--%>
  <tr>
    <td class="contentBgColor" align="right" valign="top" nowrap width="30%">&nbsp;</td>
    <td class="contentBgColor">
        <c:choose>
            <c:when test="${widgets['abViewContact.form'].contact.contactGroup}">
                <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.edit'/>" onclick="location='abEditContactGroup.jsp?id=<c:out value="${widgets['abViewContact.form'].id}" />'">
            </c:when>
            <c:otherwise>
                <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.edit'/>" onclick="location='abEditContact.jsp?id=<c:out value="${widgets['abViewContact.form'].id}" />'">
            </c:otherwise>
        </c:choose>
        <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.sendMessage'/>" onclick="location='abViewContact.jsp?cn=abViewContact.form&et=<%= ContactView.EVENT_SEND_MESSAGE %>&id=<c:out value="${widgets['abViewContact.form'].id}" />'">
        <x:permission module="<%= DirectoryModule.class.getName() %>" permission="<%= DirectoryModule.PERMISSION_EDIT_CONTACTS %>">
        <c:choose>
            <c:when test="${widgets['abViewContact.form'].contact.contactGroup}">
<%--                <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.publishDirectory'/>" onclick="location='bdImportContactGroup.jsp?id=<c:out value="${widgets['abViewContact.form'].id}" />'">--%>
            </c:when>
            <c:otherwise>
                <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.publishDirectory'/>" onclick="location='bdImportContact.jsp?id=<c:out value="${widgets['abViewContact.form'].id}" />'">
            </c:otherwise>
        </c:choose>
        </x:permission>
        <input type="button" class="buttonClass" value="<fmt:message key='addressbook.label.cancel'/>" onclick="location='abContactList.jsp'">
    </td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td>
  </tr>
  <tr>
    <td colspan="2" valign="TOP" bgcolor="#CCCCCC" class="contentStrapColor">
      <img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="15"> </td>
  </tr>
</table>


<%@include file="includes/footer.jsp" %>

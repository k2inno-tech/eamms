<!--- template directory = [root]\WEB-INF\templates\default --->
<!--- addQtnColumn.jsp --->
<!--- editQtnColumn.jsp --->

<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>

<c:set var="form" value="${widget}"/>

<!--- Uncomment if template directory = [root]\WEB-INF\templates\default\[directory] --->
<jsp:include page="../form_header.jsp" flush="true"/>
<%--<jsp:include page="form_header.jsp" flush="true"/>--%>

<table width="100%" border="0" cellspacing="6" cellpadding="0" class="contentTitleFont">
<tr>
  <td>
  <c:choose>
    <c:when test="${type eq 'Edit' }">
      <fmt:message key='com.tms.quotation.column.edit'/>
    </c:when>
    <c:otherwise>
      <fmt:message key='com.tms.quotation.column.add'/>
    </c:otherwise>
  </c:choose>
  </td>
</tr>
</table>

<table width="100%" border="0" cellspacing="6" cellpadding="0" class="contentBgColor">
<tr>
  <td colspan="2"><x:display name="${form.childMap.errorMsg.absoluteName}"/></td>
</tr>
<!---<tr>
  <td colspan="2" valign="top" height="20"><b>Subtitle</b></td>
</tr>--->
<%--
<tr>
  <td align="right" valign="top" width="30%"><b>TableId<!---marker---></b></td>
  <td><x:display name="${form.childMap.QtnColumntableId.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="30%"><b>Position<!---marker---></b></td>
  <td><x:display name="${form.childMap.QtnColumnposition.absoluteName}"/></td>
</tr>
--%>
<tr>
  <td align="right" valign="top" width="20%"><b><fmt:message key='com.tms.quotation.column.header'/>&nbsp;*<!---marker---></b></td>
  <td><x:display name="${form.childMap.QtnColumnheader.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="20%"><b><fmt:message key='com.tms.quotation.column.width'/><!---marker---></b></td>
  <td><x:display name="${form.childMap.colWidth.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="20%"><b><fmt:message key='com.tms.quotation.column.textalign'/><!---marker---></b></td>
  <td><x:display name="${form.childMap.colTextAlign.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="20%"><b><fmt:message key='com.tms.quotation.column.vertalign'/><!---marker---></b></td>
  <td><x:display name="${form.childMap.colVertAlign.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="20%"><b><fmt:message key='com.tms.quotation.column.option'/></b></td>
  <td><x:display name="${form.childMap.isCompulsory.absoluteName}"/></td>
</tr>
<%--
<tr>
  <td align="right" valign="top" width="30%"><b>ColumnClassName<!---marker---></b></td>
  <td><x:display name="${form.childMap.QtnColumncolumnClassName.absoluteName}"/></td>
</tr>
<tr>
  <td align="right" valign="top" width="30%"><b>ColumnStyle<!---marker---></b></td>
  <td><x:display name="${form.childMap.QtnColumncolumnStyle.absoluteName}"/></td>
</tr>
--%>
<tr>
  <td colspan="2" height="10"></td>
</tr>
<tr>
  <td align="right" valign="top"></td>
  <td>
    <x:display name="${form.childMap.submit.absoluteName}"/>
    <x:display name="${form.childMap.reset.absoluteName}"/>
    <x:display name="${form.childMap.cancel.absoluteName}"/>
  </td>
</tr>
<tr>
  <td colspan="2" height="5"></td>
</tr>
</table>

<!--- Uncomment if template directory = [root]\WEB-INF\templates\default\[directory] --->
<jsp:include page="../form_footer.jsp" flush="true"/>
<%--<jsp:include page="form_footer.jsp" flush="true"/>--%>
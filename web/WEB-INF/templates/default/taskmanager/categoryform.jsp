<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>



<c:set var="form" value="${widget}"/>

<c:if test="${!widget.hasPermission&&widget.category.general}" >
    <%
        pageContext.setAttribute("view",Boolean.TRUE);
    %>
</c:if>

<jsp:include page="../form_header.jsp" flush="true"/>
 <table cellpadding="4" cellspacing="1" class="classBackground" width="100%">
   <tr>
        <td align="top" colspan="2" class="calendarFooter">
        <b><c:choose>
            <c:when test="${view}" ><fmt:message key='taskmanager.label.ViewTaskCategory'/></c:when>
            <c:when test="${form.categoryId != null }" ><fmt:message key='taskmanager.label.EditTaskCategory'/></c:when>
            <c:otherwise><fmt:message key='taskmanager.label.taskManager'/> > <fmt:message key='taskmanager.label.AddNewTaskCategory'/></c:otherwise>
        </c:choose></b>
        </td>
    </tr>

    <tr>
        <td colspan="1" class="classRowLabel" align="right" width="20%"><fmt:message key='taskmanager.label.CategoryName'/>&nbsp;&nbsp;<FONT class="classRowLabel">*</FONT></td>
        <td colspan="1" class="classRow">
            <c:if test="${!view}" >
                <x:display name="${form.nameTF.absoluteName}" />
            </c:if>
            <c:if test="${view}" >
                <c:out value="${form.category.name}" escapeXml="false" />
            </c:if>
        </td>
    </tr>

    <tr>
        <td valign="top" colspan="1" class="classRowLabel" align="right"><fmt:message key='taskmanager.label.Description'/>&nbsp;&nbsp;<FONT class="classRowLabel">*</FONT></td>
        <td colspan="1" class="classRow">
            <c:if test="${!view}" >
            <x:display name="${form.description.absoluteName}" ></x:display>
            </c:if>
            <c:if test="${view}" >
                 <c:out value="${form.category.description}" escapeXml="false" />
            </c:if>
        </td>
    </tr>

    <c:if test="${form.general != null}" >
    <tr>
        <td colspan="1"  class="classRow">
        &nbsp;
        </td>
         <td colspan="1" class="classRow">
            <x:display name="${form.general.absoluteName}" ></x:display><br>
            <FONT COLOR="RED"><fmt:message key='taskmanager.label.CategoryNote'/></FONT>
        </td>
    </tr>
    </c:if>

    <tr>
        <td colspan="1" class="classRow">
        </td>
        <td colspan="1" class="classRow">
          <c:if test="${!view}" >
           <x:display name="${form.submitButton.absoluteName}" />
            </c:if>
           <x:display name="${form.cancelButton.absoluteName}" />
        </td>
    </tr>

   <tr>
    <td colspan="2" class="calendarFooter">
    &nbsp
    </td>
    </td>
   </tr>
 </table>
<jsp:include page="../form_footer.jsp" flush="true"/>

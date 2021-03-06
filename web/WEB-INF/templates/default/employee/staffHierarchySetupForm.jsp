<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>
<c:set var="form" value="${widget}"/>
<table width="100%" cellpadding="0" cellspacing="0" class="classBackground">
    <tr>
        <td>
            <table width="100%" cellpadding="3" cellspacing="1">
                <jsp:include page="../form_header.jsp" flush="true"/>
                <tr>
                    <td class="classRowLabel" valign="top" align="right">Department </td>
                    <td class="classRow" align="left"><x:display name="${form.departmentList.absoluteName}"/></td>
                </tr>
                <c:if test="${!form.usersList.hidden}">
                    <tr>
                        <td class="classRowLabel" valign="top" align="right">Employee </td>
                        <td class="classRow" align="left"><x:display name="${form.usersList.absoluteName}"/></td>
                    </tr>
                    <tr>
                        <td class="classRowLabel" valign="top" align="right">Report To </td>
                        <td class="classRow" align="left"><x:display name="${form.reportToUsersList.absoluteName}"/></td>
                    </tr>
                    <tr>
                        <td class="classRowLabel" valign="top" align="right">&nbsp;</td>
                        <td class="classRow">
                            <x:display name="${form.setup.absoluteName}"/>
                            <x:display name="${form.reset.absoluteName}"/>
                            <x:display name="${form.cancel.absoluteName}"/>
                        </td>
                    </tr>
                </c:if>
                <c:if test="${!form.errorMsg.hidden}">
                    <tr><td class="classRow" colspan=2 align='center'><font color='#FF0000'><x:display name="${form.errorMsg.absoluteName}"/></font></td></tr>
                </c:if>
                <jsp:include page="../form_footer.jsp" flush="true"/>
            </table>
        </td>
    </tr>
</table>


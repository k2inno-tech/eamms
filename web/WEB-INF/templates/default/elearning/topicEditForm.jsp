<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>
<c:set var="form" value="${widget}"/>
<table width="100%" cellpadding="0" cellspacing="0" class="classBackground">
    <tr>
        <td>
        	<jsp:include page="../form_header.jsp" flush="true"/>
            <table width="100%" cellpadding="3" cellspacing="1">
               <tr>
                    <td class="classRowLabel" valign="top" align="right">Topic</td>
                    <td class="classRow"><x:display name="${form.childMap.topic.absoluteName}"/></td>
                </tr>
                <tr>
                    <td class="classRowLabel" valign="top" align="right">Course</td>
                    <td class="classRow"><x:display name="${form.childMap.course.absoluteName}"/></td>
                </tr>

                <tr>
                    <td class="classRowLabel" valign="top" align="right">&nbsp;</td>
                    <td class="classRow">
                        <x:display name="${form.childMap.submit.absoluteName}"/>
                        <input type="button" class="button" value="Cancel" onclick="self.location='topic.jsp'">
                    </td>
                </tr>
            </table>
            <jsp:include page="../form_footer.jsp" flush="true"/>
        </td>
    </tr>
</table>
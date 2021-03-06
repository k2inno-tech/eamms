<%@ include file="/common/header.jsp" %>
<c:set var="widget" value="${widget}"/>
<link ref="stylesheet" href="images/style.css">
<jsp:include page="../form_header.jsp" flush="true"/>
<tr>
    <td colspan="2" class="profileRow" align="right">
        <table cellpadding="2" cellspacing="1" width="100%">
            <c:choose>
                <c:when test="${empty widget.competencies}">
                    <tr><td colspan="3" class="profileRow"><fmt:message key="competencies.label.noCompetency"/></td></tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${widget.competencies}" var="competency">
                        <c:set var="selectbox_name" value="sel${competency.key.competencyId}"/>
                        <c:set var="checkbox_name" value="chk${competency.key.competencyId}"/>
                        <tr>
                            <td width="5%" nowrap class="profileRow" valign="top" align="center"><x:display name="${widget.childMap[checkbox_name].absoluteName}"/></td>
                            <td width="25%" nowrap class="profileRow" valign="top" align="right"><c:out value="${competency.key.competencyName}"/>&nbsp;</td>
                            <td width="70%" class="profileRow"><x:display name="${widget.childMap[selectbox_name].absoluteName}"/></td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
            <tr>
                <td colspan="3" class="profileRow" align="left">
                    <x:display name="${widget.add.absoluteName}"/>
                    <x:display name="${widget.delete.absoluteName}"/>
                </td>
            </tr>
        </table>
    </td>
</tr>
<jsp:include page="../form_footer.jsp" flush="true"/>
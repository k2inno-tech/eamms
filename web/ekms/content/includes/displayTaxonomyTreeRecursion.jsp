<%@ page import="kacang.ui.Event"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>

<table border=0 cellspacing=2 cellpadding=1 width="100%">
<c:forEach var="co" items="${root.childNodes}" varStatus="coStatus">
    <c:set var="cookieName"><c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/></c:set>
    <c:set var="cookieValue"><c:choose><c:when test="${cookie[cookieName].value == 'block'}">block</c:when><c:otherwise>none</c:otherwise></c:choose></c:set>
<tr><td colspan="4" align="center" height="2"><img src="<c:url value="/ekms/"/>images/blank.gif" width="10" height="2"></td></tr>
<tr>
    <td height="20" width="2" align="center"><img src="<c:url value="/ekms/"/>images/blank.gif" width="2" height="5"></td>
    <td height="20" valign="top" width="5">
        <c:choose>
        <c:when test="${empty co.childNodes || empty co.childNodes[0]}">
            <span class="contentTreeNode">-</span>
        </c:when>
        <c:when test="${!empty co.childNodes && !empty co.childNodes[0] && cookieValue=='none'}">
            <a class="contentTreeNode" href="#" onclick="treeToggle('<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>'); return false"><span id="icon_<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>">+</span></a>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${(origLevel lt maxLevel || maxLevel == 0) && cookieValue=='none'}">
                    <a class="contentTreeNode" href="#" onclick="treeToggle('<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>'); return false"><span id="icon_<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>">+</span></a>
                </c:when>
                <c:otherwise>
                    <a class="contentTreeNode" href="#" onclick="treeToggle('<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>'); return false"><span id="icon_<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>">-</span></a>
                </c:otherwise>
            </c:choose>
        </c:otherwise>
        </c:choose>
    </td>
    <td height="20" valign="top">
        <a title="<c:out value="${co.taxonomyName}"/>" class="contentTreeLink" href="/ekms/content/taxonomyTree.jsp?id=<c:out value="${co.taxonomyId}"/>"><font class="menuFont"><b><c:out value="${co.taxonomyName}"/></b></font></a>
        <c:if test="${!empty co.childNodes && !empty co.childNodes[0]}">
            <span id="<c:out value="${widget.name}"/><c:out value="${co.taxonomyId}"/>" style="display: <c:out value="${cookieValue}"/>">
                    <c:set var="orig" scope="page" value="${root}"/>
                    <c:set var="root" scope="request" value="${co}"/>
                    <c:set var="origLevel" scope="page" value="${level}"/>
                    <c:if test="${origLevel lt maxLevel || maxLevel == 0}">
                        <c:catch var="ie">
                            <c:set var="level" scope="request" value="${origLevel + 1}"/>
                            <jsp:include page="displayTaxonomyTreeRecursion2.jsp" flush="true">
                                <jsp:param name="children" value="true"/>
                            </jsp:include>
                        </c:catch>
                    </c:if>
                    <c:set var="level" scope="request" value="${origLevel}"/>
                    <c:set var="root" scope="request" value="${orig}"/>
            </span>
        </c:if>
    </td>
    <td height="20" width="5%"><img src="<c:url value="/ekms/"/>images/blank.gif" width="2" height="5">

</td>
</tr>
<c:if test="${!param.children}">
<tr>
    <td colspan="4">
        <c:if test="${!coStatus.last}">
            <table border=0 cellpadding=0 cellspacing=0 width=100%>
            <tr><td align="center" bgcolor="000000" class="menuBgColorShadow"><img src="<c:url value="/ekms/"/>images/blank.gif" width="5" height="1"></td></tr>
            <tr><td align="center" bgcolor="1059A5" class="menuBgColorHighlight"><img src="<c:url value="/ekms/"/>images/blank.gif" width="5" height="1"></td></tr>
            </table>
        </c:if>
    </td>
</tr>
</c:if>
</c:forEach>
</table>

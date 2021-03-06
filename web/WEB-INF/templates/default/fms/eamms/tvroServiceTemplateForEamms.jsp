<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c-rt" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>

<c:set var="widget" value="${widget}"/>
<jsp:include page="../../form_header.jsp" flush="true"/>
<x:display name="${widget.panel.absoluteName}" body="custom">
<br>
<c:set var="colSpanValue" value="8"/>
        <c:if test="${widget.viewMode eq 'false'}">
            <c:set var="colSpanValue" value="9"/>
        </c:if>

<table width="30%">
    <tr>
        <td><b><fmt:message key="eamms.feed.list.msg.request"/></b></td>
        <td>
            <div id="requestTitle">${widget.service.propertyMap.requestTitle}</div>
        </td>
    </tr>
    <tr>
        <td><b><fmt:message key="fms.facility.label.feedType"/></b></td>
        <td>
            <c:forEach items="${widget.feedType}" var="feed">
			    <c:if test="${feed.checked}">
			        ${feed.text}
			    </c:if>
			</c:forEach>
        </td>
    </tr>
    <tr>
        <td><b><fmt:message key="eamms.feed.list.msg.requiredDate"/></b></td>
        <td>
            <div id="requestTitle">${widget.service.propertyMap.requestReqDateRange}</div>
        </td>
    </tr>
</table>
<table align="center" class="borderTable" cellpadding="3" cellspacing="1" width="95%">
    <tr>
        <th><fmt:message key="fms.facility.label.sNo"/></th>
        <th><fmt:message key="fms.facility.label.feedTitle"/></th>
        <th><fmt:message key="fms.facility.table.location"/></th>
        <th><fmt:message key="fms.facility.label.requiredDate"/></th>
        <th><fmt:message key="fms.facility.label.requiredTime"/></th>
        <th><fmt:message key="fms.facility.label.blockBooking"/></th>
        <th><fmt:message key="fms.facility.label.totalTimeReq"/></th>
        <th><fmt:message key="fms.facility.label.remarks"/></th>
        <c:if test="${widget.viewMode eq 'false'}">
            <th><x:display name="${widget.delete.absoluteName}"/></th>
        </c:if>
    </tr>
        <c:forEach items="${widget.services}" var="obj" varStatus="sNo">
        <tr>
            <td class="profileRow" align="right"><c:out value="${(sNo.index+1)}"/></td>
            <td class="profileRow"><c:out value="${obj.feedTitle}" escapeXml="false"/></td>
            <td class="profileRow" align="right"><c:out value="${obj.location}"/></td>
            <td class="profileRow" align="center">
                <fmt:formatDate value="${obj.requiredDate}" pattern="${globalDateLong}"/> - 
                <fmt:formatDate value="${obj.requiredDateTo}" pattern="${globalDateLong}"/>
            </td>
            <td class="profileRow" align="center"><c:out value="${obj.fromTime}"/> - <c:out value="${obj.toTime}"/></td>
            <td class="profileRow" align="center"><c:out value="${obj.blockBooking}"/></td>
            <td class="profileRow"><c:out value="${obj.totalTimeReq}"/> <c:out value="${obj.timeMeasureLabel}"/></td>
            <td class="profileRow"><c:out value="${obj.remarks}"/></td>
            <c:if test="${widget.viewMode eq 'false'}">
                <td class="profileRow" align="center">&nbsp;
                    <c:forEach items="${widget.checkBoxes}" var="check" varStatus="checkStatus">
                        <c:if test="${checkStatus.index eq sNo.index}">
                            <x:display name="${check.absoluteName}"/>
                        </c:if>
                    </c:forEach>
                </td>
            </c:if>
        </tr>
        </c:forEach>
    
    <tr><td class="profileFooter" colspan='<c:out value="${colSpanValue}"/>'><x:display name="${widget.add.absoluteName}"/></td></tr>
</table><br>
</x:display>
<jsp:include page="../../form_footer.jsp" flush="true"/>


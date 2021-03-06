<%@ include file="/common/header.jsp" %>

<x:permission permission="com.tms.cms.leave.Leaves" module="com.tms.cms.leave.model.LeaveModule" url="/ekms/index.jsp"/>

<x:config>
    <page name="viewLeaveEntryList">
          <com.tms.hr.leave.ui.LeaveEntryTable name="table" width="100%" />
    </page>
</x:config>

 <c:if test="${!empty param.year}">
 <x:set name="viewLeaveEntryList.table" property="year" value="${param.year}" ></x:set>
 </c:if>


<c:choose>
    <c:when test="${param.cn == 'viewLeaveEntryList.table' && !empty param.id}">
        <c:redirect url="viewLeaveEntry.jsp?entryId=${param.id}"/>
    </c:when>
</c:choose>

<c:choose>
    <c:when test="${!empty param.leaveType}">
        <x:set name="viewLeaveEntryList.table" property="leaveType" value="${param.leaveType}" />
    </c:when>
</c:choose>

<%@include file="/ekms/includes/header.jsp" %>
<jsp:include page="includes/header.jsp" />

<table width="100%" border="0" cellspacing="0" cellpadding="5">
    <tr valign="middle">
        <td height="22" bgcolor="#003366" class="contentTitleFont">
            <a href="viewLeaveSummary.jsp"><b><font color="#FFCF63" class="contentTitleFont"><fmt:message key='leave.label.LeaveSummary'/></font></b></a>
            &gt;
            <b><font color="#FFCF63" class="contentTitleFont"><c:out value="${widgets['viewLeaveEntryList.table'].myLeaveType}"/></font></b>
        </td>
        <td align="right" bgcolor="#003366" class="contentTitleFont">&nbsp;</td>
    </tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor">

        <x:display name="viewLeaveEntryList.table" ></x:display>

    </td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#CCCCCC" class="contentStrapColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="15"></td></tr>
</table>

<jsp:include page="includes/footer.jsp" />
<%@include file="/ekms/includes/footer.jsp" %>

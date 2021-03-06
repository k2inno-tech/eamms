<%@include file="/common/header.jsp"%>

<x:config>
    <page name="publicTreePg">
        <com.tms.collab.myfolder.ui.CmsPublicFolderTree name="tree" />
        <com.tms.collab.myfolder.ui.SharedFileListTable name="table"/>
    </page>
</x:config>

<c:if test="${forward.name == 'folderNavi'}">
    <x:set name="publicTreePg.table" property="mfId" value="${param.id}"/>
    <c:set var="selectedFolder" value="${param.id}" scope="session"/>
</c:if>

<%@include file="/ekms/includes/header.jsp" %>

<c:set var="bodyTitle" scope="request"><fmt:message key="mf.label.myFolder"/> > <fmt:message key="mf.label.sharedFolder"/></c:set>
<jsp:include page="/ekms/includes/bodyHeader.jsp" flush="true"/>

<p>&nbsp;</p>
<table width="100%">
    <tr>
        <td width="20%" valign="top">
            <table cellpadding="1" cellspacing="1" border="0" style="text-align: left; width: 100%; border:1px solid gray">
                <tr><td></td></tr>
                <tr>
                    <td><x:display name="publicTreePg.tree"/></td>
                </tr>
            </table>
        </td>
        <td width="80%"  style="vertical-align:top">
            <x:display name="publicTreePg.table"/>
        </td>
    </tr>
</table>


<jsp:include page="/ekms/includes/bodyFooter.jsp" flush="true"/>
<jsp:include page="includes/footer.jsp" flush="true"/>
<%@include file="/ekms/includes/footer.jsp" %>
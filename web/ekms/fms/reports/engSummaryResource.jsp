<%@ include file="/common/header.jsp" %>
<head>
<link rel="stylesheet" href="/contentSyndicationToMiti/images/style.css">
</head>
<x:config>
    <page name="report">         
            <com.tms.fms.reports.ui.EngineeringSummaryResource name="engform" width="100%"/>        
    </page>
</x:config>


<c:if test="${forward.name == 'export'}">
	<c:redirect url="exportEngineeringSummary.jsp"/>
</c:if>

<%@include file="/ekms/includes/header.jsp" %>
<jsp:include page="includes/header.jsp" />

<table border="0" cellspacing="0" cellpadding="5" bgcolor="white" width="100%">
    <tr valign="middle">
        <td height="22" bgcolor="#003366" class="contentTitleFont"><b><font color="#FFCF63" class="contentTitleFont">
        	<fmt:message key="fms.report.message.label.engSummanyResourceTitle"/> </font></b></td>
        <td align="right" bgcolor="#003366" class="contentTitleFont">&nbsp;</td>
    </tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="10"></td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#EFEFEF" class="contentBgColor">

        <x:display name="report.engform" />
    
    </td></tr>
    <tr><td colspan="2" valign="TOP" bgcolor="#CCCCCC" class="contentStrapColor"><img src="<c:url value="/ekms/" />images/blank.gif" width="5" height="15"></td></tr>
</table>



<jsp:include page="includes/footer.jsp" />
<%@include file="/ekms/includes/footer.jsp" %>
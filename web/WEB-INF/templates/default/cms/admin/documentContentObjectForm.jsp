<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>
<c:set var="form" scope="request" value="${widget}"/>
<c:set var="co" scope="request" value="${form.contentObject}"/>
<jsp:include page="../../form_header.jsp" flush="true"/>
<table cellpadding="2" cellspacing="2" border="0" style="text-align: left; width: 100%;">
    <tbody>
        <tr>
            <td style="vertical-align: center;" class="classRowLabel" align="right"><fmt:message key='general.label.upload'/>&nbsp;</td>
            <td style="vertical-align: center;" ><x:display name="${form.childMap.fileUpload.absoluteName}"/><span id="uploadFileMsg"></span></td>
        </tr>
        <tr><td colspan="2">&nbsp;</td></tr>
        <script>
            var agent = navigator.userAgent;
            if(agent.toLowerCase().match("firefox")){
                var ele = document.getElementById("uploadFileMsg");
                ele.innerHTML = "<img align='top' style='cursor:hand;' title='Please do not upload a file with non english filename. Keep the filename short.' src='/ekms/images/ic_exclam.gif'/>";
            }
        </script>
        <c:if test="${!empty co && !empty co.fileName}">
            <tr>
                <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.existingFile'/>&nbsp;</td>
                <td style="vertical-align: top;"><a target="_blank" href="<%= request.getContextPath() %>/storage<c:out value="${co.filePath}"/>"><c:out value="${co.fileName}"/></a></td>
            </tr>
            <tr>
                <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.contentType'/>&nbsp;</td>
                <td style="vertical-align: top;"><c:out value="${co.contentType}"/></td>
            </tr>
            <tr>
                <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.fileSize'/>&nbsp;</td>
                <td style="vertical-align: top;"><c:out value="${co.fileSize}"/> <fmt:message key='general.label.bytes'/></td>
            </tr>
        </c:if>
        <tr><td style="vertical-align: center;" colspan="2" class="contentTitleFont" height="22">&nbsp;<fmt:message key='general.label.content'/></td></tr>
        <tr>
            <td style="vertical-align: top; width: 150px;" align="right" class="classRowLabel"><fmt:message key='general.label.nameTitle'/>&nbsp;</td>
            <td style="vertical-align: top;"><x:display name="${form.childMap.nameField.absoluteName}"/></td>
        </tr>
        <tr>
            <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.byLine'/>&nbsp;</td>
            <td style="vertical-align: top;"><x:display name="${form.childMap.authorField.absoluteName}"/></td>
        </tr>
        <tr>
            <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.abstract'/>&nbsp;</td>
            <td style="vertical-align: top;"><x:display name="${form.childMap.summaryBox.absoluteName}"/></td>
        </tr>
        <jsp:include page="contentObjectProfileForm.jsp" flush="true" />
        <tr><td style="vertical-align: center;" colspan="2" class="contentTitleFont" height="22">&nbsp;<fmt:message key='general.label.metaInformation'/></td></tr>
        <c:choose>
            <c:when test="${!empty co && !empty co.id}">
                <tr>
                    <td style="vertical-align: top; width: 150px;" align="right" class="classRowLabel"><fmt:message key='general.label.id'/>&nbsp;</td>
                    <td style="vertical-align: top;"><c:out value="${co.id}"/></td>
                </tr>
            </c:when>
            <c:otherwise>
                <tr>
                    <td style="vertical-align: top; width: 150px;" align="right" class="classRowLabel"><fmt:message key='general.label.id'/>&nbsp;</td>
                    <td style="vertical-align: top;"><x:display name="${form.childMap.idField.absoluteName}"/></td>
                </tr>
            </c:otherwise>
        </c:choose>
        <tr>
            <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.description'/>&nbsp;</td>
            <td style="vertical-align: top;"><x:display name="${form.childMap.descriptionBox.absoluteName}"/></td>
        </tr>
        <tr><td style="vertical-align: center;" colspan="2" class="contentTitleFont" height="22">&nbsp;<fmt:message key='general.label.publication'/></td></tr>
        <tr>
            <td style="vertical-align: top;" align="right" class="classRowLabel"><fmt:message key='general.label.publishingSchedule'/>&nbsp;</td>
            <td style="vertical-align: top;">
                <table cellpadding="2">
                    <tr><td colspan="2"><x:display name="${form.childMap.scheduleCheckBox.absoluteName}"/> <fmt:message key='general.label.schedulePublishing'/></td></tr>
                    <tr>
                        <td><fmt:message key='general.label.startDate'/></td>
                        <td><x:display name="${form.childMap.startDate.absoluteName}"/></td>
                    </tr>
                    <tr>
                        <td><fmt:message key='general.label.startTime'/></td>
                        <td><x:display name="${form.childMap.startTime.absoluteName}"/></td>
                    </tr>
                    <tr><td colspan="2"><x:display name="${form.childMap.scheduleEndCheckBox.absoluteName}"/> <fmt:message key='general.label.schedulePublishingEnd'/></td></tr>
                    <tr>
                        <td><fmt:message key='general.label.endDate'/></td>
                        <td><x:display name="${form.childMap.endDate.absoluteName}"/></td>
                    </tr>
                    <tr>
                        <td><fmt:message key='general.label.endTime'/></td>
                        <td><x:display name="${form.childMap.endTime.absoluteName}"/></td>
                    </tr>
                </table>
                <p>
            </td>
        </tr>
    </tbody>
</table>
<jsp:include page="../../form_footer.jsp" flush="true"/>

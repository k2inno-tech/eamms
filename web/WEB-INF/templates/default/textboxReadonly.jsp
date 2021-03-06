<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>

<c:set var="textbox" value="${widget}"/>

<c:choose>
<c:when test="${!textbox.invalid}" >
<textarea
    name="<c:out value="${textbox.absoluteName}"/>"
    onBlur="<c:out value="${textbox.onBlur}"/>"
    onChange="<c:out value="${textbox.onChange}"/>"
    onFocus="<c:out value="${textbox.onFocus}"/>"
    onSelect="<c:out value="${textbox.onSelect}"/>"
    rows="<c:out value="${textbox.rows}"/>"
    cols="<c:out value="${textbox.cols}"/>"
    readonly="readonly"
><c:out value="${textbox.value}"/></textarea>
    </c:when>
    <c:otherwise>
!<textarea
    name="<c:out value="${textbox.absoluteName}"/>"
    style="border:1px solid #de123e"
    onBlur="<c:out value="${textbox.onBlur}"/>"
    onChange="<c:out value="${textbox.onChange}"/>"
    onFocus="<c:out value="${textbox.onFocus}"/>"
    onSelect="<c:out value="${textbox.onSelect}"/>"
    rows="<c:out value="${textbox.rows}"/>"
    cols="<c:out value="${textbox.cols}"/>"
    readonly="readonly"
><c:out value="${textbox.value}"/></textarea>
    </c:otherwise>
</c:choose>
<c:forEach var="child" items="${textbox.children}">
    <x:display name="${child.absoluteName}"/>
</c:forEach>



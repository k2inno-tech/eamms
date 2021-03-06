<%@ page import="kacang.stdui.Form,
				 java.util.Collection,
				 java.util.ArrayList,
				 java.util.Iterator,
				 kacang.ui.Widget,
				 kacang.stdui.Panel,
				 java.awt.*,
                 kacang.stdui.Hidden"%>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="kacang.tld" prefix="x" %>

<c:set var="panel" value="${widget}"/>

<c:choose>
    <c:when test="${panel.columns == 0}">
        <c:forEach var="child" items="${panel.children}">
            <x:display name="${child.absoluteName}"/>
        </c:forEach>
    </c:when>
    <c:otherwise>
		<%
			Panel form = (Panel) pageContext.getAttribute("panel");
			int column = 0;
			int row = 0;
			int limit = form.getColumns();
			Point point = null;
			Collection points = new ArrayList();
		%>
		<table width="<%= form.getWidth() %>">
			<tr>
				<%
					for (Iterator i = form.getChildren().iterator(); i.hasNext();)
					{
						//Determine spans
						Widget child = (Widget) i.next();
                        if(!(child instanceof Hidden))
                        {
                            point = new Point(column, row);
                            if(points.contains(point))
                            {
                                boolean blocked = true;
                                while(blocked)
                                {
                                    column++;
                                    if(column >= limit)
                                    {
                                        column = 0;
                                        row ++;
                                        %></tr><tr><%
                                    }
                                    /*else
                                        column++;*/
                                    point = new Point(column, row);
                                    if(!(points.contains(point)))
                                        blocked = false;
                                }
                            }
						}
						//Rendering child
						%>
						<% if(!(child instanceof Hidden)) { %>
                            <td 
                                align="<%= child.getAlign() %>"
                                valign="<%= child.getValign() %>"
                                colspan="<%= child.getColspan() %>"
                                rowspan="<%= child.getRowspan() %>"
                            >
                        <% } %>
							<x:display name="<%= child.getAbsoluteName() %>"/>
                        <% if(!(child instanceof Hidden)) { %>
						    </td>
                        <% } %>
						<%
						//Inserting points
                        if(!(child instanceof Hidden))
                        {
                            if(child.getColspan() > 1)
                            {
                                for(int x = 0; x < child.getColspan(); x++)
                                {
                                    Point block = new Point(column + x, row);
                                    points.add(block);
                                }
                            }
                            if(child.getRowspan() > 1)
                            {
                                for(int y = 0; y < child.getRowspan(); y++)
                                {
                                    Point block = new Point(column, row + y);
                                    points.add(block);
                                    if(child.getColspan() > 1)
                                    {
                                        for(int x = 1; x < child.getColspan(); x++)
                                        {
                                            Point colBlock = new Point(column + x, row + y);
                                            points.add(colBlock);
                                        }
                                    }
                                }
                            }
                            column+=child.getColspan();
                            if(column >= limit)
                            {
                                column = 0;
                                row ++;
                                %></tr><tr><%
                            }
                        }
					}
				%>
			</tr>
		</table>
    </c:otherwise>
</c:choose>


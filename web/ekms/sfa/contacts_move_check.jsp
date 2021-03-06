<%@ page import="java.util.Collection,
                 java.util.Iterator,
                 com.tms.crm.sales.model.OpportunityContactModule,
                 kacang.Application,
                 com.tms.crm.sales.model.Opportunity,
                 com.tms.crm.sales.model.ContactModule,
                 com.tms.crm.sales.model.Contact"%>
<%@ include file="/common/header.jsp" %>


<c:set var="contactList" value="${widgets['jsp_contactList_oppdetails.table1'].contactList}" />
<c:set var="contactList" value="${widgets['jsp_contactList_oppdetails.table1'].contactList}" scope="session" />

<%
    Collection contactList = (Collection) pageContext.getAttribute("contactList");
    boolean hasConflict = false;
    OpportunityContactModule ocm  = (OpportunityContactModule) Application.getInstance().getModule(OpportunityContactModule.class);
    for (Iterator iterator = contactList.iterator(); iterator.hasNext();) {
        String contactId = (String) iterator.next();
        if(ocm.countContactOpportunities(contactId)>0)
        {

            hasConflict = true;
            break;
        }
    }

    if(!hasConflict){
%>
<c:redirect url="/ekms/sfa/move_contact.jsp" />
<%
    }



%>


<%@include file="/ekms/includes/header.jsp"%>
<jsp:include page="includes/header.jsp" />
<table cellpadding="4" cellspacing="1" class="sfaBackground" width="100%">
    <tr valign="top">
        <td align="left" valign="top" class="sfaHeader">
            <fmt:message key='sfa.message.moveContactsErrors'/>
        </td>
                  </tr>
      	 <tr>
        <td class="sfaRow">

        <br>
        <fmt:message key='sfa.message.movecontacterrorreason'/>.

        <br><br>
        <table>
        <%


            for (Iterator iterator = contactList.iterator(); iterator.hasNext();) {
                String contactId = (String) iterator.next();
                Collection col  = ocm.getOpportunities(contactId);
                if(col.size()>0){
                    ContactModule cm = (ContactModule) Application.getInstance().getModule(ContactModule.class);
                    Contact contact = cm.getContact(contactId); %>
                    <tr>
                        <td colspan="2" >
                            <b><li> <%=contact.getContactFirstName()%>&nbsp;<%=contact.getContactLastName()%></li></b>
                        </td>
                    </tr>

                    <%
                    for (Iterator iterator1 = col.iterator(); iterator1.hasNext();) {
                        Opportunity opportunity = (Opportunity) iterator1.next();
                        %>
                        <tr>
                            <TD width="10%">
                                &nbsp;
                            </td>
                            <td>
                                <a href="/ekms/sfa/opportunity_details.jsp?opportunityID=<%=opportunity.getOpportunityID()%>"><%=opportunity.getOpportunityName()%></a>
                            </td>
                        </tr>
                          <%
                    }








                }
            }



        %>



        <Tr>
            <td class="sfaRow">
                <INPUT type="button" value="<fmt:message key='sfa.message.back'/>" class="button" onClick="location = '<c:url value="/ekms/sfa/contact_listing.jsp"/>' "/>

            </td>
        </tr>
        </table>
     </td></tr>


        <Tr>
                <td class="sfaFooter">
                    &nbsp;
                </td>

            </tr>

            </table>



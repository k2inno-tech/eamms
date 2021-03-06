package com.tms.fms.eamms.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import kacang.model.DaoException;
import kacang.model.DataSourceDao;
import kacang.model.DefaultDataObject;

public class EammsDao extends DataSourceDao {
	
	public void init() throws DaoException {
		super.init();
		
		try
		{
			super.update(
				" CREATE TABLE staff_workload ( " +
				"		id VARCHAR(100) NOT NULL, " +
				"		userId VARCHAR(250) NOT NULL, " +
				"		cmOnHand VARCHAR(5) NOT NULL DEFAULT '0', " +
				"		pmOnHand VARCHAR(5) NOT NULL DEFAULT '0', " +
				"		woOnHand VARCHAR(5) NOT NULL DEFAULT '0', " +
				"		lastUpdatedDate VARCHAR(30) NOT NULL, " +
				"		PRIMARY KEY (id) " +
				" ) "
				, null);
		}
		catch(Exception e){}
	}
	
	public void setOverdueStatus() throws DaoException {
		String sql = " update app_fd_eamms_asset_rental " +
				" SET c_status ='Overdue' " +
				" WHERE c_toDate < CONVERT(VARCHAR(10), GETDATE(), 120) " +
				" AND c_status='Rent Out' ";
		
		super.update(sql, null);
		
	}
	
	public DefaultDataObject getRentalReqestInfo(String id) throws DaoException {
		String sql = " select  r.c_rentalId as rentalId, r.c_toDate as toDate , " +
				" (s.firstName +' '+s.lastName) as requestorName, s.email1 as requestorEmail, " +
				" (se.firstName +' '+se.lastName) as engineerName, se.email1 as engineerEmail " +
				" FROM app_fd_eamms_asset_rental r " +
				" LEFT JOIN security_user s ON (s.username=r.c_createdBy) " +
				" LEFT JOIN security_user se ON (se.username=r.c_engineerAssign) " +
				" WHERE r.id = ? " ;    	
		
			Collection col = super.select(sql, DefaultDataObject.class, new String[]{id}, 0, 1);
			if (col.size() == 1){
				return (DefaultDataObject) col.iterator().next();
			}				
		return new DefaultDataObject();
	}
	
	public Collection getRentalReqestDueReminderListing() throws DaoException {
		String sql = " select id " +
				" from app_fd_eamms_asset_rental " +
				" WHERE  c_status='Rent Out' AND c_toDate = CONVERT(VARCHAR(10),DateAdd(dd, 1, GetDate()), 120) " ;    	
		
			Collection col = super.select(sql, DefaultDataObject.class, null, 0, -1);
			return col;
	}
	
	public Collection getOverdueItemsListing() throws DaoException {
		String sql = " SELECT c_rentalId AS rentalId FROM  app_fd_eamms_asset_rental " +
				" WHERE c_toDate < CONVERT(VARCHAR(10), GETDATE(), 120)  AND c_status='Rent Out' " ;    	
		
			Collection col = super.select(sql, DefaultDataObject.class, null, 0, -1);
			return col;
	}
	
	public void insertRentalStatusTrail(DefaultDataObject obj) throws DaoException {
		String sql = " INSERT INTO app_fd_eamms_asset_rental_status(id,rentalId,status,createdBy,dateCreated) " +
				" VALUES (#id#,#rentalId#,#status#,#createdBy#,getdate()) ";
		
		super.update(sql, obj);
		
	}
	
	//-------- PM -------------------
	public Collection getPMOverdueItemsListing() throws DaoException {
		/*String sql = "SELECT c_pmRequestId,c_status, c_endDate " +
			"FROM app_fd_eamms_pm_request " +
			"WHERE c_endDate <= CONVERT(VARCHAR(10), GETDATE(), 120) " +
			"AND c_status = 'N' OR c_status = 'P' " ;    	*/
		
		String sql = "SELECT DISTINCT(c_pmRequestId),d.serviceStatus " +
				"FROM app_fd_eamms_pm_request_dates d " +
				"INNER JOIN app_fd_eamms_pm_request r ON (r.c_pmRequestId=d.pmRequestId) " +
				"INNER JOIN security_user u ON (u.username = d.engineerAssigned) " +
				"WHERE d.serviceStatus = 'N' AND r.c_status = 'N' " +
				"AND pmDate <= CONVERT(VARCHAR(10), GETDATE(), 120) ";
		
		Collection col = super.select(sql, DefaultDataObject.class, null, 0, -1);
		return col;
	}
	
	public void setPMOverdueStatus(DefaultDataObject obj) throws DaoException {
		String sql = "UPDATE app_fd_eamms_pm_request SET " +
				"c_status = #c_status#," +
				"dateModified = #dateModified# " +
				"WHERE c_pmRequestId = #c_pmRequestId#";
		super.update(sql, obj);
	}
	
	public void setSoftwareExpiredStatus(DefaultDataObject obj) throws DaoException {
		String sql = "UPDATE app_fd_eamms_asset_sw SET " +
				"c_status = #c_status#," +
				"dateModified = #dateModified# " +
				"WHERE id = #id#";
		super.update(sql, obj);
	}
	
	public Collection getSoftwareExpiredDate() throws DaoException {
		String sql = "SELECT id from app_fd_eamms_asset_sw "+ 
					"WHERE c_licenseExpiryDate <= CONVERT(VARCHAR(10), GETDATE(), 120) "+
					"and c_status <> ? ";
							
		Collection col = super.select(sql, DefaultDataObject.class, new String[]{SoftwareExpiredDate.EXPIRED_STATUS}, 0, -1);
		return col;
	}

	public Collection getPMReqestDueReminderListing() throws DaoException {
		String sql = "SELECT id " +
				"FROM app_fd_eamms_pm_request " +
				"WHERE c_endDate = CONVERT(VARCHAR(10),DateAdd(dd, 7, GetDate()), 120) " ;
		
		Collection col = super.select(sql, DefaultDataObject.class, null, 0, -1);
		return col;
	}
	
	public DefaultDataObject getPMInfo(String id) throws DaoException {
		String sql = "SELECT s1.firstName +' '+ s1.lastName AS engName1,s1.email1 AS emailEng1," +
							"s2.firstName +' '+ s2.lastName AS engName2,s2.email1 AS emailEng2," +
							"s3.firstName +' '+ s3.lastName AS engName3,s3.email1 AS emailEng3," +
							"s4.firstName +' '+ s4.lastName AS engName4,s4.email1 AS emailEng4," +
							"c_pmRequestId,c_endDate," +
							"s.firstName +' '+ s.lastName AS requestorName,s.email1 AS requestorEmail " +
							"FROM app_fd_eamms_pm_request r " +
							"LEFT JOIN security_user s ON (s.username=c_createdBy) " +
							"LEFT JOIN security_user s1 ON (s1.username=c_engineer1UserId) " +
							"LEFT JOIN security_user s2 ON (s2.username=c_engineer2UserId) " +
							"LEFT JOIN security_user s3 ON (s3.username=c_engineer3UserId) " +
							"LEFT JOIN security_user s4 ON (s4.username=c_engineer4UserId) " +
							"WHERE r.id=?" ;    	
		
			Collection col = super.select(sql, DefaultDataObject.class, new String[]{id}, 0, 1);
			if (col.size() == 1){
				return (DefaultDataObject) col.iterator().next();
			}				
		return new DefaultDataObject();
	}
	
	public String getActivityId(String originProcessId) throws DaoException {
		
		String sql = " select Id from SHKActivities a " +
				" INNER JOIN wf_process_link l ON (l.processId = a.processId ) " +
				" WHERE a.state ='1000003' AND l.originProcessId= ? " ;			
	    	
		
		Collection col = super.select(sql, HashMap.class, new String[]{originProcessId}, 0, 1);
		if (col.size() == 1) {
			HashMap map = (HashMap) col.iterator().next();
			String id = (String) map.get("Id");
			
			return id;
		}
		return "";
	}
	
public String getActivityIdNoParent(String processId) throws DaoException {
		
		String sql = " select Id from SHKActivities " +
				"	 WHERE state ='1000003'  AND processId= ? " ;			
	    	
		
		Collection col = super.select(sql, HashMap.class, new String[]{processId}, 0, 1);
		if (col.size() == 1) {
			HashMap map = (HashMap) col.iterator().next();
			String id = (String) map.get("Id");
			
			return id;
		}
		return "";
	}
	
 public HashMap getEngineersAssignedMSR(String id) throws DaoException {
		
		String sql = " select c_engineer1UserId,c_engineer2UserId,c_engineer3UserId,c_engineer4UserId " +
				" from app_fd_eamms_cm_request where id= ? "; 			
	    	
		
		Collection col = super.select(sql, HashMap.class, new String[]{id}, 0, 1);
		if (col.size() == 1) {
			HashMap map = (HashMap) col.iterator().next();			
			
			return map;
		}
		return new HashMap();
	}
 
 public DefaultDataObject getTXMReportInfo(String id) throws DaoException {
		String sql = " select r.id, c.name as channel, r.c_date, r.c_txStart, r.c_txEnd, r.c_shift, " +
				" r.c_programme,c_startProg, c_progDuration, c_timeOccur, c_faultDuration, " +
				" c_natureOfFault, c_action  from app_fd_eamms_txm_report r " +
				" LEFT JOIN app_fd_eamms_channel_txm c ON (c.id = r.c_channel) " +
				" WHERE r.id= ? " ;    	
		
			Collection col = super.select(sql, DefaultDataObject.class, new String[]{id}, 0, 1);
			if (col.size() == 1){
				return (DefaultDataObject) col.iterator().next();
			}				
		return new DefaultDataObject();
	}
 public Collection getTXMReportFollowupInfo(String id) throws DaoException {
		String sql = "  select c_details from app_fd_eamms_txm_report_followup f where f.c_txmReportId= ? " ; 
		Collection col = super.select(sql, HashMap.class, new String[]{id}, 0, -1);						
		return col;
	}
 public Collection getTXMReportRemarksInfo(String id) throws DaoException {
		String sql = "   select c_remarks from app_fd_eamms_txm_report_remarks r where r.c_txmReportId= ? " ;  		
		Collection col = super.select(sql, HashMap.class, new String[]{id}, 0, -1);			
		return col;
	}
	

	public Collection<DefaultDataObject> getAllStaff() throws DaoException
	{
		String sql =
			" SELECT su.id AS userId, su.username " +
			" FROM security_user su " +
			" INNER JOIN fms_unit fu ON (su.unit=fu.id) " +
			" INNER JOIN fms_department fd ON (fd.id=fu.department_id) " +
			" WHERE fd.id = 'D0014' " + // ENGINEERING DEPARTMENT
			" AND su.active = '1' ";
		
		Collection result = super.select(sql, DefaultDataObject.class, null, 0, -1);
		return result;
	}
	
	public void addStaffWorkload(DefaultDataObject userObj) throws DaoException
	{
		int staffExist = 0;
		String sqlStaff = "SELECT COUNT(userId) AS totalUser  FROM staff_workload " +
				"WHERE userId =  #userId# ";
		
		HashMap staffMap = (HashMap) super.select(sqlStaff, HashMap.class, userObj, 0, 1).iterator().next();
		staffExist = ((Number)staffMap.get("totalUser")).intValue();
		if(staffExist > 0){
			String sql = 
					" UPDATE staff_workload SET " +					
					" cmOnHand = #cmOnHand#, " +
					" pmOnHand = #pmOnHand#, " +
					" woOnHand = #woOnHand#, " +
					" lastUpdatedDate = #lastUpdatedDate# " +
					" WHERE userId = #userId# ";
			
			super.update(sql, userObj);
		}		
		else
			insertStaffWorkload(userObj);
		
	}

	public void insertStaffWorkload(DefaultDataObject userObj) throws DaoException
	{		
		
		String sql = 
			" INSERT INTO staff_workload ( " +
			"	id, userId, cmOnHand, pmOnHand, woOnHand, lastUpdatedDate ) " +
			" VALUES ( " +
			"	#id#, #userId#, #cmOnHand#, #pmOnHand#, #woOnHand#, #lastUpdatedDate# ) ";
			
		super.update(sql, userObj);
	}

	public int getCountWorkloadInWO(String userId) throws DaoException
	{
		ArrayList param = new ArrayList();
		String sql =
			" SELECT COUNT(wr.id) AS total " +
			" FROM app_fd_eamms_wo_request wr " +
			" INNER JOIN app_fd_eamms_status_wo swo ON (wr.c_status=swo.c_id) " +
			" WHERE 1=1 " +
			" AND (c_engineer1UserId = ? OR c_engineer2UserId = ? OR " +
			"		c_engineer3UserId = ? OR c_engineer4UserId = ?) " +
			" AND (swo.c_id = '02' OR swo.c_id = '03') ";
		param.add(userId);
		param.add(userId);
		param.add(userId);
		param.add(userId);
		
		Collection result = super.select(sql, HashMap.class, param.toArray(), 0, 1);
		if(result != null && !result.isEmpty())
		{
			HashMap map = (HashMap) result.iterator().next();
			Number total = (Number)map.get("total");
			
			return total.intValue();
		}
		return 0;
	}

	public int getCountWorkloadInPM(String userId) throws DaoException
	{
		ArrayList param = new ArrayList();
		String sql =
			" SELECT COUNT(pr.id) AS total " +
			" FROM app_fd_eamms_pm_request pr " +
			" INNER JOIN app_fd_eamms_status_pm spm ON (pr.c_status=spm.id) " +
			" WHERE 1=1 " +
			" AND (c_engineer1UserId = ? OR c_engineer2UserId = ? OR  " +
			"		c_engineer3UserId = ? OR c_engineer4UserId = ?) " +
			" AND spm.id <> 'E' AND spm.id <> 'C' ";
		param.add(userId);
		param.add(userId);
		param.add(userId);
		param.add(userId);
		
		Collection result = super.select(sql, HashMap.class, param.toArray(), 0, 1);
		if(result != null && !result.isEmpty())
		{
			HashMap map = (HashMap) result.iterator().next();
			Number total = (Number)map.get("total");
			
			return total.intValue();
		}
		return 0;
	}

	public int getCountWorkloadInCM(String userId) throws DaoException
	{
		ArrayList param = new ArrayList();
		String sql =
			" SELECT COUNT(cr.id) AS total " +
			" FROM app_fd_eamms_cm_request cr " +
			" WHERE 1=1 " +
			" AND (c_engineer1UserId = ? OR c_engineer2UserId = ? OR " +
			"		c_engineer3UserId = ? OR c_engineer4UserId = ?) " +
			" AND (cr.c_status = 'In Progress' OR cr.c_status = 'Assigned') ";
		param.add(userId);
		param.add(userId);
		param.add(userId);
		param.add(userId);
		
		Collection result = super.select(sql, HashMap.class, param.toArray(), 0, 1);
		if(result != null && !result.isEmpty())
		{
			HashMap map = (HashMap) result.iterator().next();
			Number total = (Number)map.get("total");
			
			return total.intValue();
		}
		return 0;
	}
	
	public void rentalReassign(String id, String engineer) throws DaoException {
		String sql = " update app_fd_eamms_asset_rental " +
				" SET c_engineerAssign = ? " +
				" WHERE id = ? ";
		
		super.update(sql, new String[]{engineer, id});
		
	}
}

package com.tms.fms.engineering.ui;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import kacang.Application;
import kacang.services.security.SecurityService;
import kacang.stdui.Button;
import kacang.stdui.CheckBox;
import kacang.stdui.DatePopupField;
import kacang.stdui.Form;
import kacang.stdui.Label;
import kacang.stdui.Panel;
import kacang.stdui.TimeField;
import kacang.stdui.validator.ValidatorNotEmpty;
import kacang.ui.Event;
import kacang.ui.Forward;
import kacang.util.Log;

import com.tms.fms.department.ui.PopupHODSelectBox;
import com.tms.fms.engineering.model.EngineeringModule;
import com.tms.fms.engineering.model.EngineeringRequest;
import com.tms.fms.facility.model.FacilityModule;
import com.tms.fms.facility.model.FacilityObject;
import com.tms.fms.facility.ui.validator.ValidatorItemBarcode;
import com.tms.fms.widgets.ExtendedTextField;

public class AssignmentDirectCheckIn extends Form{
	public static final String FORWARD_ADD_SUCCESS = "success";
	public static final String FORWARD_ADD_FAIL = "fail";
	public static final String FORWARD_MORE="more";
	
	private PopupHODSelectBox psusbCheckInBy;
	private DatePopupField dpfCheckInDate;
	private TimeField tifCheckInTime;
	private ExtendedTextField tfItem[];
	private CheckBox cbDamageItem[];
	private Panel pnButton;
	private Button btnSubmit;
	private Button btnMore;
	private Button btnCancel;
	
	private boolean isMore=false;
	private int count=0;
	private String cancelUrl = "assignmentListing.jsp";
	private String whoModifyId = "";

	private String assignmentId;
	
	public void onRequest(Event event) {
		if(!isMore){
			initForm();
		}
    }
	
	public void initForm() {
	    String msgNotEmpty  = Application.getInstance().getMessage("fms.tran.msg.mandatoryField", "Mandatory Field");

	    removeChildren();
	    setMethod("post");
	    setColumns(2);
	    
	    addChild(new Label("lb1", Application.getInstance().getMessage("fms.facility.form.checkInBy*", "Check In By*")));
	    psusbCheckInBy = new PopupHODSelectBox("psusbCheckInBy");
	    psusbCheckInBy.addChild(new ValidatorNotEmpty("psusbCheckInByNotEmpty", msgNotEmpty));
	    String[] userId = new String[1];
	    userId[0] = Application.getInstance().getCurrentUser().getId();
	    psusbCheckInBy.setIds(userId);
	    addChild(psusbCheckInBy);
	    psusbCheckInBy.init();
	    
	    addChild(new Label("lb2", Application.getInstance().getMessage("fms.facility.form.checkInDate", "Check In Date*")));
	    dpfCheckInDate = new DatePopupField("dpfCheckInDate");
	    dpfCheckInDate.setFormat("dd-MM-yyyy");
	    dpfCheckInDate.setDate(new Date());
	    addChild(dpfCheckInDate);
	    
	    addChild(new Label("lb3", Application.getInstance().getMessage("fms.facility.form.checkInTime", "Check In Time")));
	    tifCheckInTime = new TimeField("tifCheckInTime");
	    addChild(tifCheckInTime);
	    
	    tfItem = new ExtendedTextField[20];
	    cbDamageItem = new CheckBox[20];
	    for(count=0; count<20; count++){
	    	addChild(new Label("lbItem"+count, Application.getInstance().getMessage("fms.facility.form.checkInItem"+(count+1), "Check In Item"+(count+1))));
		    tfItem[count] = new ExtendedTextField("tfItem"+count);
		    tfItem[count].setMaxlength("255");
		    tfItem[count].setSize("25");
		    tfItem[count].setOnKeyUp("nextbox(this,'assignmentCheckIn.form.tfItem"+ (count+1) +"')");
		    tfItem[count].addChild(new ValidatorItemBarcode("tfItem"+count+"IsValid", ValidatorItemBarcode.ASSIGNMENT_CHECK_IN));
		    addChild(tfItem[count]);
		    cbDamageItem[count] = new CheckBox("cbDamageItem"+count);
		    cbDamageItem[count].setText(Application.getInstance().getMessage("fms.facility.form.damageItem", "Damage Item"));
		    addChild(cbDamageItem[count]);
	    }
	    
		addChild(new Label("lbbutton", ""));
		pnButton = new Panel("pnButton");
		btnMore = new Button("btnMore", Application.getInstance().getMessage("fms.facility.more", "More"));
	    pnButton.addChild(btnMore);
	    btnSubmit = new Button("btnSubmit", Application.getInstance().getMessage("fms.facility.done", "Done"));
    	pnButton.addChild(btnSubmit);
	    btnCancel = new Button("btnCancel", Application.getInstance().getMessage("fms.facility.cancel", "Cancel"));
		pnButton.addChild(btnCancel);
		
	    addChild(pnButton);  
	}
	
	public Forward onSubmit(Event evt) {
	    String buttonName = findButtonClicked(evt);
	    kacang.ui.Forward result = super.onSubmit(evt);
	    if (buttonName != null && btnCancel.getAbsoluteName().equals(buttonName)) {
	    	init();
	    	return new Forward(Form.CANCEL_FORM_ACTION, cancelUrl, true);
	    }else if (buttonName != null && btnMore.getAbsoluteName().equals(buttonName)) {
	    	isMore = true;
	    	return result;
	    }else{
	    	isMore = false;
	    	return result;
	    }
	}
	
	public Forward onValidate(Event event) {
		boolean success=true;
		boolean empty=true;
		
		String message ="";
		EngineeringModule module = (EngineeringModule)Application.getInstance().getModule(EngineeringModule.class);
		FacilityModule mod = (FacilityModule)Application.getInstance().getModule(FacilityModule.class);
		
		Date checkInDate = dpfCheckInDate.getDate();
		checkInDate.setHours(tifCheckInTime.getHour());
		checkInDate.setMinutes(tifCheckInTime.getMinute());
		
//		Calendar cDate = Calendar.getInstance();
//		cDate.setTime(dpfCheckInDate.getDate());
//		cDate.set(Calendar.HOUR_OF_DAY , tifCheckInTime.getHour());
//		cDate.set(Calendar.MINUTE , tifCheckInTime.getMinute());
		
	//	SimpleDateFormat formatter = new SimpleDateFormat("EEE, dd-MM-yyyy HH:mm");
		
		Application app = Application.getInstance();
        SecurityService security = (SecurityService)app.getService(SecurityService.class);
        String user = "";
        try{
        	user = security.getUser(psusbCheckInBy.getId()).getUsername();
        }catch(Exception e){
        	Log.getLog(getClass()).error("Error getUser(1)", e);
        }
        
		for(int i=0; i<count; i++){
			String code = tfItem[i].getValue().toString();
			boolean damage = cbDamageItem[i].isChecked();
			if(!"".equals(code.trim())){
				empty = false;
				FacilityObject item = mod.getItem(code);
				if(!(item.getBarcode() == null || "".equals(item.getBarcode()))){
					
					Collection colOfEquipAsg = module.getAssignmentEquipmentByBc(item.getBarcode());
					
					if (colOfEquipAsg != null && colOfEquipAsg.size() > 0) {
						for (Iterator iea = colOfEquipAsg.iterator(); iea.hasNext();){
							EngineeringRequest er = (EngineeringRequest) iea.next();
							
							assignmentId = er.getAssignmentId();
							er.setBarcode(item.getBarcode());
							er.setCheckedInBy(user);
							er.setDamage(damage?"1":"0");
							
							module.updateCheckInEquipment(er);
							if(FacilityModule.ITEM_STATUS_CHECKED_OUT.equals(item.getStatus())){
								item.setStatus(FacilityModule.ITEM_STATUS_CHECKED_IN);
								mod.updateItem(item);
								
								// check completed request
								EngineeringRequest erC = module.getEquipmentAssignment(getAssignmentId());
								
								if (erC!=null) {
									module.updateRequestStatus(erC.getRequestId());
								}
							}
						}
					}
					tfItem[i].setValue("");
				}
			}
		}

		if(empty){
			success=false;
			message = Application.getInstance().getMessage("fms.facility.msg.pleaseKeyInAtLeastOneBarcode");
		}
		
    	if(success){
			
    		if(isMore){
    			for(count=0; count<20; count++){
    		    	tfItem[count].setValue("");
    		    	cbDamageItem[count].setChecked(false);
    		    }
    			return new Forward(FORWARD_MORE);
    		}else{
    			return new Forward(FORWARD_ADD_SUCCESS);
    		}
    	}else{
    		HttpServletRequest request = event.getRequest();
        	request.setAttribute("message", message);
        	event.setRequest(request);
    		return new Forward(FORWARD_ADD_FAIL);
    	}
	}	
	
	public String getDefaultTemplate() {
		return "fms/engineering/assignmentcheckintemp";
	}
	
	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getCancelUrl() {
		return cancelUrl;
	}

	public void setCancelUrl(String cancelUrl) {
		this.cancelUrl = cancelUrl;
	}

	public String getWhoModifyId() {
		return whoModifyId;
	}

	public void setWhoModifyId(String whoModifyId) {
		this.whoModifyId = whoModifyId;
	}

	public String getAssignmentId() {
		return assignmentId;
	}

	public void setAssignmentId(String assignmentId) {
		this.assignmentId = assignmentId;
	}
	
	
}

package com.tms.sam.po.ui;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import kacang.Application;
import kacang.stdui.Button;
import kacang.stdui.Form;
import kacang.stdui.Hidden;
import kacang.stdui.Label;
import kacang.stdui.Panel;
import kacang.ui.Event;
import kacang.ui.Forward;
import kacang.util.UuidGenerator;

import com.tms.sam.po.model.RatingObject;
import com.tms.sam.po.model.SupplierModule;
import com.tms.sam.po.model.SupplierObject;

public class SupplierEvaluationForm extends Form {
	
	private Label txtSupplier;
	private Label txtSupplierCompany;	
	private Label txtLastEvaluatedBy;
	private Label txtLastEvaluateDate;
	private Button submit;
	private Button cancel;
	private Panel buttonPanel;
	private Hidden qualitySystem;
	private Hidden concern;
	private Hidden history;
	private Hidden actual;
	private Hidden negotiation;
	private Hidden technical;
	private Hidden delivery;
	private Hidden assistance;
	private String supplierID = "";
	private String id="";
	private int count ;
	private String ppID = "";
    public static final String FORWARD_BACK = "back";	
	public static final String FORWARD_SUBMIT = "submit";
	
	public void init(){
	     setColumns(2);
	     Application app = Application.getInstance();
		 txtSupplier = new Label("txtSupplier", ""); 		 	 
		 txtSupplierCompany = new Label("txtSupplierCompany", "");	
		 txtLastEvaluatedBy = new Label("txtLastEvaluatedBy", ""); 		 	 
		 txtLastEvaluateDate = new Label("txtLastEvaluateDate", "");	
		 
		 submit = new Button("submit", app.getMessage("po.label.submit", "Submit"));       
	     cancel = new Button("cancel", app.getMessage("po.label.cancel", "Cancel")); 
         
         buttonPanel = new Panel("buttonPanel");
         buttonPanel.addChild(submit);
         buttonPanel.addChild(cancel);
         
         qualitySystem = new Hidden("qualitySystem");
         concern = new Hidden("concern");
         history = new Hidden("history");
         actual = new Hidden("actual");
         negotiation = new Hidden("negotiation");
         technical = new Hidden("technical");
         delivery = new Hidden("delivery");
         assistance = new Hidden("assistance");
         
         addChild(buttonPanel);
	     addChild(txtSupplier);         
         addChild(txtSupplierCompany);   
         addChild(txtLastEvaluatedBy);         
         addChild(txtLastEvaluateDate);    
         addChild(qualitySystem);
	     addChild(concern);         
         addChild(history);    
         addChild(actual);
	     addChild(negotiation);         
         addChild(technical);    
         addChild(delivery);
	     addChild(assistance);         
          
	}
	
	public void onRequest(Event event){
		  Application app = Application.getInstance();
		  SupplierObject oneRequest = null;
		  RatingObject ro = null;
		  
		  SupplierModule module = (SupplierModule)Application.getInstance().getModule(SupplierModule.class);
		  count =  Integer.parseInt(event.getRequest().getParameter("count").toString());;
		  oneRequest = module.singleRequest(supplierID, count, ppID);
		  id = oneRequest.getId();
		  txtSupplier.setText(oneRequest.getLastKnownSuppName());
		  txtSupplierCompany.setText(oneRequest.getLastKnownCompany());
		  DateFormat dmyDateFmt = new SimpleDateFormat(app.getProperty("globalDatetimeLong"));
	
		  ro = module.getRating(id);
		  if(ro ==null){
			  qualitySystem.setValue("0");
			  concern.setValue("0");
			  history.setValue("0");
			  actual.setValue("0");
			  negotiation.setValue("0");
			  technical.setValue("0");
			  delivery.setValue("0");
			  assistance.setValue("0"); 
			  txtLastEvaluatedBy.setText("-----");
			  txtLastEvaluateDate.setText("-----");
		  }else{
			  qualitySystem.setValue(ro.getQualitySystem());
			  concern.setValue(ro.getConcern());
			  history.setValue(ro.getHistory());
			  actual.setValue(ro.getActual());
			  negotiation.setValue(ro.getNegotiation());
			  technical.setValue(ro.getTechnical());
			  delivery.setValue(ro.getDelivery());
			  assistance.setValue(ro.getAssistance());
			  txtLastEvaluatedBy.setText(ro.getLastUpdateBy());
			  txtLastEvaluateDate.setText(dmyDateFmt.format(ro.getLastUpdateDate()));
		  }
		  
	}
	
	public Forward onValidate(Event event){
		 String button = findButtonClicked(event);
			button = (button == null)? "" : button;
			
			if(button.endsWith("cancel")){
		       	return new Forward(FORWARD_BACK);
		        	
		    }else if(button.endsWith("submit")){
		    	saveRating();
				return new Forward(FORWARD_BACK);
				
		 }
		 return null;
	}
	
	public void saveRating(){
		Calendar now = Calendar.getInstance();
		
		RatingObject obj = new RatingObject();
		obj.setLastUpdateDate(now.getTime());
		if(qualitySystem.getValue().toString()!=null){
			obj.setQualitySystem(qualitySystem.getValue().toString());
		}else{
			obj.setQualitySystem("0");
		}
		
		if(concern.getValue().toString()!=null){
			obj.setConcern(concern.getValue().toString());
		}else{
			obj.setConcern("0");
		}
		
		if(history.getValue().toString()!=null){
			obj.setHistory(history.getValue().toString());
		}else{
			obj.setHistory("0");
		}
		
		if(actual.getValue().toString()!=null){
			obj.setActual(actual.getValue().toString());
		}else{
			obj.setActual("0");
		}
		
		if(negotiation.getValue().toString()!=null){
			obj.setNegotiation(negotiation.getValue().toString());
		}else{
			obj.setNegotiation("0");
		}
		
		if(technical.getValue().toString()!=null){
			obj.setTechnical(technical.getValue().toString());
		}else{
			obj.setTechnical("0");
		}
		
		if(delivery.getValue().toString()!=null){
			obj.setDelivery(delivery.getValue().toString());
		}else{
			obj.setDelivery("0");
		}
		
		if(assistance.getValue().toString()!=null){
			obj.setAssistance(assistance.getValue().toString());
		}else{
			obj.setAssistance("0");
		}
		obj.setId(id);
		obj.setRatingID(UuidGenerator.getInstance().getUuid());
		obj.setLastUpdateBy(Application.getInstance().getCurrentUser().getName());
		SupplierModule module = (SupplierModule) Application.getInstance().getModule(SupplierModule.class);
		module.saveRating(obj);
		
		
	}
    public String getTemplate() {
		return "po/evaluationForm";
	}

    // === [ getters/setters ] =================================================	
	public String getSupplierID() {
		return supplierID;
	}

	public void setSupplierID(String supplierID) {
		this.supplierID = supplierID;
	}

	public Label getTxtSupplier() {
		return txtSupplier;
	}

	public void setTxtSupplier(Label txtSupplier) {
		this.txtSupplier = txtSupplier;
	}

	public Label getTxtSupplierCompany() {
		return txtSupplierCompany;
	}

	public void setTxtSupplierCompany(Label txtSupplierCompany) {
		this.txtSupplierCompany = txtSupplierCompany;
	}

	public Panel getButtonPanel() {
		return buttonPanel;
	}

	public Hidden getActual() {
		return actual;
	}

	public void setActual(Hidden actual) {
		this.actual = actual;
	}

	public Hidden getAssistance() {
		return assistance;
	}

	public void setAssistance(Hidden assistance) {
		this.assistance = assistance;
	}

	public Hidden getConcern() {
		return concern;
	}

	public void setConcern(Hidden concern) {
		this.concern = concern;
	}

	public Hidden getDelivery() {
		return delivery;
	}

	public void setDelivery(Hidden delivery) {
		this.delivery = delivery;
	}

	public Hidden getHistory() {
		return history;
	}

	public void setHistory(Hidden history) {
		this.history = history;
	}
	
	public Hidden getQualitySystem() {
		return qualitySystem;
	}

	public void setQualitySystem(Hidden qualitySystem) {
		this.qualitySystem = qualitySystem;
	}

	public Hidden getTechnical() {
		return technical;
	}

	public void setTechnical(Hidden technical) {
		this.technical = technical;
	}

	public void setButtonPanel(Panel buttonPanel) {
		this.buttonPanel = buttonPanel;
	}

	public Button getCancel() {
		return cancel;
	}

	public void setCancel(Button cancel) {
		this.cancel = cancel;
	}

	public Button getSubmit() {
		return submit;
	}

	public void setSubmit(Button submit) {
		this.submit = submit;
	}

	public Hidden getNegotiation() {
		return negotiation;
	}

	public void setNegotiation(Hidden negotiation) {
		this.negotiation = negotiation;
	}

	public Label getTxtLastEvaluateDate() {
		return txtLastEvaluateDate;
	}

	public void setTxtLastEvaluateDate(Label txtLastEvaluateDate) {
		this.txtLastEvaluateDate = txtLastEvaluateDate;
	}

	public Label getTxtLastEvaluatedBy() {
		return txtLastEvaluatedBy;
	}

	public void setTxtLastEvaluatedBy(Label txtLastEvaluatedBy) {
		this.txtLastEvaluatedBy = txtLastEvaluatedBy;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getPpID() {
		return ppID;
	}

	public void setPpID(String ppID) {
		this.ppID = ppID;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}

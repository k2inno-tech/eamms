package com.tms.collab.isr.model;

import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.collections.SequencedHashMap;

import com.tms.collab.isr.setting.model.ConfigDetailObject;
import com.tms.collab.isr.setting.model.ConfigModel;

import kacang.Application;
import kacang.model.DefaultDataObject;

public class ResolutionAttachmentObject extends DefaultDataObject {
	public static final String STORAGE_ROOT = "isr";
	public static final String SUB_FOLDER = "resolution";
	private Map allowedFileExt = new SequencedHashMap();
	private String resolutionAttachmentId = "";
	private String requestId = "";
	private String suggestedResolutionId = "";
	private String fileName = "";
	private String oriFileName = "";
	private Date dateCreated;
	private String createdBy = "";
	
	public ResolutionAttachmentObject() {
		ConfigModel model = (ConfigModel)Application.getInstance().getModule(ConfigModel.class);
		ConfigDetailObject config = new ConfigDetailObject();
		Collection cols;
		
		cols = model.getConfigDetailsByType(ConfigDetailObject.ALLOWED_FILE_EXTENSION, null);
		for(Iterator i=cols.iterator(); i.hasNext();) {
			config = (ConfigDetailObject) i.next();
			if(config.getConfigDetailName() != null && !"".equals(config.getConfigDetailName())) {
				allowedFileExt.put(config.getConfigDetailName().toLowerCase(), "true");
			}
		}
	}
	
	public Map getAllowedFileExt() {
		return allowedFileExt;
	}
	public void setAllowedFileExt(Map allowedFileExt) {
		this.allowedFileExt = allowedFileExt;
	}
	public String getResolutionAttachmentId() {
		return resolutionAttachmentId;
	}
	public void setResolutionAttachmentId(String resolutionAttachmentId) {
		this.resolutionAttachmentId = resolutionAttachmentId;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getRequestId() {
		return requestId;
	}
	public void setRequestId(String requestId) {
		this.requestId = requestId;
	}
	public String getSuggestedResolutionId() {
		return suggestedResolutionId;
	}
	public void setSuggestedResolutionId(String suggestedResolutionId) {
		this.suggestedResolutionId = suggestedResolutionId;
	}
}

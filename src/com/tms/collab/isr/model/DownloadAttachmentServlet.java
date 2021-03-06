package com.tms.collab.isr.model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kacang.Application;
import kacang.services.storage.StorageFile;
import kacang.services.storage.StorageService;
import kacang.util.Log;

import com.tms.collab.messaging.model.StorageFileDataSource;

public class DownloadAttachmentServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestModel requestModel = (RequestModel)Application.getInstance().getModule(RequestModel.class);
		/*SecurityService service = (SecurityService) Application.getInstance().getService(SecurityService.class);
		User loginUser = service.getCurrentUser(request);*/
		String attachmentId = request.getParameter("attachmentId");
		StorageService ss;
        StorageFile sf;
		
		try{
			if(attachmentId != null && ! "".equals(attachmentId)){
				if(requestModel.isDownloadableAttachment(attachmentId, request)){
					AttachmentObject attachment = requestModel.getAttachment(attachmentId);
					
					ss = (StorageService) Application.getInstance().getService(StorageService.class);
		            sf = new StorageFile(AttachmentObject.STORAGE_ROOT + "/" + attachment.getRequestId() + "/" + attachment.getFileName());
		            sf = ss.get(sf);
		            
		            int spacePos = sf.getName().lastIndexOf(" ");
		            int dotPos = sf.getName().lastIndexOf(".");
		            
		            String newName = sf.getName().substring(0, spacePos) + sf.getName().substring(dotPos, sf.getName().length());

		            response.setHeader("Content-Disposition", "attachment; filename=\"" + newName + "\"");
		            StorageFileDataSource.copy(sf.getInputStream(), response.getOutputStream());
				}
				else {
				    response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
				    return;
				}
			}
		}
		catch(Exception error){
			Log.getLog(getClass()).error("error downloading attachment, id: " + attachmentId, error);
		}
	}
}

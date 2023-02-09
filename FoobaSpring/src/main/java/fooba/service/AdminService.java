package fooba.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fooba.dao.IAdminDao;
import fooba.dto.Paging;

@Service
public class AdminService {

	@Autowired
	IAdminDao adao;

	public void getAdmin(HashMap<String, Object> prm) {
		adao.getAdmin(prm);
	}

	public void adminList(HashMap<String, Object> prm) {
		HttpServletRequest request = (HttpServletRequest)prm.get("request");
		HttpSession session = request.getSession();
		if(request.getParameter("first")!=null) {
			session.removeAttribute("page");
			session.removeAttribute("key");
			request.removeAttribute("page");
			request.removeAttribute("key");
		}
		
        int page = 1;
        if (request.getParameter("page")!=null) {
           page = Integer.parseInt( request.getParameter("page") );
           session.setAttribute("page", page);
        } else if (session.getAttribute("page")!=null) {
           page = (Integer)session.getAttribute("page");
        } else {
           session.removeAttribute("page");
        }
        
        String key = "";
        if(request.getParameter("key")!=null) {
           session.setAttribute("key", request.getParameter("key"));
           key = request.getParameter("key");
        } else if (session.getAttribute("key")!=null){
           key = (String)session.getAttribute("key");
        } else session.removeAttribute("key");
		
		Paging paging = new Paging();
		paging.setPage(page);
		prm.put("cnt", 0);
		prm.put("key", key);
		int count = Integer.parseInt( prm.get("cnt")+"" );
		paging.setTotalCount(count);
		paging.paging();
		prm.put("startNum", paging.getStartNum());
		prm.put("endNum", paging.getEndNum());
		prm.put("paging", paging);
		adao.adminList(prm);
	}

//	public void insertProduct(HashMap<String, Object> paramMap) {
//		adao.insertProduct(paramMap);
//	}
//
//	public void updateProduct(HashMap<String, Object> paramMap) {
//		adao.updateProduct(paramMap);
//		
//	}
//
//	public void updateOrderResult(int[] odseqs) {
//		for(int odseq : odseqs) {
//			adao.updateOrderResult(odseq);
//		}
//	}
//
//	public void memberReinsert(String id, String useyn) {
//		adao.memberReinsert(id, useyn);
//	}
//
//	public void replyQna(HashMap<String, Object> paramMap) {
//		adao.replyQna(paramMap);
//	}
//
//	public void insertBanner(HashMap<String, Object> paramMap) {
//		adao.insertBanner(paramMap);
//	}
	
}
package pds;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.SecurityUtil;
import pds.database.PdsDAO;
import pds.database.PdsVO;

public class PdsDeleteCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd")==null?"":request.getParameter("pwd");
		String[] fSNames = request.getParameterValues("fSName");
		
		PdsDAO dao = new PdsDAO();
		String shaPwd = new SecurityUtil().encryptSHA256(pwd);
		PdsVO vo = dao.search(idx);
		if(vo.getPassword().equals(shaPwd)) {
			//파일이 저장되어 있는 서버의 절대경로를 지정
			String realPath = request.getServletContext().getRealPath("/WEB-INF/pds/temp/");
			
			for (String fSName : fSNames) {
				//서버 파일시스템에 존재하는 실제파일들을 삭제
				new File(realPath + fSName).delete();
			}
			
			//파일 삭제가 완료되면 자료파일들을 DB에서 삭제
			if (dao.delete(idx)) {
				response.getWriter().write("pdsDeleteOk");
			} else {
				response.getWriter().write("pdsDeleteNo");
			}
		}
		else {
			response.getWriter().write("pwdNo");
		}
	}
}
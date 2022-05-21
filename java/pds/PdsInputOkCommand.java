package pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.SecurityUtil;
import member.database.MemberDAO;
import member.database.MemberVO;
import pds.database.PdsDAO;
import pds.database.PdsVO;

public class PdsInputOkCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/pds/temp/");
		int maxSize = 1024 * 1024 * 20;
		String encoding = "UTF-8";
		
		//파일의 업로드 처리
		MultipartRequest multiReq = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
		//업로드된 파일의 정보를 DB저장
		Enumeration fileNames = multiReq.getFileNames();
		
		String originalFileName = "";
		String filesystemFileName = "";
		String file = "";
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement();
			if (null != multiReq.getOriginalFileName(file)) {
				originalFileName += multiReq.getOriginalFileName(file) + "/";
				filesystemFileName += multiReq.getFilesystemName(file) + "/";
			}
		}
		originalFileName = originalFileName.substring(0, originalFileName.length()-1);
		filesystemFileName = filesystemFileName.substring(0, filesystemFileName.length()-1);
		
		//세션에서 아이디와 닉네임 가져오기
		HttpSession session = request.getSession();
		int sIdx = Integer.parseInt((String) session.getAttribute("sIdx"));
		String sMid = (String) session.getAttribute("sMid");
		String sNickName = (String) session.getAttribute("sNickName");
		
		MemberDAO mbrDao = new MemberDAO();
		MemberVO mbrVo = null;
		
		//전송 폼의 값 모두 받기
		//member idx회원고유번호 
		mbrVo = mbrDao.search(sIdx, sMid);
		int midIdx  = mbrVo.getIdx();
		
		int fSize = multiReq.getParameter("fileSize")==null?0:Integer.parseInt(multiReq.getParameter("fileSize"));
		String title = multiReq.getParameter("title");
		String part = multiReq.getParameter("part");
		String pwd = multiReq.getParameter("pwd");
		String openSW = multiReq.getParameter("openSW");
		String content = multiReq.getParameter("content");
		
		//비밀번호 암호화 SHA-256
		SecurityUtil sec = new SecurityUtil();
		sec.encryptSHA256(pwd);
		
		//DB저장
		PdsDAO dao = new PdsDAO();
		PdsVO vo = new PdsVO();
		vo.setMid(sMid);
		vo.setNickName(sNickName);
		vo.setfName(originalFileName);
		vo.setfName(filesystemFileName);
		vo.setTitle(title);
		vo.setPart(part);
		vo.setPassword(pwd);
		vo.setOpenSw(openSW);
		vo.setContent(content);
		
		int res = dao.insert(vo);
		if(1 == res) {
			request.setAttribute("msg", "pdsInputOk");
			request.setAttribute("url", request.getContextPath() + "/pdsList.pds");
		} else {
			request.setAttribute("msg", "pdsInputNo");
			request.setAttribute("url", request.getContextPath() + "/pdsInput.pds");
		}
	}
}
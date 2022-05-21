package pds;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import pds.database.PdsDAO;

public class PdsDownNumCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx")==null?0:Integer.parseInt(request.getParameter("idx"));
		PdsDAO dao =new PdsDAO();
		int res = dao.updatePdsDownNum(idx);
//db update만 처리했는뎅... sql error는 exception처리되서 화면이 떨어질텐데... 
//sql에서 exception을 정상처리할까?(정상으로 보이는 실패 에러가 없넹...) 그럼... 메세지 alert알려야할텐데...
//response.getWriter().write(String.valueOf(res));//update res = 1(수정성공) , ? (sql exception message(update실패))
	}
}
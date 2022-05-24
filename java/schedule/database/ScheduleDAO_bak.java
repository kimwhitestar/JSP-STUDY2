package schedule.database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;

public class ScheduleDAO_bak {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private ScheduleVO vo = null;
	private String sql = new String("");
	
	//해당 '년-월'의 자료 검색
	public List<ScheduleVO> getScheduleList(String mid, String ym) {
		List<ScheduleVO> vos = new ArrayList<>();
		try {
			sql = "select *, count(part) as partCnt from schedule where mid= ? and date_format(sDate, '%Y-%m-%d') = ? group by part  order by sDate desc ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ym);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPart(rs.getString("part"));
				vo.setsDate(rs.getString("sDate"));
				vo.setContent(rs.getString("content"));
				vo.setPartCnt(rs.getInt("partCnt"));
				vo.setYm(ym);
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}

	public List<ScheduleVO> getScMenu(String mid, String ymd) {
		List<ScheduleVO> vos = new ArrayList<>();
		try {
			sql = "select * from schedule where mid= ? and date_format(sDate, '%Y-%m-%d') = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ymd);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				vo = new ScheduleVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPart(rs.getString("part"));
				vo.setsDate(rs.getString("sDate"));
				vo.setContent(rs.getString("content"));
				vo.setYmd(ymd);
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vos;
	}
}
package emailbox;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conn.MysqlConn;

public class EmailboxDAO {
	private final MysqlConn instance = MysqlConn.getInstance();
	private final Connection conn = instance.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	private EmailboxVO vo = null;
	private String sql = new String("");

	//메세지 리스트(전체메세지(받은메세지(신규/읽은메세지포함))/신규메세지/보낸메세지/휴지통)
	public List searchEmailboxList(String mid, int mSw) {
		List<EmailboxVO> vos = null;
		try {
			if ( 1 == mSw ) { //전체메세지(받은메세지(신규/읽은메세지포함)
				sql = "select * from emailbox where receiveId = ? and (receiveSw = 'n' or receiveSw = 'r') order by idx desc limit ?, ? ";
			} else if ( 2 == mSw ) { //신규메세지
				sql = "select * from emailbox where receiveId = ? and receiveSw = 'n' order by idx desc limit ?, ? ";
			} else if ( 3 == mSw ) { //보낸메세지
				sql = "select * from emailbox where sendId = ? and sendSw = 's' order by idx desc limit ?, ? ";
			} else if ( 4 == mSw ) { //수신확인
				sql = "select * from emailbox where sendId = ? and receiveSw = 'n' order by idx desc limit ?, ? ";
			} else if ( 5 == mSw ) { //휴지통
				sql = "";
			} else  { //휴지통
				return vos;
			}
			vos = new ArrayList<>();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setInt(2, mSw);
			rs = pstmt.executeQuery();
			while (rs.next()) { //1개 검색된 ResultSet DTO의 레코드로 이동 
				vo = new EmailboxVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
				vo.setSendSw(rs.getString("sendSw"));
				vo.setSendId(rs.getString("sendId"));
				vo.setSendDate(rs.getString("sendDate"));
				vo.setReceiveSw(rs.getString("receiveSw"));
				vo.setReceiveId(rs.getString("receiveId"));
				vo.setReceiveDate(rs.getString("receiveDate"));
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
	
	public EmailboxVO search() {
		try {
			sql = "";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) { //1개 검색된 ResultSet DTO의 레코드로 이동 
				vo = new EmailboxVO();
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
			instance.rsClose();
		}
		return vo;
	}

	public int updatePoint(String id, int customId) {
		int res = 0;
		try {
			sql = "update custom_comp_login set point = point + 100 where id = ? and custom_id = ? and delete_date is null ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, customId);
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}

	public int insert(EmailboxVO vo) {
		int res = 0;
		try {
			sql = "insert into emailbox values ( default, ?, ?, ?, 's', default, ?, 'n', default )";
			pstmt = conn.prepareStatement(sql);
			int idx = 0;
			pstmt.setString(++idx, vo.getTitle());
			pstmt.setString(++idx, vo.getContent());
			pstmt.setString(++idx, vo.getSendId());
			pstmt.setString(++idx, vo.getReceiveId());
			res = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			instance.pstmtClose();
		}
		return res;
	}
}
package guestbook.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import guestbook.bean.GuestbookDTO;

public class GuestbookDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource ds;
	
	private static GuestbookDAO instance;
	
	public GuestbookDAO() {
		try {
			Context context=new InitialContext();
			ds=(DataSource) context.lookup("java:comp/env/jdbc/oracle");//tomcat일 경우 java:comp/env/를 꼭 써야한다
			
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	public static GuestbookDAO getInstance(){
		if(instance==null){
			synchronized(GuestbookDAO.class){
				instance=new GuestbookDAO();
			}
		}
		return instance;
	}
	
	
	public void guestbookWrite(GuestbookDTO dto){
		String sql="insert into guestbook values (seq_guestbook.nextval,?,?,?,?,?,sysdate)";
		
		try {
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getEmail());
			pstmt.setString(3, dto.getHomepage());
			pstmt.setString(4, dto.getSubject());
			pstmt.setString(5, dto.getContent());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(pstmt!=null)pstmt.close();//커넥션 풀에게 반환
				if(conn!=null)conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	public ArrayList<GuestbookDTO> guestbookList(int startNum, int endNum){
		ArrayList<GuestbookDTO> list=new ArrayList<GuestbookDTO>();
		String sql="select * from(select rownum rn, aa.* from "
				+ "(select seq, name, email, homepage,subject,content,"
				+ " to_char(logtime,'yyyy-mm-dd hh:mi') as logtime "
				+ "from guestbook order by seq desc)aa)where rn>=? and rn<=?";
		try {
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startNum);
			pstmt.setInt(2, endNum);
			rs=pstmt.executeQuery();
			while(rs.next()){
				GuestbookDTO dto=new GuestbookDTO();
				dto.setSeq(rs.getInt("seq"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setHomepage(rs.getString("homepage"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setLogtime(rs.getString("logtime"));
				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			list=null;
		}finally{
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	public int pageNum(){
		int su=0;
		String sql="select count(*) as cnt from guestbook";
		
		try {
			conn=ds.getConnection();
			pstmt=conn.prepareStatement(sql);		
			rs=pstmt.executeQuery();
			rs.next();
			su=rs.getInt("cnt");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return su;
	}
}

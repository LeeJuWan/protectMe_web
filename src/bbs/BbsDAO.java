package bbs;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;

import util.AESDec;

//게시판
public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	private AESDec aes;
	
	public BbsDAO() {
		try {
			//내부 암호화된 DB password read
			String propFile = "C:\\Users\\security915\\eclipse-workspace\\protectme\\src\\util\\key.properties";		
	       		Properties props = new Properties();
	        	FileInputStream fis = new FileInputStream(propFile);	         
	        	props.load(new java.io.BufferedInputStream(fis));			
			
			//외부에 저장된 비밀키 read
	       		String read_key = "C:\\Users\\key_management\\keymanagement.properties";
	       		Properties key = new Properties();	        
			FileInputStream key_fis = new FileInputStream(read_key);
	       		key.load(new java.io.BufferedInputStream(key_fis));
	        
	       		 String aes_key = key.getProperty("key");
	       		 if(aes_key !=null) {
	        		aes = new AESDec(aes_key);
	       		 }	        
	        
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword="";
			
			if(aes != null)
				dbPassword = aes.aesDecode(props.getProperty("password"));
			
			if(dbPassword != null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			}
			if(fis != null) {
				fis.close();
			}
			if(key_fis != null) {
				key_fis.close();
			}
		} catch (FileNotFoundException e) { //예외처리 ,대응부재 제거
			System.err.println("BbsDAO FileNotFoundException error");	
		} catch (IOException e) {
			System.err.println("BbsDAO IOException error");
		} catch (SQLException e) {
			System.err.println("BbsDAO SQLException error");
		} catch (ClassNotFoundException e) {
			System.err.println("BbsDAO ClassNotFoundException error");
		} catch (InvalidKeyException e) {
			System.err.println("BbsDAO InvalidKeyException error");
		} catch (NoSuchAlgorithmException e) {
			System.err.println("BbsDAO NoSuchAlgorithmException error");
		} catch (NoSuchPaddingException e) {
			System.err.println("BbsDAO NoSuchPaddingException error");
		} catch (InvalidAlgorithmParameterException e) {
			System.err.println("BbsDAO InvalidAlgorithmParameterException error");
		} catch (IllegalBlockSizeException e) {
			System.err.println("BbsDAO IllegalBlockSizeException error");
		} catch (BadPaddingException e) {
			System.err.println("BbsDAO BadPaddingException error");
		}
	}
	
	//날짜 값 
	public String getDate() {
		String SQL = "SELECT NOW()";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}		
		} catch (SQLException e) {
			System.err.println("GetDate SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetDate SQLException error");	
				}
			}
		}
		return "";
	}
	
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; 
		} catch (SQLException e) {
			System.err.println("GetNext SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetNext SQLException error");	
				}
			}
		}
		return -1;
	}
	
	//게시글 
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS VALUES(?,?,?,?,?,?)"; //SQL 인젝션 제거
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);			
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Write SQLException error");	
			 
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Write SQLException error");	
				}
			}
		}	
		return -1;
	}
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch (SQLException e) {
			System.err.println("GetList SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetList SQLException error");	
				}
			}
		}
		return list;	
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (SQLException e) {
			System.err.println("NextPage SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("NextPage SQLException error");	
				}
			}
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		} catch (SQLException e) {
			System.err.println("GetBbs SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetBbs SQLException error");	
				}
			}
		}
		return null;		
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);	
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Update SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Update SQLException error");	
				}
			}
		}
		return -1;	
	}
	

	public int delete(int bbsID) {
		String SQL = "DELETE FROM BBS WHERE bbsID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Delete SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Delete SQLException error");	
				}
			}
		}
		return -1;			
	}
	

	public int remove_bbs(String userID) {
		String SQL = "DELETE FROM BBS WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("removeBbs SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("removeBbs SQLException error");	
				}
			}
		}		
		return -1; 		
	}	
}

package comm;

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

//게시판 댓글
public class CommDAO {
	private Connection conn;
	private ResultSet rs;
	private AESDec aes;	
	
	public CommDAO() {
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
			String dbPassword = "";
			
			if(aes != null)
				dbPassword = aes.aesDecode(props.getProperty("password"));
			
			if(dbPassword != null) {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			}
			
			if(fis != null) 
				fis.close(); //부적절한 자원 해제 
			if(key_fis != null)
				key_fis.close();
		} catch (FileNotFoundException e) {//예외처리 ,대응부재 제거
			System.err.println("CommDAO FileNotFoundException error");
		} catch (IOException e) {
			System.err.println("CommDAO IOException error");
		} catch (SQLException e) {
			System.err.println("CommDAO SQLException error");
		} catch (ClassNotFoundException e) {
			System.err.println("CommDAO ClassNotFoundException error");
		} catch (InvalidKeyException e) {
			System.err.println("CommDAO InvalidKeyException error");
		} catch (NoSuchAlgorithmException e) {
			System.err.println("CommDAO NoSuchAlgorithmException error");
		} catch (NoSuchPaddingException e) {
			System.err.println("CommDAO NoSuchPaddingException error");
		} catch (InvalidAlgorithmParameterException e) {
			System.err.println("CommDAO InvalidAlgorithmParameterException error");
		} catch (IllegalBlockSizeException e) {
			System.err.println("CommDAO IllegalBlockSizeException error");
		} catch (BadPaddingException e) {
			System.err.println("CommDAO BadPaddingException error");
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
		String SQL = "SELECT commID FROM COMM ORDER BY commID DESC";
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
	
	//댓글 쓰기
	public int write(String commTitle, String userID, String commContent, int bbsID) {
		String SQL = "INSERT INTO COMM VALUES(?,?,?,?,?,?)"; //SQL 인젝션 제거
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, commTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, commContent);
			pstmt.setInt(6, bbsID);
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
	
	public ArrayList<Comm> getList(int pageNumber) {
		String SQL = "SELECT * FROM COMM WHERE commID < ? ORDER BY commID DESC LIMIT 10";
		ArrayList<Comm> list = new ArrayList<Comm>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Comm comm = new Comm();
				comm.setCommID(rs.getInt(1));
				comm.setCommTitle(rs.getString(2));
				comm.setUserID(rs.getString(3));
				comm.setCommDate(rs.getString(4));
				comm.setCommContent(rs.getString(5));
				comm.setBbsID(rs.getInt(6));
				list.add(comm);
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
		String SQL = "SELECT * FROM COMM WHERE commID < ?";
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
	
	public Comm getComm(int commID) {
		String SQL = "SELECT * FROM COMM WHERE commID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Comm comm = new Comm();
				comm.setCommID(rs.getInt(1));
				comm.setCommTitle(rs.getString(2));
				comm.setUserID(rs.getString(3));
				comm.setCommDate(rs.getString(4));
				comm.setCommContent(rs.getString(5));
				comm.setBbsID(rs.getInt(6));
				return comm;
			}
		} catch (SQLException e) {
			System.err.println("GetComm SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetComm SQLException error");	
				}
			}
		}
		return null;		
	}
	

	public int update(int commID, String commTitle, String commContent) {
		String SQL = "UPDATE COMM SET commTitle = ?, commContent = ? WHERE commID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, commTitle);
			pstmt.setString(2, commContent);
			pstmt.setInt(3, commID);			
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
	

	public int delete(int commID) {
		String SQL = "DELETE FROM COMM WHERE commID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commID);
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
	

	public int remove_comment(String userID) {
		String SQL = "DELETE FROM COMM WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("removeComment SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("removeComment SQLException error");	
				}
			}
		}
		return -1; 			
	}	
}

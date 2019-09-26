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

//占쏙옙占� 클占쏙옙占쏙옙
public class CommDAO {
	private Connection conn;
	private ResultSet rs;
	private AESDec aes;	
	//占쏙옙占� 占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	public CommDAO() {
		try {
			//占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙호 占쏙옙占쏙옙
			String propFile = "C:\\Users\\security915\\eclipse-workspace\\protectme\\src\\util\\key.properties";		
	       
	        Properties props = new Properties();
	        FileInputStream fis = new FileInputStream(propFile);	         
	        props.load(new java.io.BufferedInputStream(fis));			

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
				fis.close();
			if(key_fis != null)
				key_fis.close();
		} catch (FileNotFoundException e) {
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
	
	//占쏙옙占� 占쌜쇽옙 占쏙옙짜 획占쏙옙
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
		return ""; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}
	
	//占쏙옙占쏙옙占� 1占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占실븝옙
	public int getNext() {
		String SQL = "SELECT commID FROM COMM ORDER BY commID DESC";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫占쏙옙째 占쌉시뱄옙占쏙옙 占쏙옙占�
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
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}
	
	//占쏙옙占� 占쌜쇽옙
	public int write(String commTitle, String userID, String commContent, int bbsID) {
		String SQL = "INSERT INTO COMM VALUES(?,?,?,?,?,?)";
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
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙
	}
	
	//占쏙옙占� 占쏙옙占쏙옙占쏙옙占쏙옙 占쏙옙占� 10占쏙옙占쏙옙 占쏙옙占쏙옙占싹울옙 占쏙옙占쏙옙트 占쏙옙占쏙옙
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
	
	//占쏙옙占� 占쏙옙占쏙옙占쏙옙 占싱듸옙
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
	
	//占쌔댐옙 占쏙옙占� 占쏙옙占쏙옙 획占쏙옙
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
	
	//占쏙옙占� 占쏙옙占쏙옙
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
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙		
	}
	
	//占쏙옙占� 占쏙옙占쏙옙
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
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙			
	}
	
	//회占쏙옙탈占쏙옙占� 占쌔댐옙 占쏙옙占� 占쏙옙占쏙옙
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
		return -1; //占쏙옙占쏙옙占싶븝옙占싱쏙옙 占쏙옙占쏙옙			
	}	
}

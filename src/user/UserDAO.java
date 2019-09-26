package user;

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

import user.User;
import org.mindrot.jbcrypt.BCrypt;
import util.AESDec;

//회원 클래스
public class UserDAO {
	
	private Connection conn;
	private ResultSet rs;
	private AESDec aes;
	//회원 데이터베이스 연동
	public UserDAO() {	
		try {
			//외부 암호키 리드
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
	      
			String dbURL = "jdbc:mysql://localhost:3306/bbs?serverTimezone=UTC";
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
			System.err.println("UserDAO FileNotFoundException error");	
		} catch (IOException e) {
			System.err.println("UserDAO IOException error");	
		} catch (SQLException e) {
			System.err.println("UserDAO SQLException error");	
		} catch (ClassNotFoundException e) {
			System.err.println("UserDAO ClassNotFoundException error");	
		} catch (InvalidKeyException e) {
			System.err.println("UserDAO InvalidKeyException error");	
		} catch (NoSuchAlgorithmException e) {
			System.err.println("UserDAO NoSuchAlgorithmException error");	
		} catch (NoSuchPaddingException e) {
			System.err.println("UserDAO NoSuchPaddingException error");	
		} catch (InvalidAlgorithmParameterException e) {
			System.err.println("UserDAO InvalidAlgorithmParameterException error");	
		} catch (IllegalBlockSizeException e) {
			System.err.println("UserDAO IllegalBlockSizeException error");	
		} catch (BadPaddingException e) {
			System.err.println("UserDAO BadPaddingException error");	
		}	
	}
	
	//로그인
	public int login(String userID, String userPassword) {		
		if(userID != null && userPassword != null) {
			String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
			PreparedStatement pstmt = null;
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, userID);
				rs = pstmt.executeQuery();			
				
				if (rs.next()) {
					if(BCrypt.checkpw(userPassword, rs.getString(1)))
							return 1; // 로그인 성공
					else
						return 0; // 비밀번호 불일치
				}
				else{
					return -1; // 아이디가 없음
				}
			}
			catch (SQLException e) {
				System.err.println("Login SQLException error");	
			} finally {
				if(pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						System.err.println("Login SQLException error");	
					}
				}
			}
		}		
		return -2; // 데이터베이스 오류
	}
	
	public int count(String userID) {
		String SQL = "UPDATE USER SET userCnt = userCnt+1 WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Count SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Count SQLException error");	
				}
			}
		}	
		return -1; //데이터베이스 오류		
	}
	
	public int reset(String userID) {
		String SQL = "UPDATE USER SET userCnt = 0 WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Reset SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Reset SQLException error");	
				}
			}
		}	
		return -1; //데이터베이스 오류		
	}
	
	public int getCount(String userID) {
		String SQL = "SELECT userCnt FROM USER WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			System.err.println("GetCount SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetCount SQLException error");	
				}
			}
		}	
		return -1;		
	}
	
	//회원가입
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?,?)";
		String hashPassword =BCrypt.hashpw(user.getUserPassword(),BCrypt.gensalt());
		user.setUserPassword(hashPassword);
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setInt(6, getNext());
			pstmt.setInt(7, user.getUserCnt());
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Join SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Join SQLException error");	
				}
			}
		}
		return -1;
	}
	
	//회원탈퇴
	public int remove(String userID) {
		String SQL = "DELETE FROM USER WHERE userID = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			System.err.println("Remove SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("Remove SQLException error");	
				}
			}
		}
		return -1; //데이터베이스 오류			
	}
	
	//관리자페이지
	public int getNext() {
		String SQL = "SELECT userNum FROM USER ORDER BY userNum DESC";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우
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
		return -1; //데이터베이스 오류
	}
	public ArrayList<User> getList(int pageNumber) {
		String SQL = "SELECT * FROM USER WHERE userNum < ? ORDER BY userNum DESC LIMIT 10";
		ArrayList<User> list = new ArrayList<User>();
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserNum(rs.getInt(6));
				user.setUserCnt(rs.getInt(7));
				list.add(user);
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
		String SQL = "SELECT * FROM USER WHERE userNum < ?";
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
	public User getUser(int userNum) {
		String SQL = "SELECT * FROM USER WHERE userNum = ?";
		PreparedStatement pstmt = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserNum(rs.getInt(6));
				user.setUserCnt(rs.getInt(7));
				return user;
			}
		} catch (SQLException e) {
			System.err.println("GetUser SQLException error");	
		} finally {
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					System.err.println("GetUser SQLException error");	
				}
			}
		}
		return null;		
	}
}

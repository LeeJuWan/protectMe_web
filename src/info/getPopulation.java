package info;

import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

//�������������� 공공API ���������α��� XML ���� Ŭ����
public class getPopulation{
	
	//�� ������ ������ ���� ���� ���� -> �����ʾƼ� �迭�Ⱦ�
	public String cityname1 = "";
	public String citycnt1 = "";
	public String cityname2 = "";
	public String citycnt2 = "";
	public String cityname3 = "";
	public String citycnt3 = "";
	public String cityname4 = "";
	public String citycnt4 = "";
	public String cityname5 = "";
	public String citycnt5 = "";
	public String cityname6 = "";
	public String citycnt6 = "";
	public String cityname7 = "";
	public String citycnt7 = "";
	public String cityname8 = "";
	public String citycnt8 = "";
	public String cityname9 = "";
	public String citycnt9 = "";
	public String cityname10 = "";
	public String citycnt10 = "";
	public String cityname11 = "";
	public String citycnt11 = "";
	public String cityname12 = "";
	public String citycnt12 = "";
	public String cityname13 = "";
	public String citycnt13 = "";
	public String cityname14 = "";
	public String citycnt14 = "";
	public String cityname15 = "";
	public String citycnt15= "";
	public String cityname16 = "";
	public String citycnt16 = "";
	public String cityname17 = "";
	public String citycnt17 = "";
	public String cityname18 = "";
	public String citycnt18 = "";
	
	//XML �±׿��� �ʿ��� ���� ����
	public void getTagValue() {
		int cnt = 0;
		try{
			while(cnt<18) {
				String url = "http://116.67.77.182/openapi/SOCitysStats/"; //�������������� API ���������α��� XML ���� URL

				//������ʹ� ������ �����µ��� ������
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				Document doc = dBuilder.parse(url);

				doc.getDocumentElement().normalize();
				

				NodeList nList = doc.getElementsByTagName("City");

				for(int temp=0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						Element eElement = (Element) nNode;
						
						//�����̸�, �α��� -> Value ��� ����
						NodeList nlList1 = eElement.getElementsByTagName("city-name").item(0).getChildNodes();
						Node nValue1 = (Node) nlList1.item(0);
						NodeList nlList2 = eElement.getElementsByTagName("city-count").item(0).getChildNodes();
						Node nValue2 = (Node) nlList2.item(0);
						
						//�� ��忡 �ش� �� ����
						if(cnt==0) {
							cityname1 = nValue1.getNodeValue();
							citycnt1 = nValue2.getNodeValue();
						}
						else if(cnt==1) {
							cityname2 = nValue1.getNodeValue();
							citycnt2 = nValue2.getNodeValue();
						}
						else if(cnt==2) {
							cityname3 = nValue1.getNodeValue();
							citycnt3 = nValue2.getNodeValue();
						}
						else if(cnt==3) {
							cityname4 = nValue1.getNodeValue();
							citycnt4 = nValue2.getNodeValue();
						}
						else if(cnt==4) {
							cityname5 = nValue1.getNodeValue();
							citycnt5 = nValue2.getNodeValue();
						}
						else if(cnt==5) {
							cityname6 = nValue1.getNodeValue();
							citycnt6 = nValue2.getNodeValue();
						}
						else if(cnt==6) {
							cityname7 = nValue1.getNodeValue();
							citycnt7 = nValue2.getNodeValue();
						}
						else if(cnt==7) {
							cityname8 = nValue1.getNodeValue();
							citycnt8 = nValue2.getNodeValue();
						}
						else if(cnt==8) {
							cityname9 = nValue1.getNodeValue();
							citycnt9 = nValue2.getNodeValue();
						}
						else if(cnt==9) {
							cityname10 = nValue1.getNodeValue();
							citycnt10 = nValue2.getNodeValue();
						}
						else if(cnt==10) {
							cityname11 = nValue1.getNodeValue();
							citycnt11 = nValue2.getNodeValue();
						}
						else if(cnt==11) {
							cityname12 = nValue1.getNodeValue();
							citycnt12 = nValue2.getNodeValue();
						}
						else if(cnt==12) {
							cityname13 = nValue1.getNodeValue();
							citycnt13 = nValue2.getNodeValue();
						}
						else if(cnt==13) {
							cityname14 = nValue1.getNodeValue();
							citycnt14 = nValue2.getNodeValue();
						}
						else if(cnt==14) {
							cityname15 = nValue1.getNodeValue();
							citycnt15 = nValue2.getNodeValue();
						}
						else if(cnt==15) {
							cityname16 = nValue1.getNodeValue();
							citycnt16 = nValue2.getNodeValue();
						}
						else if(cnt==16) {
							cityname17 = nValue1.getNodeValue();
							citycnt17 = nValue2.getNodeValue();
						}
						else if(cnt==17) {
							cityname18 = nValue1.getNodeValue();
							citycnt18 = nValue2.getNodeValue();
						}
						cnt += 1;
					}
				}
			}
			
		}
		catch (ParserConfigurationException e){
			System.err.println("getPopulation ParserConfigurationException error");
		}catch (SAXException e) {
			System.err.println("getPopulation SAXException error");
		} catch (IOException e) {
			System.err.println("getPopulation IOException error");
		}
	}
}
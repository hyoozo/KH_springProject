package com.spring.openapi.data.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Service;

@Service
public class DataServiceImpl implements DataService {

	/* 외부로 부터 데이터를 받기 위함이지 
	 * DB로 부터 데이터를 받기 위함이 아니므로, DAO 정의는 필요 없다!
	 * */
	
	
	@Override
	public StringBuffer chungnamList() throws Exception {
		//String site = "https://tour.chungnam.go.kr/_prog/openapi/?func=tour&start=1&end=10";
		//URL url = new URL(site);
		
		//전달해 주어야 하는 파라미터
		StringBuffer site = new StringBuffer("https://tour.chungnam.go.kr/_prog/openapi/");
		site.append("?" + URLEncoder.encode("func","UTF-8") + "=" + URLEncoder.encode("tour","UTF-8"));
		site.append("&" + URLEncoder.encode("start","UTF-8") + "=" + URLEncoder.encode("1","UTF-8"));
		site.append("&" + URLEncoder.encode("end","UTF-8") + "=" + URLEncoder.encode("10","UTF-8"));
		/* URL 인코더로 인해값 전 name = URLEncoder.encode("func","UTF-8")
							 value = URLEncoder.encode("tour","UTF-8")
							 
							 "="  : 공백이 들어 가지 않도록 주의
		 */
		
		URL url = new URL(site.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();/*openConnection : url 를 객체로 변환 */
		
		//요청 방식 선택(GET, POST)
		conn.setRequestMethod("GET");
		
		//서버 Reponse Data를 xml(application/xml), json(application/json) 형식의 타입으로 요청
		conn.setRequestProperty("Accept", "application/xml");
		
		//타입설정(application/xml) 형식으로 전송 (Request Body 전달시 application/xml로 서버에 전달)
		//conn.setRequestProperty("Content-type","application/xml");
		
		//확인용 코드
		int resCode = conn.getResponseCode();
		System.out.println("응답코드 : " + resCode);
																	//getInputStream 외부의 값을 읽어 들어 오기 위해
		BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
													//InputStreamReader 바이트를 문자로 변환
		
		String inputLine;
		StringBuffer output = new StringBuffer();
		
		while((inputLine = in.readLine()) != null) { //readLine 한 라인씩 읽기 위해
			output.append(inputLine);
		}
		
		return output;
	}
	

}

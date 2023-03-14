package com.spring.common.file;


import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import java.awt.image.BufferedImage;

import org.imgscalr.Scalr;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class FileUploadUtil {
	
	/*********************************************
	 * 파일 업로드할 폴더 생성
	 *********************************************/
	public static void makeDir(String docRoot) {
		File fileDir = new File(docRoot);
		if(fileDir.exists()) {
			return;
		}
		
		fileDir.mkdirs();
	}

	/*********************************************
	 * 파일 업로드 메서드
	 * 파일명이 중복시 해결 방법
	 * System.currentTimeMillis()를 사용하거나 UUID는 128비트의 수이다.
	 * 표준 형식에서 UUID는 32개의 16진수로 표현되며 총 36개 문자(32개 무자와 4개의 하이픈)로된 8-4-4-4-12라는 5개의 그룹을 하이픈으로 구분한다.
	 * 이를테면,
	 * 이때 UUID.randomUUID().toString()를 이용해서 얻는다.
	 * 50e8400-e29-41d4-a716-446655440000
	 *********************************************/
	public static String fileUpload(MultipartFile file, String fileName) throws IOException {
		log.info("-----fileUpload 호출 성공-----");
	
		String real_name = null;
		
		// MultipartFile 클래스의 getFile() 메서드로 클라이언트가 업로드한 파일
		String org_name = file.getOriginalFilename();
		log.info("업로드 파일명 : " + org_name);
		
		// 파일명 변경(중복되지 않게)
		if(org_name != null && (!org_name.equals(""))) {
			real_name = fileName + "_" + System.currentTimeMillis() + "_" + org_name; //저장할 파일 이름
			
			String docRoot = "/Users/hyoozo/Documents/webdeveloper/uploadStorage/" + fileName;
			makeDir(docRoot);
			
			File fileAdd = new File(docRoot + "/" + real_name);
			log.info("업로드할 파일(fileAdd) : " + fileAdd);
			
			file.transferTo(fileAdd); // 이메서드에 의해 저장 경로에 실질적으로 File이 생성됨.
		}
		
		return real_name; //서버에 저장된 파일명 반환 (board_1658205347977_cat.jpg)
	}

	/*********************************************
	 * 파일 삭제 메서드
	 * 경로 및 파일명 : board/board_1658205347977_cat.jpg
	 * Thumbnail 경로 및 파일명 : board/thumbnail/thumbnail_board_1658205347977_cat.jpg
	 *********************************************/
	public static void fileDelete(String fileName) throws IOException {
		log.info("-----fileDelete호출성공-----");
		boolean result = false;
		String startDirName = "", docRoot = "";
		String dirName = fileName.substring(0, fileName.indexOf("_")); //dirName = thumbnail
		
		if(dirName.equals("thumbnail")) {
			startDirName = fileName.substring(dirName.length() + 1, fileName.indexOf("_", dirName.length() + 1)); //board
			//								thumbnail의 길이수+1부터 시작하여, thumbnail의 길이수+1 다음부터 시작하여 _ 전까지
			docRoot = "/Users/hyoozo/Documents/webdeveloper/uploadStorage/" + startDirName + "/" +dirName; //
		}else {
			docRoot = "/Users/hyoozo/Documents/webdeveloper/uploadStorage/" + dirName;
		}
		
		File fileDelete = new File(docRoot + "/" + fileName);
		
		if(fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		log.info("파일 삭제 여부(true/false) : " + result);
	}
	
	/*********************************************
	 * 파일 Thumbnail 생성 메서드
	 * Thumbnail 경로 및 파일명 : thumbnail/thumbnail_board_1658205347977_cat.jpg
	 *********************************************/
	/*public static String makeThumbnail(String fileName) throws Exception {
		String dirName = fileName.substring(0, fileName.indexOf("_")); // dirName = board
		// 이미지가 존재하는 폴더 추출
		String imgPath = "/Users/hyoozo/Documents/webdeveloper/uploadStorage/" + dirName;
		// 추출된 폴더의 실제 경로(물리적 위치: C:\...)
		File fileAdd = new File(imgPath, fileName);
		log.info("원본 이미지 파일(fileAdd): " + fileAdd);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd); //fileAdd에 해당하는 이미지 파일을 읽어와서 데이터로 저장
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 80); // 크기를 조정하여 이미지 데이터 저장
									//resize(대상 [BufferedImage 타입]=원본이미지, 원본비율(가로세로비율), 높이 또는 너비, 크기)
		
		String thumbnailName = "thumbnail_" + fileName;
		String docRoot = imgPath + "/thumbnail";
		makeDir(docRoot);
		
		File newFile = new File(docRoot, thumbnailName);
		log.info("업로드할 파일(newFile) : " + newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1); //확장자 : jpg
		log.info("확장자(formatName) : " + formatName);
		
		boolean result = ImageIO.write(destImg, formatName, newFile); //조정한 이미지 데이터를 생성한 파일에 저장.
		log.info("저장여부 : " + result);
		
		return thumbnailName; //서버에 저장된 파일명 반환
	}*/
	
	public static String makeThumbnail(String fileName) throws Exception{ // fileName = board_1658205347977_cat.jpg
		String dirName = fileName.substring(0, fileName.indexOf("_")); // dirName = board
		
		// 이미지가 존재하는 폴더 추출
		String imgPath = "/Users/hyoozo/Documents/webdeveloper/uploadStorage/"+dirName;
		
		// 추출된 폴더의 실제 경로(물리적 위치: C:\...)
		File fileAdd = new File(imgPath, fileName);	// C://uploadStorage//board//board_1658205347977_cat.jpg
		log.info("원본 이미지 파일(fileAdd) : " + fileAdd);
		
		BufferedImage sourceImg = ImageIO.read(fileAdd); // fileAdd에 해당하는 이미지 파일을 읽어와서 데이터로 저장. 
		BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,Scalr.Mode.FIT_TO_HEIGHT, 133); //크기를 조정하여 이미지 데이터 저장.
                                    //resize(대상[BufferedImage 타입]=원본이미지, 원본비율(가로세로비율), 높이 또는 너비, 크기)
		
		String thumbnailName = "thumbnail_"+ fileName; //thumbnail_board_1658205347977_cat.jpg
		String docRoot = imgPath+"/thumbnail"; // C://uploadStorage//board//thumbnail
		makeDir(docRoot);
				
		File newFile = new File(docRoot, thumbnailName); //C://uploadStorage//board//thumbnail//thumbnail_board_1658205347977_cat.jpg
		log.info("업로드할 파일(newFile) : " + newFile);
		
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1); //확장자: jpg
		log.info("확장자(formatName) : " + formatName);
		
		boolean result = ImageIO.write(destImg, "tif" , newFile);     // 조정한 이미지 데이터를 생성한 파일에 저장.         
		log.info("저장여부 : " + result);
		
		return thumbnailName; // 서버에 저장된 파일명 반환(thumbnail_board_1658205347977_cat.jpg)
}
	
}

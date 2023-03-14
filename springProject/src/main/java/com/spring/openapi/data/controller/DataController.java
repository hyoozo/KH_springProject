package com.spring.openapi.data.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.openapi.data.service.DataService;

import lombok.Setter;

@Controller
@RequestMapping("/data/*")
public class DataController {
	
	@Setter(onMethod_=@Autowired)
	private DataService dataService;
	
	/* 충남관광명소 리스트 화면 요청 */
	@GetMapping("/chungnamView")
	public String chungnamView() {
		return "data/chungnamView";
	}
	
	/* 충남관광명소 리스트 정보
	 * (응답문서타입 : application/xml) */
	@ResponseBody
	@RequestMapping(value = "/chungnamList" , produces = "application/xml; charset=UTF-8")
	public String chungnamList() throws Exception {
		StringBuffer sb = dataService.chungnamList();
		return sb.toString();
	}
	
	/* 충남관광명소 상세페이지 화면 */
	@PostMapping("/chungnamDetailView")
	public String chungnamDetailView() {
		
		return "data/chungnamDetailView";
	}
	
	/* 충남관광명소 상세페이지정보
	 * (응답문서타입 : application/xml)*/
	@GetMapping("/chungnamDetail")
	public String chungnamDetail() {
		
		return "data/chungnamDetail";
	}

}

package com.spring.admin.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.admin.board.service.AdminBoardService;
import com.spring.client.board.vo.BoardVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;

@Controller
@RequestMapping(value ="/admin/*")
public class AdminBoardController {
	
	@Setter(onMethod_=@Autowired)
	private AdminBoardService adminBoardService;
	
	
	/*****************************************************
	 * 글 목록 구현하기
	 *****************************************************/
	@GetMapping("/board/boardList")
	public String boardList(@ModelAttribute("data") BoardVO bvo, Model model) {
							//@ModelAttribute("data") 클라이언트로 부터 요청 받아온 것을 jsp로 포워드 할 때, data라는 이름으로 보낸다.
							//위 코드가 없을 시  클래스이름. 으로 호출한다.
		// 리스트 조회
		List<BoardVO> boardList = adminBoardService.boardList(bvo);
		model.addAttribute("boardList",boardList);
		
		// 전체 레코드수 구현
		int total = adminBoardService.boardListCnt(bvo);
		model.addAttribute("pageMaker", new PageDTO(bvo, total));
		
		// 리스트 번호 부여를 위한 속성
		int count = total - (bvo.getPageNum()-1) * bvo.getAmount();
		model.addAttribute("count",count);
		
		return "admin/board/boardList"; // boardList.jsp
		
	}
	
	@GetMapping("/board/boardDetail")
	public String boardDetail(Model model, BoardVO bvo) {
		
		BoardVO detail = adminBoardService.boardDetail(bvo);
		model.addAttribute("detail",detail);
		
		return "admin/board/boardDetail";
	}
	
//	@GetMapping("/board/boardDelete")
//	public String boardDelete() {
//		BoardVO result = 
//		
//		
//		return "admin/board/boardList";
//	}
}

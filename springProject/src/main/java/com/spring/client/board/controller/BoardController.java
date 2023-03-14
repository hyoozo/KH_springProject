package com.spring.client.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.admin.login.vo.AdminLoginVO;
import com.spring.client.board.service.BoardService;
import com.spring.client.board.vo.BoardVO;
import com.spring.common.vo.PageDTO;

import lombok.Setter;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Setter(onMethod_ =  @Autowired)
	private BoardService boardService;
	
	/*****************************************************
	 * @SessionAttributes 의 파라미터와 같은 이름이 @ModelAttribute에 있을 경우
	 * 세션에 있는 객체를 가져온 후, 클라이언트로 전송받은 값을 설정한다.
	 *****************************************************/
	@ModelAttribute
	public AdminLoginVO adminLogin() {
		return new AdminLoginVO();
	}
	
	/*****************************************************
	 * 글목록 구현하기(페이징 처리부분 제외 목록 조회)
	 * 요청 URL:http://localhost:8080/board/boardList
	 *****************************************************/
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardList(@ModelAttribute("data") BoardVO bvo, Model model) {
		//log.info("boardList 호출 성공");
		
		// 전체 레코드 조회
		List<BoardVO> boardList = boardService.boardList(bvo); 
		
		model.addAttribute("boardList", boardList);
		
		// 전체 레코드수 구현
		int total = boardService.boardListCnt(bvo);
		
		// 페이징 처리
		model.addAttribute("pageMaker", new PageDTO(bvo, total));
		
		return "client/board/boardList";
	}
	
	/*****************************************************
	 * 글쓰기 폼 출력하기
	 *****************************************************/
	@GetMapping("/writeForm")
	public String writeForm() {
		//log.info("-----writeForm() 호출 성공------");
		
		return "client/board/writeForm";
	}
	/*****************************************************
	 * 글쓰기 구현하기
	 *****************************************************/
	@PostMapping("/boardInsert")
	public String boardInsert(@ModelAttribute BoardVO vo, Model model) throws Exception {
														// 전달할 값이 없다면 model은 생략해도 된다.
		//log.info("-----boardInsert() 호출 성공------");
		String url = "";
		
		int result = boardService.boardInsert(vo);
		
//		입력 성공과 실패에 대한 페이지를 다르게 주고 싶을때,
		if(result == 1) {
			url = "/board/boardList"; //매핑주소.
		} else {
			url = "/board/writeForm";
		}
		
		return "redirect:"+url;
	}
	
	/*@GetMapping("/boardDetail")
	public String boardDetaile(Model model, int b_num) {
		BoardVO BoardVO = boardService.boardDetail(b_num);
		
		model.addAttribute("board",BoardVO);
		return "board/boardDetaile";
	}*/
	
	/*****************************************************
	 * 글 상세보기 구현
	 *****************************************************/
	@GetMapping("/boardDetail")
	public String boardDetail(Model model, BoardVO vo) throws Exception {
		//log.info("-----boardDetail() 호출 성공------");
		
		BoardVO detail = boardService.boardDetail(vo);
		model.addAttribute("detail",detail);
		
		return "client/board/boardDetail";
	}
	
	/*****************************************************
	 * 글수정 폼 출력하기
	 * @param : b_num
	 * @return : BoardVO
	 *****************************************************/
	@RequestMapping(value = "/updateForm")
	public String updateForm(@ModelAttribute BoardVO vo, Model model) {
		//log.info("-----updateForm() 호출 성공------");
		//log.info("b_num: " + vo.getB_num());
		
		BoardVO update = boardService.updateForm(vo);
		
		model.addAttribute("update",update);
		
		return "client/board/updateForm";
	}
	
	/*****************************************************
	 * 글수정 폼 구현하기
	 * @param : BoardVO
	 * 참고 : RedirectAttributes 객체는 리다이렉트 시점 (return :redirecte:/경로")에
	 * 한번만 사용되는 데이터를 전송할 수 있는 addFlashAttribute()라는 기능을 지원한다.
	 * addFlashAttribute() 메서드는 브라우저까지 전송되기는 하지만, URI상에는 보이지 않는 숨겨진 데이터의 형태로 전달된다.
	 *****************************************************/
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdate(@ModelAttribute BoardVO vo/*, RedirectAttributes ras*/) throws Exception {
		//log.info("-----boardUpdate() 호출 성공------");
		
		String url = ""; 
		int result = 0;
		
		result = boardService.boardUpdate(vo);
//		ras.addFlashAttribute("boardVO",vo);
		
		if(result == 1) {
			//log.info("boardUpdate() 수정 성공");
			url = "/board/boardDetail?b_num="+vo.getB_num();
//			url = "/board/boardDetaile";
			
		} else {
			//log.info("boardUpdate() 수정 실패");
			url = "/board/updateForm?b_num="+vo.getB_num();
//			url = "/board/updateForm";
		}
		
		return "redirect:"+url;
	}
	
	/*****************************************************
	 * 글삭제 구현하기
	 *****************************************************/
	@RequestMapping("/boardDelete")
	public String boardDelete(@ModelAttribute BoardVO vo) throws Exception {
		//log.info("-----boardDelete() 호출 성공------");
		//log.info("삭제할 글 번호: " + vo.getB_num());
		
		// 아래 변수에는 입력 성공에 대한 상태값 담습니다. (1 or 0)
		int result = 0;
		String url = ""; 
	
		result = boardService.boardDelete(vo);
		
		if(result == 1) {
			//log.info("삭제성공");
			url = "/board/boardList";
		}else {
			url ="/board/boardDetail?b_num="+vo.getB_num();
		}
		
		return "redirect:"+url;
 		
	}
	
	/*****************************************************
	 * 비밀번호 확인
	 * @param b_num: 본일글 여부를 확인할 게시글 번호
	 * @param b_pwd: 입력한 비밀번호
	 * @return int로 result를 0 또는 를 리턴할 수도 있고,
	 * 		   String로 result 값을 "성공 or 실패, 일치 or 불일치"를 리턴할 수도 있다. (현재 문자열 리턴)
	 * 참고: @ResponseBody는 전달된 뷰를 통해서 출력하는 것이 아니라 HTTP Response Body에 직접 출력하는 방식. (ajax 요청시 사용)
	 * 		produces 속성은 지정한 미디어 타입과 관련된 응답을 생성하는데 사용한 실제 컨텐트 타입을 보장.
	 *****************************************************/
	@ResponseBody
	@RequestMapping(value="/pwdConfirm", method=RequestMethod.POST, produces="text/plain; charset=UTF-8")
	public String pwdConfirm(BoardVO bvo) {
		//log.info("-----pwdConfirm() 호출 성공------");
		String value="";
		
		//아래 변수에는 입력 성공에 대한 상태값 저장(1 or 0)
		int result = boardService.pwdConfirm(bvo);
		if(result == 1) {
			value="성공";
		}else {
			value="실패"; 
		}
		//log.info("result = "+result);
		
		return value; //value값 자체를 브라우저에 출력.
	}
	
	/*****************************************************
	 * 글삭제전 댓글 개수 구현하기
	 * @param int
	 ******************************************************/
	@ResponseBody
	@RequestMapping(value ="/replyCnt")
	public String replyCnt(@RequestParam("b_num") int b_num) {
		//log.info("-----replyCnt() 호출 성공------");
		
		int result = 0;
		result = boardService.replyCnt(b_num);
		
		//return result + " ";
		return String.valueOf(result);
	
	}
	

}

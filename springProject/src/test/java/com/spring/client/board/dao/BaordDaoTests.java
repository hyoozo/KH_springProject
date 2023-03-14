package com.spring.client.board.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.client.board.vo.BoardVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
@WebAppConfiguration
public class BaordDaoTests {

	@Setter(onMethod_ = @Autowired)
	private BoardDao boardDao;

	
	  @Test public void testBoardList() { 
		  log.info("---testBoardList() 메소드 실행---");
		  BoardVO bvo = new BoardVO();
		  bvo.setPageNum(1);
		  bvo.setAmount(10);
		  
		  bvo.setSearch("b_title");
		  bvo.setKeyword("노력");
		  
		  List<BoardVO> list = boardDao.boardList(bvo);
	  
//		  for(BoardVO vo :list ) { 
//			  log.info(vo);
//		  }
	  
	  }
	 

	
	  @Test 
	  public void testBoardInsert() { 
		  BoardVO board = new BoardVO();
		  board.setB_name(null);
		  board.setB_title(null); 
		  board.setB_content(null);
		  board.setB_pwd(null);
	  
		  int result = boardDao.baordInsert(board); 
		  log.info("입력한 행의 수 " +result); 
	  }
	 

	
	  @Test 
	  public void testBoardDetaile() { 
		  BoardVO board = new BoardVO();
		  board.setB_num(1);
	  
		  BoardVO vo = boardDao.boardDetail(board);
	  
		  log.info(vo.toString()); 
	  }
	 

	
	  @Test 
	  public void testBoardUpdate() { 
		  BoardVO board = new BoardVO();
		  board.setB_num(7); 
		  board.setB_title("수정3"); 
		  board.setB_content("수정된 내용");
	  
	  
		  int result = boardDao.boardUpdate(board);
	  
		  log.info("test result 반환값 :"+result); 
	  }
	 

	
	  @Test 
	  public void testBoardDelete() { 
		 
		  log.info("삭제된 행의 수 : "+ boardDao.boardDelete(4)); 
		  
	  }
	 

	
	  @Test 
	  public void testPwdConfirm() { 
		  BoardVO vo = new BoardVO();
	  
		  vo.setB_num(1); vo.setB_pwd("1234");
		  int result = boardDao.pwdConfirm(vo);
		  
		  log.info("result : " + result);
	  
	  }
	 

}

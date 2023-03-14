package com.spring.client.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.board.vo.BoardVO;

@Mapper
public interface BoardDao { //인터페이스로 만들다.
	
	//public List<BoardVO> boardList();
	public List<BoardVO> boardList(BoardVO vo); /* 검색 포함 리스트 */
	
	public int boardListCnt(BoardVO vo); /* 페이징 처리*/
	
	public int baordInsert(BoardVO vo); /* board 테이블의 전체 레코드 수 */

	//public BoardVO boardDetail(int b_num);
	public BoardVO boardDetail(BoardVO vo); // vo안에도 b_num이 들어 있기에 vo로 받아도 됨.

	public int readCntUpdate(BoardVO vo);
	
	public int pwdConfirm(BoardVO vo);
	
	public int boardUpdate(BoardVO vo);
	
	public int boardDelete(int b_num);
	
	//public List<BoardVO> boardListExcel(BoardVO vo); /* 엑셀 다운로드에서 사용할 쿼리 */
	
}

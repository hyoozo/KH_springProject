package com.spring.client.board.service;

import java.util.List;

import com.spring.client.board.vo.BoardVO;

public interface BoardService {
	
	public List<BoardVO> boardList(BoardVO vo);  /* 검색 포함 리스트 */
	
	public int boardListCnt(BoardVO bvo);
	
	public int boardInsert(BoardVO vo) throws Exception;
	
	/*public BoardVO boardDetaile(int b_num);*/
	public BoardVO boardDetail(BoardVO vo);
	
	public int pwdConfirm(BoardVO vo);
	
	public BoardVO updateForm(BoardVO vo);
	
	public int boardUpdate(BoardVO vo)throws Exception;
	
	public int boardDelete(BoardVO vo) throws Exception;
	
	public int replyCnt(int b_num);
	
	
}

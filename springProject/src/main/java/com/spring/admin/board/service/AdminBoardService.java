package com.spring.admin.board.service;

import java.util.List;

import com.spring.client.board.vo.BoardVO;


public interface AdminBoardService {
	
	public List<BoardVO> boardList(BoardVO bvo);
	
	public int boardListCnt(BoardVO bvo);
	
	public BoardVO boardDetail(BoardVO bvo);
	
	public int boardDelete(BoardVO bvo) throws Exception;

}

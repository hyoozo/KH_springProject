package com.spring.admin.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.board.dao.BoardDao;
import com.spring.client.board.vo.BoardVO;
import com.spring.common.file.FileUploadUtil;

import lombok.Setter;

@Service
public class AdminBoardServiceImpl implements AdminBoardService {
	
	@Setter(onMethod_=@Autowired)
	private BoardDao boardDao;

	@Override
	public List<BoardVO> boardList(BoardVO bvo) {
		List<BoardVO> aList = null;
		
		aList = boardDao.boardList(bvo);
		return aList;
	}

	@Override
	public int boardListCnt(BoardVO bvo) {
		int countNum = 0;
		countNum = boardDao.boardListCnt(bvo);
		return countNum;
	}

	@Override
	public BoardVO boardDetail(BoardVO bvo) {
		BoardVO boardDetail =null;
		boardDetail = boardDao.boardDetail(bvo);
		return boardDetail;
	}

	@Override
	public int boardDelete(BoardVO vo) throws Exception {
		int result = 0;
		
		if(!vo.getB_file().isEmpty()) {  //b_file 필드의 값이 null이거나 "" 아니면 (이미지 파일이 존재하면)
			FileUploadUtil.fileDelete(vo.getB_file());
			FileUploadUtil.fileDelete(vo.getB_thumb());
		}
		result = boardDao.boardDelete(vo.getB_num());
		return result;
	}
	
	

	
}

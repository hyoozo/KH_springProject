package com.spring.client.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.client.board.dao.BoardDao;
import com.spring.client.board.vo.BoardVO;
import com.spring.client.reply.dao.ReplyDao;
//import com.spring.client.reply.dao.ReplyDao;
import com.spring.common.file.FileUploadUtil;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardDao boardDao;
	
	@Setter(onMethod_=@Autowired) 
	private ReplyDao replyDao;

	// 글목록 구현
	@Override
	public List<BoardVO> boardList(BoardVO vo) {
		List<BoardVO> list = null;
		list = boardDao.boardList(vo);
		return list;
	}
	
	// 전체 레코드 수 구현
	@Override
	public int boardListCnt(BoardVO bvo) {
		return boardDao.boardListCnt(bvo);
	}

	//글입력 구현
	/*@Override
	public int boardInsert(BoardVO vo) {
		int result = boardDao.baordInsert(vo);
		return result;
	}*/
	@Override
	public int boardInsert(BoardVO vo) throws Exception {
		int result = 0;
		
		/*
		 * if(vo.getB_num() == 0){ throw new
		 * IllegalArgumentException("0번 글은 등록할 수 없습니다."); }
		 */
		
		if(vo.getFile().getSize() > 0) {
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "board"); 
			vo.setB_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			vo.setB_thumb(thumbName);
		}
		
		result = boardDao.baordInsert(vo);
		return result;
	}

	/*@Override
	public BoardVO boardDetaile(int b_num) {
		return boardDao.boardDetaile(b_num); //controller에서 받는 넘버.
	}*/
	@Override //글 상세 구현
	public BoardVO boardDetail(BoardVO vo) {
		BoardVO detail = null;
		
		boardDao.readCntUpdate(vo); //조회수 증가 메서드 호출
		
		detail = boardDao.boardDetail(vo);
		
		if(detail != null) {
			detail.setB_content(detail.getB_content().toString().replaceAll("\n", "<br/>"));
			// "\n" 이걸 만나면 "<br/>"로 변경하자.
		}
		return detail;
	}
	
	// 글 수정 폼 
	@Override
	public BoardVO updateForm(BoardVO vo) {
		BoardVO updateDate = null;
		updateDate = boardDao.boardDetail(vo);
		return updateDate;
	}

	//글 수정 구현
	@Override 
	public int boardUpdate(BoardVO vo) throws Exception {
		int result = 0;
		if(!vo.getFile().isEmpty()) { // 새롭게 업로드할 파일이 존재하면
			if(!vo.getB_file().isEmpty()) { //기존 파일이 존재하면
				FileUploadUtil.fileDelete(vo.getB_file());
				FileUploadUtil.fileDelete(vo.getB_thumb());
			}
			String fileName = FileUploadUtil.fileUpload(vo.getFile(), "board");
			vo.setB_file(fileName);
			
			String thumbName = FileUploadUtil.makeThumbnail(fileName);
			vo.setB_thumb(thumbName);
		}
		result = boardDao.boardUpdate(vo);
		return result;
	}

	//글 삭제 구현
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
	
	// 비밀번호 확인 구현
	@Override
	public int pwdConfirm(BoardVO vo) {
		int result = 0;
		result = boardDao.pwdConfirm(vo);
		return result;
	}

	// 글 삭제전 댓글 개수 구현
	@Override
	public int replyCnt(int b_num) {
		int result = 0;
		result = replyDao.replyCnt(b_num);
		return result;
	}
	
	
	
	
	
	

}

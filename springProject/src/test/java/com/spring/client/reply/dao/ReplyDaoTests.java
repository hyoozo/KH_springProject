package com.spring.client.reply.dao;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.client.reply.vo.ReplyVO;

import lombok.Setter;
import lombok.extern.slf4j.Slf4j;

@SpringBootTest
@Slf4j
@WebAppConfiguration
public class ReplyDaoTests {

	@Setter(onMethod_ = @Autowired)
	private ReplyDao replyDao;
	
	@Test
	public void testReplyList() {
		List<ReplyVO> list = replyDao.replyList(1);
	
//		for(ReplyVO r : list ) {
//			log.info(r);
//		}
	}
	
	/*@Test
	public void testReplyInsert() {
		ReplyVO vo = new ReplyVO();
		vo.setB_num(1);
		vo.setR_name("홍길동");
		vo.setR_content("남을 위해 사는 착한사람 말고, 나를 위해 사는 좋은 사람이 되기를");
		vo.setR_pwd("1234");
		int result = replyDao.replyInsert(vo);
		
		log.info(result);
	}*/
	
	/*@Test
	public void testPwdConfirm() {
		ReplyVO vo = new ReplyVO();
		vo.setR_num(1);
		vo.setR_pwd("1234");
		int result = replyDao.pwdConfirm(vo);
		
		log.info("일치 여부(일치:1/불일치:0): " + result);
	}*/
	
	/*@Test
	public void testReplyDelete() {
		int result = replyDao.replyDelete(3);
		
		log.info("삭제결과 : " + result);
	}*/
}

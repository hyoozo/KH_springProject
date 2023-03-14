package com.spring.client.reply.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.spring.client.reply.vo.ReplyVO;

@Mapper
public interface ReplyDao {
	
	public List<ReplyVO> replyList(Integer b_num); // 객체로 표현하기 위해 Integer로 표현
	public int replyInsert(ReplyVO rvo);
	public int pwdConfirm(ReplyVO rvo);
	public int replyUpdate(ReplyVO rvo);
	public int replyDelete(Integer r_num);
	public int replyCnt(int b_num);

}

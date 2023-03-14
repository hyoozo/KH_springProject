package com.spring.admin.login.dao;

import org.apache.ibatis.annotations.Mapper;

import com.spring.admin.login.vo.AdminLoginVO;

@Mapper
public interface AdminLoginDao {
	
	public AdminLoginVO loginProcess(AdminLoginVO login);
		// 로그인 성공시 레코드 반환되는 메서드 (VO에서 아이디와 비밀번호를 받기 위함)
	
	
}

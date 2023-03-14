package com.spring.admin.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.admin.login.dao.AdminLoginDao;
import com.spring.admin.login.vo.AdminLoginVO;


import lombok.Setter;

@Service // Service 인터페이스 만든 후 구현클래스에 @Service 어노테이션 붙이기
public class AdminLoginServiceImpl implements AdminLoginService {

	@Setter(onMethod_=@Autowired) // 설정자를 만들고 의존 객체에 대해 주입해주기
	private AdminLoginDao adminLoginDao;
	
	

	@Override
	public AdminLoginVO loginProcess(AdminLoginVO login) {
		AdminLoginVO adminLoginVO = adminLoginDao.loginProcess(login);
		return adminLoginVO;
	}
	
	
	
}

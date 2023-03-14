package com.spring.common.log;

import java.util.Arrays;

import org.springframework.util.StopWatch;
import org.aspectj.lang.JoinPoint;
//import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
//import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
//import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

//import com.spring.client.board.vo.BoardVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@Aspect
public class LoggerAdvice {
	
	/* execution(@execution) 메서드를 기준으로 Pointcut을 설정 */
	/*@Before("execution(* com.spring..*Impl.*(..))")
	public void printLogging() {
		log.info("-------------------------------");
		log.info("[공통 로그 Log] 비즈니스 로직 수행 전 동작");
		log.info("-------------------------------");
	}*/

	
	/*@Before("execution(* com.spring..*Impl.*(..)) && args(bvo)")
	public void printLogging(BoardVO bvo) {
		log.info("-------------------------------");
		log.info("[공통 로그 Log] 비즈니스 로직 수행 전 동작");
		log.info("-------------------------------");
	}*/
	
	/*@Before("execution(* com.spring..*Impl.*(..))")
	public void printLogging(JoinPoint jp) {
		log.info("-------------------------------");
		log.info("[공통 로그 Log] 비즈니스 로직 수행 전 동작");
		log.info("[호출 메서드명] " + jp.getSignature().getName());
		log.info("[호출 메서드의 파라미터 값] " + Arrays.toString(jp.getArgs()));
		log.info("-------------------------------");
	}*/
	
	/* 예외가 발생한 시점에 동작 */
	@AfterThrowing(pointcut="execution(* com.spring..*Impl.*(..))", throwing="exception")
	public void exceprionLogging(JoinPoint jp, Throwable exception) {
		log.info("-------------------------------");
		log.info("[예외발생]");
		log.info("[예외발생 메서드명] " + jp.getSignature().getName());
		log.info("[예외 메시지] " + exception);
		log.info("-------------------------------");
	}
	
	/* 비즈니스 로직 메서드가 정상적으로 수행 된 후 동작 */
	/*@AfterReturning(pointcut="execution(* com.spring..service.*Impl.*(..))", returning = "returnValue")
	public void afterReturningMethod(JoinPoint jp, Object returnValue) { 
		log.info("-------------------------------------");
		log.info("[공통 로그 Log] 비즈니스 로직 수행 후 동작"); 
		log.info("afterReturningMethod() called....." + jp.getSignature().getName()); 
		log.info("[리턴 결과] " + returnValue); 
		log.info("-------------------------------------");
	}*/
	
	
	@Around("execution(* com.spring..*Impl.*(..))")
	public Object timeLogging(ProceedingJoinPoint pjp) throws Throwable{
		log.info("-------------------------------------"); 
		log.info("[공통 로그 Log] 비즈니스 로직 수행 전 동작");
		
		//long startTime = System.currentTimeMillis();
		StopWatch watch = new StopWatch();
		watch.start();
		log.info("[호출 메서드의 파라미터 값] " + Arrays.toString(pjp.getArgs()));
		
		Object result = null;
		// proceed() : 실제 target 객체의 메서드를 실행하는 기능. 
		result = pjp.proceed();
		
		//long endTime = System.currentTimeMillis();
		watch.stop();
		
		log.info("[Class] " + pjp.getTarget().getClass());
		
		//logger.info(pjp.getSignature().getName()+":소요시간 "+ (endTime-startTime)+"ms"); 
		log.info("[호출 메서드명] " + pjp.getSignature().getName() );
		log.info("[소요시간] " + watch.getTotalTimeSeconds() +"ms");
		log.info("[리턴 결과] " + result);
		log.info("[공통 로그 Log] 비즈니스 로직 수행 후 동작"); 
		log.info("-------------------------------------");
		
		return result; 
	}
	
}

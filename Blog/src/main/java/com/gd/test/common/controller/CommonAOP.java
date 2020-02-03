package com.gd.test.common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;


@Aspect //필터같은 역할
public class CommonAOP {
	//Point -> 적용범위
	//@Pointcut(범위 설정)
	/*
		범위
		execution --> include필터
		!execution --> exclude필터(제외)
		* --> 모든것
		*(..) --> 모든메소드
		.. --> 모든경로
		&& --> 필터추가
	*/
	@Pointcut("execution(* com.gd.test..TestController2.*(..))"
			+ "&&!execution(* com.gd.test..TestController2.*Ajax(..))"
			+ "&&!execution(* com.gd.test..TestController2.*Log*(..))"
			+ "&&!execution(* com.gd.test..TestController2.*Join(..))"
			+ "&&!execution(* com.gd.test..TestController2.*List(..))"
			+ "&&!execution(* com.gd.test..TestController2.*Details(..))")
	
	public void aLoginCheckAOP() {
		
	}
	
	//ProceedingJoinPoint --> 대상 적용 이벤트 필터
	/*
	 *  @Before -> 메소드 실행 전
	 *  @After -> 메소드 실행 후
	 *  @After-returning -> 메소드 정상실행 후
	 *  @After-throwing -> 메소드 예외 발생 후
	 *  @Around -> 모든동작시점
	*/
	
	@Around("aLoginCheckAOP()")
	public ModelAndView aLoginCheckAOP(ProceedingJoinPoint joinPoint) throws Throwable{
		
		ModelAndView mav = new ModelAndView();
		
		//Request 객체 취득
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		//Session 취득
		HttpSession session = request.getSession();
		
		if(session.getAttribute("sBmNo") != null) {
			mav = (ModelAndView) joinPoint.proceed();
		}
		else {
			mav.setViewName("redirect:aLogin");
		}
		System.out.println("------ aLoginCheckAOP 실행됨 ------");
		return mav;
	}
	
}

package com.gd.test.web.blog.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gd.test.common.bean.PagingBean;
import com.gd.test.common.service.IPagingService;
import com.gd.test.util.Utils;
import com.gd.test.web.blog.service.Ibservice;

@Controller
public class bcontroller {
	@Autowired
	public Ibservice ibservice;
	@Autowired
	public IPagingService iPagingService;
	//main page
	@RequestMapping(value = "/blog_main")
	public ModelAndView blog_main(ModelAndView mav) {

		mav.setViewName("blog/blog_main");

		return mav;
	}
	
	//join page
	@RequestMapping(value = "/blog_join")
	public ModelAndView blog_join(ModelAndView mav) {
		
		mav.setViewName("blog/blog_join");
		
		return mav;
	}
	
	//ID 중복체크
	@RequestMapping(value="/bIdCheckAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String bIdCheckAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	System.out.println(params.get("id"));
	int cnt = ibservice.idCheck(params); //중복체크
	
	modelMap.put("cnt", cnt);
	
	return mapper.writeValueAsString(modelMap);
}
	
	//회원가입s
	@RequestMapping(value="/bJoinAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String bJoinAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			//비밀번호 암호화
			params.put("pw",Utils.encryptAES128(params.get("pw")));
			ibservice.insertBM(params);
			modelMap.put("res","SUCCESS");
		} catch(Exception e){
			e.printStackTrace();
			modelMap.put("res","FAILED");
		}
		
		
		return mapper.writeValueAsString(modelMap);
}
	//로그인 처리
	@RequestMapping(value="/bLoginAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String bLoginAjax(@RequestParam HashMap<String,String> params, ModelAndView mav
			, HttpSession session) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
			//비밀번호 암호화
			params.put("pw",Utils.encryptAES128(params.get("pw")));
			
			HashMap<String,String> data = ibservice.getBM(params);
			
			if(data != null) {
				session.setAttribute("sBmNo", data.get("M_NO"));
				session.setAttribute("sBmNm", data.get("M_NM"));
				session.setAttribute("sBmId", data.get("M_ID"));
				session.setAttribute("sBmPw", data.get("M_PW"));
				session.setAttribute("bNo", data.get("BLOG_NUM"));
				modelMap.put("res", "SUCCESS");
			}
			else {
				modelMap.put("res", "FAILED");
			}
		return mapper.writeValueAsString(modelMap);
	}
	
	//로그아웃
		@RequestMapping(value="/blog_logout")
		public ModelAndView blog_logout(ModelAndView mav, HttpSession session) {
			
			session.invalidate();
			mav.setViewName("redirect:blog_main");
			
			return mav;
		}
	
	//글목록
	@RequestMapping(value="/blog_list")
	public ModelAndView blog_list(ModelAndView mav) {
		
		mav.setViewName("blog/blog_list");
		return mav;
	}

	/********************************************************************	**/
	//글목록s
	@RequestMapping(value="/bListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody 
	public String bListAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = ibservice.getBCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt , 5 ,5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String,String>> list = ibservice.getB(params);
		HashMap<String, String> data = ibservice.getData2(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("data", data);
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//글쓰기
	@RequestMapping(value = "/blog_write")
	public ModelAndView blog_write(ModelAndView mav, HttpSession session) {

		mav.setViewName("blog/blog_write");

		return mav;
	}

	//글쓰기s
	@RequestMapping(value="/bSaveAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String bSaveAjax(@RequestParam HashMap<String,String> params, 
							HttpSession session,ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			ibservice.saveB(params);
			modelMap.put("res","SUCCESS");
		} catch(Exception e){
			e.printStackTrace();
			modelMap.put("res","FAILED");
		}
		return mapper.writeValueAsString(modelMap);
}


	//상세보기
	@RequestMapping(value = "/blog_detail")
	public ModelAndView blog_detail(@RequestParam HashMap<String, String> params, ModelAndView mav
										,HttpSession session) throws Throwable {
		
		HashMap<String, String> data = ibservice.getData2(params);
		mav.addObject("data", data);
		mav.setViewName("blog/blog_list");
		return mav;
	}

	
	//상세보기리스트?
	@RequestMapping(value="/cListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody 
	public String cListAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = ibservice.getBCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt , 10 ,5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String,String>> list = ibservice.getB(params);
		HashMap<String, String> data = ibservice.getData2(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		modelMap.put("data", data);
		
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//댓글등록s
	@RequestMapping(value="/aMentAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String aMentAjax(@RequestParam HashMap<String,String> params, 
							HttpSession session,ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		try {
			ibservice.saveComment(params);
			modelMap.put("res","SUCCESS");
		} catch(Exception e){
			e.printStackTrace();
			modelMap.put("res","FAILED");
		}
		return mapper.writeValueAsString(modelMap);
	}
	
	//댓글목록
		@RequestMapping(value="/mentListAjax",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")

		@ResponseBody 
		public String mentListAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			List<HashMap<String,String>> ment = ibservice.getM(params);
			System.out.println(ment + "\n\n\n");
			modelMap.put("ment", ment);
			
			
			return mapper.writeValueAsString(modelMap);
		}
	
	//글수정
	@RequestMapping(value="/blog_update")
	public ModelAndView blog_update(@RequestParam HashMap<String,String> params, 
									ModelAndView mav,HttpSession session) throws Throwable {
		
		
		HashMap<String, String> data = ibservice.getData3(params);
		mav.addObject("data", data);
		mav.setViewName("blog/blog_update");
		
		return mav;
	}
	//글수정 ajax
	@RequestMapping(value="/cUpdateAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String cUpdateAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			ibservice.updateB(params);
			modelMap.put("res","SUCCESS");
		} catch(Exception e){
			e.printStackTrace();
			modelMap.put("res","FAILED");
		}
		return mapper.writeValueAsString(modelMap);
}

	//delete ajax
	@RequestMapping(value="/cdeleteAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
	public String cdeleteAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			ibservice.deleteB(params);
			modelMap.put("res","SUCCESS");
		} catch(Exception e){
			e.printStackTrace();
			modelMap.put("res","FAILED");
		}
		return mapper.writeValueAsString(modelMap);
}	
		
	
	//블로그목록
		@RequestMapping(value="/blog_list1")
		public ModelAndView blog_list1(ModelAndView mav) {
			
			mav.setViewName("blog/blog_list1");
			
			return mav;
		}
		
	//블로그리스트?
	@RequestMapping(value="/dListAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")

	@ResponseBody 
	public String dListAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
	
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		int cnt = ibservice.getBCnt(params);
		
		PagingBean pb = iPagingService.getPagingBean(Integer.parseInt(params.get("page")), cnt , 10 ,5);
		
		params.put("startCnt", Integer.toString(pb.getStartCount()));
		params.put("endCnt", Integer.toString(pb.getEndCount()));
		
		List<HashMap<String,String>> list = ibservice.getBloglist(params);
		
		modelMap.put("list", list);
		modelMap.put("pb", pb);
		
		return mapper.writeValueAsString(modelMap);
	}
		
	//블로그만들기
	@RequestMapping(value="/blog_make")
	public ModelAndView blog_make(ModelAndView mav) {
		
		mav.setViewName("blog/blog_make");
		
		return mav;
	}	
	
	//만들기s
		@RequestMapping(value="/makeAjax",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")

		@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
		public String makeAjax(@RequestParam HashMap<String,String> params, ModelAndView mav ,HttpSession session) throws Throwable{
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			
			try {
				ibservice.insertBlog(params);
				modelMap.put("res","SUCCESS");
			} catch(Exception e){
				e.printStackTrace();
				modelMap.put("res","FAILED");
			}
			
			
			return mapper.writeValueAsString(modelMap);
	}
	//블로그명 중복체크
	@RequestMapping(value="/blogNameAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String blogNameAjax(@RequestParam HashMap<String,String> params, ModelAndView mav, HttpSession session) throws Throwable{
	
	ObjectMapper mapper = new ObjectMapper();
	Map<String, Object> modelMap = new HashMap<String, Object>();
	int cnt = ibservice.blogCheck(params); //중복체크
	
	modelMap.put("cnt", cnt);
	
	return mapper.writeValueAsString(modelMap);
	}
	
	//data ajax
	@RequestMapping(value="/dataAjax",
			method = RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String dataAjax(@RequestParam HashMap<String,String> params, ModelAndView mav, HttpSession session) throws Throwable{
		
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
		HashMap<String, String> data = ibservice.getData2(params);
		modelMap.put("data", data);

		return mapper.writeValueAsString(modelMap);
	}

	//댓글삭제
		@RequestMapping(value="/mentdelAjax",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")

		@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
		public String mentdelAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			try {
				ibservice.deleteMent(params);
				modelMap.put("res","SUCCESS");
			} catch(Exception e){
				e.printStackTrace();
				modelMap.put("res","FAILED");
			}
			return mapper.writeValueAsString(modelMap);
		}	
	
	
	
		//회원정보수정
		@RequestMapping(value="/blog_user_update")
		public ModelAndView blog_user_update(@RequestParam HashMap<String,String> params, 
										ModelAndView mav,HttpSession session) throws Throwable {
			System.out.println(session.getAttribute("sBmId"));
			
			HashMap<String, String> data = ibservice.getuserData(params);
			mav.addObject("data", data);			
			mav.setViewName("blog/blog_user_update");
			
			return mav;
		}
		//회원정보수정 ajax
		@RequestMapping(value="/userUpdateAjax",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")

		@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
		public String userUpdateAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			try {
				params.put("Bpw",Utils.encryptAES128(params.get("Bpw")));
				ibservice.updateU(params);
				modelMap.put("res","SUCCESS");
			} catch(Exception e){
				e.printStackTrace();
				modelMap.put("res","FAILED");
			}
			return mapper.writeValueAsString(modelMap);
	}
	
	
	
		//회원탈퇴
		
		@RequestMapping(value="/useroutAjax",
				method = RequestMethod.POST,
				produces = "text/json;charset=UTF-8")

		@ResponseBody // Spring은 View를 활용하여 구현하게 되어있어 View인것으로 인식시켜 넘어가게하는 어노테이션
		public String useroutAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable{
		
			ObjectMapper mapper = new ObjectMapper();
			Map<String, Object> modelMap = new HashMap<String, Object>();
			try {
				params.put("Bpw",Utils.encryptAES128(params.get("Bpw")));
				ibservice.deleteU(params);
				modelMap.put("res","SUCCESS");
			} catch(Exception e){
				e.printStackTrace();
				modelMap.put("res","FAILED");
			}
			return mapper.writeValueAsString(modelMap);
	}	

}

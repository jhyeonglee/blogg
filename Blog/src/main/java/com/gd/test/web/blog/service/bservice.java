package com.gd.test.web.blog.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gd.test.web.blog.dao.Ibdao;

@Service
public class bservice implements Ibservice{
	@Autowired
	public Ibdao ibdao;

	@Override
	public int idCheck(HashMap<String, String> params) throws Throwable {
		return ibdao.idCheck(params);
	}

	@Override
	public void insertBM(HashMap<String, String> params) throws Throwable {
		ibdao.insertBM(params);
		
	}

	@Override
	public HashMap<String, String> getBM(HashMap<String, String> params) throws Throwable {
		
		return ibdao.getBM(params);
	}

	@Override
	public int getBCnt(HashMap<String, String> params) throws Throwable {
		return ibdao.getBCnt(params);
	}

	@Override
	public List<HashMap<String, String>> getB(HashMap<String, String> params) throws Throwable {
		return ibdao.getB(params);
	}

	@Override
	public void saveB(HashMap<String, String> params) throws Throwable {
		ibdao.saveB(params);
		
	}

	@Override
	public HashMap<String, String> getData2(HashMap<String, String> params) throws Throwable {
		return ibdao.getData2(params);
	}

	@Override
	public void saveComment(HashMap<String, String> params) throws Throwable {
		ibdao.saveComment(params);
	}

	@Override
	public HashMap<String, String> getData3(HashMap<String, String> params) throws Throwable {
		return ibdao.getData3(params);
	}

	@Override
	public void deleteB(HashMap<String, String> params) throws Throwable {
		ibdao.deleteB(params);
	}

	@Override
	public void updateB(HashMap<String, String> params) throws Throwable {
		ibdao.updateB(params);
	}

	@Override
	public List<HashMap<String, String>> getM(HashMap<String, String> params) throws Throwable {
		return ibdao.getM(params);
	}

	@Override
	public List<HashMap<String, String>> getBloglist(HashMap<String, String> params) throws Throwable {
		return ibdao.getBloglist(params);
	}

	@Override
	public void insertBlog(HashMap<String, String> params) throws Throwable {
		ibdao.insertBlog(params);
	}

	@Override
	public int blogCheck(HashMap<String, String> params) throws Throwable {
		return ibdao.blogCheck(params);
	}

	@Override
	public void deleteMent(HashMap<String, String> params) throws Throwable {
		ibdao.deleteMent(params);
	}

	@Override
	public HashMap<String, String> getuserData(HashMap<String, String> params) throws Throwable {
		return ibdao.getuserData(params);
	}

	@Override
	public void updateU(HashMap<String, String> params) throws Throwable {
		ibdao.updateU(params);
	}

	@Override
	public void deleteU(HashMap<String, String> params) throws Throwable {
		ibdao.deleteU(params);
	}
}

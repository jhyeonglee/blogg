package com.gd.test.web.blog.dao;

import java.util.HashMap;
import java.util.List;

public interface Ibdao {

	public int idCheck(HashMap<String, String> params) throws Throwable;

	public void insertBM(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getBM(HashMap<String, String> params) throws Throwable;

	public int getBCnt(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getB(HashMap<String, String> params) throws Throwable;

	public void saveB(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getData2(HashMap<String, String> params) throws Throwable;

	public void saveComment(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getData3(HashMap<String, String> params) throws Throwable;

	public void deleteB(HashMap<String, String> params) throws Throwable;

	public void updateB(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getM(HashMap<String, String> params) throws Throwable;

	public List<HashMap<String, String>> getBloglist(HashMap<String, String> params) throws Throwable;

	public void insertBlog(HashMap<String, String> params) throws Throwable;

	public int blogCheck(HashMap<String, String> params) throws Throwable;

	public void deleteMent(HashMap<String, String> params) throws Throwable;

	public HashMap<String, String> getuserData(HashMap<String, String> params) throws Throwable;

	public void updateU(HashMap<String, String> params) throws Throwable;

	public void deleteU(HashMap<String, String> params) throws Throwable; 
	

}

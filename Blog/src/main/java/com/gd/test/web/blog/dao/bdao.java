package com.gd.test.web.blog.dao;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class bdao implements Ibdao{
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int idCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.idCheck",params);
	}

	@Override
	public void insertBM(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("blog.insertBM",params);		
	}

	@Override
	public HashMap<String, String> getBM(HashMap<String, String> params) throws Throwable {
		
		return sqlSession.selectOne("blog.getBM",params);
	}

	@Override
	public int getBCnt(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.getBCnt",params);
	}

	@Override
	public List<HashMap<String, String>> getB(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("blog.getB",params);
	}

	@Override
	public void saveB(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("blog.saveB",params);
		
	}

	@Override
	public HashMap<String, String> getData2(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.getData2",params);
	}

	@Override
	public void saveComment(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("blog.saveComment",params);
	}

	@Override
	public HashMap<String, String> getData3(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.getData3",params);
	}

	@Override
	public void deleteB(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("blog.deleteB",params);
	}

	@Override
	public void updateB(HashMap<String, String> params) throws Throwable {
		sqlSession.update("blog.updateB",params);
		
	}

	@Override
	public List<HashMap<String, String>> getM(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("blog.getM",params);
	}

	@Override
	public List<HashMap<String, String>> getBloglist(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectList("blog.getBloglist",params);
	}

	@Override
	public void insertBlog(HashMap<String, String> params) throws Throwable {
		sqlSession.insert("blog.insertBlog",params);
	}

	@Override
	public int blogCheck(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.blogCheck",params);
	}

	@Override
	public void deleteMent(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("blog.deleteMent",params);
	}

	@Override
	public HashMap<String, String> getuserData(HashMap<String, String> params) throws Throwable {
		return sqlSession.selectOne("blog.getuserData",params);
	}

	@Override
	public void updateU(HashMap<String, String> params) throws Throwable {
		sqlSession.update("blog.updateU",params);
	}

	@Override
	public void deleteU(HashMap<String, String> params) throws Throwable {
		sqlSession.delete("blog.deleteU",params);
	}

}


package com.de.cmmn.service;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;


/**
 * @author 김승원
 * @since 2020. 03. 19.
 * @version 1.0
 *
 * <pre>
 * Name : CmmnDAO.java
 * Description  : TODO
 * 
 * << 개정이력(Modification Information) >>
 *   
 *   수정일             수정자             수정내용
 * ==============================================
 *  2020. 03. 19.      김승원             최초 생성
 *
 * </pre>
 */
public abstract class ComAbstractDAO extends SqlSessionDaoSupport{
	
	
	//@Resource(name="egov.sqlMapClient")
	@Autowired
	public void setSuperSqlSessionFactory(SqlSessionFactory sqlSessionFactory) {
        //super.setSuperSqlMapClient(sqlMapClient);
        //super.setSqlSessionTemplate(sqlSessionTemplate);
        super.setSqlSessionFactory(sqlSessionFactory);
    }
	

}

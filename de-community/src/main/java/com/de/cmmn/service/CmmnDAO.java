package com.de.cmmn.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.de.cmmn.CmmnMap;




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

@Repository("cmmnDAO")
public class CmmnDAO extends ComAbstractDAO{

	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<CmmnMap> selectList(String sqlId, CmmnMap param) throws Exception{
		return getSqlSession().selectList(sqlId, param);
	}
	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public CmmnMap selectObject(String sqlId, CmmnMap param) throws Exception{
		return getSqlSession().selectOne(sqlId, param);
	}
	
	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int selectCount(String sqlId, CmmnMap param) throws Exception{
		return getSqlSession().selectOne(sqlId, param);
	}
	/**
	 * @param sqlId
	 * @param param
	 * @throws Exception
	 */
	public void insertObject(String sqlId, CmmnMap param) throws Exception{
		getSqlSession().insert(sqlId, param);
	}
	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String insertObjectReturnKeyString(String sqlId, CmmnMap param) throws Exception{
		return  (String)insertObjectReturnKeyString(sqlId, param);
	}
	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int updateObject(String sqlId, CmmnMap param) throws Exception{
		return getSqlSession().update(sqlId, param);
	}
	/**
	 * @param sqlId
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public int deleteObject(String sqlId, CmmnMap param) throws Exception{
		return getSqlSession().delete(sqlId, param);
	}
	
//	 private static final int DB_BATCH_SIZE = 1000;
//	 
//	/**
//	 * @param sqlId
//	 * @param param
//	 * @param dataList
//	 * @throws Exception
//	 */
//		@SuppressWarnings({ "unchecked", "rawtypes", "deprecation" })
//		public void insertBatchObject(final String sqlId,final CmmnMap param,final List<CmmnMap> dataList)throws Exception{
//			 
//			getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
//				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
//					int count = 0, total = 0;
//					
//					executor.startBatch();
//					for(int i=0,max=dataList.size();i<max;i++){
//						CmmnMap dataVO = new CmmnMap();
//					if(param!=null)
//					dataVO.putAll(param);
//					dataVO.putAll(dataList.get(i));
//						executor.insert(sqlId, dataVO);
//						 count++;
//		                    if (count % DB_BATCH_SIZE == 0) 
//		                    {
//		                        total += executor.executeBatch();
//		                        executor.startBatch();
//		                    }
//					}
//					total += executor.executeBatch();
//					return new Integer(total);
//				}
//			});
//		}
//
//	/**
//	 * @param sqlId
//	 * @param param
//	 * @param dataList
//	 * @throws Exception
//	 */
//	@SuppressWarnings({ "deprecation", "rawtypes", "unchecked" })
//	public void updateBatchObject(final String sqlId,final CmmnMap param,final List<CmmnMap> dataList)throws Exception{
//		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
//			public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
//				executor.startBatch();
//				for(int i=0,max=dataList.size();i<max;i++){
//				CmmnMap dataVO = new CmmnMap();
//				dataVO.putAll(param);
//				dataVO.putAll(dataList.get(i));
//					executor.update(sqlId, dataVO);
//				}
//				executor.executeBatch();
//				return null;
//			}
//		});
//	}
//
//	/**
//	 * @param sqlId
//	 * @param param
//	 * @param dataList
//	 * @throws Exception
//	 */
//	@SuppressWarnings({ "deprecation", "rawtypes", "unchecked" })
//	public void deleteBatchObject(final String sqlId,final CmmnMap param,final List<CmmnMap> dataList)throws Exception{
//		getSqlMapClientTemplate().execute(new SqlMapClientCallback() {
//			public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException {
//				executor.startBatch();
//				for(int i=0,max=dataList.size();i<max;i++){
//				CmmnMap dataVO = new CmmnMap();
//				dataVO.putAll(param);
//				dataVO.putAll(dataList.get(i));
//					executor.delete(sqlId, dataVO);
//				}
//				executor.executeBatch();
//				return null;
//			}
//		});
//	}
//	/**
//	 * @param sqlId
//	 * @param dataList
//	 * @throws Exception
//	 */
//	public void insertList(String sqlId,List<CmmnMap> dataList)throws Exception{
//		insert(sqlId, dataList);
//	}
//	/**
//	 * @param sqlId
//	 * @param dataList
//	 * @return
//	 * @throws Exception
//	 */
//	public int updateForeach(String sqlId,List<CmmnMap>dataList)throws Exception{
//		
//		return update(sqlId,dataList);
//	}

}

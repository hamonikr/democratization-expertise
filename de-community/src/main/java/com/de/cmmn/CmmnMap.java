package com.de.cmmn;

import java.io.IOException;
import java.io.Reader;
import java.sql.Clob;

import egovframework.rte.psl.dataaccess.util.EgovMap;


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
public class CmmnMap extends EgovMap {

	private static final long serialVersionUID = 5999449270240546463L;

	/**
	 * @return
	 */
	public CmmnMap getFormMap() {
		return this;
	}
	/**
	 * @param formMap
	 */
	public void setFormMap(CmmnMap formMap) {
		this.clear();
		this.putAll(formMap);
	}

	/**
	 * @return
	 */
	public CmmnMap getVoMap() {
		return this;
	}

	/**
	 * @param voMap
	 */
	public void setVoMap(CmmnMap voMap) {
		this.clear();
		this.putAll(voMap);
	}

	@Override
	public Object put(Object key, Object value) {
		if(key == null || key.toString().trim().length() < 1){
			return this;
		}
		// clob to string
		if(value != null && value instanceof java.sql.Clob ) {
			super.put(key, getStringForClob( (Clob) value));
			return this;
		}
		if(value == null){
			value="";
		}
		super.put(key, value);
		return this;

	}

	/**
	 * @param key
	 * @param value
	 */
	public void set(Object key, Object value) {
		// clob to string
		if(value != null && value instanceof java.sql.Clob ) {
			super.put(key, getStringForClob( (Clob) value));
			return;
		}
		super.put(key, value);
	}
	/*public void setChar(Object obj,char i){
		char char1 = new Character(i);
		super.put(obj, char1);
	}*/
	/**
	 * @param obj
	 * @param i
	 */
	public void setBoolean(Object obj,boolean i ){
		boolean boolean1 = new Boolean(i);
		super.put(obj, boolean1);
	}

	/**
	 * @param obj
	 * @param i
	 */
	public void setInt(Object obj, int i) {
		Integer integer = new Integer(i);
		super.put(obj, integer);
	}

	/**
	 * @param obj
	 * @param d
	 */
	public void setDouble(Object obj, double d) {
		Double double1 = new Double(d);
		super.put(obj, double1);
	}
	/*public char getChar(Object obj){
		Object obj1 =super.get(obj);
		if(obj1==null)
			//return '\0';
			return "".charAt(0);
		else{
			if(obj1 instanceof Character ||obj1 instanceof String)
				return ((Character) obj1).charValue();
		}
		return "".charAt(0);
	}*/
	/**
	 * @param obj
	 * @return
	 */
	public boolean getBoolean(Object obj){
		Object obj1 = super.get(obj);
		if(obj1==null)
			return Boolean.FALSE;
		else{
			if (obj1 instanceof Boolean)
				return ((Boolean) obj1).booleanValue();
			else if(obj1 instanceof String){
				try{
					return Boolean.parseBoolean(obj1.toString());
				}catch(Exception e){}
			}
		}
			return Boolean.FALSE;
	}
	/**
	 * @param obj
	 * @return
	 */
	public String getString(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null)
			return "";
		else
			return obj1.toString();
	}

	/**
	 * @param obj
	 * @return
	 */
	public int getInt(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null) {
			return 0;
		} else {
			if (obj1 instanceof Number)
				return ((Number) obj1).intValue();
			if (obj1 instanceof String)
				try {
					return Integer.parseInt(obj1.toString());
				} catch (Exception exception) {
				}
		}
		return 0;
	}

	/**
	 * @param obj
	 * @return
	 */
	public double getDouble(Object obj) {
		Object obj1 = super.get(obj);
		if (obj1 == null) {
			return 0.0D;
		} else {
			if (obj1 instanceof Number)
				return ((Number) obj1).doubleValue();
			if (obj1 instanceof String)
				try {
					return Double.parseDouble(obj1.toString());
				} catch (Exception exception) {
				}
		}
		return 0.0D;
	}

	@Override
	public Object get(Object key) {
		if(!this.containsKey(key))
			return "";

		return super.get(key);
	}



	/**
	 * java.sql.Clob 을 String 으로 리텅
	 * @param clob
	 * @return
	 */
	private String getStringForClob(Clob clob) {

        StringBuffer sbf = new StringBuffer();
        Reader br = null;
        char[] buf = new char[1024];
        int readcnt;
        try {
            br = clob.getCharacterStream();
            while ((readcnt=br.read(buf,0,1024))!=-1) {
                sbf.append(buf,0,readcnt);
            }
        } catch (Exception e) {
        	//logger.error("Failed to create String object from CLOB" + e);
        	//throw new Exception(e.getMessage());
        }finally{
            if(br!=null)
                try {
                    br.close();
                } catch (IOException e) {
//                	logger.error("Failed to close BufferedReader object" + e);
//                	throw new Exception(e.getMessage());
               }
        }
        return sbf.toString();
    }
}

package com.de.file.service.mapper;

import java.util.Map;

public interface FileMapper {
	
	public Map<String, Object> getImageFile(Map<String, Object> params);
	
	public int saveFile(Map<String, Object> params);
	
	public int updateFile(Map<String, Object> params);

}

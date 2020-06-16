package com.de.file.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.file.service.mapper.FileMapper;

@Service
@Transactional
public class FileService {
	
	@Autowired
	FileMapper fm;
	
	public int saveFile(Map<String, Object> dataMap,List<FileVO> fileList) {
		int result = 0;
		System.out.println("seq===="+dataMap.get("seq"));
		// 2. 파일 정보 저장
				if(fileList !=  null && fileList.size() == 1) {
					for (FileVO fileVO : fileList) {
						dataMap.put("filemakename", fileVO.getFilename());
						dataMap.put("filerealname", fileVO.getRealname());
						dataMap.put("filesize", fileVO.getFilesize());
						dataMap.put("filepath", fileVO.getFilepath());
						System.out.println("f1=="+dataMap.get("filemakename"));
						System.out.println("f2=="+dataMap.get("filerealname"));
						System.out.println("f3=="+dataMap.get("filesize"));
						System.out.println("f4=="+dataMap.get("seq"));
						System.out.println("f5=="+dataMap.get("filepath"));
						System.out.println("f6=="+dataMap.get("section"));
					
					}
					// 1. 게시글 정보 저장
				}
				fm.saveFile(dataMap);
				result = 1;
		return result;
		
	}
	
	public int updateFile(Map<String, Object> dataMap,List<FileVO> fileList) {
		int result = 0;
		System.out.println("seq===="+dataMap.get("seq"));
		// 2. 파일 정보 저장
				if(fileList !=  null && fileList.size() == 1) {
					for (FileVO fileVO : fileList) {
						dataMap.put("filemakename", fileVO.getFilename());
						dataMap.put("filerealname", fileVO.getRealname());
						dataMap.put("filesize", fileVO.getFilesize());
						dataMap.put("filepath", fileVO.getFilepath());
						System.out.println("f1=="+dataMap.get("filemakename"));
						System.out.println("f2=="+dataMap.get("filerealname"));
						System.out.println("f3=="+dataMap.get("filesize"));
						System.out.println("f4=="+dataMap.get("seq"));
						System.out.println("f5=="+dataMap.get("filepath"));
						System.out.println("f6=="+dataMap.get("section"));
					
					}
					// 1. 게시글 정보 저장
				}
				fm.updateFile(dataMap);
				result = 1;
		return result;
		
	}

}

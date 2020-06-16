package com.de.sample.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.de.file.service.FileService;
import com.de.file.service.FileVO;
import com.de.sample.service.mapper.SampleMapper;

@Service
@Transactional(rollbackFor = SQLException.class)
public class SampleService {
	
	@Autowired
	SampleMapper sampleMapper;
	
	@Autowired
	private FileService fileService;
	
		// 게시물 목록
		public List<SampleVO> getList(SampleVO vo) throws Exception {
			return sampleMapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(SampleVO vo) throws Exception {
			return sampleMapper.getListCount(vo);
		}
		// 게시물 등록
		public int save(SampleVO vo, Map<String, Object> params,List<FileVO> fileList) throws Exception {
			int result = sampleMapper.save(vo);
				if(result > 0) {
				try {
					result = fileService.saveFile(params, fileList);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("==========error===========");
					throw new SQLException(e);
				}
			}
			return result;
		}
		// 게시물 수정
		public int update(SampleVO vo) throws Exception{
			return sampleMapper.update(vo);
		}
		// 게시물 상세
		public SampleVO getView(SampleVO vo) throws Exception {
			return sampleMapper.getView(vo);
		}
		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return sampleMapper.selectSEQ();
		}

}

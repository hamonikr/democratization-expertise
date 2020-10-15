package com.hamonize.contract.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hamonize.contract.service.mapper.ContractMapper;
import com.hamonize.file.service.FileService;
import com.hamonize.file.service.FileVO;

@Service
@Transactional(rollbackFor = SQLException.class)
public class ContractService {
	
	@Autowired
	ContractMapper mapper;
	
	@Autowired
	private FileService fileService;
	
		// 게시물 목록
		public List<ContractVO> getList(ContractVO vo) throws Exception {
			return mapper.getList(vo);
		}
		// 게시물 카운트
		public int getListCount(ContractVO vo) throws Exception {
			return mapper.getListCount(vo);
		}
		// 게시물 등록
				public int save(ContractVO vo, Map<String, Object> params, List<FileVO> fileList) throws Exception {
					int result = mapper.save(vo);
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
		public int update(ContractVO vo, Map<String, Object> params, List<FileVO> fileList) throws Exception{
			int result = mapper.update(vo);
			if(result > 0 && fileList != null) {
				try {
					result = fileService.updateFile(params, fileList);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("==========error===========");
					throw new SQLException(e);
				}
			}
			return result;
		}
		// 게시물 상세
		public ContractVO getView(ContractVO vo) throws Exception {
			return mapper.getView(vo);
		}
		// 게시물 삭제
		public int delete(ContractVO vo) throws Exception{
			return mapper.delete(vo);
		}
		// 게시물 SEQ
		public int selectSEQ() throws Exception {
			return mapper.selectSEQ();
		}
		// 견적 승인
		public int updateReqeust(ContractVO vo) throws Exception{
			return mapper.updateReqeust(vo);
		}

}

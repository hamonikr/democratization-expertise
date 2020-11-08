package com.de.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.board.mapper.BoardMapper;

@Service
public class BoardService {
	
	@Autowired
	BoardMapper bm;
	
	// 게시물 목록
		public List<Board> getList(Board vo) throws Exception {
			return bm.getList(vo);
		}


		// 게시물 카운트
		public int getListCount(Board vo) throws Exception {
			return bm.getListCount(vo);
		}

}

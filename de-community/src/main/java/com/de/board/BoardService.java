package com.de.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.de.board.mapper.BoardMapper;
import com.de.question.Questions;

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
		// 게시물 상세
		public Board getView(int boardno) throws Exception {
			return bm.getView(boardno);
		}

}

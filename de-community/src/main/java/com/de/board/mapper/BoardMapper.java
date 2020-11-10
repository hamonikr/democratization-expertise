package com.de.board.mapper;

import java.util.List;

import com.de.board.Board;

public interface BoardMapper {
	
	public List<Board> getList(Board vo) throws Exception;

	public int getListCount(Board vo) throws Exception;
	
	public Board getView(int boardno) throws Exception;

}

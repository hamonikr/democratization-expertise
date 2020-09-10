package com.de.wiki.mapper;

import java.util.List;
import com.de.tag.Tags;

public interface WikiMapper {
	
	public List<Tags> getTagList(Tags vo);
}

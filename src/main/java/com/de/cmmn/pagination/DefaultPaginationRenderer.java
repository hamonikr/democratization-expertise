package com.de.cmmn.pagination;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class DefaultPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{
	
	public DefaultPaginationRenderer() {
		firstPageLabel = "<li class=\"page-item\"><a href=\"#\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><<</a></li>"; 
		previousPageLabel = "<li class=\"page-item\"><a href=\"#\" class=\"page-link\" onclick=\"{0}({1}); return false;\"><</a></li>";
		currentPageLabel = "<li class=\"page-item active\"><a class=\"page-link\" href=\"#\">{0}</a></li>";
		otherPageLabel = "<li class=\"page-item\"><a class=\"page-link\" href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></li>";
		nextPageLabel = "<li class=\"page-item\"><a href=\"#\" class=\"page-link\" onclick=\"{0}({1}); return false;\">></a></li>";
		lastPageLabel = "<li class=\"page-item\"><a href=\"#\" class=\"page-link\" onclick=\"{0}({1}); return false;\">>></a></li>";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		// TODO Auto-generated method stub
		
	}
}
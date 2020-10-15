package com.hamonize.cmmn.pagination;

import javax.servlet.ServletContext;

import org.springframework.web.context.ServletContextAware;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;
/**
 * ImagePaginationRenderer.java 클래스
 *
 * @author 서준식
 * @since 2011. 9. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2011. 9. 16.   서준식       이미지 경로에 ContextPath추가
 * </pre>
 */
public class WwwPaginationRenderer extends AbstractPaginationRenderer implements ServletContextAware{

	private ServletContext servletContext;

	public WwwPaginationRenderer() {
		// no-op
	}

	public void initVariables(){
		firstPageLabel    = "<a href=\"?pageIndex={1}\" class=\"first\" onclick=\"{0}({1});return false;\">처음으로</a>";
		previousPageLabel = "<a href=\"?pageIndex={1}\" class=\"prev\" onclick=\"{0}({1});return false;\">이전</a>";
		currentPageLabel  = "<a href=\"#;\" class=\"on\" aria-label=\"페이지{0}\" title=\"{0}페이지선택됨\" >{0}</a>";
		otherPageLabel    = "<a href=\"?pageIndex={1}\"  aria-label=\"페이지{2}\" onclick=\"{0}({1});return false;\">{2}</a>";
		nextPageLabel     = "<a href=\"?pageIndex={1}\" class=\"next\" onclick=\"{0}({1});return false;\">다음</a>";
		lastPageLabel     = "<a href=\"?pageIndex={1}\" class=\"last\" onclick=\"{0}({1});return false;\">마지막으로</a>";
	}

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
		initVariables();
	}

}


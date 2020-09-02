/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
//	 config.uiColor = '#F7B42C';
	
	config.height = 900;
	config.toolbarCanCollapse = true;
	config.font_names = '맑은 고딕/Malgun Gothic;굴림/Gulim;돋움/Dotum;바탕/Batang;궁서/Gungsuh;' + config.font_names;
//	config.skin = 'office2013';
	config.extraPlugins = 'youtube';

//	config.filebrowserUploadUrl = '/wiki/upload';
};

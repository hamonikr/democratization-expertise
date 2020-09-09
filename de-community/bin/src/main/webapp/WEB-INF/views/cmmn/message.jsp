<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="UTF-8">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>main</title>
<script type="text/javascript">
//<![CDATA[
        var j ='${message}';
        var regex = /<br\s*[\/]?>/gi;
        j = j.replace(regex, '\n');
	    if(j!=''){
	    	alert(j);
	    }        
	    var urls ='${url}';
	    if(urls!=''){
	    	if(urls=='http://www.pol-a.com')
	    	location.href='/';
	    	else
	    	location.href=urls; 
	    }
//]]>
</script>
</head>
<body>

</body>
</html>
package com.hamonize.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class FileDownloadController {

	@Value("${attach.path}")
	private String path;
	
    /**
     * 파일(첨부파일, 이미지등) 다운로드.
     */
    @RequestMapping(value = "fileDown")
    public void fileDownload(@RequestParam Map<String,Object> params, HttpServletRequest request,HttpServletResponse response) {
        
        String realPath = "";
        String tmpPath = path; 
        
        Map<String, Object> boardFile = new HashMap<String, Object>();
        
        String filename = (String)boardFile.get("FILE_NAME");
        String downname = (String)boardFile.get("REAL_NAME");
        String filepath = (String)boardFile.get("FILE_PATH");
        
        if (filepath == null || "".equals(filepath)) filepath = tmpPath;        
        if (filename == null || "".equals(filename)) filename = downname;
        
        try {
            filename = URLEncoder.encode(filename, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        
        String folder = "";
        if(downname.indexOf("_") > -1) {
            String temp[] = downname.split("_");
            folder = temp[1].substring(0,4);
        }
        
        realPath = filepath + folder + "/" + downname;

        File file1 = new File(realPath);
        if (!file1.exists()) {
            return ;
        }
        
        // 파일명 지정
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realPath);

            int ncount = 0;
            byte[] bytes = new byte[512];

            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            
            //다운로드 완료시 카운트 증가
            //boardService.insertBoardFileDownHistory(paramMap);
            
            fis.close();
            os.close();
        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFoundException");
        } catch (IOException ex) {
            System.out.println("IOException");
        }
    }
    
    
    

    /**
     * 이미지파일 다운로드.
     */
    @RequestMapping(value = {"imgfile", "download"})
    public void fileDownload(HttpServletRequest request,HttpServletResponse response) {        
        String filename = request.getParameter("fn");
        String downname = request.getParameter("dn");
        String realPath = "";
        System.out.println("filename==="+filename);
        System.out.println("downname==="+downname);
        if (filename == null || "".equals(filename)) {
            filename = downname;
        }
        
        String folder = "";
        if(downname.indexOf("_") > -1) {
            String temp[] = downname.split("_");
            folder = temp[1].substring(0,4);
        }
        
        try {
            filename = URLEncoder.encode(filename, "UTF-8");
        } catch (UnsupportedEncodingException ex) {
            System.out.println("UnsupportedEncodingException");
        }
        
        realPath = path + folder + "/" + downname;

        File file1 = new File(realPath);
        if (!file1.exists()) {
            return ;
        }
        
        // 파일명 지정
        response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
        try {
            OutputStream os = response.getOutputStream();
            FileInputStream fis = new FileInputStream(realPath);

            int ncount = 0;
            byte[] bytes = new byte[512];

            while ((ncount = fis.read(bytes)) != -1 ) {
                os.write(bytes, 0, ncount);
            }
            fis.close();
            os.close();
        } catch (FileNotFoundException ex) {
            System.out.println("FileNotFoundException");
        } catch (IOException ex) {
            System.out.println("IOException");
        }
    }
    
    @RequestMapping("/fileDownload")
    private void fileDown(HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("UTF-8");
        String filename = request.getParameter("fm");
        String fileoriname = request.getParameter("fom");
        
        //파일 업로드된 경로 
        try{
            String fileUrl = path;
            fileUrl += "/";
            String savePath = fileUrl;
            String fileName = filename;
            
            //실제 내보낼 파일명 
            String oriFileName = fileoriname;
            InputStream in = null;
            OutputStream os = null;
            File file = null;
            boolean skip = false;
            String client = "";
            
            //파일을 읽어 스트림에 담기  
            try{
                file = new File(savePath, fileName);
                in = new FileInputStream(file);
            } catch (FileNotFoundException fe) {
                skip = true;
            }
            
            client = request.getHeader("User-Agent");
            
            //파일 다운로드 헤더 지정 
            response.reset();
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Description", "JSP Generated Data");
            
            if (!skip) {
                // IE
                if (client.indexOf("MSIE") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                    // IE 11 이상.
                } else if (client.indexOf("Trident") != -1) {
                    response.setHeader("Content-Disposition", "attachment; filename=\""
                            + java.net.URLEncoder.encode(oriFileName, "UTF-8").replaceAll("\\+", "\\ ") + "\"");
                } else {
                    // 한글 파일명 처리
                    response.setHeader("Content-Disposition",
                            "attachment; filename=\"" + new String(oriFileName.getBytes("UTF-8"), "ISO8859_1") + "\"");
                    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
                }
                response.setHeader("Content-Length", "" + file.length());
                os = response.getOutputStream();
                byte b[] = new byte[(int) file.length()];
                int leng = 0;
                while ((leng = in.read(b)) > 0) {
                    os.write(b, 0, leng);
                }
            } else {
                response.setContentType("text/html;charset=UTF-8");
                System.out.println("<script>alert('파일을 찾을 수 없습니다');</script>");
            }
            in.close();
            os.close();
        } catch (Exception e) {
            System.out.println("ERROR : " + e.getMessage());
        }
        
    }

}

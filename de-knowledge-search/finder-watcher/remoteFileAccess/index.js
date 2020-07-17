const render = require('koa-ejs');
const Koa = require('koa');
const app = new Koa();
const Router = require('koa-router');
const router = new Router();
const http = require('http');
const fs = require('fs');
const path = require('path');
const extname = path.extname;
const url = require('url');
const EJS = require('ejs');
const program = require('commander');
const zipper = require('adm-zip');
const views = require("koa-views");
const iconvLite = require('iconv-lite');
let rootFolder;
const publicFolder = path.resolve(__dirname, 'public');
const mimeTypes = {
  '.js': 'text/javascript',
  '.html': 'text/html',
  '.css': 'text/css'
}
 


function processSize(size, unit) {
  const units = {
    B: 'KB',
    KB: 'MB',
    MB: 'GB'
  }
  if (size >= 1024 && unit !== 'GB') {
    return processSize(size/1024, units[unit]);
  }

  return size.toFixed(2) + ' ' + unit;
}

function getFileSize(file, callback) {
  fs.stat(file, (err, stats) => {
    if (err) {
       callback(null);
    }
    const fileSize = processSize(stats.size, 'B');
    callback(fileSize);
  });
}

function serveStatic(file, req, res) {
console.log( "p------" + publicFolder +"==="+ file);
  fs.exists(publicFolder + file, exists => {
    if (!exists) {
      res.writeHead(404);
      return res.end(
        file + ' Not Found'
      );
    } else {
      fs.readFile(publicFolder + file, 'utf-8', (err, staticFile) => {
        if (err) {
          res.writeHead(500);
          return res.end('Error reading File')
        } else {
          res.writeHead(
            200,
            {
              'Content-type': mimeTypes[path.extname(file)] || ''
            }
          );
          return res.end(staticFile);
        }
      });
    }
  });
}

function serveFile(fileName, req, res, download) {
  const blacklistExtensions = ['.avi', '.mp4', '.mov', '.flv', '.mpg', '.3gp', '.asf', '.*'];
  fs.exists(fileName, exists => {
    if (!exists) {
      res.writeHead(404);
      return res.end('File Not Found or has been moved');
    } else {
      if (download === '1' || path.extname(fileName) in blacklistExtensions) {
        let attachment = fileName.split('/').pop();
        ext = attachment.split('.').pop();
        file = attachment.split('.');
        file.pop();
        file = file.join('.');
        file = file.replace(/\W+/g, '_');
        res.writeHead(200, { 'Content-disposition': 'attachment; filename=' + file + '.' + ext });
        return fs.createReadStream(fileName).pipe(res);
      } else {
        fs.readFile(fileName, (err, file) => {
          if (err) {
            res.writeHead(500);
            return res.end('Error while reading File: ' + fileName);
          } else {
            res.writeHead(200);
            return res.end(file);
          }
        });
      }
    }
  });
}

function serveDir(dirName, req, res, download) {
	let folderName = dirName;
	let files = [];
	folderName.forEach(aa =>{

	let pathName = path.normalize(aa);
  let baseName = pathName;
  console.log('Path Name Requested: ', pathName, 'Base Name: ', baseName);
  fs.exists(pathName, exists => {
    if (!exists) {
      res.writeHead(404);
      return res.end(
        'The path you requested does not exist or has been moved'
      );
    } else {
      if (download === '1') {
        let zip = new zipper();
        zip.addLocalFolder(pathName);
        zip.writeZip(pathName.split('/').pop() + '.zip');
        res.writeHead(200, { 'Content-disposition': 'attachment; filename=' + pathName.split('/').pop() + '.zip' });
        fs.createReadStream(pathName.split('/').pop() + '.zip').pipe(res);
        fs.unlink(pathName.split('/').pop() + '.zip');
        return;
      } else {
        fs.readdir(pathName, (err, data) => {
          if (err) {
            res.writeHead(500);
            return res.end('An error occured while trying to read DIR');
          } else {
           // let files = [];
            data.forEach(datum => {
              if (fs.lstatSync(pathName + '/' + datum).isDirectory()) {
                files.push(
                  {
                    type: 'dir',
                    path:  baseName + '/' + datum,
                    name: datum
                  }
                );
              } else {
                  files.push(
                    {
                      type: 'file',
                      path: baseName + '/' + datum,
                      name: datum,
                      size: 0 // fileSize || "Can't get Size"
                    }
                  );
              }
            });
          }
        });
				console.log("====> "+ path.join(publicFolder, '/index.ejs'));
      }
    }
  });
  
	});
}

let baseName = "";
function getDirectories(path, callback) {
	fs.readdir(pathName, (err, data) => {
   if (err) {
     res.writeHead(500);
     return res.end('An error occured while trying to read DIR');
   } else {
     data.forEach(datum => {
       console.log("datum====== "+ datum);
       if (fs.lstatSync(pathName + '/' + datum).isDirectory()) {
         files.push(
           {
             type: 'dir',path:  baseName + '/' + datum, name: datum
           }
         );
       } else {
           files.push(
             {
               type: 'file',path: baseName + '/' + datum,name: datum, size: 0 // fileSize || "Can't get Size"
             }
           );
       }
     });
   }
	 callback(null, files);
  });
}

function stat(file) {
  return new Promise(function(resolve, reject) {
    fs.stat(file, function(err, stat) {
      if (err) {
        reject(err);
      } else {
        resolve(stat);
      }
    });
  });
}


router.all('/bbb', async (ctx, next) => {

let ctxQuery = ctx.request.query;
	console.log("c====================+"+ ctx.request);
	console.log("c====================+"+ ctx.request.query.file);
//let ctxQuery = decodeURI(ctx.request.query);

var searchPathAry = new Array();
var osType = require('os');
var fileDir = osType.homedir() + '/.config/hamonikr_finder/pr_finder_config';
var tmpStr = fs.readFileSync(fileDir, 'utf8');
var arrPath = tmpStr.split('\n');

for(var i=0; i<arrPath.length-1; i++){
	searchPathAry[i] = arrPath[i];
}
dirName = searchPathAry;

//dirName = ["/home/ivsryans/aaa (또 다른 사본)","/home/ivsryans/aaa (사본)"];
console.log("dirname length === "+ dirName);
let folderName = dirName;

	if( ctxQuery.dir){
		console.log("dir");
	}else if( ctxQuery.file){
	console.log("file");
	console.log("hre===============");
	console.log("hre=2==============" + ctxQuery.file);
	var fileName = ctxQuery.file;
	let attachment = fileName.split('/').pop();
	console.log("atta=-===+"+ attachment);
        ext = attachment.split('.').pop();
	console.log("ex===="+ ext);
        file = attachment.split('.');
	console.log("fil=-==="+ file);
        file.pop();
        file = file.join('.');
        file = file.replace(/\W+/g, '_');

			 const fpath = fileName;
  const fstat = await stat(fpath);
  if (fstat.isFile()) {
    ctx.type = extname(fpath);
    const src = fs.createReadStream(fpath);
//	  res.setHeader('Content-disposition', 'attachment; filename=' + getDownloadFilename(req, filename));

		ctx.response.set('Content-disposition', 'attachment; filename=' + getDownloadFilename(ctx.request, attachment));
		ctx.body = src;
  }


	}else{
		try {
			var fileslist = [];
			var fileslistA = "";
			var filesAry = new Array();
			dirName.forEach( (dirnm) => {
				fileslistA += fs.readdirSync(dirnm);
				var splitFileslistA = fileslistA.split(',');
				splitFileslistA.forEach( (datum) => {
          let pathName = path.normalize(dirnm);

            console.log("aa===="+ pathName +"==/=="+datum);
            if (fs.lstatSync(pathName + '/' + datum).isDirectory()) {
              files.push(
                {
                  type: 'dir',path:  pathName + '/' + datum, name: datum
                }
              );
            } else {
                files.push(
                  {
                    type: 'file',path: pathName + '/' + datum,name: datum, size: 0 // fileSize || "Can't get Size"
                  }
                );
            }

      });
			fileslistA = "";
			});
		} catch(err) {
		  console.error(err);
		}
		await ctx.render('index', { files: files });
	}
});

var tmpVal = "";
let files = [];

function getDownloadFilename(req, filename) {
    var header = req.headers['user-agent'];

    if (header.includes("MSIE") || header.includes("Trident")) {
        return encodeURIComponent(filename).replace(/\\+/gi, "%20");
    } else if (header.includes("Chrome")) {
        return iconvLite.decode(iconvLite.encode(filename, "UTF-8"), 'ISO-8859-1');
    } else if (header.includes("Opera")) {
        return iconvLite.decode(iconvLite.encode(filename, "UTF-8"), 'ISO-8859-1');
    } else if (header.includes("Firefox")) {
        return iconvLite.decode(iconvLite.encode(filename, "UTF-8"), 'ISO-8859-1');
    }

    return filename;
}

function setFolder(req, res){
rootFolder = ["/home/rnd/bbb","/home/rnd/aaa"];
	let query = url.parse(decodeURI(req.url), true).query;
  if (query.dir) {
    serveDir(
      rootFolder + '/' + query.dir.replace(/\.\./g, ''),
      req,
      res,
      query.download
    );
  } else if (query.file) {
    serveFile(
      query.file.replace(/\.\./g, ''),
      req,
      res,
      query.download
    );
  } else {
    let lookup = url.parse(decodeURI(req.url)).pathname;
    lookup = path.normalize(lookup);
    //lookup === '/' ? serveDir(rootFolder, req, res) : serveStatic(lookup, req, res);
		var abc = serveDir(rootFolder, req, res);
		console.log("abc==="+ abc);
  }
}

module.exports = router;

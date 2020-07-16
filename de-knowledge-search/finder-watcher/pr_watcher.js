const sqlite3 = require('sqlite3').verbose();
const fs = require('fs');
const chokidar = require('chokidar');
const request = require('request');
const Router = require('koa-router');
const watcher = new Router();
const rp = require('request-promise');
const axios = require('axios');
const FormData = require('form-data');
const concat = require("concat-stream");


var extend          = require('node.extend'),
	globule         = require('globule'),
	path            = require('path'),
  EventEmitter    = require('events').EventEmitter;
  

const delay = require('delay');
const sleep = delay => new Promise(resolve => { setTimeout(resolve, delay) }, delay)
const moment = require("moment");

var https = require('https');
var http = require('http');

https.globalAgent.maxSockets = 50000;
http.globalAgent.maxSockets = 50000;
let chkLimitCnt = 0;
var searchPathAry = new Array();



let startTime;
let endTime;
let second = 1000 * 60;
let fmt1 = 'YYYY.MM.DD HH:mm:ss.SSSSSSS';
let  nowMoment = moment(new Date()).format(fmt1); //Date 객체를 파라미터로 넣기

function fileIndexingDel(){
	var osType = require('os');
  var fileDir  = osType.homedir() + '/.config/hamonikr_finder/public_indexingFile';
	 if (fs.existsSync(fileDir)) {
		fs.unlinkSync(fileDir);
	}
  startTime = nowMoment;
}


 searchPathAry = new Array();
function getSearchPath(){

	var osType = require('os');
	var fileDir = osType.homedir() + '/.config/hamonikr_finder/pr_finder_config';
  var tmpStr = fs.readFileSync(fileDir, 'utf8');
  var arrPath = tmpStr.split('\n');

  for(var i=0; i<arrPath.length-1; i++){
    searchPathAry[i] = arrPath[i];
  }
}


const ES_UPLOAD_PATH = 'http://192.168.0.55:8081/_upload'
const DB_FILE = './db/pr_files.db';
//const FILE_FOLDER = '/home/rnd/test-file';
const FILE_FOLDER = searchPathAry;
const FileSharing = "PR";
const initializeDB = () => {

  //const dropQuery = `DROP TABLE IF EXISTS filelist`;
  
	return new Promise((resolve, reject) => {
					const insertQuery = `CREATE TABLE IF NOT EXISTS filelist(
																file_id INTEGER PRIMARY KEY AUTOINCREMENT,
																local_path VARCHAR(100),
																url VARCHAR(20))`;
						
					const db = new sqlite3.Database(DB_FILE, sqlite3.OPEN_CREATE | sqlite3.OPEN_READWRITE, (err) => {
						if (err) {
							return console.error(err.message);
						}
						
						db.serialize(() => {
							// db.each(dropQuery);
							db.run(insertQuery);
						})
						
						db.close((err) => {
							if (err) {
								return reject(console.error(err.message));
							}

							console.log('init db close');
							return resolve('done');
						});
					});
	});
}

const main = async (argUserUuid, argGroupIndex, argUserNm) => {

	const userIndexUUID = argGroupIndex;
	const userNm = argUserNm;
	const userUuid = argUserUuid;


	const res = fs.existsSync(DB_FILE);
	if (res == false) {
		console.log("initializeDB");
  	await initializeDB();
	}
	console.log("initializeDB next");


  const db = new sqlite3.Database(DB_FILE, sqlite3.OPEN_READWRITE);

  process.on('exit', function () {
    db.close((err) => {
      if (err) {
        return console.error(err.message);
      }
      console.log('Close the database connection.');
    });
    console.log('Goodbye!');
  });
  
  
  var batchFiles  = [];
  var batchFilesIndexing  = [];
  var batchTimer  = null;

  const watcher = chokidar.watch(FILE_FOLDER, {
    ignored: /(^|[\/\\])\../, // ignore dotfiles
    persistent: true,
    ignoreInitial: false,
    followSymlinks: true,
    //cwd: '.',
    disableGlobbing: false,

    usePolling: false,
    interval: 100,
    binaryInterval: 300,
    alwaysStat: false,
    depth: 99,
    awaitWriteFinish: {
      stabilityThreshold: 10000,
      pollInterval: 1000
    },

    ignorePermissionErrors: false,
    atomic: true
  });

  const log = console.log.bind(console);
  // watcher.on('add', path => log(`File ${path} has been added`));

  async function doRequest(formData) {
    return new Promise(function (resolve, reject) {
      
      request.post({url: ES_UPLOAD_PATH, formData: formData}, async (err, response, body) => {
          if (!err && response.statusCode == 200) {
            const result = JSON.parse(body);
            if (result.ok == false) {
              return console.log('upload failed');
            }
            resolve(body);
          } else {
           return  reject(err);
          }
      });
    });
  }

  async function processArray(array) {

    // array.forEach(async (item, itemcnt) => {
    for( const item of array ){
      const formData = {
        index: userIndexUUID,
        file: fs.createReadStream(item), //fs.readFileSync(path, 'utf8'), 
        tags: "{\"external\":{\"description\":\""+item +" \", \"FileSharing\":\""+FileSharing+"\", \"owner_uuid\":\""+userUuid+"\", \"owner_nm\":\""+userNm+"\"}}" //fs.createReadStream("tagtest" + runningCnt +".txt")
      };
      const options = "";

      let response = await promisifiedRequest(formData, options);
      
      console.log(  "===========userIndexUUID========>"+userIndexUUID);
      console.log(  "===========00========>"+item);
      console.log( "===========11========>"+JSON.stringify(response.headers));
      console.log( "==========22=========>"+JSON.stringify(response));
      console.log( "==========22=========>"+response.body);

      const result = JSON.parse(response.body);
      if (result.ok == false) {
        return console.log('upload failed');
        // return reject(err);
      }
      // console.log('업로드 한 파일의 hash 값을 local DB 에 저장한다.');
      const addQuery = `insert into filelist(local_path, url) values ('${item}', '${result.url}')`;
      const resAddQuery = await asyncQuery(addQuery);
      
      // const selectQuery = `SELECT * FROM filelist WHERE local_path = '${item}'`;
      // const found = await asyncQuery(selectQuery);

    }
  }

  const promisifiedRequest = function(formData, options) {
    return new Promise((resolve,reject) => {
      request.post({url: ES_UPLOAD_PATH, formData: formData, gzip:true}, async (error, response, body) => {
        if (response) {
          return resolve(response);
        }
        if (error) {
          return reject(error);
        }
      });
    });
  };


  function watcherBatch() {
    watcherChange('change', batchFiles);
    batchFiles = [];
    batchFilesIndexing = [];
  }

  function watcherChange(event, path) {
    processArray(path);

    var osType = require('os');
    var fileDir  = osType.homedir() + '/.config/hamonikr_finder/public_indexingFile';			
    var nowMoment = moment(new Date()).format(fmt1); 
    var fileArg = "";

    // endTime = nowMoment;
    batchFilesIndexing.forEach(async (item, itemcnt) => {
      console.log("item-------------" + item +"==========="+ batchFiles[itemcnt]);
      fileArg += "시간 : [" + item +"], 파일수 :" + (itemcnt+1) +",   file name is : "+ batchFiles[itemcnt] +"\n";
      
      console.log("batchFilesIndexing.length==" + batchFilesIndexing.length +"=========+"+ (itemcnt+1));
      if( batchFilesIndexing.length == (itemcnt+1) ){
        var lastVal = "start time : " + batchFilesIndexing[0] +"\nlast time : " + batchFilesIndexing[batchFilesIndexing.length-1];

        fs.appendFile(fileDir, fileArg + lastVal, (err) => {
          if(err) { console.log("err====" + err);}
        });
      }  

    });

	}

  const asyncQuery = (query) => {
    return new Promise((resolve, reject) => {
      // console.log(`${query}`);
      db.all(query, [], (err, rows) => {
        if (err) {
          return reject(err);
        }
        (rows.length > 0) ? resolve(true) : resolve(false);
      });
    });
  };

  const asyncQueryVal = (query) => {
    return new Promise((resolve, reject) => {
      db.all(query, [], (err, rows) => {
        if (err) {return reject(err);}
        var retVal = "";
        rows.forEach((row) => {retVal = row.url;});
        (rows.length > 0) ? resolve(retVal) : resolve(false);
      });
    });
  };


  watcher.on('ready', function() {
    console.log('Newly watched paths:', watcher.getWatched());
  });

  watcher.on('add', async path => {

    var nowMoment = moment(new Date()).format(fmt1); //Date 객체를 파라미터로 넣기

    batchFiles.push(path);
    batchFilesIndexing.push(nowMoment);
    clearTimeout(batchTimer);
    batchTimer = setTimeout(watcherBatch);


  });

  watcher.on('addDir', function(path) {})
  
  watcher.on('change', async function(path, stats) {
    console.log('파일이 변경된 경우' + path);
    console.log('파일이 변경된 경우' + JSON.stringify(stats));

    const query = `SELECT * FROM filelist WHERE local_path = '${path}'`;
    const found = await asyncQuery(query);

    if (found == false) {
      return console.log(`Local DB 에서 파일을 찾을 수 없음.`);
    }
    
    // console.log(`여기서 ES 서버에 파일을 다시 업로드 할 것... ${path}`);
    request.post({url: ES_UPLOAD_PATH, formData: {file: fs.createReadStream(path)}}, async (err, response, body) => {
        if (err) {
          return console.error('upload failed:', err);
        }
        const result = JSON.parse(body);
        if (result.ok == false) {
          return console.log('upload failed');
        }
      });
  })

  watcher.on('unlink', async function(path) {

    const selectQuery = `SELECT * FROM filelist WHERE local_path = '${path}'`;
    const valquery = await asyncQueryVal(selectQuery);
    console.log("found add query=============" + valquery);

    // console.log('파일을 삭제하는 경우')
    const delQuery = `DELETE FROM filelist WHERE local_path = '${path}'`;
    const res = await asyncQuery(delQuery);
    console.log(`여기서 ES 서버 데이터 삭제할 것 ... ${path}`);

     //console.log(`여기서 ES 서버에 파일을 다시 업로드 할 것... ${path}`);
    
     /*
     es delete documnet 수정...작동 오류
    const options = {
      url: 'http://localhost:3001/api/esdelete/'+userIndexUUID+"/2223.txt",
      method: 'POST',
      gzip: true,
    };
    console.log("options.url" + options.url);
    request.post(options, async (err, response, body) => {
      if (err) {
        return console.error('upload failed:', err);
      }
      console.log("del es documnet ---" + response.body);
      // const result = JSON.parse(body);
      // if (result.ok == false) {
      //   return console.log('upload failed');
      // }
    });
    */
  
  })
  watcher.on('unlinkDir', function(path) {})
  watcher.on('error', function(error) {})

};


module.exports = {
	start: function(userUuid, groupIndex, userNm){
    fileIndexingDel();
    getSearchPath();
 	  main(userUuid, groupIndex, userNm);
	}
};

const electron = require('electron');
const {Tray, Menu} = require('electron');
const {shell} = require('electron');
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const windowStateKeeper = require('electron-window-state');
const { globalShortcut } = require("electron");
const fs = require('fs');
const path = require('path');
const mkdirp = require('mkdirp');
const { promisify } = require('util');
const readFileAsync = promisify(fs.readdir);
const mkDirpAsync = promisify(mkdirp);
const url = require('url');
const request = require('request');
const CHILD_PADDING = 100;
// const notifier = require("node-notifier");
const Notification = require('electron-native-notification');
const open = require('open');

let mainWindow, settingWindow;

function createWindow () {

	let mainWindowState = windowStateKeeper({
		defaultWidth: 500,
		defaultHeight: 80
	});

	mainWindow = new BrowserWindow({
		skipTaskbar: false,
	//	resizable: false,
		'x': mainWindowState.x,
		'y': mainWindowState.y,
		'width': 500, 
		'height': 80,
		//'height': mainWindowState.height,
		 frame:false,
		 alwaysOnTop: true,
//		 resizable: false,
		  transparent: true
		//  titleBarStyle: 'hidden'
		// titleBarStyle: 'hiddenInset' 
	});

  	mainWindowState.manage(mainWindow);

  	mainWindow.loadURL('file://' + __dirname + '/app/settings.html');
  	//mainWindow.loadURL('file://' + __dirname + '/app/index.html');

  	mainWindow.setMenu(null);
		mainWindow.setMenuBarVisibility(false);	
  // Open the DevTools.
  	mainWindow.webContents.openDevTools(); 

		mainWindow.on('closed', function () {
		mainWindowState.saveState(mainWindow);
		mainWindow = null;

	});

}



const toggleWindow = () => {
    mainWindow.isVisible() ? mainWindow.hide() : showWindow();
}
const showWindow = () => {
    const position = getWindowPosition();
    mainWindow.setPosition(position.x, position.y, false);
    mainWindow.show();
}
const getWindowPosition = () => {
    const windowBounds = mainWindow.getBounds();
    const trayBounds = trayIcon.getBounds();
    
    // Center window horizontally below the tray icon
    const x = Math.round(trayBounds.x + (trayBounds.width / 2) - (windowBounds.width / 2))
    // Position window 4 pixels vertically below the tray icon
    const y = Math.round(trayBounds.y + trayBounds.height + 4)
    return {x: x, y: y}
}
const createTray = () => {
	trayIcon  = new Tray(__dirname + '/build/icons/48.png');
	//tray.setTitle('hello world');
	const trayMenuTemplate = [
		{
		   label: 'Hamonikr-finder',
		   //enabled: false
			click: function (){
				toggleWindow();
		   }
		},
		// {
		//    label: 'Settings',
		//    click: function () {
		// 	  console.log("Clicked on settings");
		// 	  settingWindow.show();
		// 	  console.log("Clicked on settings222");
		//    }
		// },
		// {
		//    label: 'Help',
		//    click: function () {
		// 	  console.log("Clicked on Help")
		//    }
		// },
		{ label: 'Quit', click: () => { app.quit(); } }
	 ]
	 
	 let trayMenu = Menu.buildFromTemplate(trayMenuTemplate)
	 trayIcon.setContextMenu(trayMenu)
}
let trayIcon  = null;

function notiAction(){
	const opt = {
		title: 'Hamonikr-Office-Toolchain  Alert',
		body: 'Hamonikr-Office-Toolchain사용자로부터 \n화상통화 연결 요청이 왔습니다.!!! ',
		icon: path.join(__dirname, "/build/icons/48.png"),
		sound:true,
		wait: true
	};
	const notification = new Notification(opt.title, opt);
	notification.on('show', () => {
		console.log('notification show');
	});
	notification.onclick = () => {
		console.log('notification click');
		// var Request = unirest.get('http://mockbin.com/request');
		open('https://hamonia.kr/1234', {app: 'firefox'});
	};
	notification.addEventListener('close', () => {
		console.log('notification close');
	});
	notification.addListener('error', (err) => {
		console.error(err);
	});
	setTimeout(() => notification.close(), 10000);
}

var http = require('http');
var port = "8081";

// var server = http.createServer();
// server.addListener('request', function (req, res) {  
// 	console.log('requested...');
// 	res.writeHead(200);
// 	res.end();
// 	notiAction();
// });
// server.addListener('connection', function(socket){  
//     console.log('connected...');
// });
// server.listen({ port: port }, () => {
// console.log('####################################################');
// console.log(`\n IP Address: ${require('ip').address()}:${port}\n`);
// console.log('####################################################');
// });

http.createServer((req, res) => {
	let query = url.parse(decodeURI(req.url), true).query;
	let lookup = url.parse(decodeURI(req.url)).pathname;
	lookup = path.normalize(lookup);
	console.log("lookup==="+ lookup);

	if (lookup == '/notify') {
	  	console.log('requested...notify');
		res.writeHead(200);
		res.end();
		notiAction();
	} else {
		console.log('requested...');
		res.writeHead(200);
		res.end();
	}
  }).listen({ port: port }, () => {
	console.log('####################################################');
	console.log(` IP Address: ${require('ip').address()}:${port}\n`);
	console.log('####################################################');
  });
  

app.on('ready', () => {

	createTray();
	setTimeout(createWindow, 500)
	
	globalShortcut.register('f5', function() {
		console.log('f5 is pressed')
		mainWindow.reload();
		mainWindow.setSize(570,80);
	})

	
});



app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') {
	   mainWindow.setSize(500,80);
	 //  mainWindow.hide();
    app.quit();
  }
});

app.on('activate', function () {
	console.log("activate==="+ mainWindow);
  if (mainWindow === null) {
    createWindow();
  }
});



const {ipcMain} = require('electron')
ipcMain.on('openUserUUID', (event, path) => {

	var osType = require('os');
    var dirpath = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
	var userUuidStr = "";
	try{
		var retVal = fs.existsSync(dirpath);
		console.log("FnChk_settingsFile====="+ retVal);
		if( retVal ){
			userUuidStr = fs.readFileSync(dirpath, 'utf8');
		}
	}catch(e){
		if(e.code == 'ENOENT'){
			console.log("//==mkdir directory");
			userUuidStr = "none";
		}
	}
 	event.sender.send('userUUidData', userUuidStr);
});


ipcMain.on('resize-me-please', (event, arg) => {
	console.log("==========================++>"+ arg);
	if(arg == "initLayer"){
		mainWindow.setResizable(true);
		mainWindow.setSize(550,80);
		console.log("init layer size 550:80");
	}else if( arg == "viewLayer"){
		  mainWindow.setSize(570, 580);
		  console.log("viewLayer size : 570:580");
		 // esRequest();
	}else{
		createWindow();
		mainWindow.setSize(550,80);
	}		
})


ipcMain.on('openFileDir', (event, path) => {
  console.log("main.js=-====" + path);
 shell.showItemInFolder(path);
//   shell.openItem(path);

});


ipcMain.on('openConfigFile', (event, path) => { 
	var osType = require('os');
  	var filepath  = osType.homedir() + '/.config/hamonikr_finder/finder_config';

	fs.readFile(filepath, 'utf-8', (err, data) => { 
		if(err){ 
			console.log("An error ocurred reading the file :" + err.message);
			return 
		}else{
			var settingData_arr = data.split('\n');
			event.sender.send('settingData_arr', data);
		}
	});
});


ipcMain.on('prOpenConfigFile', (event, path) => { 
	var osType = require('os');
  	var filepath  = osType.homedir() + '/.config/hamonikr_finder/pr_finder_config';

	fs.readFile(filepath, 'utf-8', (err, data) => { 
		if(err){ 
			console.log("An error ocurred reading the file :" + err.message);
			return 
		}else{
			var settingData_arr = data.split('\n');
			event.sender.send('prSettingData_arr', data);
		}
	});
});


const osType = require('os');
const dir  = osType.homedir() + '/.config/hamonikr_finder'

//##################################################################
//로그인 성공 후 고유값 생성 (자동로그인을 위해)
ipcMain.on('saveUserInfo', (event, usernm, userpw) => {
	console.log("dddddddddddddddddddd");
	userInfoFileAsync(dir, usernm);
})

const userInfoFileAsync = async(dir, usernm) => {
	var chkFile = FnChk_settingsFile();
	console.log("chkFile==="+ chkFile);


	// if( chkFile == false ){
		var makeDirpAsync = await mkDirpAsync(dir);
		var userUUIDVal = await userInfoWriteFile();
	
		console.log("userUUIDVal==="+userUUIDVal);

		var headersOpt = {
			"content-type": "application/json",
		};
		console.log("aa==="+ usernm+"==="+ userUUIDVal);
		request({
			method:'POST',
			url:'http://127.0.0.1:8080/api/userUUID?${_csrf.parameterName}=${_csrf.token}',
			form: {'uuiduser':  userUUIDVal, 'userid' : usernm},
			
			headers: headersOpt,
			json: true,
			}, async function (error, response, body) {
				console.log("client ready --------------err==="+ error);
				if(!error){
					console.log("client ready --------------ret body==="+ body);
				}else{
					console.log("client ready --------------err="+ error);
				}
			}
		);

	// }
}


function userInfoWriteFile(){
	return new Promise(function(resolve, reject){
	  var uniqid = require('uniqid');
	  var osType = require('os');
	  var fileDir  = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
	  var arg = uniqid()+(new Date()).getTime().toString(36);
  
	  // if (!fs.existsSync(fileDir)) {
	  fs.unlink(fileDir, (err) => err ?  console.log(err) : console.log(`${fileDir} 를 정상적으로 삭제했습니다!!!`));
	  fs.writeFile(fileDir, arg, (err) => {
		  if(err){
			reject("error");
			console.log("//== save-dir-path() error  "+ err.message);
		  }
		   resolve(arg);
		});
	  // }else{
	  // 	console.log("bbbbbbbbb");
	  //    resolve(arg);
	  // }
	});
  }

  
  
//################			END			##################################################

ipcMain.on('save-dir-path', (event, arg, fileIndexingGubun, gubun, gruopNm, userNm) => {
	// 설정 폴더 생성.
	makeRecursiveFileAsync(dir, arg, gubun, gruopNm, userNm);

//	색인 파일 초기화시 작업....
	if( fileIndexingGubun == false){
		console.log("aa==");
	}else{
		console.log("bb==");

	}

})
//const cleanRecursiveFileAsync = async(dir, arg, gubun) => {
//	var makeWatchFile = await create_settingFile(arg);
//}

const initFileAsync = async(dir) => {
	console.log("-------app init----------");
	// 사용자 고유아이디 여부 체크
	var chkFile = FnChk_settingsFile();
	console.log("chkFile==="+ chkFile);
	if( chkFile == false ){
		var makeDirpAsync = await mkDirpAsync(dir);
		var makeFileTmp = await userInfoWriteFile();
	}
}

const makeRecursiveFileAsync = async(dir, arg, gubun, groupNm, userNm) => {
   try{
			// 폴더 및 파일 유무 체크
			var chkFile = FnChk_settingsFile();
			console.log("chkFile==="+ chkFile);
			if( chkFile == false ){
				var makeDirpAsync = await mkDirpAsync(dir);
				var makeFileTmp = await userInfoWriteFile();
			}


			//파일의 uuid가 존제 여부
			var chkUuidInFile = await readUuidFile();

   }
   catch(err){
	 	console.log("error");
       return Object.assign(err);
   }
}


function uuid_db_chk(arg){
	return new Promise((resolve, reject) => {
		const formData = {
	    userUuid:  arg
	  };
	  request.post({url: "http://127.0.0.1:3001/userinfo", formData: formData}, async (err, response, body) => {
	    if (err) return reject(err);
	    const result = body; // JSON.parse(body);
			resolve("true");
		});
	});
}

function readUuidFile(){
return new Promise(function(resolve, reject){
  var osType = require('os');
  var dirpath = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
		fs.readFile(dirpath, (err, data) => {
      if (err)  { reject("false")}
      else {
				var os = require("os");
				var text = data.toString().split(os.EOL);
        resolve(text[0]);
      }
    });
	});
}


function FnChk_settingsFile(){
	var osType = require('os');
  var dirpath = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';

  try{
   // var retVal =  fs.lstatSync(dirpath).isDirectory();
	 var retVal = fs.existsSync(dirpath);
		console.log("FnChk_settingsFile====="+ retVal);
		return retVal;
  }catch(e){
     // Handle error
     if(e.code == 'ENOENT'){
       console.log("//==mkdir directory");
			 return "false";
     }
  }
}


function getToken(result){
	return new Promise((resolve,reject) => {
	console.log("getTokent------ "+ result);
		var unirest = require('unirest');
		unirest.post('http://127.0.0.1:3001/userinfo')
			.headers('Accept', 'application/json')
			.send({ "userUuid": result })
			.end(function (response) {
				if(response.error){return reject(error)}
				//return resolve(response.body.ops[0].user_uuid);
				console.log("gettoken rest ===== "+ JSON.stringify(response.body));
				return resolve(response.body);
			});
		})
}


function chkUuid(){
	return new Promise(function(resolve, reject){
	  var osType = require('os');
	  var fileDir  = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
	  let returnVal = "";
	  
	 // var data = fs.readFileSync(fileDir, 'utf8');a
		fs.readFile(fileDir, (err, data) => {
		  if (err)  { reject("false")}
			else { 
				resolve("true");
			  console.log(data);
			}
		});
	});
}

//  es index create 
function esIndexExists(arg){
  return new Promise(function(resolve, reject){
		console.log("esindexcreate============================");
    var headersOpt = { 
      "content-type": "application/json",
    };
    request({
        method:'post',
        url:'http://127.0.0.1:3001/api/indexExists',
        form: {'userUuid':  arg},
        headers: headersOpt,
        json: true,
      }, async function (error, response, body) {
          console.log("esIndex====" +body);
					if(!error){
						resolve("true");
					}else{
						reject("false");
					}
					
      }
    );
  });
}


//  watcher dir info 
function watcherCall(arg, gubun, groupNm, userNm){
  return new Promise(function(resolve, reject){
		var headersOpt = {  
  	  "content-type": "application/json",
		};
		request({
  	  	method:'post',
  	    url:'http://127.0.0.1:3001/watcher',
  	    form: {'userUuid':  arg, 'gubun': gubun, "groupIndexNm": groupNm, "userNm": userNm}, 
  	    headers: headersOpt,
  	    json: true,
  	  }, function (error, response, body) {  
  	      console.log(body);  
					if(!error){
            resolve("true");
          }else{
            reject("false");
          }

			}
		); 
  });
}


//	watcher dir info 
function create_settingFile(arg, gubun){
  return new Promise(function(resolve, reject){
		var fileName = "";
		if( gubun == "PR"){
			fileName = "pr_finder_config";
		}else{
			fileName = "finder_config";
		}
    var osType = require('os');
    var fileDir  = osType.homedir() + '/.config/hamonikr_finder/' + fileName;
    //var fileDir  = osType.homedir() + '/.config/hamonikr_finder/finder_config';

console.log("arg================="+ arg);

//    if (!fs.existsSync(fileDir)) {
      fs.writeFile(fileDir, arg, (err) => {
        if(err){
          reject("error");
          console.log("//== save-dir-path() error  "+ err.message);
        }
         resolve(arg);
      });
//    }else{
//       resolve(arg);
//    }
  });
}

ipcMain.on('initApp', (event, path) => { 
	console.log("bbbbbbbbb");
	var osType = require('os');
	var dirpath = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
	var userUuidStr = "";
	try{
		var retVal = fs.existsSync(dirpath);
		if( retVal ){
			userUuidStr = fs.readFileSync(dirpath, 'utf8');
			console.log("userUuidStr=========" + userUuidStr);

			var headersOpt = {
				"content-type": "application/json",
			};
			request({
				method:'post',
				url:'http://127.0.0.1:8080/api/getUserCheck',
				form: {'uuiduser':  userUuidStr},
				headers: headersOpt,
				json: true,
				}, async function (error, response, body) {
					console.log("getUserCheck --------------err==="+ error);
					if(!error){
						console.log("getUserCheck--------------ret body==="+ JSON.stringify(body));
						if( body.output == "Y" ){
							event.sender.send('initAppProc', body);
						}
					}else{
						console.log("getUserCheck --------------err="+ error);
					}
				}
			);
		}
		//else{
			// initFileAsync(dir);
		// }
	}catch(e){
		if(e.code == 'ENOENT'){
			console.log("//==mkdir directory");
			userUuidStr = "none";
		}
	}
});


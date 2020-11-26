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
const Notification = require('electron-native-notification');
const open = require('open');
const {ipcMain} = require('electron')
const uniqid = require('uniqid');
const osType = require('os');
const dir  = osType.homedir() + '/.config/hamonikr_finder'

// let dirpath = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';
let  fileDir  = osType.homedir() + '/.config/hamonikr_finder/userinfo_config';


let mainWindow, settingWindow;

function createWindow () {

	let mainWindowState = windowStateKeeper({
		defaultWidth: 520,
		defaultHeight: 70
	});

	mainWindow = new BrowserWindow({
		skipTaskbar: false,
	//	resizable: false,
		'x': mainWindowState.x,
		'y': mainWindowState.y,
		'width': 527, 
		'height': 340,
		//'height': mainWindowState.height,
		 frame:false,
		 alwaysOnTop: true,
//		 resizable: false,
		  transparent: true
		//  titleBarStyle: 'hidden'
		// ,titleBarStyle: 'hiddenInset' 
	});

  	mainWindowState.manage(mainWindow);

  	mainWindow.loadURL('file://' + __dirname + '/app/settings.html');

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

app.on('ready', () => {
	createTray();
	setTimeout(createWindow, 500)
	// globalShortcut.register('f5', function() {
	// 	console.log('f5 is pressed')
	// 	mainWindow.reload();
	// 	mainWindow.setSize(570,80);
	// })
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


//##################################################################
//로그인 성공 후 고유값 생성 후 파일로 저장 (자동로그인을 위해)
ipcMain.on('saveUserInfo', (event, usernm, userpw) => {
	userInfoFileAsync(dir, usernm);
})

const userInfoFileAsync = async(dir, usernm) => {
	var chkFile = FnChk_settingsFile();
	console.log("chkFile==="+ chkFile);

	var makeDirpAsync = await mkDirpAsync(dir);
	var userUUIDVal = await userInfoWriteFile();

	console.log("userUUIDVal==="+userUUIDVal);

	var headersOpt = {
		"content-type": "application/json",
	};
	console.log("aa==="+ usernm+"==="+ userUUIDVal);
	request({
		method:'POST',
		url:'http://askos.co.kr/api/userUUID?${_csrf.parameterName}=${_csrf.token}',
		form: {'uuiduser':  userUUIDVal, 'userid' : usernm},
		
		headers: headersOpt,
		json: true,
		}, async function (error, response, body) {
			if(!error){
				console.log("client ready --------------ret body==="+ body);
			}else{
				console.log("client ready --------------err="+ error);
			}
		}
	);
}


function FnChk_settingsFile(){
	try{
		var retVal = fs.existsSync(fileDir);
		return retVal;
  	}catch(e){
		if(e.code == 'ENOENT'){
			return "false";
    	}
  	}
}


function userInfoWriteFile(){
	return new Promise(function(resolve, reject){
	  var arg = uniqid()+(new Date()).getTime().toString(36);
	  fs.unlink(fileDir, (err) => err ?  console.log(err) : console.log(`${fileDir} 를 정상적으로 삭제했습니다!!!`));
	  fs.writeFile(fileDir, arg, (err) => {
		  if(err){
			reject("error");
		  }
		   resolve(arg);
		});
	});
  }

// ##################################################################
//	앱 실행시 저장된 사용자 정보 확인 

ipcMain.on('initApp', (event, path) => { 
	console.log("bbbbbbbbb");
	
	var userUuidStr = "";
	try{
		var retVal = fs.existsSync(fileDir);
		if( retVal ){
			userUuidStr = fs.readFileSync(fileDir, 'utf8');
			console.log("userUuidStr=========" + userUuidStr.trim()+"===");

			var headersOpt = {
				"content-type": "application/json",
			};
			request({
				method:'post',
				url:'http://askos.co.kr/api/getUserInfo',
				form: {'uuiduser':  userUuidStr.trim()},
				headers: headersOpt,
				json: true,
				}, async function (error, response, body) {
					console.log("getUserInfo --------------err==="+ error);
					if(!error){
						console.log("getUserInfo--------------ret body==="+ JSON.stringify(body));
						if( body.output == "Y" ){
							event.sender.send('initAppProc', body, userUuidStr.trim());
						}else{
							event.sender.send('initAppProc', body, userUuidStr.trim());
						}
					}else{
						console.log("getUserInfo --------------err="+ error);
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


// ##################################################################
//	질문 등록 
ipcMain.on('questWriteProc', (event, sub, cont, tsUser, tsUserUuidId) => {

	const  questionURL = 'http://askos.co.kr/api/questWrite?_csrf=${_csrf.token}';
	var req = request.post(questionURL, function (err, resp, body) {
			if (err) {
					console.log("request tech error is :"+ err);
			} else {
				console.log("============+"+body);
				event.sender.send('isQuestWriteProc', body );
			}
	});

	var form = req.form();
	form.append('title', sub);
	form.append('contents', '<p>' + cont+'</p>');
	form.append('username', tsUser);
	form.append('uuiduser', tsUserUuidId);
	form.append('section', 'Q');

});



// ##################################################################
//	앱 레이어 
ipcMain.on('resize-me-please', (event, arg) => {
	console.log("==========================++>"+ arg);
	if(arg == "initLayer"){
		mainWindow.setResizable(true);
		mainWindow.setSize(520,340);
		console.log("init layer size 550:80");
	}else if( arg == "viewLayer"){
		  mainWindow.setSize(520, 627);
		 // esRequest();
	}else if( arg == "questLayer"){
		console.log("questLayer=========");
		mainWindow.setSize(520, 670);
	   // esRequest();
  	}else{
		createWindow();
		mainWindow.setSize(520,340);
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
    		fs.readFile(fileDir, (err, data) => {
      if (err)  { reject("false")}
      else {
				var os = require("os");
				var text = data.toString().split(os.EOL);
        resolve(text[0]);
      }
    });
	});
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
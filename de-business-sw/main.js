const electron = require('electron');
const {Tray, Menu} = require('electron');
const {shell} = require('electron');
const { app, BrowserWindow, globalShortcut } = require("electron");
const {ipcMain} = require('electron')  
const { exec } = require('child_process');
const timestamp = require('time-stamp');
const path = require('path');
// const watch = require('node-watch');
// const lineReader = require('line-reader');
const fs = require('fs');
const windowStateKeeper = require('electron-window-state');
const request = require('request');
const open = require('open');
const unirest = require('unirest');
const CHILD_PADDING = 100; 
var log = require('./logger');

const { promisify } = require('util');
const mkdirp = require('mkdirp-promise')
const mkDirpAsync = promisify(mkdirp);

// const Poller = require('./Poller');

//var nodeConsole = require('console');
//var log = new nodeConsole.Console(process.stdout, process.stderr);


const osType = require('os');
const dirPath = osType.homedir() + '/.config/support/feedback';




// server url 
let restUrl = "http://192.168.0.2:8090";

let mainWindow, settingWindow;

function createWindow () {
	let mainWindowState = windowStateKeeper({
		defaultWidth: 100,
		defaultHeight: 100
	});

	mainWindow = new BrowserWindow({
		icon:'icons/icon16.png',
		skipTaskbar: false,
		'x': mainWindowState.x,
		'y': mainWindowState.y,
		'width': 310, 
		'height': 460, 
		// 'width': 427, 
		// 'height': 544, 
		 frame:false,
		 alwaysOnTop: false,
		//  resizable: false,
		 transparent: true,
		 show: true
		 ,webPreferences: {
			// defaultEncoding: 'utf8',
			// defaultFontFamily: 'cursive',
			// focusable: true,
			// webviewTag: true,
			nodeIntegration: true
			// nodeIntegrationInWorker: true,
			// nodeIntegrationInSubFrames: true,
			//  sandbox: true
//			webgl: true
		}
	});
	mainWindowState.manage(mainWindow);

	//    mainWindow.loadURL('file://' + __dirname + '/public/index.html');
	   mainWindow.loadURL('file://' + __dirname + '/public/test.html');
	  

	let display = electron.screen.getPrimaryDisplay();
	// let widthPosition = display.bounds.width-500;
	// mainWindow.setPosition(widthPosition,0);
  	mainWindow.setMenu(null);
	mainWindow.setMenuBarVisibility(false);	
	// Open the DevTools.
  	mainWindow.webContents.openDevTools(); 

	mainWindow.on('closed', function () {
		mainWindow = null;
	});

	mainWindow.webContents.on('did-finish-load', () => {
        	// Send the timer value
        	mainWindow.webContents.send('timer-change');
	});
	mainWindow.once('ready-to-show', () => {
		mainWindow.show()
	})
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
	trayIcon  = new Tray(__dirname + '/icons/icon16.png');
	//tray.setTitle('hello world');
	const trayMenuTemplate = [
		{
		   label: 'Hamonikr-finder',
		   //enabled: false
			click: function (){
				toggleWindow();
		   }
		},
		{
		   label: 'Settings',
		   click: function () {
			  log.info("Clicked on settings");
			  settingWindow.show();
			  log.info("Clicked on settings222");
		   }
		},
		{
		   label: 'Help',
		   click: function () {
			  log.info("Clicked on Help")
		   }
		},
		{ label: 'Quit', click: () => { app.quit(); } }
	 ]
	 
	 let trayMenu = Menu.buildFromTemplate(trayMenuTemplate)
	 trayIcon.setContextMenu(trayMenu)
}
let trayIcon  = null;



app.on('ready', () => {
	createTray();
	setTimeout(createWindow, 500);
	
});

app.on('window-all-closed', function () {
  if (process.platform !== 'darwin') {
	   mainWindow.setSize(500,70);
    app.quit();
  }
});

app.on('activate', function () {
	log.info("activate==="+ mainWindow);
  if (mainWindow === null) {
    createWindow();
  }
});


ipcMain.on('shutdown', (event,path) => {
	console.log("main....shutdown");
	exec("gnome-session-quit --no-prompt", (error, stdout, stderr) => {
          if (error) {
            log.info(`exec error: ${error}`);
            return;
          }
        });

});

// layer resize ========================
// ipcMain.on('resize-layer', (event, arg) => {
// 	if(arg == "initLayer"){
// 		mainWindow.setResizable(true);
// 		mainWindow.setSize(500,80);
// 	}else if( arg == "viewLayer"){
//   		mainWindow.setSize(550, 540);
// 		 // esRequest();
// 	}else{
// 		createWindow();
// 		mainWindow.setSize(500,80);
// 	}		
// })

// browser open ========================
ipcMain.on('openBrowser', (event) => {
	// opn('https://hamonikr.org/');
	(async () => {
		await open('http://192.168.0.116:8080/');
	})();
});

ipcMain.on('openbrowserCommunity', (event) => {
	(async () => {
		var getCompyUUID = await readUuidFileOnlyData("licenseChk");
		await open('http://127.0.0.1:8080/api/loginWithoutForm/'+ getCompyUUID);
		// await open('https://sindresorhus.com', {app: ['google chrome', '--incognito']});
	})();
});



var  rimraf = require("rimraf");
// 실행시 파일 삭제 (초기화)
removeSystemLogFile();

ipcMain.on('cancleSystemLogFile', (event) => {
	rimraf(dirPath, function () { console.log("done"); });	
});


function removeSystemLogFile(){
	rimraf(dirPath, function () { console.log("done"); });	
}


//========================================================================
//== upgradabel chk  =============================================================
//========================================================================
ipcMain.on('getUpgradable', (event) => {
	const exec = require('child_process').exec;
	exec('sudo apt list --upgradable | grep -i htop | wc -l ', (error, stdout, stderr) => {
	// exec('sudo apt list --upgradable | grep -i hamonikr-support | wc -l ', (error, stdout, stderr) => {

		if (error) {
			console.log("N=="+error);
		}else{
			console.log("Y===stdout=="+stdout);
		}

		event.sender.send('getUpgradableProc', stdout );

	 });
});
//========================================================================
//== notice data  =============================================================
//========================================================================
ipcMain.on('getNoticeTitle', (event) => {
	// server connection chk
	unirest.post('http://192.168.0.2:8090/restapi/tsNotice')
	  	.header('Accept', 'application/json')
	  	// .send({ "id": "connect" })
	  	.end(function (response) {
			var noticeResultObj = response.body;
			if( typeof noticeResultObj == "undefined" ){
				// event.sender.send('noticeProc', 'isNet', '','' );
			}else {
				var jsontext = JSON.stringify(noticeResultObj);
				var accountObj = JSON.parse(jsontext);
				event.sender.send('getNoticeTitleProc', accountObj );
			}
	 	});
});

//========================================================================
//== notice data  =============================================================
//========================================================================
ipcMain.on('getNoticeTitle', (event) => {
	// server connection chk
	unirest.post('http://192.168.0.2:8090/restapi/tsNotice')
	  	.header('Accept', 'application/json')
	  	// .send({ "id": "connect" })
	  	.end(function (response) {
			var noticeResultObj = response.body;
			if( typeof noticeResultObj == "undefined" ){
				// event.sender.send('noticeProc', 'isNet', '','' );
			}else {
				var jsontext = JSON.stringify(noticeResultObj);
				var accountObj = JSON.parse(jsontext);
				event.sender.send('getNoticeTitleProc', accountObj );
			}
	 	});
});

ipcMain.on('getNoticeList', (event, seq) => {
	unirest.post('http://192.168.0.2:8090/restapi/tsNotice')
	  	.header('Accept', 'application/json')
	  	.end(function (response) {
			var noticeResultObj = response.body;
			if( typeof noticeResultObj == "undefined" ){
				// event.sender.send('noticeProc', 'isNet', '','' );
			}else {
				var jsontext = JSON.stringify(noticeResultObj);
				var accountObj = JSON.parse(jsontext);
				event.sender.send('getNoticeListProc', accountObj, seq );
			}
	 	});
});

//========================================================================
//== tchnlgyChkProc chk =============================================================
//========================================================================
ipcMain.on('tchnlgyDataCall', (event) => {
	
	(async () => {
		try{
			var tchnlgyDatas = await readUuidFile("tchnlgy");
			event.sender.send('tchnlgyDataProc', tchnlgyDatas );
		}
		catch(err){
			console.log("nofile---" + err);
			// event.sender.send('isChkLicense', 'N', '','' );
		}
	})();


});

//========================================================================
//== License chk =============================================================
//========================================================================
ipcMain.on('licenseChkProc', (event) => {
	// server connection chk
	unirest.post('http://127.0.0.1:8080/api/connt')
	  	.header('Accept', 'application/json')
	  	.send({ "id": "connect" })
	  	.end(function (response) {
			var esResultObj = response.body;
			if( typeof esResultObj == "undefined" ){
				event.sender.send('isChkLicense', 'isNet', '','' );
			  }else {
				var jsontext = JSON.stringify(esResultObj);
				console.log("jsontext=222222222222==="+ jsontext);
				var accountObj = JSON.parse(jsontext);
				chkLIcenseFileAsync(event);
			  }
	 	});

});
// license number sync chk proc =======================
const chkLIcenseFileAsync = async(event) => {
	try{
		var chkLicFileVal = await readUuidFile("licenseChk");
		var jsonData = JSON.parse(chkLicFileVal);
		
		var usedYN = jsonData.output;
		var usernm = jsonData.usernm;
		var questionTotalCnt = jsonData.totalCnt;
		var answerCnt = jsonData.ansComplete;

		event.sender.send('isChkLicense', usedYN, usernm, questionTotalCnt, answerCnt );
	}
	catch(err){
		console.log("nofile---" + err);
		event.sender.send('isChkLicense', 'N', '','' );
	}
}
function readUuidFile(arg){
	return new Promise(function(resolve, reject){
		var osType = require('os');
		var fileDir  = osType.homedir() + '/.config/support_compy/.hamonikr_compy';
		fs.readFile(fileDir, 'utf-8', (err, data) => { 
			if(err){ 
				return resolve("N");
			}else{
				console.log("data==="+ data);
				resolve(uuid_db_chk(data, arg));
			}
		});
	});
}
// 라이선스 체크 (리턴값: 사용기간 유무)
function uuid_db_chk(arg, gubun){
	return new Promise((resolve, reject) => {
		const formData = { 'uuiduser':  arg.trim()  };
	  if( gubun == "licenseChk" ){
		request.post({url: "http://127.0.0.1:8080/api/getUserCheck", formData: formData}, async (err, response, body) => {
	    	if (err) return reject(err);
				const result = body.trim(); // JSON.parse(body);
				console.log("result=======+++"+ result);
				resolve(result);
		});
	}
	//   }else if( gubun == "tchnlgy" ){
	// 	request.post({url: "http://192.168.0.2:8090/restapi/tsChk", formData: formData}, async (err, response, body) => {
	//     	if (err) return reject(err);
	// 			const result = body.trim(); // JSON.parse(body);
	// 			resolve(result);
	// 	});	
	//   }
	  	
	});
}




//========================================================================
//==  기업 사용자 로그인 프로세스 ===========================================
//========================================================================
ipcMain.on('osMachineIdProc', (event) => {
	machineIdAsync(event);
});
const machineIdAsync = async(event) => {
	try{

		var machineIdChk = await getOsMachineId();

		if( machineIdChk == 'N' ){
			// var createMachineId = await userOsMachineIdWriteFile();
			if( createMachineId == 'Y' ){
				var machineIdVal = await getOsMachineId();
				event.sender.send('isOsMachineId', machineIdVal );
			}
		}else{
				event.sender.send('isOsMachineId', machineIdChk );
		}		
	}catch(err){
		  console.log("machineIdAsync Error");
		return Object.assign(err);
	}
 }

 function userOsMachineIdWriteFile(cmd) {
	const exec = require('child_process').exec;
	return new Promise((resolve, reject) => {

		// var fileDir = "/usr/share/applications/.support/.hmMachineId";
		var osType = require('os');
		var fileDir = osType.homedir() + '/.config/support/.hmMachineId'
		exec(' mkdir -p  '+osType.homedir()+'/.config/support/ &&  mkdir -p '+osType.homedir() +'/.config/support/feedback &&  cat /dev/null > ' +fileDir + ' && cat /etc/machine-id >> ' + fileDir + ' && chmod 600 ' + fileDir, (error, stdout, stderr) => {
			if (error) {
				console.log("N=="+error);
				resolve("N");
			}else{
				console.log("Y");
				resolve("Y");
			}
			// resolve(stdout? stdout : stderr);
	 	});
	});
}
function getOsMachineId(){
	return new Promise(function(resolve, reject){
		var osType = require('os');
		var fileDir = osType.homedir() + '/.config/support/.hmMachineId'
		fs.readFile(fileDir, 'utf-8', (err, data) => { 
			if(err){ 
				return resolve("N");
			}else{
				return resolve(data);
			}
		});

	
	});
}



//로그인 성공 후 고유값 생성 (자동로그인을 위해) ===============================
ipcMain.on('userLoginSuccess', (event, userid) => {
	

	const dir  = osType.homedir() + '/.config/support_compy/';
	// userUUidInfoSave(event,dir, userid);
	userInfoFileAsync(event,dir,userid);
})

const userUUidInfoSave = async(event, dir, userid) => {
	var isCreateFolder = await createDirectory(dir);
	console.log("isCreateFolder==="+isCreateFolder);

	var retUUIDVal = await userLcnsInfoWriteFile(userid);
	console.log("=====retUUIDVal===============" + retUUIDVal);
	event.sender.send('isUserLoginSuccess' );
};


const userInfoFileAsync = async(event,dir, userid) => {

	var isCreateFolder = await createDirectory(dir);
	console.log("isCreateFolder==="+isCreateFolder);

	var retUUIDVal = await userLcnsInfoWriteFile(userid);
	console.log("=====retUUIDVal===============" + retUUIDVal);

	var headersOpt = {
			"content-type": "application/json",
	};
	console.log("aa==="+ userid+"==="+ retUUIDVal);
	request({
			method:'POST',
			url:'http://127.0.0.1:8080/api/userUUID?${_csrf.parameterName}=${_csrf.token}',
			form: {'uuiduser':  retUUIDVal, 'userid' : userid},

			headers: headersOpt,
			json: true,
			}, async function (error, response, body) {
					console.log("client ready --------------err==="+ error);
					if(!error){
							console.log("client ready --------------ret body==="+ body);
							event.sender.send('isUserLoginSuccess' );
					}else{
							console.log("client ready --------------err="+ error);
					}
			}
	);
}

// app 실행시 자동로그인 처리 =======================



//========================================================================
//== License add =============================================================
//========================================================================
ipcMain.on('licenseSubmitProc', (event, licenseNo) => {
	makeRecursiveFileAsync(event, licenseNo);
});
const makeRecursiveFileAsync = async(event, licenseNo) => {
	try{
		var lcnsChkVal = await userLcnsInfoWriteFile(licenseNo);
		if( lcnsChkVal == 'Y'){
			userOsMachineIdWriteFile();
			event.sender.send('isBoolLicense' );
		}
		
	}catch(err){
		  console.log(" makeRecursiveFileAsync  error");
		return Object.assign(err);
	}
 }


function userLcnsInfoWriteFile(str){
	return new Promise(function(resolve, reject){

		var osType = require('os');
		var fileDir = osType.homedir() + '/.config/support_compy/.hamonikr_compy'

		// createFile(fileDir, 'my content\n', function (err) {
		//   // file either already exists or is now created (including non existing directories)
		// });

		var uniqid = require('uniqid');
	  	var osType = require('os');
	  	var arg = uniqid()+(new Date()).getTime().toString(36);
		

		if (!fs.existsSync(fileDir)) {
			fs.writeFile(fileDir, arg, (err) => {
		  		if(err){
					reject("error");
					console.log("//== save-dir-path() error  "+ err.message);
				  }
				   resolve(arg);
			});
	  	}else{
			fs.writeFile(fileDir, arg, (err) => {
				if(err){
				  reject("error");
				  console.log("//== save-dir-path() error  "+ err.message);
				}
				resolve(arg);
		  });
	  	}


		// const fsPromises = require("fs").promises;
		// const fd = fs.openSync(fileDir, 'r'); 
  
		// // Allowing only read permission 
		// fs.fchmod(fd, fs.constants.S_IRUSR, (err) => { 
		// if (err) throw err; 
		
		// // Check the file mode 
		// // console.log("Current File Mode:",         fs.statSync(fileDir).mode); 
		
		// fs.fchmod(fd, fs.constants.S_IRUSR |  
		// 		fs.constants.S_IWUSR, (err) => { 
		// 			if (err) throw err; 
				
		// 			// Check the file mode 
		// 			// console.log("Current File Mode:",          fs.statSync(fileDir).mode); 
		// 			// console.log("Trying to write to file"); 
		// 			// console.log("File Contents:",          fs.readFileSync(fileDir, 'utf8')); 
		// 		}); 
		// }); 
				
	
	});
  }
  


// 라이선스 권한 변경
		// const fsPromises = require("fs").promises;
		// (async () => {
		// try {
		// 	const { fd } = await fsPromises.open(fileDir, "r");
		// 	fs.fchown(fd, 1000, 1000, err => {
		// 	if (err) throw err;
		// 	console.log("File permission change succcessful");
		// 	});
		// } catch (error) {
		// 	console.log(error);
		// }
		// })();
	

//========================================================================
//== System Log File Proc =======================================================
//========================================================================
var sudo = require('sudo-prompt');
var options = {
  	name: 'Hamonikr'
//   ,icns: '/home/ryan/1.png', // (optional)
};

ipcMain.on('logFileTar', (event) => {


	// var osType = require('os');
	// var dirPath = osType.homedir() + '/.config/feedback/';

	// if (!fs.existsSync(dirPath)){
	// 	fs.mkdirSync(dirPath)
	// }

	logFileTarAsync(event);
});




const logFileTarAsync = async(event) => {
	try{
		var isCreateFolder = await createDirectory(dirPath);
		if( isCreateFolder == 'Y' ){
			var chkLicFileVal = await logFileTarProc();
			event.sender.send('islogFileTarProc', chkLicFileVal );
		}else {
			console.log("error");
		}
	}catch(err){
		console.log("logFileTarAsync---" + err);
		// event.sender.send('isChkLicense', 'N', '','' );
		return Object.assign(err);
	}
}

// crate folder =============================
function createDirectory(directoryPath) {
	console.log("1========="+ directoryPath);
	const directory = path.normalize(directoryPath);
	console.log("directory==========+"+ directory);
	return new Promise((resolve, reject) => {
		fs.stat(directory, (error) => {
			if (error) {
		  		if (error.code === 'ENOENT') {
					fs.mkdir(directory, (error) => {
			  			if (error) {
							reject("N");
			  			} else {
							resolve("Y");
			  			}
					});
		  		} else {
					reject("N");
		  		}
			} else {
				resolve("Y");
			}
	  	});
	});
  }

function logFileTarProc(){
	return new Promise(function(resolve, reject){

		var makeFolder = "";
		makeFolder += " sudo cp /var/log/syslog  " + dirPath +"/syslog.log";
		makeFolder += " &&  sudo cp /var/log/auth.log  " + dirPath ;
		makeFolder += " &&  sudo cp /var/log/boot.log  " + dirPath ;
		makeFolder += " &&  sudo cp /var/log/kern.log  " + dirPath ;
		makeFolder += " &&  dmesg  > " + dirPath +"/dmesg.log" ;
		makeFolder += " && sudo tar cvf " + dirPath +"/system_logfile.tar  " + dirPath +"/*.log";

		// var syslogFile = "/var/log/syslog";
		// var authlogFile = "/var/log/auth.log";
		// var bootlogFile = "/var/log/boot.log";
		// var kernlogFile = "/var/log/kern.log";
		// var dmesglogFile = "dmesg  > " + dirPath +"/dmesg.log" ;
		// makeFolder += " sudo tar cvf " + dirPath +"/feedback.tar  dmesg > dmesg.log  " +  
		// 	syslogFile + " " + authlogFile + " " + bootlogFile + " " + kernlogFile;
		
		sudo.exec(makeFolder, options,
			function(error, stdout, stderr) {
				if (error) {
					console.log("error is " + error);
					return resolve("N");
				}else{
					console.log('stdout: ' + stdout);
					console.log('stderr: ' + stderr);
					resolve("Y");
				}
			}
		);
	});
}


//const  uploadURL = 'http://localhost:8090/restapi/upload';
//const  uploadURL = 'http://localhost:8090/restapi/upload?${_csrf.parameterName}=${_csrf.token}';





//========================================================================
//== 기술지원 요청 전송 =========================================================
//========================================================================
ipcMain.on('tchnlgyIngryProc', (event, sub, cont, tsUser, isChkBox) => {

	var osType = require('os');
	var fileDir = osType.homedir() + '/.config/support/.hkrmesysinfo'

	fs.readFile(fileDir, 'utf-8', (err, data) => { 
		if(err){ 
			console.log("An error ocurred reading the file :" + err.message);
			return resolve("N");
		}else{
			// resolve(uuid_db_chk(data));
			var osType = require('os');
			const  uploadURL = 'http://192.168.0.2:8090/restapi/saveTchnlgyIngry?_csrf=${_csrf.token}';
			var filLocation =  osType.homedir()+"/.config/support/feedback/system_logfile.tar";


			
			var filename = "system_logfile.tar";

			var req = request.post(uploadURL, function (err, resp, body) {
				if (err) {
					console.log("request tech error is :"+ err);
				} else {
					var accountObj = JSON.parse(body);
					// 기술문의 등록후 첨부파일 삭제
					removeSystemLogFile();
					event.sender.send('isTchnlgyIngryProc', accountObj.message );
				}
			});
			
			var form = req.form();
			form.append('subject', sub);
			form.append('contents', cont);
			form.append('ts_user', tsUser);
			form.append('usedUserLicenseUUID', data);
			if( isChkBox ){
				form.append('file1', fs.createReadStream(filLocation), {
				filename: filename,
				contentType: 'application/octet-stream',
					enctype: 'multipart/form-data'
				});
			}
		}
	});

	
});


// ===================== de =========================
function FnChk_settingsFile(){
	var osType = require('os');
	var dirpath = osType.homedir() + '/.config/support_compy/.hamonikr_compy';

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

function userInfoWriteFile(){
	return new Promise(function(resolve, reject){
	  var uniqid = require('uniqid');
	  var osType = require('os');
	  var fileDir  = osType.homedir() + '/.config/support_compy/.hamonikr_compy';
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
	  //    console.log("bbbbbbbbb");
	  //    resolve(arg);
	  // }
	});
}




function notiAction(){
	// var eNotify = require('electron-notify');
	
	
	// eNotify.notify({
	// 	title: 'Notification title',
	// 	text: 'Some text', 
	// 	// url: 'http://wikipedia.org',
	// 	image: path.join(__dirname, '/public/assets/img/bg02.png'),
	// 	sound: true,
	// 	appName: "com.myapp.id",
	// 	onClickFunc: function() { console.log('onCLick') },
	// });

	// notification 옵션 정보 참조
	// Send notification that uses the new options
	// eNotify.notify({
	//     title: '22222222222222',
	//     text: 'Some text22222222222',
	//     // image: path.join(__dirname, '/public/assets/img/bg01.png'),
	//     url: 'http://google.de',
	//     sound: true, //path.join(__dirname, 'notification.wav'),
	//     onClickFunc: function() {console.log('onCLick') },
	//     onShowFunc: function() { console.log('onShow') },
	//     onCloseFunc: function() { console.log('onClose')}
	// });

	// Change config options between notify calls
	// eNotify.setConfig({
	// 	appIcon: path.join(__dirname, '/public/assets/img/bg02.png'),
	// 	defaultStyleText: {
	// 		color: '#FF0000',
	// 		fontWeight: 'bold'
	// 	}
	// });

 
 
}

// let poller = new Poller(6000);
// poller.onPoll(() => {
// 		pollingData();
//         poller.poll(); // Go for the next poll
// });

// // Initial start
// poller.poll();


ipcMain.on('callQuestionData', (event) => {
	console.log("callQuestionData=== START");
	 getQuestionData(event);
});


const getQuestionData = async(event) => {
	try{
		var getCompyUUID = await readUuidFileOnlyData("licenseChk");
		console.log("getQuestionData getCompyUUID==="+getCompyUUID);
		var retVal = await getQuestionDataCall(getCompyUUID);
		console.log("retVal==="+JSON.stringify(retVal));
		event.sender.send('callNotify','');

	}
	catch(err){
		console.log("getQuestionData nofile---" + err);
	}
}
function readUuidFileOnlyData(arg){
	return new Promise(function(resolve, reject){
		var osType = require('os');
		var fileDir  = osType.homedir() + '/.config/support_compy/.hamonikr_compy';
		fs.readFile(fileDir, 'utf-8', (err, data) => { 
			if(err){ 
				return reject("N");
			}else{
				console.log("getQuestionData data==="+ data);
				resolve(data);
				// resolve();
			}
		});
	});
}
function getQuestionDataCall(retUUIDVal){
	return new Promise(function(resolve, reject){
		var headersOpt = {
			"content-type": "application/json",
		};
		request({
				method:'POST',
				url:'http://127.0.0.1:8080/api/getCompQuestion?${_csrf.parameterName}=${_csrf.token}',
				form: {'uuiduser':  retUUIDVal},
	
				headers: headersOpt,
				json: true,
				}, async function (error, response, body) {
						console.log("getQuestionDataCall-----------err==="+ error);
						if(!error){
								console.log("getQuestionDataCall---------ret body==="+ JSON.stringify(body));
								resolve( "1" );
						}else{
								console.log("getQuestionDataCall---------err="+ error);
								return reject("N");
						}
				}
		);
	});
}





const moment = require('moment');
const electron = require('electron');
const {ipcRenderer} = require('electron');
const {BrowserWindow} = require('electron')
const path = require('path');
const unirest = require('unirest');

// server url 
let restUrl = "http://192.168.0.2:8090/";


// app 실행시 자동로그인 처리를 위해....==============
// ipcRenderer.send('openUserUUID', () => {
// 	console.log("Event sent.");
// })
// ipcRenderer.on('userUUidData', (event, data) => {
// 	$("#userIpAddress").val(data);
// });

// 로그인버튼클릭시 =====================================
const licenseSubmitBtn = document.getElementById('licenseSubmit');
const enterIdVal = document.getElementById('enterId');
const enterPwVal = document.getElementById('enterPw');

licenseSubmitBtn.addEventListener('click', function (event) {
	if( enterIdVal.value.length == 0 ){
		fn_alert('아이디를 입력해주세요.');
		return false;
	}
	if( enterPwVal.value.length == 0 ){
		fn_alert('비밀번호를 입력해주세요.');
		return false;
	}
	
	// ipcRenderer.send('osMachineIdProc');

	unirest.post('http://askos.co.kr/api/signproc')
		.header('Accept', 'application/json')
		.send({ "userid": enterIdVal.value, "userpassword": enterPwVal.value })
		.end(function (response) { 
			console.log(response.body);
			var retval = response.body;
			if( retval.output == "Y" ){
				const {ipcRenderer} = require('electron');
				ipcRenderer.send('userLoginSuccess', retval.userid);
			}else{
				fn_alert("로그인 정보가 틀립니다.");
			}
		});

});

ipcRenderer.on('isOsMachineId', (event, machineIdVal) => {
	unirest.post('http://askos.co.kr/api/signproc')
		.header('Accept', 'application/json')
		.send({ "userid": enterIdVal.value, "userpassword": enterPwVal.value })
		.end(function (response) { 
			console.log(response.body);
			var retval = response.body;
			
			if( retval.output == "Y" ){
				const {ipcRenderer} = require('electron');
				console.log("response.body.trim()===========+"+ JSON.stringify(response.body));
				ipcRenderer.send('userLoginSuccess', retval.userid);
			}else{
				fn_alert("로그인 정보가 틀립니다.");
			}

		});
})


ipcRenderer.on('isUserLoginSuccess', (event, usedYN, usernm, totalCnt, answerCnt) => {
	// var licenseInfoLayer = document.getElementById("licenseInfoLayerDescription");
	// licenseInfoLayer.innerHTML= usernm + "님 접속하셨습니다." ;

	$("#licenseok").text( usernm + "님 접속하셨습니다.");
	$("#licenseok").show();
	$("#loginFormLayer").hide();
	$("#questionLayer").show();
	
	ipcRenderer.send('loginSuccessLayerChange');

});
// 로그인  체크
ipcRenderer.send('licenseChkProc');
ipcRenderer.on('isChkLicense', (event, usedYN, usernm, totalCnt, answerCnt) => {

	// var licenseInfoLayer = document.getElementById("licenseInfoLayerDescription");
	hiddenLIcenChkVal.value = usedYN;
console.log("usedYN===========++"+usedYN);
	if( usedYN == 'Y' ){

		$("#loginFormLayer").hide();
		$("#questionLayer").show();
		$("#licenseok").show();
		// licenseInfoLayer.innerHTML= usernm + "님 접속하셨습니다." ;
		$("#licenseok").text( usernm + "님 접속하셨습니다.");

		// document.getElementById("tcIng").innerText= (totalCnt-answerCnt);
		// document.getElementById("tcDone").innerText=answerCnt;
		// document.getElementById("tcTot").innerText=totalCnt;
		$("#tcIng").text((totalCnt-answerCnt));
		$("#tcDone").text(answerCnt);
		$("#tcTot").text(totalCnt);

		ipcRenderer.send('loginSuccessLayerChange');

	}else if( usedYN == 'isNet' ){

		// $("#slideshow").hide();
		// document.getElementById("tcIng").innerText=0;
		// document.getElementById("tcDone").innerText=0;
		// document.getElementById("tcTot").innerText=0;
		$("#tcIng").text(0);
		$("#tcDone").text(0);
		$("#tcTot").text(0);
		fn_alert("기술지원 서비스접속이 원활하지않습니다. 네트워크를 확인해주시기바랍니다.");
	}else{
		$("#license_base").show();
		$("#licenseok").hide();
		// $("#qnaLayer").hide();
	}
  })

// =======alert===================================
// createBrowserWindow();
function createBrowserWindow() {
	const remote = require('electron').remote;
	const BrowserWindow = remote.BrowserWindow;

	const modalPath = path.join('file://', __dirname, 'alert.html')
	let win = new BrowserWindow({ width: 680, height: 100, skipTaskbar: false, alwaysOnTop:true, frame:false  })
	win.on('close', function () { win = null })
	win.loadURL(modalPath)
	win.show()

//      let modal = window.open('./alert.html', 'modal',"resizable,scrollbars,status")
}

// ==========================================














var hiddenLIcenChkVal = document.getElementById("hiddenLIcenChkVal");


const footeropenCmmrlctBtn = document.getElementById('footeropenCmmrlct');
footeropenCmmrlctBtn.addEventListener('click', function (event) {
	ipcRenderer.send('openBrowser');
});


// 공지사항
// ipcRenderer.send('getNoticeTitle');
ipcRenderer.on('getNoticeTitleProc', (event, jsonData) => {
	var list = $.parseJSON(jsonData);
	var listLen = list.length;
	var slideshowHTML = "";

	for(var i=0; i<listLen; i++){
		slideshowHTML += `<div class='notiTitle' style='margin-left:20px;' data-value='`+list[i].notice_seq+`'>
		<img class="direct-chat-img" style='margin-top: -10px;'src="assets/images/loud.png" alt="message user image"><span style='margin-left:10px;'>`+list[i].title+`</span></div>`;
	}
	
	var slideshowLayerList = document.getElementById("slideshow");
	slideshowLayerList.innerHTML = slideshowHTML;

	$("#slideshow > div:gt(0)").hide();

    setInterval(function() { 
    $('#slideshow > div:first')
        .fadeOut(1000)
        .next()
        .fadeIn(1000)
        .end()
        .appendTo('#slideshow');
    },  3000);
});


$(document).on('click', '.notiTitle', function () {
	ipcRenderer.send('getNoticeList', $(this).data("value"));
});
ipcRenderer.on('getNoticeListProc', (event, jsonData, clickSeq) => {
	
	$("#slideshow").hide();
	$("#mainLayer").hide();
	$("#supportLayer").hide();
	$("#tchnlgyLayer").hide();
	$("#noticeLayer").show();

	var list = $.parseJSON(jsonData);
	var listLen = list.length;
	var noticeListHTML = "";

	for(var i=0; i<listLen; i++){
		var faTag = "fa-plus", viewContentsTag="display:none;", cardTag="collapsed-card";
		if( clickSeq == list[i].notice_seq ){
			faTag = "fa-minus";
			viewContentsTag = "display:block;"
			cardTag = "";
		}
		noticeListHTML += `<div class="col-md-6">
		<div class="card direct-chat direct-chat-warning `+cardTag+`">
			<div class="card-header">
				<h3 class="card-title" data-value='`+list[i].notice_seq+`'>`+list[i].title+`</h3>
				<div class="card-tools">
					<span class='badge badge-info'>`+list[i].reg_date+`</span>
					<button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas `+faTag+`"></i></button>
				</div>
			</div>
			<div class="card-body" style="`+viewContentsTag+`">
				<div class="direct-chat-messages2">
					<div class="direct-chat-msg">
						<img class="direct-chat-img" src="assets/images/noticon.png" alt="message user image">
						<div class="direct-chat-text">`+list[i].notice_contents+`</div>
					</div>
				</div>
			</div>
		</div>
	</div>`;

	}

	var noticeListLayerList = document.getElementById("noticedata_list");
  	noticeListLayerList.innerHTML = noticeListHTML;
});

  
  ipcRenderer.on('isBoolLicense', (event) => {
	fn_alert("라이선스 등록이 정상처리 되었습니다.");
	setTimeout(function(){
		location.reload();
	},1500);
})

// qna click====
// const qnaLayerBtn = document.getElementById('qnaLayer');
// qnaLayerBtn.addEventListener('click', function (event) {
// 	// 기술문의 조회
// 	ipcRenderer.send('tchnlgyDataCall');
// });
ipcRenderer.on('tchnlgyDataProc', (event,jsonData) => {
	var list = $.parseJSON(jsonData);
	var listLen = list.length;
	var characterHTML = "";
	for(var i=0; i<listLen; i++){
		// .badge-danger
		var classTag = "", displayTag = "", dontBtn="";
		if( list[i].proc_stat == '완료' ){
			classTag = 'badge-danger';
			displayTag = 'display:block;';
			dontBtn = '<button type="button" href="#layer2"  class="btn btn-tool answerDonProc" data-seq="'+list[i].seq+'">만족도 조사</button>';
		}else{
			classTag = 'badge-warning';
			displayTag = 'display:none;';
		}

		characterHTML += `
		<div class="col-md-6">
			<div class="card direct-chat direct-chat-warning collapsed-card">
				<div class="card-header">
					<h3 class="card-title">`+list[i].subject+`</h3>
					<div class="card-tools">
						<span data-toggle="tooltip" title="3 New Messages" class="badge `+classTag+`">`+list[i].proc_stat+`</span>
						<span class='badge badge-info'>`+list[i].reg_date+`</span>
						<button type="button" class="btn btn-tool" data-card-widget="collapse"><i class="fas fa-plus"></i></button>
					</div>
				</div>
				<div class="card-body" style="display: none;">
					<div class="direct-chat-messages2">
						<div class="direct-chat-msg">
							<img class="direct-chat-img" src="assets/images/ques.png" alt="message user image">
							<div class="direct-chat-text">`+list[i].contents+`</div>
						</div>
						
						<div class="direct-chat-msg right" style="`+displayTag+`">
							<img class="direct-chat-img" src="assets/images/ans.png" alt="message user image">
							<div class="direct-chat-text">`+list[i].comments+`</div>
						</div>
						` +dontBtn	+`
					</div>
				</div>
			</div>
		</div>`;
	}


	
var tchnlgyLayerList = document.getElementById("character_list");
	tchnlgyLayerList.innerHTML = characterHTML;
	$("#mainLayer").hide();
	$("#supportLayer").hide();
	$("#tchnlgyLayer").show();
});


$(document).on('click', '.btn-layerSubmit', function () {

	unirest.post('http://192.168.0.2:8090/restapi/tsSurvey')
		.header('Accept', 'application/json')
		.send({ "survey_seq": $("#ansSeq").val(), "survey_score": $("#star2_input").val(), "survey_content": $("#survey_content").val()})
		.end(function (response) {
			var jsonData = JSON.parse(response.body);

			fn_alert("고객 지원 문의 조사에 참여해주셔서 감사합니다..");
			setTimeout(function(){
				location.reload();
			},1500);
			// if( jsonData.output == 'N' ){
			// }else{

			// }
			// if( jsonData.output == 'N' ){
			// 	fn_alert("잘못된 라이선스 번호입니다.");
			// 	licenseVal.value = "";
			// 	return false;
			// }else if( jsonData.output == 'DN' ){
			// 	fn_alert("라이선스 기간이 완료된 라이선스입니다.");
			// 	licenseVal.value = "";
			// 	return false;
			// }else if( jsonData.output == 'DUN' ){
			// 	fn_alert("사용중인 라이선스입니다.");
			// 	licenseVal.value = "";
			// 	return false;
			// }else{
			// 	ipcRenderer.send('licenseSubmitProc', response.body.trim());
			// }
		});
});


// 만족도 view
$(document).on('click', '.answerDonProc', function () {
	var $href = $(this).attr('href');

	$("#ansSeq").val("");
	$("#ansSeq").val($(this).data("seq"));

    layer_popup($href);
});

function layer_popup(el){

	var $el = $(el);        //레이어의 id를 $el 변수에 저장
	var isDim = $el.prev().hasClass('dimBg');   //dimmed 레이어를 감지하기 위한 boolean 변수

	isDim ? $('.dim-layer').fadeIn() : $el.fadeIn();

	var $elWidth = ~~($el.outerWidth()),
		$elHeight = ~~($el.outerHeight()),
		docWidth = $(document).width(),
		docHeight = $(document).height();

	// 화면의 중앙에 레이어를 띄운다.
	if ($elHeight < docHeight || $elWidth < docWidth) {
		$el.css({
			marginTop: -$elHeight /2,
			marginLeft: -$elWidth/2
		})
	} else {
		$el.css({top: 0, left: 0});
	}

	$el.find('a.btn-layerClose').click(function(){
		isDim ? $('.dim-layer').fadeOut() : $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
		return false;
	});

	$('.layer .dimBg').click(function(){
		$('.dim-layer').fadeOut();
		return false;
	});

}



// 기술지원 요청하기 proc
// const feedBackBtn = document.getElementById('feedBack');
// const feedBackLayer = document.getElementById('feedBackLayer');

// feedBackBtn.addEventListener('click',function(event){
// 	if( hiddenLIcenChkVal.value == 'Y'){
// 		$("#slideshow").hide();
// 		$("#mainLayer").hide();
// 		$("#supportLayer").show();
// 	}else {
// 		fn_alert('라이선스 등록이 필요합니다.\n 라이선스 등록 후 기술지원을 요청해주세요.');
// 	}
// });

// 로그파일 첨부 버튼 클릭
// const logFileAttachmentBtn = document.getElementById('logFileAttachment');
// logFileAttachmentBtn.addEventListener('click',function(event){

// 	var isChkBox = $("input:checkbox[id='logFileAttachment']").is(":checked");
// 	if( isChkBox ){
// 		ipcRenderer.send('logFileTar');
// 	}else {
// 		ipcRenderer.send('cancleSystemLogFile');
// 		document.getElementById("logFileDes").innerText = "";
// 	}

// });
// ipcRenderer.on('islogFileTarProc', (event, chkLicFileVal) => {
// 	if( chkLicFileVal == 'Y' ){
// 		var other = document.getElementById("logFileDes");
// 		other.innerText = " - system_logfile.tar";
// 	}else{
// 		document.getElementById("logFileAttachment").checked = false;
// 	}

// })


ipcRenderer.on('viewChange', (event, usedYN, stDate, dtDate) => {
	$("#mainLayer").hide();
	$("#supportLayer").show();
});

		
// const btn_cancelBtn = document.getElementById('btn_cancel');
// btn_cancelBtn.addEventListener('click',function(event){
// 		$("#mainLayer").show();
// 		$("#supportLayer").hide();
// 		$("#tchnlgyLayer").hide();
// });
// const btn_mainBtn = document.getElementById('btn_main');
// btn_mainBtn.addEventListener('click',function(event){
// 		$("#mainLayer").show();
// 		$("#supportLayer").hide();
// 		$("#tchnlgyLayer").hide();
// });
// const btn_noticeBtn = document.getElementById('btn_notice');
// btn_noticeBtn.addEventListener('click',function(event){
// 		$("#mainLayer").show();
// 		$("#slideshow").show();
// 		$("#supportLayer").hide();
// 		$("#tchnlgyLayer").hide();
// 		$("#noticeLayer").hide();
// });




function fn_alert(arg){
	const Dialogs = require('dialogs');
	  const dialogs = Dialogs()
	  
	$(".banner-text").css({
		"z-index": "0"
	});

  	dialogs.alert(arg, ok => {
		$(".banner-text").css({
			"z-index": "1000000000"
		});
	 });
}






// $('input[type=file]').bind("change", function(){
// 	if(window.FileReader) {
// 		var filename = $(this)[0].files[0].name;
// 	} else {
// 		var filename = $(this).val().split('/').pop().split('\\').pop();
// 	}
// 	$(this).siblings('.input_type1').val(filename);
// });

$( document ).ready(function() {
	// if(window.FileReader) {
	// 	$('input[type=file]').siblings('.input_type1').val("feedback.tar");
	// }
	// var other = document.getElementById("logFileDes");
	// other.innerText = " - system_logfile.tar";
	// other.innerHTML ='<label><input type="checkbox" class="input_check" name="class[1]" value="1"> <b>Upload System Log</b></label>';
});


// // 기술지원 요청 등록
// const tchnlgySubmitBtn = document.getElementById('tchnlgySubmit');
// tchnlgySubmitBtn.addEventListener('click', function (event) {

// 	const subjectId = document.getElementById('subject');
// 	const contentsId = document.getElementById('contents');
// 	const tsUser = document.getElementById('tsUser');

// 	var isChkBox = $("input:checkbox[id='logFileAttachment']").is(":checked");
// 	ipcRenderer.send('tchnlgyIngryProc', subjectId.value, contentsId.value, tsUser.value, isChkBox);
// });


ipcRenderer.on('isTchnlgyIngryProc', (event, isProcYN, ) => {
	if( isProcYN == 'Y'){
		const Dialogs = require('dialogs');
		const dialogs = Dialogs()
		$(".banner-text").css({
			"z-index": "0"
		});
		
		dialogs.alert("기술지원 요청이 완료되었습니다.", ok => {
			$(".banner-text").css({
				"z-index": "1000000000"
			});
			location.reload();
		});
	}else{
		fn_alert("기술지원 요청 등록중 오류가 발생하였습니다. ");
	}
	
  })


  const open = require('open');
  var notifier = require('node-notifier');
//   (function() {
	  function createNotification(title, message) {
		  console.log("createNotification===========");
		  let myNotification = new Notification(title, {
			  body: message // '미등록된 답변이 있습니다.'
		 })
		 
		 myNotification.onclick = () => {
			  console.log('Notification clicked');
			ipcRenderer.send('openbrowserCommunity');
		 }
	  };
	  var handleNotification = function(event) {
		  var title ="Ask-Community",
			  message = "미등록된 답변이 있습니다.";
		  createNotification(title, message)
	  };
	//   var notifyButton = document.getElementById("abcdddd");
	//   notifyButton.addEventListener("click", handleNotification);
//   })();
  
 

// const Poller = require('../../../Poller');
const EventEmitter = require('events');
class Poller extends EventEmitter {
    constructor(timeout = 100) {
        super();
        this.timeout = timeout;
    }
    poll() {
        setTimeout(() => this.emit('poll'), this.timeout);
    }
    onPoll(cb) {
        this.on('poll', cb);
    }
}

let poller = new Poller(60000);
poller.onPoll(() => {
		testA();
        poller.poll(); // Go for the next poll
});

// Initial start
poller.poll();


function testA(){
	ipcRenderer.send('callQuestionData');
}
ipcRenderer.on('callNotify', (event, data) => {
	// createNotification("커뮤니티", "커뮤니티에 미등록된 답변이 있습니다.");
	handleNotification();
});
// handleNotification();

// var notifyButton = document.getElementById("abcdddd");
// 	  notifyButton.addEventListener("click", handleNotification);

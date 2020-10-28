
//  앱 실행시 저장된 사용자 정보 확인 ==============================================
// ipcRenderer.send('openUserUUID', () => {
// 	console.log("Event sent.");
// })
// ipcRenderer.on('userUUidData', (event, data) => {
//     $("#userIpAddress").val(data);
//     $('#signBefore').hide();
//     $('#signAfter').show();
//     $('#singAfterInfo').text(retval.usernm+"님 접속을 환영합니다.");
// });


// 개인정보 설정 버튼 클릭  =====================================================
function setProfile(){
    var unirest = require('unirest');
    var fs = require("fs");
    var osType = require('os');
    
    unirest.post('http://127.0.0.1:8080/api/signproc')
        .header('Accept', 'application/json')
        .send({ "userid": $("#userId").val(), "userpassword": $("#userPw").val(), "userIp": $("#userIpAddress").val() })
        .end(function (response) { 
            console.log(response.body);
            var retval = response.body;
  
            if( retval.output == "Y" ){
                const {ipcRenderer} = require('electron');
                ipcRenderer.send('saveUserInfo',  $("#userId").val(), $("#userPw").val());
    
                $('#signBefore').hide();
                $('#signAfter').show();
                $('#singAfterInfo').text(retval.usernm+"님 접속을 환영합니다.");
                location.reload();
            }else{
                fn_alert("로그인 정보가 틀립니다.");
            }
        });
}

// 질문하기 버튼 클릭  =====================================================
const questSubmitBtn = document.getElementById('questSubmit');
questSubmitBtn.addEventListener('click', function (event) {

    const tsUserUuidId = document.getElementById('tsUserUuid');
    const subjectId = document.getElementById('subject');
    const contentsId = document.getElementById('contents');
    const tsUser = document.getElementById('tsUser');

    ipcRenderer.send('questWriteProc', subjectId.value, contentsId.value, tsUser.value, tsUserUuidId.value);
});
ipcRenderer.on('isQuestWriteProc', (event, isProcYN, ) => {
	if( isProcYN == 'Y'){
			const Dialogs = require('dialogs');
			const dialogs = Dialogs()
			$(".banner-text").css({
					"z-index": "0"
			});
			dialogs.alert("커뮤니티에 질문 등록이 완료되었습니다.", ok => {
					$(".banner-text").css({
							"z-index": "1000000000"
					});
					location.reload();
			});
	}else{
			fn_alert("기술지원 요청 등록중 오류가 발생하였습니다. ");
	}

})

const btn_cancelBtn = document.getElementById('btn_cancel');
btn_cancelBtn.addEventListener('click',function(event){
    //
    location.reload();
    ipcRenderer.send('resize-me-please', "initLayer");
});



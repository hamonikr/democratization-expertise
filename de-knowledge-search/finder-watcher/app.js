//const express = require('express');
//const app = express();

const Koa = require('koa');
const Router = require('koa-router');
const koaBody = require('koa-body');
const app = new Koa();
const router = new Router();
const mongo = require('./MongoCon/mongoconf')
const bodyParser = require('koa-bodyparser');
const render = require('koa-ejs');
const path = require('path');

// notifycation 
const notifier = require("node-notifier");
//const Notification = require('electron-native-notification');
const open = require('open');

// Require the Router
const api = require('./Esproxy/api');
const fileapi = require('./remoteFileAccess');

app.use(mongo())
app.use(koaBody());
app.use(router.routes()).use(router.allowedMethods());

router.use('/api', api.routes()); 
router.use('/fileapi', fileapi.routes());

render(app, {
  root: path.join(__dirname, '/remoteFileAccess/public'),
  layout: 'template',
  viewExt: 'ejs',
  cache: false,
  debug: true
})


// Server
var port = 3001;
app.listen(port, function(){
	console.log('watcher listening on port:' + userIPChk() +"/"+ port);
});

//	Watcher
router.post('/watcher', async (ctx, next) => {
	console.log("watcher==================+++");
  console.log("useruuid==="+ ctx.request.body.userUuid);
  console.log("gubun === "+ ctx.request.body.gubun);
	var watcherObj = ctx.request.body.userUuid;
	var gubun = ctx.request.body.gubun;

	if( gubun == "PV"){
		const watcher = require('./watcher');
	  watcher.start(watcherObj);
	}else{
		var groupIndexNm = ctx.request.body.groupIndexNm;
		var userNm = ctx.request.body.userNm;
		const pr_watcher = require('./pr_watcher');
	  pr_watcher.start(watcherObj, groupIndexNm, userNm);
	}
	//const watcher = require('./watcher');
  //watcher.start(watcherObj);
	//
	//const pr_watcher = require('./pr_watcher');
  //pr_watcher.start(watcherObj);

});

router.post('/aaa', koaBody(),
  (ctx) => {
    console.log(ctx.request.body);
    // => POST body
    ctx.body = JSON.stringify(ctx.request.body);
  }
);

router.post('/profile', async (ctx, next) => {
	console.log(" profile ==================+++");
    var profileObj = ctx.request.body;
    console.log("userid === "+ profileObj.userId);
    console.log("groum name == "+ profileObj.groupNm);
	console.log("useruuid === "+ profileObj.userUuid);
	console.log("user ip  === "+ profileObj.userIp);
	var ipaddressVal = userIPChk();
console.log("ipaddressVal===========++"+ ipaddressVal);

	var retVal = "";
	var userUuidInsertChk = await ctx.db.collection('test_users').findOne({"user_uuid":profileObj.userUuid});

	if( userUuidInsertChk == null){
		console.log("aaaaaaaaaaaaaaaaaaaaa");
		retVal = await ctx.db.collection('test_users').insertOne({
			 user_id: profileObj.userUuid, 
			 group_nm: profileObj.groupNm, 
			 user_nm: profileObj.userId,
			 user_ip: ipaddressVal
		})
	}else{
		console.log("bbbbbbbbbbbbbbbbbb");
		retVal = await ctx.db.collection('test_users').updateOne(
			{ 
				user_uuid: profileObj.userUuid
			},
			{ $set:
				{ 
					user_nm: profileObj.userId, 
					group_nm: profileObj.groupNm,
					user_ip: ipaddressVal
				}
			}
		)
	}
	console.log("===retVal===="+ retVal);
  }
);

// 사용자 ip 정보 등록
router.post('/userIPchk', async (ctx, next) => {
	console.log("ip update====");
	var userInfo = ctx.request.body;
	console.log("user uuid ===" + userInfo.userUuid);
	var ipaddressVal = userIPChk();
	
	const tmp = await ctx.db.collection('test_users').updateOne(
		{ 
			user_uuid: userInfo.userUuid
		},
		{ $set:
			{ 
				user_ip: ipaddressVal
			}
		}
	)
	console.log("===tmp===="+ tmp);
});

router.post('/ownerIp', async (ctx) => {
	console.log("owner ip ");
	var ownerInfo = ctx.request.body;
	console.log("user id ===" + ownerInfo.owner_uuid);
	
	var dbOwnerInfo = await ctx.db.collection('test_users').findOne({"user_uuid":ownerInfo.owner_uuid});
	console.log("dbOwnerInfo==" + JSON.stringify(dbOwnerInfo));
	console.log("dbOwnerInfo==" + dbOwnerInfo.user_ip);
	
	ctx.body =  dbOwnerInfo.user_ip;
});

router.post('/userinfo', async (ctx) => {
    const profileObj = ctx.request.body;
		var uuidTmp = profileObj.userUuid;
		let chkUuid = "";

		const userUuidVal = await ctx.db.collection('test_users').findOne({"user_uuid":uuidTmp});

		if( userUuidVal == null  ){
				console.log("Insert");
				ctx.body = await ctx.db.collection('test_users').insertOne({ user_uuid: uuidTmp, group_nm: '', user_nm: '' }); //, (err, result) => {
				ctx.body = ctx.body.ops[0].user_uuid;
		}else{
			ctx.body = userUuidVal.user_uuid;
		}
  }
);

// Mongo
router.post('/select', async(ctx) => {
  console.log("select----------");
	var profileObj = ctx.request.body;
  var uuidTmp = profileObj.userUuid;
	console.log("uuidtmp===="+ uuidTmp);
  //ctx.body = await ctx.db.collection('test_users').find().toArray()
	ctx.body = await ctx.db.collection('test_users').findOne({"user_uuid":uuidTmp});
});



router.get('/insert', async(ctx) => {
  console.log("insert-------------");
	await ctx.db.collection('test_users').insertOne({ user_id: 'example', status: 'aa', group_nm: 'groupnm', user_nm: 'usernm' })
});

function userIPChk(){
	var os = require('os');
	var ifaces = os.networkInterfaces();
	var retVal ='';
	var tmpIfname = "";
	Object.keys(ifaces).forEach(function (ifname) {
			var alias = 0;
			ifaces[ifname].forEach(function (iface) {

				console.log("iface.inter " +iface.internal );
					if (iface.internal !== false) {
						console.log('not conn');
						tmpIfname = 'ERROR-not-conn';
					}
					
					if (alias >= 1) {
						// console.log("---------------------------ipv4 addresses is : " + ifname + ':' + alias, iface.address);
					} else {
						console.log("==================================== ipv4 adress is :" + ifname+"----"+ iface.address);
						if( ifname.indexOf('eth') == 0 ){
							tmpIfname = iface.address;
						}else if( ifname.indexOf('en') == 0 ){
							tmpIfname = iface.address;
						}
					}
					++alias;
			});
			retVal = tmpIfname;
	});

	return retVal;
}


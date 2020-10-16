const {ipcRenderer} = require('electron');
const {BrowserWindow} = require('electron')
const path = require('path');
const open = require("open");

  var notifier = require('node-notifier');
// (function() {
    function createNotification(title, message) {
        console.log("createNotification===========");
		let myNotification = new Notification('Title', {
			body: 'Lorem Ipsum Dolor Sit Amet'
	   })
	   
	   myNotification.onclick = () => {
			console.log('Notification clicked')
	   }
    };
    var handleNotification = function(event) {
        var title ="aa",
            message = "aaa";
        createNotification(title, message)
    };
    // var notifyButton = document.getElementById("abcdddd");
    // notifyButton.addEventListener("click", handleNotification);
// })();


// ipcRenderer.on('actionNotfyi', (event, data) => {
// 	handleNotification;
// })



// const add = createNotification("aa","bb");
function add(){
    console.log("afadfasdfasdf");
}
 
module.exports = {
 	add
 };
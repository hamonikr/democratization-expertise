const notifier = require('node-notifier')
const path = require('path');
// notifier.notify({
//   title: 'My awesome title',
//   message: 'Hello from node, Mr. User!',
//   icon: path.join(__dirname, 'coulson.jpg'), // Absolute path (doesn't work on balloons)
//   sound: true, // Only Notification Center or Windows Toasters
//   wait: true // Wait with callback, until user action is taken against notification
// }, function (err, response) {
//   // Response is response from notification
// });
// notifier.on('click', function(notifierObj, options) {
//     // Triggers if `wait: true` and user clicks notification
//     console.log('The user clicked on the Notification!');
//   });


// var open = require('open');

// notifier.notify({
//   title: 'Notification',
//   message: 'Hello World',
//   sound: true,
//   wait: true
// }
// // , function () {
// //   open('https://www.google.com');
// // }
// );

notifier
  .notify({ message: 'Hello', wait: true }, function(err, data) {
    // Will also wait until notification is closed.
    console.log('Waited');
    console.log(err, data);
  })
  .on('click', function() {
    console.log("arguments"+ arguments);
  });
  
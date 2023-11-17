importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

   /*Update with yours config*/
  const firebaseConfig = {
   apiKey: 'AIzaSyCkrHxtomQxJJ9R7DCIyx6kUE8Yk0UbNs0',
       appId: '1:840436675517:web:c24827fba2955b742858d4',
       messagingSenderId: '840436675517',
       projectId: 'diwali-rnd-90ab3',
       authDomain: 'diwali-rnd-90ab3.firebaseapp.com',
       storageBucket: 'diwali-rnd-90ab3.appspot.com',
       measurementId: 'G-XTEHV1RHJY',
 };
  firebase.initializeApp(firebaseConfig);
  const messaging = firebase.messaging();

  /*messaging.onMessage((payload) => {
  console.log('Message received. ', payload);*/
  messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });
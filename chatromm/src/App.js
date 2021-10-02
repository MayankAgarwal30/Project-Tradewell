//imports
//import logo from './logo.svg';
import './App.css';
import React, { useRef, useState } from "react";

//firebase imports
import firebase from 'firebase/app';
import 'firebase/firestore';
import 'firebase/auth';
import 'firebase/analytics';
//function imports of firebase
import { useAuthState } from 'react-firebase-hooks/auth';
import { useCollectionData } from 'react-firebase-hooks/firestore';
import reportWebVitals from './reportWebVitals';


firebase.initializeApp({
  // your firebase config
  apiKey: "AIzaSyBHMavbmvI6IKYKdQN_pO6A4KZCG-vTjx0",
  authDomain: "webchat-65de0.firebaseapp.com",
  projectId: "webchat-65de0",
  storageBucket: "webchat-65de0.appspot.com",
  messagingSenderId: "454032400697",
  appId: "1:454032400697:web:8383997cb5e7f6152c88e8",
  measurementId: "G-J8MESJE1RH"
})
// firebase declaraton
const auth = firebase.auth();
const firestore = firebase.firestore();
//const analytics = firebase.analytics();




//terminal commands to use 
//$ npx create-react-app APPnAME
//$code APPnAME
//$npm install
//$npm install firebase react-firebase-hooks
//$ modify app.js

// create firebase project 
// create firestore 

// firebase auth code 
// rules_version = '2';
// service cloud.firestore {
//   match /databases/{database}/documents {
    
//     match /{document=**} {
//       allow read, write: if false;
//     }
    
//     match /messages/{docId}{
//     allow read: if request.auth.uid != null;
//     allow create: if canCreateMessage();
//     }
    
//     function canCreateMessage() {
//     let isSignedIn = request.auth.uid != null;
//     let isOwner = request.auth.uid == request.resource.data.uid;
    
//     let isNotBanned = exists(
//     /database/$(database)/documents/banned/$(request.auth.uid)
//     ) == false;
    
//     return isSignedIn && isOwner && isNotBanned;
    
//     }
    
    
//   }
// }

//modify app.css



//$firebase init functions
//$cd functions
//$npm i bad-words

// modify functions/index.js

//$firebase deploy --only functions

// host to github pages
// version check
// $ node --version
// v6.10.1
// $ npm --version
// 3.10.10
// $ create-react-app --version
// 1.3.1
// or 
// $ sed --version
// sed (GNU sed) 4.4

// configure
// create a repo
// $ create-react-app react-gh-pages
// $ cd react-gh-pages
// $ npm install gh-pages --save-dev

// add to package.json
// //...
// "homepage": "http://gitname.github.io/react-gh-pages"
// "scripts": {
//   //...
//   "predeploy": "npm run build",
//   "deploy": "gh-pages -d build"
// }

// or
// $ sed -i '5i\  "homepage": "http://gitname.github.io/react-gh-pages",' ./package.json
// $ sed -i '15i\    "predeploy": "npm run build",' ./package.json
// $ sed -i '16i\    "deploy": "gh-pages -d build",' ./package.json

// create repo 
// $ git init
// Initialized empty Git repository in C:/path/to/react-gh-pages/.git/
// $ git remote add origin https://github.com/gitname/react-gh-pages.git
// $ npm run deploy

// commit 
// $ git add .
// $ git commit -m "Create a React app and publish it to GitHub Pages"
// $ git push origin master


//main
function App() {
  //auth construction
  const [user] = useAuthState(auth);

  return (
    <div className="App">
      <header>
        <h1>⚛️🔥💬</h1>
        <SignOut />
      </header>

     { /* check if useAuthState is logged in or not */}

      <section>
        {user ? <ChatRoom /> : <SignIn />}
      </section>

    </div>
  );
}

// signin function
function SignIn() {
    // signIn
  const signInWithGoogle = () => {
    const provider = new firebase.auth.GoogleAuthProvider();
    auth.signInWithPopup(provider);
  }

  return (
    <>
      <button className="sign-in" onClick={signInWithGoogle}>Sign in with Google</button>
      <p>Do not violate the community guidelines or you will be banned until i wish to unban !</p>
    </>
  )

}

//sign out function

function SignOut() {
  return auth.currentUser && (
    <button className="sign-out" onClick={() => auth.signOut()}>Sign Out</button>
  )
}


//chatroom

function ChatRoom() {
  //scroll ke liye
  const dummy = useRef();
  // message integrity
  const messagesRef = firestore.collection('messages');
  const query = messagesRef.orderBy('createdAt').limit(25);

  const [messages] = useCollectionData(query, { idField: 'id' });

  const [formValue, setFormValue] = useState('');

// message bhejne ke liye
  const sendMessage = async (e) => {
    e.preventDefault();
  // user ki photo dalne ke liye
    const { uid, photoURL } = auth.currentUser;
    // firebase pe text update 
    await messagesRef.add({
      text: formValue,
      createdAt: firebase.firestore.FieldValue.serverTimestamp(),
      uid,
      photoURL
    })
      // scroll function ke liye
    setFormValue('');
    dummy.current.scrollIntoView({ behavior: 'smooth' });
  }

    //page layout aur ui 

  return (<>
    <main>

      {messages && messages.map(msg => <ChatMessage key={msg.id} message={msg} />)}

      <span ref={dummy}></span>

    </main>

    <form onSubmit={sendMessage}>

      <input value={formValue} onChange={(e) => setFormValue(e.target.value)} placeholder="say something nice" />

      <button type="submit" disabled={!formValue}>🕊️</button>

    </form>
  </>)
}


// aur thora ui

function ChatMessage(props) {
  const { text, uid, photoURL } = props.message;

  const messageClass = uid === auth.currentUser.uid ? 'sent' : 'received';


  return (<>
    <div className={`message ${messageClass}`}>
      <img src={photoURL || 'https://api.adorable.io/avatars/23/abott@adorable.png'} />
      <p>{text}</p>
    </div>
  </>)
}


export default App;

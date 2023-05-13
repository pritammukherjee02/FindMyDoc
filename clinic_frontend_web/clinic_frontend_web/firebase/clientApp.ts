// Import the functions you need from the SDKs you need
import { initFirestore } from "@next-auth/firebase-adapter"
import { initializeApp } from "firebase/app"
// var admin = require("firebase-admin")
import { getFirestore, initializeFirestore } from "firebase/firestore"

var serviceAccount = require("../service.json")

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
	apiKey: "AIzaSyCvpITFb55XU8mQ3T7fIzoXRtItz_wruGk",
	authDomain: "find-my-doc-app.firebaseapp.com",
	projectId: "find-my-doc-app",
	storageBucket: "find-my-doc-app.appspot.com",
	messagingSenderId: "957926978125",
	appId: "1:957926978125:web:97bb3624143eb8cc596204",
	measurementId: "G-S2H0VGH9Y7",
}

// Initialize Firebase
export const app = initializeApp(firebaseConfig)

export const initFirebaseApp = () => {
	return app
}

// Initialize Firestore
// export const db = initFirestore({
// 	credential: admin.credential.cert(serviceAccount),
// })

export const client_db = initializeFirestore(app, {})
export const db = getFirestore(app)

import React from "react"
import { Inter } from "next/font/google"
import { NextPage } from "next"
import { signInWithPopup, GoogleAuthProvider, getAuth } from "firebase/auth"

import { initFirebaseApp } from "../../../firebase/clientApp"

const Auth: NextPage = () => {
	const app = initFirebaseApp()
	const provider = new GoogleAuthProvider()
	const auth = getAuth()

	const signIn = async () => {
		const result = await signInWithPopup(auth, provider)
		console.log(result.user)
	}

	return (
		<div>
			<button onClick={signIn}>Sign in with Google</button>
		</div>
	)
}

export default Auth

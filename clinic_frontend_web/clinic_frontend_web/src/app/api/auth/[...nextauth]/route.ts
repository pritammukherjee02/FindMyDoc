import NextAuth from "next-auth"
import GoogleProvider from "next-auth/providers/google"
import { FirestoreAdapter } from "@next-auth/firebase-adapter"

import { db } from "../../../../../firebase/clientApp"
import { collection, doc, getDoc, setDoc } from "@firebase/firestore"

const handler = NextAuth({
	// adapter: FirestoreAdapter(db),
	providers: [
		GoogleProvider({
			clientId: process.env.GOOGLE_CLIENT_ID!,
			clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
		}),
		// ...add more providers here
	],
	pages: {
		// signIn: "/login",
	},
	callbacks: {
		async signIn(params) {
			const { email, id, image, name } = params.user
			// const usersRef = db.collection("clinic_users")
			// const docRef = usersRef.doc(email!)
			// const userRef = await docRef.get()
			// if (!userRef.exists) {
			// 	try {
			// 		await docRef.set({
			// 			name: name,
			// 			email: email,
			// 			uid: id,
			// 			image: image,
			// 			type: "clinic",
			// 		})
			// 	} catch (error) {
			// 		console.log(
			// 			"Error encountered while creating user at database: ",
			// 			error
			// 		)
			// 	}
			// }

			const docRef = doc(db, `clinic_users/${email}`)
			const userDoc = await getDoc(docRef)
			if (!userDoc.exists) {
				try {
					await setDoc(
						docRef,
						{
							name: name,
							email: email,
							uid: id,
							image: image,
							type: "clinic",
						},
						{ merge: true }
					)
				} catch (error) {
					console.log(
						"Error encountered while creating user at database: ",
						error
					)
				}
			}

			return true
		},
	},
})

export { handler as GET, handler as POST }

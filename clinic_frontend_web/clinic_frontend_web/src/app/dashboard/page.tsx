"use client"

import Image from "next/image"
import { Inter } from "next/font/google"
import { useSession } from "next-auth/react"
import { redirect } from "next/navigation"

// Components
import Sidebar from "../../components/Sidebar"

const inter = Inter({ subsets: ["latin"] })

export default function Home() {
	const { data: session } = useSession({
		required: true,
		onUnauthenticated() {
			redirect("/login?callbackurl=/dashboard")
		},
	})

	return (
		<div>
			{/* Body */}
			<div>
				{/* Sidebar for view change */}
				<Sidebar />

				{/* Data View */}
			</div>
		</div>
	)
}

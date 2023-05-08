"use client"

import { Inter } from "next/font/google"
import { useSession } from "next-auth/react"
import { redirect } from "next/navigation"

// Components
import Sidebar from "../../../components/Sidebar"

const inter = Inter({ subsets: ["latin"] })

function AppointmentsPage() {
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
				<Sidebar activePage="Appointments" />

				{/* Data View */}
			</div>
		</div>
	)
}

export default AppointmentsPage

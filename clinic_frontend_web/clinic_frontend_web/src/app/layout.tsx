import Header from "@/components/Header"
import "./globals.css"
import { Inter } from "next/font/google"

import Provider from "../components/provider"

const inter = Inter({ subsets: ["latin"] })

export const metadata = {
	title: "Find My Doc | Dashboard",
	description:
		"Manaage your doctors and appointments right from the equipped dashboard of Find My Doc. Reach thousands of customers around you",
}

export default function RootLayout({
	children,
}: {
	children: React.ReactNode
}) {
	return (
		<html lang="en">
			<body className={inter.className}>
				<Provider>
					{/* The Header will be visible across the entire application */}
					{/* The Header should automatically reflect the Auth state */}
					<Header />

					<main className="flex min-h-screen">{children}</main>
				</Provider>
			</body>
		</html>
	)
}

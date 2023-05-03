import "./globals.css"
import { Inter } from "next/font/google"

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
			<body className={inter.className}>{children}</body>
		</html>
	)
}

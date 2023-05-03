import Image from "next/image"
import { Inter } from "next/font/google"

// Components
import Header from "@/components/Header"

const inter = Inter({ subsets: ["latin"] })

export default function Home() {
	return (
		<div>
			{/* Header */}
			<Header />

			{/* Body */}
			<main className="flex min-h-screen"></main>
		</div>
	)
}

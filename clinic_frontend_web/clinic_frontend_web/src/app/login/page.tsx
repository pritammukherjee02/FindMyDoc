"use client"

import { signIn } from "next-auth/react"
import Image from "next/image"
import { useSearchParams } from "next/navigation"

function LoginPage() {
	// const [] = useSearchParams()
	return (
		<div className="flex min-h-full min-w-full">
			<div className="flex flex-col mt-28 w-1/3 h-1/2 rounded-2xl mx-auto p-4 bg-gray-100 drop-shadow-sm">
				<div className="border-b-2 flex flex-col justify-evenly h-1/3">
					<h2 className="text-2xl font-semibold text-gray-600">
						<span className="text-blue-500">Dashboard</span> |
						Authentication
					</h2>

					<p className="mt-2 mb-4 text-sm text-gray-500">
						Login using your clinic's Google Account
					</p>
				</div>

				<div className="flex items-center h-2/3 justify-center">
					<div
						onClick={() =>
							signIn("google", { callbackUrl: "/dashboard" })
						}
						className="flex h-16 bg-gray-800 opacity-95 rounded-2xl px-8 p-5 cursor-pointer"
					>
						{/* Google Logo login */}
						<Image
							alt="Google Logo"
							width={25}
							height={40}
							src="/google.png"
						/>

						{/* Sign in text */}
						<p className="text-gray-200 pl-3">
							Sign in with Google
						</p>
					</div>
				</div>
			</div>
		</div>
	)
}

export default LoginPage

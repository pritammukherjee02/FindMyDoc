"use client"

import React, { useState } from "react"
import HeaderIcon from "./HeaderIcon"
import Image from "next/image"

import {
	BellIcon,
	ChevronDownIcon,
	ArrowRightOnRectangleIcon,
} from "@heroicons/react/24/solid"
import { signIn, signOut, useSession } from "next-auth/react"
import { redirect } from "next/navigation"

function Header(): JSX.Element {
	const { data: session } = useSession()

	return (
		<div className="flex justify-between sticky top-0 z-50 h-7 lg:h-14 bg-[#D6DBDC] items-center p-1 px-3 lg:px-5 shadow-md">
			{/* Branding */}
			<h1 className="text-lg sm:text-2xl text-blue-600 font-medium">
				Find My Doc |{" "}
				<span className="text-sm text-gray-500">Clinic Dashboard</span>
			</h1>

			{/* Controls */}
			{session ? (
				<div className="flex items-center space-x-4 md:space-x-2">
					{/* Notifications */}
					<HeaderIcon Icon={BellIcon} />

					{/* Clinic selection */}
					<div className="flex items-center bg-gray-300 cursor-pointer justify-between h-7 lg:h-10 p-3 rounded-full hover:bg-gray-200 ">
						<ChevronDownIcon className="h-5" />
						<p className="text-semibold pl-2 whitespace-nowrap">
							Clinic Name
						</p>
					</div>

					{/* Profile Picture */}
					<NavbarProfileDropDown />
				</div>
			) : (
				<button
					className="cursor-pointer text-blue-500"
					onClick={() => redirect("/login?callbackurl=/dashboard")}
				>
					<HeaderIcon
						Icon={ArrowRightOnRectangleIcon}
						caption="Login"
					/>
				</button>
			)}
		</div>
	)
}

function NavbarProfileDropDown() {
	const { data: session } = useSession()
	const [open, setOpen] = useState(false)

	return session ? (
		<div className="relative flex flex-col items-end">
			<Image
				className="rounded-full cursor-pointer"
				src={session.user?.image!}
				alt="PFP"
				width={40}
				height={40}
				onClick={() => setOpen((current) => !current)}
			/>

			{/* Dropdown */}
			{open && (
				<div className="absolute z-50 w-[300px] p-3 bg-gray-100 drop-shadow-sm rounded-xl top-14">
					{/* Proile picture and Account name */}
					<div className="flex space-x-2 items-center w-full h-9 cursor-default mb-3">
						<Image
							className="rounded-full cursor-pointer"
							src={session.user?.image!}
							alt="PFP"
							width={36}
							height={36}
						/>

						<div className="flex flex-col text-sm text-gray-600">
							<p className="font-semibold">
								{session.user?.name}
							</p>
							<p className="font-light text-xs">
								{session.user?.email}
							</p>
						</div>
					</div>

					<hr />

					{/* Sign Out Action button */}
					<div
						onClick={() => signOut()}
						className="flex space-x-2 mt-2 items-center p-1 py-4 w-full h-7 cursor-pointer rounded-lg hover:bg-gray-200 hover:text-blue-600"
					>
						<ArrowRightOnRectangleIcon className="h-5 text-center" />

						<p className="text-sm">Sign Out</p>
					</div>
				</div>
			)}
		</div>
	) : (
		<div></div>
	)
}

export default Header

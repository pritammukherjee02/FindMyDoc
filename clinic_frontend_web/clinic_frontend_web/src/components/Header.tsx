import React from "react"
import HeaderIcon from "./HeaderIcon"

import { BellIcon, ChevronDownIcon } from "@heroicons/react/24/solid"

function Header(): JSX.Element {
	return (
		<div className="flex justify-between sticky top-0 z-50 bg-[rgb(214, 219, 220)] items-center p-1 lg:px-5 shadow-md">
			{/* Branding */}
			<h1 className="text-2xl text-blue-600 font-medium">
				Find My Doc |{" "}
				<span className="text-sm text-gray-500">Clinic Dashboard</span>
			</h1>

			{/* Controls */}
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
			</div>
		</div>
	)
}

export default Header

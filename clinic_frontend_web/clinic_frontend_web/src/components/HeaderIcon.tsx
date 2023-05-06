import React from "react"

function HeaderIcon({ Icon, active, caption }: any) {
	return (
		<div className="flex items-center space-x-1 cursor-pointer h-10 md:px-6 sm:h-14 md:hover:bg-gray-300 rounded-xl group">
			<Icon
				className={`h-5 text-center sm:h-6 mx-auto group-hover:text-blue-600 ${
					active ? "text-blue-600" : "text-gray-500"
				}`}
			/>

			{caption && (
				<p className="mx-auto text-gray-500 group-hover:text-blue-600">
					{caption}
				</p>
			)}
		</div>
	)
}

export default HeaderIcon

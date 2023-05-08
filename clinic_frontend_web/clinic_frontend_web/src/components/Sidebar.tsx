import {
	QueueListIcon,
	UserGroupIcon,
	CalendarDaysIcon,
	PencilSquareIcon,
} from "@heroicons/react/24/solid"
import Link from "next/link"

function Sidebar({ activePage }: { activePage: String }) {
	return (
		<div className="flex flex-col space-y-2 p-2 mt-5 max-w-[600px] xl:min-w-[250px]">
			<SidebarRow
				active={activePage == "Appointments"}
				Icon={QueueListIcon}
				title="Appointments"
				onClickUrl="/dashboard/appointments"
			/>
			<SidebarRow
				active={activePage == "Calendar"}
				Icon={CalendarDaysIcon}
				title="Calendar"
				onClickUrl="/dashboard/calendar"
			/>
			<SidebarRow
				active={activePage == "Doctors"}
				Icon={UserGroupIcon}
				title="Doctors"
				onClickUrl="/dashboard/doctors"
			/>
			<SidebarRow
				active={activePage == "Clinic Information"}
				Icon={PencilSquareIcon}
				title="Clinic Information"
				onClickUrl="/dashboard/clinic_information"
			/>
		</div>
	)
}

// For each button/row in the Sidebar
function SidebarRow({
	Icon,
	title,
	active,
	onClickUrl,
}: {
	Icon: any
	title: String
	active: boolean
	onClickUrl: string
}) {
	return (
		<Link href={onClickUrl}>
			<div
				className={`flex items-center space-x-3 ${
					active && "bg-gray-300 text-blue-600"
				} hover:bg-gray-300 rounded-full cursor-pointer p-4`}
			>
				<Icon
					className={`h-6 ${
						active ? "text-blue-600" : "text-gray-500"
					}`}
				/>

				<p
					className={`hidden sm:inline-flex font-medium ${
						active ? "text-blue-600" : "text-gray-500"
					}`}
				>
					{title}
				</p>
			</div>
		</Link>
	)
}

export default Sidebar

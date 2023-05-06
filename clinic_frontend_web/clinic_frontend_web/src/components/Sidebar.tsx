import {
	QueueListIcon,
	UserGroupIcon,
	CalendarDaysIcon,
	PencilSquareIcon,
} from "@heroicons/react/24/solid"

function Sidebar() {
	return (
		<div className="flex flex-col space-y-2 p-2 mt-5 max-w-[600px] xl:min-w-[250px]">
			<SidebarRow Icon={QueueListIcon} title="Appointments" />
			<SidebarRow Icon={CalendarDaysIcon} title="Calendar" />
			<SidebarRow Icon={UserGroupIcon} title="Doctors" />
			<SidebarRow Icon={PencilSquareIcon} title="Clinic Information" />
		</div>
	)
}

// For each button/row in the Sidebar
function SidebarRow({ Icon, title }: { Icon: any; title: String }) {
	return (
		<div className="flex items-center space-x-3 hover:bg-gray-300 rounded-full cursor-pointer p-4">
			<Icon className="h-6 text-gray-500" />

			<p className="hidden sm:inline-flex font-medium text-gray-500">
				{title}
			</p>
		</div>
	)
}

export default Sidebar

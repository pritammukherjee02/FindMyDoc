"use client"

import { Inter } from "next/font/google"
import { useSession } from "next-auth/react"
import { redirect } from "next/navigation"
import { client_db, db } from "../../../../firebase/clientApp"
import { collection, doc, getDoc, setDoc } from "firebase/firestore"

// Components
import Sidebar from "../../../components/Sidebar"

const inter = Inter({ subsets: ["latin"] })

export default function Home() {
	const { data: session } = useSession({
		required: true,
		onUnauthenticated() {
			redirect("/login?callbackurl=/dashboard")
		},
	})

	async function saveClinicInformation(e: any) {
		e.preventDefault()
		const data = new FormData(e.target)

		// await db
		// 	.collection("clinics")
		// 	.doc(session!.user!.email!)
		// 	.set({
		// 		name: data.get("clinic_name"),
		// 		description: data.get("clinic_description"),
		// 		days_open: [
		// 			{
		// 				name: "Monday",
		// 				open: data.get("days_open_monday") != null,
		// 			},
		// 			{
		// 				name: "Tuesday",
		// 				open: data.get("days_open_tuesday") != null,
		// 			},
		// 			{
		// 				name: "Wednesday",
		// 				open: data.get("days_open_wednesday") != null,
		// 			},
		// 			{
		// 				name: "Thursday",
		// 				open: data.get("days_open_thursday") != null,
		// 			},
		// 			{
		// 				name: "Friday",
		// 				open: data.get("days_open_friday") != null,
		// 			},
		// 			{
		// 				name: "Saturday",
		// 				open: data.get("days_open_saturday") != null,
		// 			},
		// 			{
		// 				name: "Sunday",
		// 				open: data.get("days_open_sunday") != null,
		// 			},
		// 		],
		// 	})

		await setDoc(
			doc(db, `clinics/${session?.user?.email}`),
			{
				name: data.get("clinic_name"),
				description: data.get("clinic_description"),
				days_open: [
					{
						name: "Monday",
						open: data.get("days_open_monday") != null,
					},
					{
						name: "Tuesday",
						open: data.get("days_open_tuesday") != null,
					},
					{
						name: "Wednesday",
						open: data.get("days_open_wednesday") != null,
					},
					{
						name: "Thursday",
						open: data.get("days_open_thursday") != null,
					},
					{
						name: "Friday",
						open: data.get("days_open_friday") != null,
					},
					{
						name: "Saturday",
						open: data.get("days_open_saturday") != null,
					},
					{
						name: "Sunday",
						open: data.get("days_open_sunday") != null,
					},
				],
			},
			{ merge: true }
		)

		// db.doc(`clinics/${session?.user?.email}`).get()
	}

	return (
		<div className="w-full h-screen flex">
			{/* Sidebar for view change */}
			<Sidebar activePage="Clinic Information" />

			{/* Data View */}
			<div className="h-full w-full p-2 flex justify-center overflow-x-auto">
				<div className="p-2 border-black mt-5 flex flex-col items-start max-w-[1200px] md:min-w-[600] lg:min-w-[800px] xl:min-w-[1100px]">
					<h2 className="text-3xl font-bold">Public Information</h2>
					<p className="text-sm font-light mt-2">
						The information you provide will appear as the 'About'
						of your clinic. Make sure to give accurate information.
					</p>

					{/* Information bundle Div */}
					<form
						onSubmit={saveClinicInformation}
						className="flex flex-col space-y-2 p-3 mt-6 bg-gray-100 drop-shadow-sm rounded-xl w-full"
					>
						{/* Clinic's name */}
						<FormTextInputWithLabel
							labelText="Clinic Name:"
							name="clinic_name"
							required
						/>

						{/* Clinic's Description */}
						<FormMultilineInputWithLabel
							labelText="Description:"
							helperText="Describe the services your clinic provides"
							name="clinic_description"
						/>

						{/* Days open */}
						<DayPicker labelText="Days open:" name="days_open" />

						{/* Openning time */}
						<TimePicker
							labelText="Openning Time:"
							name="openning_time"
						/>

						{/* Closing time */}
						<TimePicker
							labelText="Closing Time:"
							name="closing_time"
						/>

						{/* Save Button */}
						<div className="flex justify-end p-1">
							<input
								type="submit"
								value="Save"
								className="bg-blue-500 text-white p-2 px-8 rounded-full cursor-pointer hover:bg-blue-700"
							/>
						</div>
					</form>

					{/* Location */}
					<h2 className="text-3xl font-bold mt-10">Location</h2>
					<p className="text-sm font-light mt-2">
						The information you provide will appear as the 'About'
						of your clinic. Make sure to give accurate information.
					</p>
				</div>
			</div>
		</div>
	)
}

function FormTextInputWithLabel({ labelText, name, required }: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 items-center w-full">
			<label
				htmlFor={name}
				className="w-full md:w-[250px] lg:w-[350px] font-medium p-1"
			>
				{labelText}
			</label>

			<input
				type="text"
				required={required}
				name={name}
				className="bg-gray-100 border-2 border-gray-300 rounded-md w-full p-1 active:border active:border-blue-400"
			/>
		</div>
	)
}

function FormMultilineInputWithLabel({ labelText, helperText, name }: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 w-full">
			<div className="flex flex-col w-full md:w-[250px] lg:w-[350px]">
				<label htmlFor={name} className="w-full font-medium p-1 ">
					{labelText}
				</label>

				<label className="w-full font-light text-xs px-1">
					{helperText}
				</label>
			</div>

			<textarea
				name={name}
				className="bg-gray-100 border-2 border-gray-300 rounded-md w-full p-1 active:border active:border-blue-400"
			/>
		</div>
	)
}

function TimePicker({ labelText, name, required }: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 items-center w-full">
			<label className="w-full md:w-[260px] font-medium p-1">
				{labelText}
			</label>

			<div className="inline-flex text-md bg-gray-100 border-2 border-gray-300 rounded-md p-2">
				<select
					name={`{${name}_hour}`}
					id={`{${name}_hour}`}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					<option value="12">12</option>
					<option value="01">01</option>
					<option value="02">02</option>
					<option value="03">03</option>
					<option value="04">04</option>
					<option value="05">05</option>
					<option value="06">06</option>
					<option value="07">07</option>
					<option value="08">08</option>
					<option value="09">09</option>
					<option value="10">10</option>
					<option value="11">11</option>
				</select>
				<span className="px-2">:</span>
				<select
					name={`{${name}_minute}`}
					id={`{${name}_minute}`}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					{Array.from({ length: 60 }, (_, i) => {
						const value = i.toString().padStart(2, "0")
						return (
							<option key={value} value={value}>
								{value}
							</option>
						)
					})}
				</select>
				<select
					name={`{${name}_am/pm}`}
					id={`{${name}_am/pm}`}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					<option value="AM">AM</option>
					<option value="PM">PM</option>
				</select>
			</div>
		</div>
	)
}

function DayPicker({ labelText, name, required }: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 md:items-center w-full">
			<label className="w-full md:w-[250px] lg:w-[350px] font-medium p-1">
				{labelText}
			</label>

			<div className="flex flex-col md:flex-row flex-wrap w-full">
				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_monday`}
							name={`${name}_monday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_monday`}
							className="ml-2 text-sm font-medium"
						>
							Monday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_tuesday`}
							name={`${name}_tuesday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_tuesday`}
							className="ml-2 text-sm font-medium"
						>
							Tuesday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_wednesday`}
							name={`${name}_wednesday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_wednesday`}
							className="ml-2 text-sm font-medium"
						>
							Wednesday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_thursday`}
							name={`${name}_thursday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_thursday`}
							className="ml-2 text-sm font-medium"
						>
							Thursday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_friday`}
							name={`${name}_friday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_friday`}
							className="ml-2 text-sm font-medium"
						>
							Friday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_saturday`}
							name={`${name}_saturday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_saturday`}
							className="ml-2 text-sm font-medium"
						>
							Saturday
						</label>
					</div>
				</div>

				<div className="flex ml-5 md:ml-1">
					<div className="flex items-center mr-4">
						<input
							id={`${name}_sunday`}
							name={`${name}_sunday`}
							type="checkbox"
							className="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 rounded focus:ring-blue-500 focus:ring-2 checked:text-blue-600"
						/>
						<label
							htmlFor={`${name}_sunday`}
							className="ml-2 text-sm font-medium"
						>
							Sunday
						</label>
					</div>
				</div>
			</div>
		</div>
	)
}

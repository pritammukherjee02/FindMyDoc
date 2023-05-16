"use client"

import { Inter } from "next/font/google"
import { useSession } from "next-auth/react"
import { redirect } from "next/navigation"
import { client_db, db } from "../../../../firebase/clientApp"
import { collection, doc, getDoc, setDoc } from "firebase/firestore"
import { useDocument, useDocumentData } from "react-firebase-hooks/firestore"

// Components
import Sidebar from "../../../components/Sidebar"
import { useState } from "react"

const inter = Inter({ subsets: ["latin"] })

interface ClinicData {
	name: String
	description?: String
	days_open?: {
		name: string
		open: boolean
	}[]
	phone_number: Number
	openning_time?: {
		hour: string
		minute: string
		am_pm: string
	}
	closing_time?: {
		hour: string
		minute: string
		am_pm: string
	}
}

function mapClinicData(data: any): ClinicData {
	return {
		...data,
		days_open:
			data &&
			data.days_open &&
			data.days_open.map((day: any) => ({
				...day,
				open: day.open || false,
			})),
	}
}

export default function Home() {
	const { data: session } = useSession({
		required: true,
		onUnauthenticated() {
			redirect("/login?callbackurl=/dashboard")
		},
	})

	const [clinicData, setClinicData] = useState<ClinicData | undefined>()

	// const [value, loading, error, snapshot] = useDocumentData<ClinicData>(
	// 	doc(db, "clinic", session?.user?.email!).withConverter<ClinicData>({
	// 		toFirestore: (data: ClinicData) => data,
	// 		fromFirestore: (snapshot) => snapshot.data() as ClinicData,
	// 	}),
	// 	{
	// 		snapshotListenOptions: { includeMetadataChanges: true },
	// 	}
	// )

	const [value, loading, error] = useDocument(
		doc(db, "clinics", session ? session?.user?.email! : "random"),
		{
			snapshotListenOptions: { includeMetadataChanges: true },
		}
	)
	if (!loading && !error) {
		// Fetched data from Firestore and set into a state
		if (clinicData == undefined) {
			console.log("mapped Clinic Data: ", mapClinicData(value?.data()))
			setClinicData(mapClinicData(value?.data()))
		}
	}

	async function saveClinicInformation(e: any) {
		e.preventDefault()
		const data = new FormData(e.target)

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
				phone_number: data.get("clinic_phone"),
				openning_time: {
					hour: data.get("openning_time_hour"),
					minute: data.get("openning_time_minute"),
					am_pm: data.get("openning_time_am/pm"),
				},
				closing_time: {
					hour: data.get("closing_time_hour"),
					minute: data.get("closing_time_minute"),
					am_pm: data.get("closing_time_am/pm"),
				},
			},
			{ merge: true }
		)

		// db.doc(`clinics/${session?.user?.email}`).get()
	}

	return (
		<div className="w-full h-screen flex overflow-y-hidden">
			{/* Sidebar for view change */}
			<Sidebar activePage="Clinic Information" />

			{/* Data View */}
			<div className="h-full w-full p-2 flex justify-center overflow-x-auto overflow-y-auto">
				<div className="p-2 border-black mt-5 flex flex-col items-start max-w-[1200px] md:min-w-[600] lg:min-w-[800px] xl:min-w-[1100px]">
					<h2 className="text-3xl font-bold">Public Information</h2>
					<p className="text-sm font-light mt-2">
						The information you provide will appear as the 'About'
						of your clinic. Make sure to give accurate information.
					</p>

					{/* Information bundle Div */}
					<form
						onSubmit={saveClinicInformation}
						className="flex flex-col space-y-2 p-3 mt-6 bg-gray-100 drop-shadow-md rounded-xl w-full"
					>
						{/* Clinic's name */}
						<FormTextInputWithLabel
							labelText="Clinic Name:"
							name="clinic_name"
							required
							value={clinicData?.name}
						/>

						{/* Clinic's Description */}
						<FormMultilineInputWithLabel
							labelText="Description:"
							helperText="Describe the services your clinic provides"
							name="clinic_description"
							value={clinicData?.description}
						/>

						{/* Phone Number */}
						<FormTextInputWithLabel
							labelText="Phone Number:"
							name="clinic_phone"
							required
							type="number"
							value={clinicData?.phone_number}
						/>

						{/* Days open */}
						<DayPicker
							labelText="Days open:"
							name="days_open"
							values={clinicData?.days_open}
						/>

						{/* Openning time */}
						<TimePicker
							labelText="Openning Time:"
							name="openning_time"
							data={clinicData?.openning_time}
						/>

						{/* Closing time */}
						<TimePicker
							labelText="Closing Time:"
							name="closing_time"
							data={clinicData?.closing_time}
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

function FormTextInputWithLabel({
	labelText,
	name,
	required,
	type,
	value,
}: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 items-center w-full">
			<label
				htmlFor={name}
				className="w-full md:w-[250px] lg:w-[350px] font-medium p-1"
			>
				{labelText}
			</label>

			<input
				type={type ? type : "text"}
				required={required}
				name={name}
				defaultValue={value}
				className="bg-gray-100 border-2 border-gray-300 rounded-md w-full p-1 active:border active:border-blue-400"
			/>
		</div>
	)
}

function FormMultilineInputWithLabel({
	labelText,
	helperText,
	name,
	value,
}: any) {
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
				defaultValue={value}
				className="bg-gray-100 border-2 border-gray-300 rounded-md w-full p-1 active:border active:border-blue-400"
			/>
		</div>
	)
}

function TimePicker({ labelText, name, data }: any) {
	return (
		<div className="flex flex-col md:flex-row p-1 space-y-2 md:space-x-3 items-center w-full">
			<label className="w-full md:w-[260px] font-medium p-1">
				{labelText}
			</label>

			<div className="inline-flex text-md bg-gray-100 border-2 border-gray-300 rounded-md p-2">
				<select
					name={`${name}_hour`}
					id={`${name}_hour`}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					<option selected={data?.hour == "12"} value="12">
						12
					</option>
					<option selected={data?.hour == "01"} value="01">
						01
					</option>
					<option selected={data?.hour == "02"} value="02">
						02
					</option>
					<option selected={data?.hour == "03"} value="03">
						03
					</option>
					<option selected={data?.hour == "04"} value="04">
						04
					</option>
					<option selected={data?.hour == "05"} value="05">
						05
					</option>
					<option selected={data?.hour == "06"} value="06">
						06
					</option>
					<option selected={data?.hour == "07"} value="07">
						07
					</option>
					<option selected={data?.hour == "08"} value="08">
						08
					</option>
					<option selected={data?.hour == "09"} value="09">
						09
					</option>
					<option selected={data?.hour == "10"} value="10">
						10
					</option>
					<option selected={data?.hour == "11"} value="11">
						11
					</option>
				</select>
				<span className="px-2">:</span>
				<select
					name={`${name}_minute`}
					id={`${name}_minute`}
					defaultValue={data?.minute}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					{Array.from({ length: 60 }, (_, i) => {
						const value = i.toString().padStart(2, "0")
						return (
							<option
								selected={data?.minute == value}
								key={value}
								value={value}
							>
								{value}
							</option>
						)
					})}
				</select>
				<select
					name={`${name}_am/pm`}
					id={`${name}_am/pm`}
					className="px-2 outline-none appearance-none bg-transparent"
				>
					<option selected={data?.am_pm == "AM"} value="AM">
						AM
					</option>
					<option selected={data?.am_pm == "PM"} value="PM">
						PM
					</option>
				</select>
			</div>
		</div>
	)
}

function DayPicker({ labelText, name, values }: any) {
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
							defaultChecked={values ? values[0].open : false}
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
							defaultChecked={values ? values[1].open : false}
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
							defaultChecked={values ? values[2].open : false}
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
							defaultChecked={values ? values[3].open : false}
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
							defaultChecked={values ? values[4].open : false}
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
							defaultChecked={values ? values[5].open : false}
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
							defaultChecked={values ? values[6].open : false}
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

export async function POST(request: Request) {
	var formData = request.formData // Gets all the data that was submitted in the form
	console.log(formData.toString)
	return new Response()
}

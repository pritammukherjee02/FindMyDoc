export async function GET(request: Request) {
	console.log("Received a GET req to api/hello")
	return new Response("Hello, Next.js!")
}

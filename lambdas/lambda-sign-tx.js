await fetch(new Request("https://cloudflare-eth.com", {
	method: "POST",
	body: JSON.stringify({
		"jsonrpc":"2.0",
		"method":"eth_sendRawTransaction",
		"params":["0xd46e8dd67c5d32be8d46e8dd67c5d32be8058bb8eb970870f072445675058bb8eb970870f072445675", true],
		"id":1
	}),
	headers: {
		"Content-Type": "application/json"
	}
})).then((resp) => {
	return resp.json()
});

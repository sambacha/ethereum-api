await fetch(new Request("https://cloudflare-eth.com", {
	method: "POST",
	body: JSON.stringify({
		"jsonrpc":"2.0",
		"method":"eth_getBlockByNumber",
		"params":["0x2244", true],
		"id":64
	}),
	headers: {
		"Content-Type": "application/json"
	}
})).then((resp) => {
	return resp.json()
});

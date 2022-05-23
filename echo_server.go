package main

import (
	"fmt"
	"net/http"
	"os"
)

func handler(response http.ResponseWriter, request *http.Request) {
	response.Write([]byte(request.RequestURI[1:]))
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: go run echo_server.go <port>")
		os.Exit(1)
	}
	port := os.Args[1]
	fmt.Println("Echo server listening on port:", port)
	http.HandleFunc("/", handler)
	http.ListenAndServe(":"+port, nil)
}

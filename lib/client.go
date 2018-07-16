/*
 vim:set ts=4 fenc=utf-8:
*/

package main

import (
	"C"
	"github.com/aws/aws-lambda-go/lambda/messages"
	"log"
	"strconv"
	"net/rpc"
)

//export invoke
func invoke(port int, ctx *C.char, event *C.char) *C.char {

	client, err := rpc.Dial("tcp", "localhost:" + strconv.Itoa(port))
	if err != nil {
		log.Fatal("dialing:", err)
	}

	req := &messages.InvokeRequest{Payload: []byte(C.GoString(event))}
	res := messages.InvokeResponse{}

	_err := client.Call("Function.Invoke", req, &res)

	if _err != nil {
		log.Fatal(_err)
	}
	//log.Printf("Invoke: %v\n", string(res.Payload))
	return C.CString(string(res.Payload))
}

func init() { }
func main() { }

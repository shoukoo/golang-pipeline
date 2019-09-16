package main

import (
	"fmt"
	"test-project/test"
)

func main() {
	result := test.Add(1, 2)
	fmt.Printf("result: %+v", result)
}

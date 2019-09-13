package main

import (
	"fmt"
	"strconv"
	"test-project/test"
)

func main() {
	fmt.Println("vim-go")
	test.Add(1, 2)
	_, err := strconv.ParseBool("true")
	if err != nil {
		fmt.Println("error found")
	}
	_, err = strconv.ParseBool("false")

	err = TestFunc()
}

// Hllo world
func TestFunc() error {
	fmt.Println("Hello Wrld")
	return nil
}

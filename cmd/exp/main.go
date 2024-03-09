package main

import (
	"html/template"
	"os"
)

type User struct {
	Name string
	Bio  string
	Age  int
}

func main() {
	t, err := template.ParseFiles("hello.gohtml")
	if err != nil {
		panic(err)
	}

	user := User{
		Name: "Elijah XZG",
		Bio:  `<script>alert("Ha ha, you've been hacked!");</script>`,
		Age:  30,
	}

	err = t.Execute(os.Stdout, user)
	if err != nil {
		panic(err)
	}
}

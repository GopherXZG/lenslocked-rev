package controllers

import (
	"net/http"

	"github.com/GopherXZG/lenslocked-rev/views"
)

type Users struct {
	Templates struct {
		New views.Template
	}
}

func (u Users) New(w http.ResponseWriter, r *http.Request) {
	u.Templates.New.Execute(w, nil)
}

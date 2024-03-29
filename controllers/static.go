package controllers

import (
	"html/template"
	"net/http"

	"github.com/GopherXZG/lenslocked-rev/views"
)

func StaticHandler(tpl views.Template) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		tpl.Execute(w, nil)
	}
}

func FAQ(tpl views.Template) http.HandlerFunc {
	questions := []struct {
		Question string
		Answer   template.HTML
	}{
		{
			Question: "Is there a free version?",
			Answer:   "Yes, we offer a free trail for 30 days on any paid plans.",
		},
		{
			Question: "What are your support hours?",
			Answer:   "We have supporting staff answering emails 24/7, though response time may be a bit slower on weekends.",
		},
		{
			Question: "How do I contact support?",
			Answer:   `Email us <a href="mailto:elijahbeyourself@gmail.com">elijahbeyourself@gmail.com</a>.`,
		},
	}
	return func(w http.ResponseWriter, r *http.Request) {
		tpl.Execute(w, questions)
	}
}

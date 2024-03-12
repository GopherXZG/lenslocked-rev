package main

import (
	"fmt"
	"net/http"

	"github.com/GopherXZG/lenslocked-rev/controllers"
	"github.com/GopherXZG/lenslocked-rev/templates"
	"github.com/GopherXZG/lenslocked-rev/views"
	"github.com/go-chi/chi/v5"
)

func main() {
	r := chi.NewRouter()
	r.Get("/", controllers.StaticHandler(views.Must(views.ParseFS(templates.FS, "home.gohtml"))))
	r.Get("/contact", controllers.StaticHandler(views.Must(views.ParseFS(templates.FS, "contact.gohtml"))))
	r.Get("/faq", controllers.StaticHandler(views.Must(views.ParseFS(templates.FS, "contact.gohtml"))))
	r.NotFound(func(w http.ResponseWriter, r *http.Request) {
		http.Error(w, http.StatusText(http.StatusNotFound), http.StatusNotFound)
	})
	fmt.Println("Starting server on :3000...")
	http.ListenAndServe(":3000", r)
}

open Confirm
open Types
open Question_list

(* language array... *)
let languages =
  [
    "Java";
    "C#";
    "C++";
    "C";
    "Python";
    "Ruby";
    "Perl";
    "F#";
    "Ocaml";
    "Haskell";
    "Scala";
    "Go";
    "Rust";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
    "Lisp";
    "Scheme";
    "Racket";
    "Forth";
    "Prolog";
    "Eiffel";
    "Ada";
    "Fortran";
    "Pascal";
    "Basic";
    "Lisp";
    "Smalltalk";
    "Erlang";
    "Elixir";
    "Clojure";
  ]

(* util: *)

let q_option : question =
  {
    name = "languages";
    prompt_type = List;
    message = "Choose your favorite language:";
    choices = string_list_to_choice_list languages;
    page_size = None;
  }

let result_string = list_question 1 q_option;;

print_endline result_string

let confirm_q_option =
  {
    name = "confirm";
    prompt_type = Confirm;
    message = "Are you sure?";
    default = Some true;
  }

(* util: *)
let result = inquirer_confirm confirm_q_option
let () = print_endline (string_of_bool result)

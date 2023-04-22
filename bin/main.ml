open Terminal_util

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

let prevIndex currentIndex listLength =
  match currentIndex with 1 -> listLength | _ -> currentIndex - 1

let next_index currentIndex listLength =
  if currentIndex = listLength then 1 else currentIndex + 1

let get_index current_index nextOrPrev list_length =
  if nextOrPrev then next_index current_index list_length
  else prevIndex current_index list_length

let list_to_string (list : string list) (currentIndex : int)
    (is_pagination : bool) (pagination_index : int) (pagination_length : int) =
  let rec loop list currentIndex index result =
    match list with
    | [] -> result
    | head :: tail ->
        if index = currentIndex then
          loop tail currentIndex (index + 1)
            (result ^ "\027[32m❯ " ^ head ^ "\027[0m\n")
        else loop tail currentIndex (index + 1) (result ^ "  " ^ head ^ "\n")
  in
  print_endline "Choose your favorite language:";
  print_endline "Use arrow keys to navigate, Enter to select.";
  print_endline (loop list currentIndex 1 "") |> ignore;
  if is_pagination then
    print_endline
      ("Page "
      ^ string_of_int (pagination_index + 1)
      ^ " of "
      ^ string_of_int pagination_length)
  else ()

let next_page_list sub_list current_index =
  if current_index + 1 >= List.length sub_list then 0 else current_index + 1

let prev_page_list sub_list current_index =
  if current_index - 1 < 0 then List.length sub_list - 1 else current_index - 1

(* listを1個ずつ->で区切ってprintする関数 *)

(* list_question関数 *)

let rec list_question (num : int) (list : string list) (list_index : int) =
  let selected = ref num in
  let subList = Add.split_every 5 list in

  let is_pagination = List.length subList > 1 in
  let now_list = List.nth subList list_index in

  let key = read_arrow_key () in
  match key with
  | Some "Up" ->
      clear_screen ();
      selected := get_index !selected false (List.length now_list);
      list_to_string now_list !selected is_pagination list_index
        (List.length subList);
      list_question !selected list list_index
  | Some "Left" ->
      clear_screen ();
      let next_list_index = prev_page_list subList list_index in
      let next_list = List.nth subList next_list_index in
      list_to_string next_list !selected is_pagination next_list_index
        (List.length subList);
      list_question !selected list next_list_index
  | Some "Right" ->
      clear_screen ();
      let next_list_index = next_page_list subList list_index in
      let next_list = List.nth subList next_list_index in
      list_to_string next_list !selected is_pagination next_list_index
        (List.length subList);
      list_question !selected list next_list_index
  | Some "Down" ->
      clear_screen ();
      selected := get_index !selected true (List.length now_list);
      list_to_string now_list !selected is_pagination list_index
        (List.length subList);
      list_question !selected list list_index
  | Some "Enter" -> List.nth now_list (!selected - 1)
  | _ -> list_question !selected list list_index
;;

clear_screen ()

let result_string = list_question 1 languages 0;;

print_string result_string

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

let prev_index current_index list_length =
  match current_index with 1 -> list_length | _ -> current_index - 1

let next_index current_index list_length =
  if current_index = list_length then 1 else current_index + 1

let get_index current_index nextOrPrev list_length =
  if nextOrPrev then next_index current_index list_length
  else prev_index current_index list_length

let is_sublist_index_out_of_range sub_list cursor_index =
  cursor_index >= List.length sub_list

let get_pagenation_sublist_cursor sub_list cursor_index =
  if is_sublist_index_out_of_range sub_list cursor_index then 1
  else cursor_index

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

let list_question num list =
  let rec loop index list_index =
    let selected = ref index in
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
        loop !selected list_index
    | Some "Left" ->
        clear_screen ();
        let next_list_index = prev_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        list_to_string next_list !selected is_pagination next_list_index
          (List.length subList);

        loop !selected next_list_index
    | Some "Right" ->
        clear_screen ();
        let next_list_index = next_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        list_to_string next_list !selected is_pagination next_list_index
          (List.length subList);

        print_int !selected;
        loop !selected next_list_index
    | Some "Down" ->
        clear_screen ();
        selected := get_index !selected true (List.length now_list);
        list_to_string now_list !selected is_pagination list_index
          (List.length subList);
        loop !selected list_index
    | Some "Enter" -> List.nth now_list (!selected - 1)
    | _ -> loop !selected list_index
  in
  loop num 0
;;

clear_screen ()

let result_string = list_question 1 languages;;

print_string result_string

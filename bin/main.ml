open Terminal_util

type prompt_type =
  | Input
  | Confirm
  | List
  | Rawlist
  | Expand
  | Checkbox
  | Password
  | Editor

type choice = { word : string; value : string }

type question = {
  name : string;
  prompt_type : prompt_type;
  message : string;
  choices : choice list;
  page_size : int option;
}

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

let list_to_string (list : choice list) (current_index : int)
    (is_pagination : bool) (pagination_index : int) (pagination_length : int)
    messsage =
  let rec loop (list : choice list) current_index index result =
    match list with
    | [] -> result
    | head :: tail ->
        let { word; _ } = head in
        if index = current_index then
          loop tail current_index (index + 1)
            (result ^ "\027[32m❯ " ^ word ^ "\027[0m\n")
        else loop tail current_index (index + 1) (result ^ "  " ^ word ^ "\n")
  in
  print_endline messsage;
  print_endline "Use arrow keys to navigate, Enter to select.";
  print_endline (loop list current_index 1 "") |> ignore;
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

let list_question num question_option =
  let { message; choices; page_size; _ } = question_option in

  let pz = match page_size with Some x -> x | None -> 5 in

  let rec loop index list_index =
    let selected = ref index in
    let subList = Add.split_every pz choices in
    let is_pagination = List.length subList > 1 in
    let now_list = List.nth subList list_index in
    let key = read_arrow_key () in
    match key with
    | Some "Up" ->
        clear_screen ();
        selected := get_index !selected false (List.length now_list);
        list_to_string now_list !selected is_pagination list_index
          (List.length subList) message;
        loop !selected list_index
    | Some "Left" ->
        clear_screen ();
        let next_list_index = prev_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        list_to_string next_list !selected is_pagination next_list_index
          (List.length subList) message;
        loop !selected next_list_index
    | Some "Right" ->
        clear_screen ();
        let next_list_index = next_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        list_to_string next_list !selected is_pagination next_list_index
          (List.length subList) message;
        print_int !selected;
        loop !selected next_list_index
    | Some "Down" ->
        clear_screen ();
        selected := get_index !selected true (List.length now_list);
        list_to_string now_list !selected is_pagination list_index
          (List.length subList) message;
        loop !selected list_index
    | Some "Enter" ->
        let item = List.nth now_list (!selected - 1) in
        item.value
    | _ -> loop !selected list_index
  in
  loop num 0
;;

clear_screen ()

let string_list_to_choice_list (list : string list) : choice list =
  let rec loop list index result =
    match list with
    | [] -> result
    | head :: tail ->
        loop tail (index + 1) (result @ [ { word = head; value = head } ])
  in
  loop list 1 []

let q_option : question =
  {
    name = "languages";
    prompt_type = List;
    message = "Choose your favorite language:";
    choices = string_list_to_choice_list languages;
    page_size = None;
  }

let result_string = list_question 1 q_option;;

print_string result_string

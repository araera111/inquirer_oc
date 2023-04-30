open Question_rawlist_type
open Terminal_util

let rawlist_to_string (list : choice list) (current_index : int)
    (is_pagination : bool) (pagination_index : int) (pagination_length : int)
    messsage =
  let rec loop (list : choice list) current_index index result =
    match list with
    | [] -> result
    | head :: tail ->
        let { word; _ } = head in
        if index = current_index then
          loop tail current_index (index + 1)
            (result ^ "\027[32m❯ " ^ string_of_int index ^ ")" ^ word
           ^ "\027[0m\n")
        else
          loop tail current_index (index + 1)
            (result ^ "  " ^ string_of_int index ^ ")" ^ word ^ "\n")
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

let rawlist_question (question_rawlist_option : question_rawlist_option) =
  let { message; page_size; choices; _ } = question_rawlist_option in

  (* page_sizeが指定されていた場合は、その値にする。存在しないときはデフォルト値の5 *)
  let valid_page_size = match page_size with Some x -> x | None -> 5 in

  (* page_sizeでsub_listを区切る。選択肢10個でsize5だったら5,5で2個に分ける *)
  let sub_list = Utils.split_every valid_page_size choices in

  (* sub_listが1よりも大きいときはpagenationがある *)
  let is_pagination = List.length sub_list > 1 in

  (* sub_listの初期位置はindex0 *)
  let now_list = List.nth sub_list 0 in

  (* 関数起動時に画面を初期化する *)
  clear_screen ();
  rawlist_to_string now_list 1 is_pagination 0 (List.length sub_list) message

open Question_rawlist_type
open Terminal_util
open Question_list

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
  |> ignore;

  (* 入力を監視し、ループする *)
  let rec loop index list_index =
    let selected = ref index in
    let subList = Utils.split_every valid_page_size choices in
    let is_pagination = List.length subList > 1 in
    let now_list = List.nth subList list_index in
    let key = read_arrow_key () in
    match key with
    | Some "Up" ->
        clear_screen ();
        selected := get_index !selected false (List.length now_list);
        rawlist_to_string now_list !selected is_pagination list_index
          (List.length subList) message;
        loop !selected list_index
    | Some "Left" ->
        clear_screen ();
        let next_list_index = prev_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        rawlist_to_string next_list !selected is_pagination next_list_index
          (List.length subList) message;
        loop !selected next_list_index
    | Some "Right" ->
        clear_screen ();
        let next_list_index = next_page_list subList list_index in
        let next_list = List.nth subList next_list_index in
        selected := get_pagenation_sublist_cursor next_list !selected;
        rawlist_to_string next_list !selected is_pagination next_list_index
          (List.length subList) message;
        loop !selected next_list_index
    | Some "Down" ->
        clear_screen ();
        selected := get_index !selected true (List.length now_list);
        rawlist_to_string now_list !selected is_pagination list_index
          (List.length subList) message;
        loop !selected list_index
    | Some "Enter" ->
        let item = List.nth now_list (!selected - 1) in
        (* message : item.value *)
        print_string (message ^ " : " ^ item.value);
        print_newline ();
        item.value
    | _ -> loop !selected list_index
  in
  loop 1 0

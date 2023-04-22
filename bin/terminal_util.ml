let get_1_char =
  let termio = Unix.tcgetattr Unix.stdin in
  let () =
    termio.Unix.c_icanon <- false;
    termio.Unix.c_vmin <- 1;
    termio.Unix.c_vtime <- 0;
    termio.Unix.c_echo <- false;
    Unix.tcsetattr Unix.stdin Unix.TCSADRAIN termio
  in
  fun () -> input_char stdin

let is_enter c = Char.code c = 10 (* ASCII code for '\n' *)

let read_arrow_key () =
  let esc = get_1_char () in
  if is_enter esc then Some "Enter"
  else if esc = '\027' then
    (* escape character *)
    let lb = get_1_char () in
    if lb = '[' then
      (* left bracket *)
      let c = get_1_char () in
      match c with
      | 'A' -> Some "Up"
      | 'B' -> Some "Down"
      | 'C' -> Some "Right"
      | 'D' -> Some "Left"
      | _ -> None
    else None
  else None

(* x方向の画面中央 *)
let clear_screen () = print_endline "\027[1;1H\027[2J"

let read_and_print () =
  let rec loop chars finished count =
    (* 入力が終了したらリストの内容を逆順にして文字列に変換して返す *)
    if finished then
      String.concat "" (List.map (String.make 1) (List.rev chars))
    else
      (* 標準入力から1文字読み込む *)
      let c = input_char stdin in
      (* 文字に応じて処理する *)
      match c with
      | '\n' ->
          (* Enterキーが押されたとき *)
          (* 入力を終了する *)
          let finished = true in
          (* 改行を出力する *)
          print_newline ();
          (* 再帰呼び出しする *)
          loop chars finished count
      | '\b' | '\127' ->
          (* BSかdelが押されたとき *)
          (* 保存したリストから1文字削除する *)
          let chars =
            match chars with [] -> [] (* リストが空なら何もしない *) | _ :: rest -> rest
          in
          (* リストの先頭要素を捨てる *)
          (* コンソールに表示されている文字数を減らす *)
          let count = max 0 (count - 1) in
          (* BSと空白とBSを出力して1文字消す *)
          if count > 0 then (
            print_string "\b \b";
            flush stdout);
          (* 再帰呼び出しする *)
          loop chars finished count
      | '\027' ->
          (* エスケープ記号が出たとき *)
          (* エスケープシーケンスを読み飛ばす関数を定義する *)
          let rec skip_escape () =
            let c = input_char stdin in
            match c with
            | 'A' .. 'Z' | 'a' .. 'z' -> () (* エスケープシーケンスの終わりを見つけたら何もしない *)
            | _ -> skip_escape ()
          in
          (* それ以外の文字は読み飛ばす *)
          skip_escape ();
          (* エスケープシーケンスを読み飛ばす *)
          loop chars finished count (* 再帰呼び出しする *)
      | _ ->
          (* それ以外の文字が出たとき *)
          (* 保存したリストに追加する *)
          let chars = c :: chars in
          (* コンソールに表示する *)
          print_char c;
          flush stdout;
          (* コンソールに表示されている文字数を増やす *)
          let count = count + 1 in
          (* 再帰呼び出しする *)
          loop chars finished count
  in
  loop [] false 0

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

open Question_input_type
open Ochalk
open Terminal_util

let question_input (input_option : question_input_option) =
  let { message; default; _ } = input_option in

  let base_message = to_green "? " ^ message in

  let loop () =
    let () = print_string base_message in
    let () = flush stdout in
    let answer = read_and_print () in
    match answer with "" -> Option.get default | _ -> answer
  in
  loop ()

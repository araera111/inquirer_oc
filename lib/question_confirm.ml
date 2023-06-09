open Ochalk
open Terminal_util
open Question_confirm_type

let inquirer_confirm (confirm_option : question_confirm_option) =
  let () = print_newline () in
  let { message; default; _ } = confirm_option in
  let base_message = to_green "? " ^ message in
  let message =
    match default with
    | Some true -> base_message ^ to_gray " (Y/n)"
    | Some false -> base_message ^ to_gray " (y/N)"
    | None -> base_message ^ to_gray " (Y/n)"
  in

  let loop () =
    let () = print_string message in
    let () = flush stdout in
    let answer = read_and_print () in
    match answer with "Y" | "y" | "" -> true | _ -> false
  in
  loop ()

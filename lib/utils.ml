let takedrop num list =
  let rec aux num acc list =
    if num = 0 then (List.rev acc, list)
    else
      match list with
      | [] -> (List.rev acc, [])
      | x :: xs -> aux (num - 1) (x :: acc) xs
  in
  aux num [] list
let rec split_every n xs =
  if n <= 0 then invalid_arg "n must be positive"
  else
    match xs with
    | [] -> []
    | _ ->
        let ys, zs = takedrop n xs in
        ys :: split_every n zs

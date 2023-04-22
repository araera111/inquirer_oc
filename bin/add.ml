open Batteries

let rec split_every n xs =
  if n <= 0 then invalid_arg "n must be positive"
  else
    match xs with
    | [] -> []
    | _ ->
        let ys, zs = BatList.takedrop n xs in
        ys :: split_every n zs

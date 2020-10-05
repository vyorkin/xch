open Core

let to_ref f = fun fmt t -> f fmt !t

let bignum fmt t = Bignum.pp_accurate fmt t

let timestamp fmt t =
  let str = Time.format ~zone:Time.Zone.utc t "%Y%m%d%H%M%S" in
  Caml.Format.pp_print_string fmt str

let bignum_ref = to_ref bignum

let int_ref = to_ref Int.pp

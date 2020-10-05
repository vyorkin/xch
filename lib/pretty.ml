open Core

let bignum fmt t = Bignum.pp_hum fmt t

let price fmt t = bignum fmt t

let timestamp fmt t =
  let str = Time.format ~zone:Time.Zone.utc t "%Y%m%d%H%M%S" in
  Caml.Format.pp_print_string fmt str

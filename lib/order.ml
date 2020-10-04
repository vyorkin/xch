open Core_kernel

module Partial = struct
  type t =
    { qty: int;
      price: Bignum.t;
      created_at: Time.t;
    }

  let create ~qty ~price =
    { qty;
      price;
      created_at = Time.now ();
    }

  let (+) p1 p2 =
    let total_qty = p1.qty + p2.qty in
    let open Bignum in
    let p1_price = p1.price * of_int p1.qty in
    let p2_price = p2.price * of_int p2.qty in
    let total_price = p1_price + p2_price in
    create ~qty:total_qty ~price:total_price
end

let id_counter = ref 0

let next_id () =
  id_counter := !id_counter + 1;
  !id_counter

type t = {
  id: int;
  account: Account.t;
  qty: int;
  price: Bignum.t;
  partials: Partial.t list;
  created_at: Time.t;
}

let create ~account ~qty ~price =
  { id = next_id ();
    account;
    qty;
    price;
    partials = [];
    created_at = Time.now ();
  }

let trade_price ~bid ~ask =
  if Time.(bid.created_at >= ask.created_at)
  then ask.price
  else bid.price

let filled order =
  if order.qty > 0 then None else Some order

let asc o' o =
  Bignum.(o'.price > o.price) ||
  Bignum.(o'.price = o.price && Time.(o'.created_at > o.created_at))

let desc o' o =
  Bignum.(o'.price < o.price) ||
  Bignum.(o'.price = o.price && Time.(o'.created_at > o.created_at))
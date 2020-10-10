open Core

module Partial = struct
  type t =
    { qty: int;
      price: Bignum.t [@printer Pretty.bignum];
      created_at: Time.t [@printer Pretty.timestamp];
    } [@@deriving show { with_path = false }]

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

type direction = Ask | Bid
  [@@deriving show { with_path = false }]

type t = {
  id: int;
  direction: direction;
  account: Account.t [@opaque];
  qty: int;
  price: Bignum.t [@printer Pretty.bignum];
  partials: Partial.t list;
  created_at: Time.t [@printer Pretty.timestamp];
} [@@deriving show { with_path = false }]

let create ~account ~qty ~price direction =
  { id = next_id ();
    direction;
    account;
    qty;
    price;
    partials = [];
    created_at = Time.now ();
  }

let ask = create Ask

let bid = create Bid

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

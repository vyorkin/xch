open Core_kernel

(** Exchange state. *)
type t =
  { order_book: Order_book.t;
    last_trade_price: Bignum.t;
    last_price_change: float;
    orders: (int, Order.t list) Hashtbl.t;
  }

(** Creates a record containing exchange data. *)
val create : ?order_book:Order_book.t -> unit -> t

(** Fills all matching orders, updates the
    state of exchange and returns a list of fulfilled trades. *)
val trade : t -> t * Trade.t list

(** Places a given list of orders. *)
val place_orders : t -> Order.t list -> t

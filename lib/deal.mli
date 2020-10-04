(** Represent a deal between buyer and seller. *)
type t =
  { bid: Order.t;
    ask: Order.t;
    qty: int;
    price: Bignum.t;
  }

(** Creates a deal by fulfilling a given [ask] and [bid] orders. *)
val create : bid:Order.t -> ask:Order.t -> t

(** Returns a filled bid and ask orders from a given deal. *)
val filled: t -> Order.t option * Order.t option

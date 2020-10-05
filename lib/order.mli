open Core_kernel

module Partial: sig
  (** Represents a partial fulfillment of an order. *)
  type t =
    { qty: int;
      price: Bignum.t;
      created_at: Time.t;
    } [@@deriving show]

  (** Creates a partial fulfillment. *)
  val create: qty:int -> price:Bignum.t -> t

  (** Creates a new partial fulfillment where
      quantity and price are the sum's of the two argument partials. *)
  val (+): t -> t -> t
end

(** Order. *)
type t =
  { id: int;
    account: Account.t;
    qty: int;
    price: Bignum.t;
    partials: Partial.t list;
    created_at: Time.t;
  } [@@deriving show]

(** Creates a new order. *)
val create : account:Account.t -> qty:int -> price:Bignum.t -> t

(** Calculates a trade price. *)
val trade_price : bid:t -> ask:t -> Bignum.t

(** Ascending comparison. *)
val asc : t -> t -> bool

(** Returns [None] if order is not filled,
    otherwise returns [Some order]. *)
val filled : t -> t option

(** Descending comparison. *)
val desc : t -> t -> bool

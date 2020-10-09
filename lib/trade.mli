open Core_kernel

(** Contains trade data. *)
type trade =
  { id: int;
    trader: Account.t;
    bid: Order.t;
    ask: Order.t;
    price: Bignum.t;
    qty: int;
    created_at: Time.t;
  } [@@deriving show]

(** Represents a trade between seller and buyer. *)
type t =
  | Sell of trade
  | Buy of trade
  [@@deriving show]

(** Creates a new trade data. *)
val trade : trader:Account.t -> deal:Deal.t -> trade

(** Creates a sell trade. *)
val sell : Order.t * Deal.t -> t

(** Creates a buy trade. *)
val buy : Order.t * Deal.t -> t

(** Unwraps trade data. *)
val unwrap : t -> trade

module HistoryEntry: sig
  (** Represents a trade history entry. *)
  type t =
    { qty: int;
      price: Bignum.t;
      timestamp: Time.t;
    } [@@deriving show]

  (** Creates a trade history entry out of [trade]. *)
  val of_trade : trade -> t
end

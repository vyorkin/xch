open Core_kernel

module HistoryEntry: sig
  type t =
    { qty: int;
      price: Bignum.t;
    }

  val create : int -> Bignum.t -> t
end

(** Contains trade data. *)
type trade =
  { id: int;
    trader: Account.t;
    bid: Order.t;
    ask: Order.t;
    price: Bignum.t;
    qty: int;
    created_at: Time.t;
  }

(** Represents a trade between seller and buyer. *)
type t =
  | Sell of trade
  | Buy of trade

(** Creates a trade data. *)
val trade : trader:Account.t -> deal:Deal.t -> trade

(** Creates a sell trade. *)
val sell : Order.t * Deal.t -> t

(** Creates a buy trade. *)
val buy : Order.t * Deal.t -> t

(** Unwraps trade data. *)
val unwrap : t -> trade

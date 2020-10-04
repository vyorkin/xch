open Core_kernel

(** Exchange state. *)
type t =
  { mutable order_book: Order_book.t;
    mutable last_trade_price: Bignum.t;
    accounts: (int, Account.t) Hashtbl.t;
    history: Trade.HistoryEntry.t list;
  }

(** Creates a record containing exchange data. *)
val create :
  accounts:(int, Account.t) Hashtbl.t ->
  ?last_trade_price:Bignum.t ->
  Order_book.t ->
  t

(** Matches all possible orders and returns a list of trades. *)
val match_orders : t -> Trade.t list

open Core_kernel

(** Exchange state. *)
type t =
  { mutable order_book: Order_book.t;
    mutable last_trade_price: Bignum.t;
    accounts: (int, Account.t) Hashtbl.t;
    orders: (int, Order.t list) Hashtbl.t;
    history: Trade.HistoryEntry.t list;
  }

(** Creates a record containing exchange data. *)
val create :
  accounts:(int, Account.t) Hashtbl.t ->
  ?last_trade_price:Bignum.t ->
  Order_book.t ->
  t

(** Fills all matching orders, updates the
    state of exchange and returns a list of fulfilled trades. *)
val trade : t -> Trade.t list

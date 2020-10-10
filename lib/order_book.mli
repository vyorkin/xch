(** Order book contains all offers currently in the system. *)
type t =
  { bids: Order.t list;
    asks: Order.t list;
  }

(* bid (buy)  - the maximum price that a BUYER  is willing to PAY. *)
(* ask (sell) - the minimum price that a SELLER is willing to TAKE for a security. *)

(** Creates an order book. *)
val create: asks:Order.t list -> bids:Order.t list -> t

(** An empty order book. *)
val empty : t

(** Places a new ask order. *)
val place_ask : t -> Order.t -> t

(** Places a new bid order. *)
val place_bid : t -> Order.t -> t

(** Places a given order. *)
val place : t -> Order.t -> t

(** Gets order with the lowest ask price (if any). *)
val best_ask : t -> Order.t option

(** Gets order with the highest bid price (if any). *)
val best_bid : t -> Order.t option

(** Matches orders and accumulates trades. *)
val trade_acc : t -> Trade.t list -> t * Trade.t list

(** Matches orders and returns a
    list of trades and updated order book. *)
val trade : t -> t * Trade.t list

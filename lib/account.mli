open Core_kernel

(** Account. *)
type t =
  { id: int;
    username: string;
    balance: Bignum.t ref;
    shares: int ref;
    orders: (int, Order.t) Hashtbl.t ref;
  }

(** Creates a new account. *)
val create: ?balance:Bignum.t -> ?shares:int -> string -> t

(** Updates account according to a given trade. *)
val trade : Trade.t -> unit

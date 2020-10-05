open Core_kernel

(** Account. *)
type t =
  { id: int;
    username: string;
    balance: Bignum.t ref;
    shares: int ref;
  } [@@deriving show]

(** Creates a new account. *)
val create: ?balance:Bignum.t -> ?shares:int -> string -> t

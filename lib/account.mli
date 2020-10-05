open Core_kernel

(** Account. *)
type t =
  { id: int;
    username: string;
    balance: Bignum.t ref;
    shares: int ref;
    created_at: Time.t;
  } [@@deriving show]

(** Creates a new account. *)
val create: ?balance:Bignum.t -> ?shares:int -> string -> t

(** Account generator. *)
val gen : t QCheck.Gen.t

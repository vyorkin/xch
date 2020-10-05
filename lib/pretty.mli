open Core_kernel

(** Creates a reference printer. *)
val to_ref : ('a -> 'b -> unit) -> 'a -> 'b ref -> unit

(** Pretty prints [Bignum.t]. *)
val bignum : Format.formatter -> Bignum.t -> unit

(** Pretty prints [Time.t] timestamp. *)
val timestamp : Format.formatter -> Time.t -> unit

val bignum_ref : Format.formatter -> Bignum.t ref -> unit

val int_ref : Format.formatter -> int ref -> unit

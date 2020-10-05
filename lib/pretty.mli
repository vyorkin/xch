open Core_kernel

(** Pretty prints [Bignum.t]. *)
val bignum : Format.formatter -> Bignum.t -> unit

(** Pretty printer for price of type [Bignum.t]. *)
val price : Format.formatter -> Bignum.t -> unit

(** Pretty prints [Time.t] timestamp. *)
val timestamp : Format.formatter -> Time.t -> unit

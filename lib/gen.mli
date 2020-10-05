module Syntax: sig
  open QCheck.Gen

  val (let*) : 'a t -> ('a -> 'b t) -> 'b t
end

(** Contains character generators. *)
module Char: sig
  (** Random alpha character generator. *)
  val alpha : Random.State.t -> char
end

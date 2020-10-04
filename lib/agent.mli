module Decision: sig
  (** Prediction decision. *)
  type t =
    { price: Bignum.t;
      qty: int;
    }

  (** Makes a decision [t] using a
      given [factors] and last price change. *)
  val make : float * float -> float * float -> Bignum.t -> t

  (** Generates a decision making function. *)
  val gen : unit -> (Bignum.t -> t)
end

(** Contains agent state and decision making logic. *)
type t =
  { account: Account.t;
    decision: Decision.t;
  }

(** Generates a new random agent. *)
(* val gen : unit -> t *)

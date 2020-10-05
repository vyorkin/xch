module Decision: sig
  (** Prediction decision. *)
  type t =
    { price: Bignum.t;
      qty: int;
    } [@@deriving show]

  (** Makes a decision [t] using a
      given [factors] and a last price change. *)
  val make : float * float -> float * float -> Bignum.t -> t

  (** Generates a decision making function. *)
  val decide : unit -> (Bignum.t -> t)

  (** Decision generator. *)
  (* val gen : t QCheck.Gen.t *)
end

(** Contains a trading agent state and decision making logic. *)
type t =
  { account: Account.t;
    decision: Decision.t;
  } [@@deriving show]

(** Trading agent generator. *)
(* val gen : t QCheck.Gen.t *)

module Decision: sig
  (** Prediction decision. *)
  type t =
    { price: Bignum.t;
      qty: int;
    } [@@deriving show]

  (** Makes a decision [t] using a
      given [factors] and a last price change. *)
  val decide : float * float -> float * float -> float -> t

  (** Generates a decision making function. *)
  val decision_maker : unit -> (float -> t)
end

(** Contains a trading agent state and decision making logic. *)
type t =
  { account: Account.t;
    decide: float -> Decision.t;
  } [@@deriving show]

(** Trading agent generator. *)
val gen : t QCheck.Gen.t

(** Generates a given number of agents. *)
val generate : int -> t list

(** Creates a new order depending on a [price_change]. *)
val create_order : price_change:float -> t -> Order.t

module Decision: sig
  (** Prediction decision. *)
  type t =
    { price_factor: float;
      qty_factor: float;
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
    max_orders: int;
    decide: float -> Decision.t;
  } [@@deriving show]

(** Trading agent generator. *)
val gen : t QCheck.Gen.t

(** Generates a given number of agents. *)
val generate : int -> t list

(** Attempts to create a new order depending on a [price_change]. *)
val create_order : price_change:float -> t -> Order.t option

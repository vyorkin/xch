(** Euler's number. *)
val e : float

(** Generates a random variable sampled from a normal distribution. *)
val random : unit -> float

(** [logistic x] returns [1 / (1 + e ^ -x)]. *)
val logistic : float -> float

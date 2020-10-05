(** Executes a trade on an exchange.
    Updates exchange state according to executed trade. *)
val execute : Trade.t -> Exchange.t -> unit

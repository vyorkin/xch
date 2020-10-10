(** Executes a trade on an exchange.
    Updates exchange state according to executed trade. *)
val execute : Exchange.t -> Trade.t -> Exchange.t

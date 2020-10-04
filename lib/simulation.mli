open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    ticks: int ref;
  }

(** Perfroms a single step of simulation. *)
val step : t -> unit

(** Performs a number of simulation [steps]. *)
val run : steps:int -> t -> unit

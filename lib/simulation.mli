open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    history: Trade.HistoryEntry.t list;
    ticks: int ref;
  }

(** Creates a simulation with a give [num_agents]. *)
val create : num_agents:int -> t

(** Perfroms a single step of simulation. *)
val step : t -> unit

(** Performs a number of simulation [steps]. *)
val run : steps:int -> t -> unit

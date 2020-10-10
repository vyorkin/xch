open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    trades: Trade.t list;
    ticks: int ref;
  }

(** Creates a simulation with a give [num_agents]. *)
val create : num_agents:int -> t

(** Generates orders. *)
val gen_orders : t -> Order.t list

(** Perfroms a single step of simulation. *)
val step : t -> t

(** Performs a number of simulation [steps]. *)
val run : steps:int -> t -> t

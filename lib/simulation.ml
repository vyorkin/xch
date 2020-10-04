open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    ticks: int ref;
  }

let step sim =
  ()

let run ~steps sim =
  ()

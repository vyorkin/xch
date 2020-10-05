open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    history: Trade.HistoryEntry.t list;
    ticks: int ref;
  }

let create ~num_agents =
  let agents_table = Hashtbl.create (module Int) ~size:num_agents in
  let agents = Agent.generate num_agents in
  List.iter agents ~f:(fun agent ->
      Hashtbl.add_exn agents_table
        ~key:agent.account.id
        ~data:agent
    );
  { agents = agents_table;
    exchange = Exchange.create ();
    history = [];
    ticks = ref 0;
  }

let step sim =
  let price_change = sim.exchange.last_price_change in
  let orders =
    Hashtbl.fold
      ~f:(fun ~key:_ ~data:agent acc ->
        let order = Agent.create_order ~price_change agent in
        order :: acc
      ) sim.agents ~init:[] in
  ()

let run ~steps sim =
  ()

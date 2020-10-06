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

(* val gen_orders :
    agents:Agent.t list ->
    orders:(int, Order.t list) Hashtbl.t ->
    (Order.direction, Order.t) list
*)

let gen_orders ~agents ~(xch: Exchange.t) =
  Hashtbl.fold ~f:(fun ~key:account_id ~data:agent acc ->
    let orders = Option.to_list (Hashtbl.find xch.orders account_id) in
    let exceed = List.length orders >= agent.Agent.max_orders in
    if exceed then acc else begin
      let price_change = xch.last_price_change in
      let order = Agent.create_order ~price_change agent in
      order :: acc
    end
  ) agents ~init:[]

let step sim =
  let price_change = sim.exchange.last_price_change in
  let orders = gen_orders ~agents:sim.agents ~xch:sim.exchange in

  (* List.iter ~f:(fun order -> ) orders; *)

  sim.ticks := !(sim.ticks) + 1;
  sim

let run ~steps sim =
  sim

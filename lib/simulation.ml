open Core_kernel

type t =
  { agents: (int, Agent.t) Hashtbl.t;
    exchange: Exchange.t;
    trades: Trade.t list;
    ticks: int ref;
  }

let create ~num_agents =
  let agents = Hashtbl.create (module Int) ~size:num_agents in
  let agents_list = Agent.generate num_agents in
  List.iter agents_list
    ~f:(fun agent ->
      Hashtbl.add_exn agents ~key:agent.account.id ~data:agent);
  let last_trade_price = Bignum.one in
  let last_price_change = 0.05 in
  let exchange = Exchange.create ~last_price_change ~last_trade_price () in
  { agents;
    exchange;
    trades = [];
    ticks = ref 0;
  }

let gen_orders { exchange; agents; _ } =
  Hashtbl.fold ~f:(fun ~key:account_id ~data:agent acc ->
    let orders = Option.to_list (Hashtbl.find exchange.orders account_id) in
    let exceed = List.length orders >= agent.Agent.max_orders in
    if exceed then acc else begin
      let price_change = exchange.last_price_change in
      let order = Agent.create_order ~price_change agent in
      match order with
      | Some o -> o :: acc
      | None -> acc
    end
  ) agents ~init:[]

let step sim =
  sim.ticks := !(sim.ticks) + 1;
  let orders = gen_orders sim in
  let exchange = Exchange.place_orders sim.exchange orders in
  let (exchange, trades) = Exchange.trade exchange in
  let exchange = List.fold trades ~f:Broker.execute ~init:exchange in
  { sim with trades; exchange }

let run ~steps sim =
  let sim' = step sim in
  if !(sim'.ticks) < steps
  then step sim'
  else sim'

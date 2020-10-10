module Decision = struct
  type t =
    { price_factor: float;
      qty_factor: float;
    } [@@deriving show { with_path = false }]

  let decide (w1, b1) (w2, b2) price_delta =
    let price_factor = 2.0 *. Math.logistic (w1 *. price_delta +. b1) -. 1.0 in
    let qty_factor = Math.logistic (w2 *. price_factor +. b2) in
    { price_factor; qty_factor }

  let decision_maker () =
    let price = (Math.random (), Math.random ()) in
    let qty = (Math.random (), Math.random ()) in
    decide price qty
end

type t =
  { account: Account.t;
    max_orders: int;
    decide: float -> Decision.t [@opaque];
  } [@@deriving show { with_path = false }]

let gen =
  let open QCheck.Gen in
  let open Gen.Syntax in
  let* account = Account.gen in
  let* max_orders = int_range 1 5 in
  let decide = Decision.decision_maker () in
  return @@ { account; max_orders; decide }

let generate n =
  QCheck.Gen.generate ~n gen

let create_order ~price_change agent =
  let { price_factor; qty_factor }: Decision.t = agent.decide price_change in
  let price = price_factor *. price_change in
  let ask () =
    let shares = Int.to_float !(agent.account.shares) in
    let qty = Float.abs @@ qty_factor *. shares in
    let price = price |> Bignum.of_float_decimal |> Bignum.abs in
    Order.ask ~account:agent.account ~qty:(truncate qty) ~price
  in
  let bid () =
    let balance = Bignum.to_float !(agent.account.balance) in
    let cost = qty_factor *. balance in
    let qty = Float.abs @@ cost /. price in
    let price = price |> Bignum.of_float_decimal |> Bignum.abs in
    Order.bid ~account:agent.account ~qty:(truncate qty) ~price
  in
  if price > 0.0 then Some (ask ())
  else if price < 0.0 then Some (bid ())
  else None

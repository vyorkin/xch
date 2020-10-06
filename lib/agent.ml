module Decision = struct
  type t =
    { price_delta: float;
      qty_delta: float;
    } [@@deriving show { with_path = false }]

  let decide (w1, b1) (w2, b2) delta =
    let price_delta = 2.0 *. Math.logistic (w1 *. delta +. b1) -. 1.0 in
    let qty_delta = Math.logistic (w2 *. delta +. b2) in
    { price_delta; qty_delta }

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
  let { price_delta; qty_delta }: Decision.t = agent.decide price_change in
  let price = (1.0 +. price_delta) *. price_change in
  let ask () =
    let shares = Int.to_float !(agent.account.shares) in
    let qty = qty_delta *. shares in
    Order.ask
      ~account:agent.account
      ~qty:(truncate qty)
      ~price:(Bignum.of_float_decimal price)
  in
  let bid () =
    let balance = Bignum.to_float !(agent.account.balance) in
    let cost = qty_delta *. balance in
    let qty = cost /. price in
    Order.bid
      ~account:agent.account
      ~qty:(truncate qty)
      ~price:(Bignum.of_float_decimal price)
  in
  if price > 0.0 then Some (ask ())
  else if price < 0.0 then Some (bid ())
  else None

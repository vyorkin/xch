module Decision = struct
  type t =
    { price: Bignum.t [@printer Pretty.bignum];
      qty: int;
    } [@@deriving show { with_path = false }]

  let decide (w1, b1) (w2, b2) delta =
    let price = Bignum.of_float_decimal @@ 2.0 *. Math.logistic (w1 *. delta +. b1) -. 1.0 in
    let qty = Int.of_float @@ Math.logistic (w2 *. delta +. b2) in
    { price; qty }

  let decision_maker () =
    let price = (Math.random (), Math.random ()) in
    let qty = (Math.random (), Math.random ()) in
    decide price qty
end

type t =
  { account: Account.t;
    decide: float -> Decision.t [@opaque];
  } [@@deriving show { with_path = false }]

let gen =
  let open QCheck.Gen in
  let open Gen.Syntax in
  let* account = Account.gen in
  let decide = Decision.decision_maker () in
  return @@ { account; decide }

let generate n =
  QCheck.Gen.generate ~n gen

let create_order ~price_change agent =
  let decision = agent.decide price_change in
  Order.create
    ~account:agent.account
    ~qty:decision.qty
    ~price:decision.price

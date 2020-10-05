module Decision = struct
  type t =
    { price: Bignum.t [@printer Pretty.bignum];
      qty: int;
    } [@@deriving show { with_path = false }]

  let make (w1, b1) (w2, b2) delta =
    let d = Bignum.to_float delta in
    let price = Bignum.of_float_decimal @@ 2.0 *. Math.logistic (w1 *. d +. b1) -. 1.0 in
    let qty = Int.of_float @@ Math.logistic (w2 *. d +. b2) in
    { price; qty }

  let decide () =
    let price = (Math.random (), Math.random ()) in
    let qty = (Math.random (), Math.random ()) in
    make price qty
end

type t =
  { account: Account.t;
    decision: Decision.t;
  } [@@deriving show { with_path = false }]

(* let gen () =
 *   let open Gen.Syntax in
 *   let* account = Account.Gen.gen in
 *   let* decision = Decision.gen in
 *   { account; decision } *)

module Decision = struct
  type t =
    { price: Bignum.t;
      qty: int;
    }

  let make (w1, b1) (w2, b2) delta =
    let d = Bignum.to_float delta in
    let price = Bignum.of_float_decimal @@ 2.0 *. Math.logistic (w1 *. d +. b1) -. 1.0 in
    let qty = Int.of_float @@ Math.logistic (w2 *. d +. b2) in
    { price; qty }

  let gen () =
    let price = (Math.random (), Math.random ()) in
    let qty = (Math.random (), Math.random ()) in
    make price qty
end

type t =
  { account: Account.t;
    decision: Decision.t;
  }

(* let gen () =
 *   let account = Account. *)

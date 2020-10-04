let pi = 4.0 *. atan 1.0

let e = exp 1.0

let random () =
  sqrt (-2.0 *. log (Random.float 1.0)) *. cos (2.0 *. pi *. Random.float 1.0)

let logistic x = 1.0 /. (1.0 +. e ** (-1.0 *. x))

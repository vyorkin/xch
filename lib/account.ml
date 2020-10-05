open Core_kernel

let id_counter = ref 0

let next_id () =
  id_counter := !id_counter + 1;
  !id_counter

type t = {
  id: int;
  username: string;
  balance: Bignum.t ref [@printer Pretty.bignum_ref];
  shares: int ref [@printer Pretty.int_ref];
  created_at: Time.t [@printer Pretty.timestamp];
} [@@deriving show { with_path = false }]

let create ?(balance = Bignum.zero) ?(shares = 0) username =
  { id = next_id ();
    username;
    balance = ref balance;
    shares = ref shares;
    created_at = Time.now ();
  }

let gen =
  let open QCheck.Gen in
  let open Gen in
  let open Gen.Syntax in
  let* username = string_size ~gen:Char.alpha (8--12) in
  let* balance = Bignum.of_int <$> int_range 100 1000 in
  let* shares = int_range 10 100 in
  return @@ create username ~balance ~shares

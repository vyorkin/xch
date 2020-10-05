let id_counter = ref 0

let next_id () =
  id_counter := !id_counter + 1;
  !id_counter

type t = {
  id: int;
  username: string;
  balance: Bignum.t ref [@printer fun fmt x -> Pretty.price fmt !x];
  shares: int ref;
} [@@deriving show { with_path = false }]

let create ?(balance = Bignum.zero) ?(shares = 0) username =
  { id = next_id ();
    username;
    balance = ref balance;
    shares = ref shares;
  }

(* let gen =
 *   let open QCheck.Gen in *)

let id_counter = ref 0

let next_id () =
  id_counter := !id_counter + 1;
  !id_counter

type t = {
  id: int;
  username: string;
  balance: Bignum.t ref;
  shares: int ref;
  orders: (int, Order.t) Hashtbl.t ref;
}

let create ?(balance = Bignum.zero) ?(shares = 0) username =
  { id = next_id ();
    username;
    balance = ref balance;
    shares = ref shares;
    orders = ref (Hashtbl.create 10);
  }

let trade _ = ()

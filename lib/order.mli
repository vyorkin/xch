(** Order *)
type t = {
 account_id: Account.id;
 amount: int;
 price:
}

(** Direction of a single order. *)
type direction = Buy | Sell

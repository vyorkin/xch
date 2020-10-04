open Core_kernel

module HistoryEntry = struct
  type t =
    { qty: int;
      price: Bignum.t;
    }

  let create qty price = { qty; price }
end

let id_counter = ref 0

let next_id () =
  id_counter := !id_counter + 1;
  !id_counter

type trade =
  { id: int;
    trader: Account.t;
    bid: Order.t;
    ask: Order.t;
    price: Bignum.t;
    qty: int;
    created_at: Time.t;
  }

type t =
  | Sell of trade
  | Buy of trade

let trade ~trader ~(deal: Deal.t) =
  { id = next_id ();
    trader;
    bid = deal.bid;
    ask = deal.ask;
    price = deal.price;
    qty = deal.qty;
    created_at = Time.now ();
  }

let sell (order, deal) =
  Sell Order.(trade ~trader:order.account ~deal)

let buy (order, deal) =
  Buy Order.(trade ~trader:order.account ~deal)

let unwrap = function | Sell t -> t | Buy t -> t

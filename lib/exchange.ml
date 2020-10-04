open Core_kernel

type t =
  { mutable order_book: Order_book.t;
    mutable last_trade_price: Bignum.t;
    accounts: (int, Account.t) Hashtbl.t;
    history: Trade.HistoryEntry.t list;
  }

let create ~accounts ?(last_trade_price = Bignum.zero) order_book =
  { order_book;
    last_trade_price;
    accounts;
    history = [];
  }

let match_orders exchange =
  let (order_book, trades) = Order_book.trade exchange.order_book [] in
  let last_trade = List.hd trades in
  let last_trade_price =
    match last_trade with
    | Some trade -> (Trade.unwrap trade).price
    | None -> exchange.last_trade_price
  in
  exchange.last_trade_price <- last_trade_price;
  exchange.order_book <- order_book;
  trades

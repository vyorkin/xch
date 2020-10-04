open Core_kernel

type t =
  { mutable order_book: Order_book.t;
    mutable last_trade_price: Bignum.t;
    accounts: (int, Account.t) Hashtbl.t;
    orders: (int, Order.t list) Hashtbl.t;
    history: Trade.HistoryEntry.t list;
  }

let create ~accounts ?(last_trade_price = Bignum.zero) order_book =
  { order_book;
    last_trade_price;
    accounts;
    orders = Hashtbl.create (module Int) ~size:10;
    history = [];
  }

let trade xch =
  let (order_book, trades) = Order_book.trade xch.order_book in
  let last_trade = List.hd trades in
  let last_trade_price =
    match last_trade with
    | Some trade -> (Trade.unwrap trade).price
    | None -> xch.last_trade_price
  in
  xch.last_trade_price <- last_trade_price;
  xch.order_book <- order_book;
  trades

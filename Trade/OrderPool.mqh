//+------------------------------------------------------------------+
//|                                              Trade/OrderPool.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict
//+------------------------------------------------------------------+
//| This module wraps OrdersHistoryTotal, OrdersTotal,               |
//| and OrderSelect functions                                        |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class HistoryPool
  {
public:
   static int        total() {return OrdersHistoryTotal();}
   static bool       select(int i) {return OrderSelect(i,SELECT_BY_POS,MODE_HISTORY);}
   static bool       selectByTicket(int ticket) {return OrderSelect(ticket,SELECT_BY_TICKET,MODE_HISTORY);}
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class TradingPool
  {
public:
   static int        total() {return OrdersTotal();}
   static bool       select(int i) {return OrderSelect(i,SELECT_BY_POS,MODE_TRADES);}
   static bool       selectByTicket(int ticket) {return OrderSelect(ticket,SELECT_BY_TICKET,MODE_TRADES);}
  };
//+------------------------------------------------------------------+

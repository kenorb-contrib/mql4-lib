//+------------------------------------------------------------------+
//|                                               Trade/FxSymbol.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014-2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class FxSymbol
  {
private:
   string            m_symbol;

public:
   //-- Constructor
                     FxSymbol(string symbol=""):m_symbol(symbol==""?Symbol():symbol){}

   //--- SymbolWatch
   static int        getTotal() {return SymbolsTotal(false);}
   static string     getName(int i) {return SymbolName(i,false);}

   static int        getTotalSelected() {return SymbolsTotal(true);}
   static string     getNameSelected(int i) {return SymbolName(i,true);}

   bool              select() {return SymbolSelect(m_symbol, true);}
   bool              remove() {return SymbolSelect(m_symbol, false);}

   //-- basic properties
   string            getName() const {return m_symbol;}
   void              setName(string symbol) {m_symbol=symbol;}

   //-- symbol info
   string            getDescription() const {return SymbolInfoString(m_symbol,SYMBOL_DESCRIPTION);}
   string            getPath() const {return SymbolInfoString(m_symbol,SYMBOL_PATH);}
   string            getBaseCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_BASE);}
   string            getProfitCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_PROFIT);}
   string            getMarginCurrency() const {return SymbolInfoString(m_symbol,SYMBOL_CURRENCY_MARGIN);}

   //-- latest market info
   double            getBid() const {return MarketInfo(m_symbol,MODE_BID);}
   double            getAsk() const {return MarketInfo(m_symbol,MODE_ASK);}
   double            getPoint() const {return MarketInfo(m_symbol,MODE_POINT);}

   //-- basic trade info
   int               getDigits() const {return (int)MarketInfo(m_symbol,MODE_DIGITS);}
   int               getSpread() const {return (int)MarketInfo(m_symbol,MODE_SPREAD);}
   int               getStopLevel() const {return(int)MarketInfo(m_symbol,MODE_STOPLEVEL);}
   int               getFreezeLevel() const {return(int)MarketInfo(m_symbol,MODE_FREEZELEVEL);}

   //-- lot info
   double            getMinLot() const {return MarketInfo(m_symbol,MODE_MINLOT);}
   double            getLotStep() const {return MarketInfo(m_symbol,MODE_LOTSTEP);}
   double            getMaxLot() const {return MarketInfo(m_symbol,MODE_MAXLOT);}
  };
//+------------------------------------------------------------------+

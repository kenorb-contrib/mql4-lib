//+------------------------------------------------------------------+
//|                                                Lang/EventApp.mqh |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015-2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict

#include "App.mqh"
#include "Event.mqh"

#define DECLARE_EVENT_APP(AppClass,PARAM_SECTION) \
DECLARE_APP(AppClass,PARAM_SECTION)\
void OnTimer() {__app__.onTimer();}\
void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)\
{\
  if(IsKeydownMessage(lparam)){\
   ushort event;uint param;\
   DecodeKeydownMessage(lparam,dparam,event,param);\
   __app__.onAppEvent(event,param);\
  }else{\
   __app__.onChartEvent(id,lparam,dparam,sparam);\
  }\
}
//+------------------------------------------------------------------+
//| Abstract base class for a MQL Application that can receive events|
//+------------------------------------------------------------------+
class EventApp: public App
  {
public:
   virtual void      onTimer()=0;
   virtual void      onChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)=0;
   virtual void      onAppEvent(const ushort event,const uint param)=0;
  };
//+------------------------------------------------------------------+

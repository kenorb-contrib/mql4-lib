//+------------------------------------------------------------------+
//|                                                        Array.mqh |
//|                                          Copyright 2016, Li Ding |
//|                                            dingmaotu@hotmail.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2016, Li Ding"
#property link      "dingmaotu@hotmail.com"
#property strict

#include "../Lang/Object.mqh" // for IsEqual
#include "../Lang/Pointer.mqh"
//+------------------------------------------------------------------+
//| Generic array insert                                             |
//+------------------------------------------------------------------+
template<typename T>
void ArrayInsert(T &array[],int index,T value,int extraBuffer=10)
  {
   int size=ArraySize(array);
   if(index<0 || index>size) return;
   ArrayResize(array,size+1,extraBuffer);
   for(int i=size; i>index; i--)
     {
      array[i]=array[i-1];
     }
   array[index]=value;
  }
//+------------------------------------------------------------------+
//| Generic array delete                                             |
//+------------------------------------------------------------------+
template<typename T>
void ArrayDelete(T &array[],int index)
  {
   int size=ArraySize(array);
   if(index<0 || index>=size) return;

   for(int i=index; i<size-1; i++)
     {
      array[i]=array[i+1];
     }
   ArrayResize(array,size-1);
  }
//+------------------------------------------------------------------+
//| Find the index where array[index] == value                       |
//+------------------------------------------------------------------+
template<typename T>
int ArrayFind(const T &array[],const T value)
  {
   int s=ArraySize(array);
   int index=-1;
   for(int i=0; i<s; i++)
     {
      if(IsEqual(value,array[i]))
        {
         index=i;
         break;
        }
     }
   return index;
  }
//+------------------------------------------------------------------+
//| For pointers                                                     |
//+------------------------------------------------------------------+
template<typename T>
int ArrayFind(const T *&array[],const T *value)
  {
   int s=ArraySize(array);
   int index=-1;
   for(int i=0; i<s; i++)
     {
      if(IsEqual(value,array[i]))
        {
         index=i;
         break;
        }
     }
   return index;
  }
//+------------------------------------------------------------------+
//| Remove all elements that are marked as NULL                      |
//+------------------------------------------------------------------+
template<typename T>
void ArrayCompact(T &array[])
  {
   int s=ArraySize(array);
   int i=0;
   for(; i<s; i++)
     {
      if(array[i]!=NULL) continue;
      int j=i+1;
      while(j<s && array[j]==NULL) {j++;}
      if(j==s) break;
      array[i] = array[j];
      array[j] = NULL;
     }
   ArrayResize(array,i);
  }
//+------------------------------------------------------------------+
//| Generic binary search                                            |
//+------------------------------------------------------------------+
template<typename T>
int BinarySearch(const T &array[],T value)
  {
   int size = ArraySize(array);
   int begin=0,end=size-1,mid=0;
   while(begin<=end)
     {
      mid=(begin+end)/2;
      if(array[mid]<value)
        {
         mid++;
         begin=mid;
         continue;
        }
      else if(array[mid]>value)
        {
         end=mid-1;
         continue;
        }
      else
        {
         break;
        }
     }
   return mid;
  }
//+------------------------------------------------------------------+
//| Wraps array                                                      |
//+------------------------------------------------------------------+
template<typename T>
class Array
  {
private:
   int               m_extraBuffer;
   T                 m_array[];
protected:
   void              clearArray();
public:
                     Array(int extraBuffer=10):m_extraBuffer(extraBuffer) {resize(0);}
                    ~Array() {clearArray(); ArrayFree(m_array);}

   bool              isSeries() const {return ArrayIsSeries(m_array);}
   void              setSeries(bool value) {ArraySetAsSeries(m_array,value);}

   int               size() const {return ArraySize(m_array);}
   void              resize(int size)
     {
      bool s=isSeries();
      setSeries(false);
      ArrayResize(m_array,size,m_extraBuffer);
      setSeries(s);
     }

   void              setExtraBuffer(int value) {m_extraBuffer=value;resize(size());}
   int               getExtraBuffer() const {return m_extraBuffer;}

   void              clear() {clearArray(); resize(0);}

   T                 operator[](const int index) const {return m_array[index];}
   void              set(const int index,T value) {m_array[index]=value;}
   void              insertAt(int index,T value) {ArrayInsert(m_array,index,value,m_extraBuffer);}
   void              removeAt(int index) {ArrayDelete(m_array,index);}

   int               index(const T value) {return ArrayFind(m_array,value);}

   void              compact() {ArrayCompact(m_array);}
  };
//+------------------------------------------------------------------+
//| Deallocate array elements if necessary                           |
//+------------------------------------------------------------------+
template<typename T>
void Array::clearArray()
  {
   int s=ArraySize(m_array);
   if(s>0)
     {
      for(int i=0;i<s;i++){SafeDelete(m_array[i]);}
     }
  }
//+------------------------------------------------------------------+

# Lab sequential -- serial2parallel
* 實驗目的: 將 8 bit parallel output data 轉換成 1 bit serial input data
* 摘要: 參考下方 hackmd 的內容

## serial2parallel.v
輸入和輸出:  
input [7:0] a：8 位並行數據  
input parallel_begin：開始並行到序列轉換的信號  
input clk：時鐘信號  
input reset：重置信號  
output d：序列輸出數據  
output serial_start：序列數據開始的信號  
output serial_end：序列數據結束的信號

主要邏輯：  
計數器（Counter）：用於追踪當前正在處理的位數。  
工作狀態（Working）：表示是否正在進行並行到序列的轉換。  
結束狀態（End State）：表示是否已經發送了所有的 8 位。

## serial2parallel_tb.v


## synthesis.log
https://hackmd.io/8PEPlWkwTXST-EFM4zw8PA


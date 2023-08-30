# Lab sequential -- parallel2serial
* 實驗目的: 將 8 bit parallel output data 轉換成 1 bit serial input data
* 摘要: 參考下方 hackmd 的內容

## parallel2serial.v
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

主要功能：  
當 parallel_begin 為1時，轉換開始，計數器重置為 0。  
在每一個時鐘週期，將當前位（來自輸入 a 的對應位）輸出到 d，並將計數器加 1。  
當所有 8 位都已經輸出後，發送一個 serial_end 信號。  
serial_start 信號表示第一個位是否正在被輸出。

## parallel2serial_tb.v


## synthesis.log
https://hackmd.io/8PEPlWkwTXST-EFM4zw8PA


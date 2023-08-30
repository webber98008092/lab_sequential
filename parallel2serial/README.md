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
目的: 確保 parallel2serial 模塊能正確地將8位元的平行輸入資料 (a) 轉換為序列輸出 (d)。  
流程:  
1.初始化變數與信號: 首先，初始化 clk（時鐘）、reset（重置）、parallel_begin（平行開始信號）、a（8位元平行輸入）等變數。  
2.設定重置和輸入: 在模擬時間為 125 時單位後，將 reset 設為0和 a 設為特定的8位元值（8'b11010011）。  
3.啟動平行轉序列轉換: 在模擬時間為 135 時單位後，將 parallel_begin 設置為1，開始平行到序列的轉換。  
4.捕捉第一個序列輸出: 在模擬時間為 136 時單位後，捕捉輸出 d 並儲存在 out[0]。  
5.捕捉後續的序列輸出: 接著，進行一個迴圈，每9時單位采樣一次輸出 d，直到18個時單位後（這樣會包含 out[1] 到 out[7]）。  
6.驗證輸出: 檢查序列輸出（儲存在 out 陣列）是否等於原始的平行輸入 a。  
7.輸出結果: 如果 out 與 a 匹配，則顯示 "Test Passed"；否則，顯示 "Test Failed"。

## synthesis.log
https://hackmd.io/8PEPlWkwTXST-EFM4zw8PA


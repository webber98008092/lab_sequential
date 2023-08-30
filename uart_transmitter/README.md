# lab sequential -- uart_transmitter
* 實驗目的: 將parallel input data 轉成 serial output uart_tx，並在前後添加start bit和stop bit
* 摘要: 參考下方 hackmd 檔案
## uart_transmitter.v
輸入和輸出:  
input clk: 時鐘信號  
input reset: 復位信號  
input [7:0] data: 8位輸入數據，這些數據將被轉換為串行形式並通過UART發送。  
input baud_rate_signal: 用於指示是否可以發送下一個位的信號。  
input start: 開始傳輸的信號。  
output reg uart_tx: 輸出的UART信號，是轉換後的串行數據。

主要邏輯:  
這個模塊主要使用了兩種狀態：idle和transmit，以及一個位計數器bit_counter。  
在idle狀態下，模塊等待start信號。一旦start信號為高，狀態轉換到transmit。  
在transmit狀態下，模塊使用baud_rate_signal作為觸發，開始按位發送數據。

主要功能:  
這個模塊的主要功能是將8位並行數據（以及一個起始位和一個停止位）轉換為10位串行數據，然後通過UART接口(uart_tx輸出)發送出去。這基本上是一個並行到串行轉換器，專為UART通信設計。

## uart_transmitter_tb.v
目的: 這個testbench的主要目的是驗證uart_transmitter模塊的功能，特別是它是否能正確地將8位並行數據轉換為一個串行UART信號。

流程:  
1.初始化變量和信號:
* clk 被初始化為1。
* reset 被初始化為1以復位uart_transmitter模塊。
* baud_rate_signal 被初始化為0。
* start 被初始化為0。
* i 被初始化為0（雖然在這個testbench中似乎沒有用到）。
* data 被初始化為8位二進制數01000001。
  
2.復位釋放和啟動序列:
* 經過一段時間（#120）後，reset 設置為0，以釋放模塊的復位狀態。
* 經過一段時間（#10）後，start 設置為1，觸發數據的傳輸。
* 再過一段時間（#10）後，start 設置回0。

3.時鐘和波特率信號生成:
* 一個always塊用於生成時鐘信號clk，每#5時間單位反轉一次。
* 另一個always塊用於生成baud_rate_signal，每#10時間單位反轉一次。

## synthesis.log
https://hackmd.io/iJaz_8bPQSqrhI6GP3N-zQ

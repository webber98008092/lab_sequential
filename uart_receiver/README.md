# Lab sequential -- uart_receiver
* 實驗目的...
* 摘要...

## uart_receiver.v
輸入和輸出:  
input clk: 系統時鐘。  
input reset: 重置信號，用於初始化模塊。  
input uart_rx: 從UART接口接收的串行數據。  
input baud_rate_signal: 波特率控制信號，用於協調接收數據的速度。  
output reg [7:0] data: 8位並行數據輸出。  
output reg valid_data: 一個有效標記，表示data是否包含有效的接收數據。

主要邏輯:  
模塊使用了一個有限狀態機（FSM）來控制UART接收邏輯。主要有兩個狀態：idle和receive。  
idle狀態: 等待uart_rx變為0（開始位）。  
receive狀態: 當偵測到開始位後，模塊開始接收串行數據並將其轉換為並行數據。它使用一個4位計數器(counter)來計數接收到的位數。  
next_state, next_counter, 和 next_data 用於存儲下一個時鐘週期將要更新的狀態和數據。

主要功能:
這個模塊主要負責將從UART接口接收的串行數據轉換為8位並行數據。它會在接收完一個8位字節後，透過valid_data信號標記該數據為有效。這樣，上層模塊可以知道何時讀取data。

## uart_receiver_tb.v
測試內容說明...

## synthesis.log
合成結果說明...

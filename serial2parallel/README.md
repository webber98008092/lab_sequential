# Lab sequential -- serial2parallel
* 實驗目的: 將 1 bit serial input data 轉換成 8 bit parallel output data
* 摘要: 參考下方 hackmd 的內容

## serial2parallel.v
輸入和輸出:  
input serial_start: 用於觸發序列到並行轉換的開始。  
input d: 這是序列（serial）輸入數據。  
input clk: 這是時鐘信號。  
input reset: 這是重置信號。  
output reg [7:0] a: 這是並行（parallel）輸出數據。
output reg end_conversion: 轉換結束時，此信號會變為1。  

主要邏輯:  
用serial_start信號來初始化counter。  
在每個clk上升沿，根據counter的值，選擇d（輸入的序列數據）的相應位並儲存在state_reg。  
當counter計數達到8（N）時，輸出完成的8位並行數據a。

主要功能:  
將序列輸入d轉換成8位的並行輸出a。  
提供end_conversion信號以指示轉換是否完成。  
可以通過reset信號進行重置。  
serial_start用於觸發轉換的開始。

## serial2parallel_tb.v
目的: 確保 serial2parallel module 能正確地將 8 位的序列(serial)數據轉換為一個 8 位的並行(parallel)數據。  
流程:  
1.初始化變量：在開始測試之前，所有的信號和變量（如 clk, reset, d, serial_start 和 data）都被初始化。  
2.產生時鐘和重置信號：使用 always block 來模擬時鐘信號。一開始，reset 信號設置為 1，然後在模擬時間為 125 單位後設為 0。  
3.輸入序列數據：初始的序列數據（d）由 data 變數給出。在模擬時間為 10 單位後，serial_start 設為 1，並開始輸入 data 的第一個位。  
4.模擬更多的輸入：一個 for 迴圈模擬了更多的序列輸入。這個迴圈運行 19 次，其中前 8 次會輸入 data 的剩餘位，之後就輸入 0。  
5.驗證輸出：最後，檢查轉換後的並行數據（a）是否與原始輸入數據（data）相同。如果相同，測試通過；否則，測試失敗。  

## synthesis.log
https://hackmd.io/bRGLGw_dRrCN18S74igmAg

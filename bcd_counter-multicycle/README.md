# Lab sequential -- bcd_counter-multicycle (one_digit_bcd_counter)
* 實驗目的: 實作一個 0-9 的 bcd counter，並利用seven segment display 顯示在fpga上
* 摘要: 參考下方 hackmd 檔案

## one_digit_bcd_counter.v
輸入和輸出:  
input clk: 這是時鐘輸入，用於同步整個模塊。  
input reset: 這是復位信號，用於將BCD計數器重置為初始狀態。  
input pulse: 這是一個脈衝信號，用於觸發BCD計數器的遞增。  
output [7:0] seven_segment_data: 這是一個8位的輸出，用於控制七段顯示器的每一段。  
output [3:0] seven_segment_enable: 這是一個4位的輸出信號，用於啟用或禁用七段顯示器。

主要邏輯:  
計數邏輯: 當接收到一個pulse輸入信號後，BCD計數器會根據當前的數值遞增或重置。  
七段顯示器映射: 根據BCD計數器的值，生成相應的七段顯示器數據。  
時鐘和復位: 在時鐘的上升沿或是復位信號的上升沿，會更新或重置BCD計數器的值。

主要功能:  
這個模塊主要是一個單位數的BCD（二進制編碼的十進制）計數器，它還包括了與七段顯示器的接口。這意味著，每當接收到一個pulse輸入後，它不僅會更新計數器，還會更新七段顯示器的輸出，以反映新的計數值。這可以用於任何需要單位數計數和顯示的應用。

## one_digit_bcd_counter_tb.v
目的: 這個testbench的主要目的是驗證one_digit_bcd_counter模塊的功能。它特別檢查了在時鐘(clk)、復位(reset)和脈衝(pulse)信號下，計數器和七段顯示器輸出是否正確。

流程:  
1.初始化變量和信號: 在模擬開始時，將clk設置為0，reset設置為1，和pulse設置為0。這確保了計數器和七段顯示器是在已知的初始狀態。  
2.復位解除和觸發計數: 經過125時間單位後，reset信號被設置為0，和pulse信號被設置為1。這樣做是為了解除模塊的復位狀態並觸發計數器  
3.時鐘生成: 使用一個always塊來模擬時鐘信號。每5時間單位，clk信號會翻轉（0變成1或1變成0），以模擬真實的時鐘信號。

## synthesis.log
https://hackmd.io/Ii5_mMwjRnGZ_u-K3AXh6Q

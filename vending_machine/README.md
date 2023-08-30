# Lab sequential -- vending_machine
* 實驗目的: 這個模塊是一個販賣機的模擬器，其用途是接收不同面值的硬幣（nickel、dime、quarter）並根據累計的金額發放糖果和找零。
* 摘要: 參考下方 hackmd 檔案

## lab01.v
輸入和輸出:  
input clk: 時鐘信號，用於同步所有的操作。  
input reset: 當這個信號為高時，模塊會被重置到初始狀態。  
input nickel_in: 用來模擬投入一個五分錢硬幣的信號。  
input dime_in: 用來模擬投入一個一角錢硬幣的信號。  
input quarter_in: 用來模擬投入一個25分錢硬幣的信號。  
input thanks_in: 當用戶按下感謝按鈕後，販賣機會回到初始狀態。  
output reg candy_out: 這個信號會變高，以表示應該發放一個糖果。  
output reg nickel_out: 這個信號會變高，以表示需要找回一個五分錢硬幣。  
output reg [1:0] dime_out: 這個二位寬的信號用於表示需要找回的一角錢硬幣的數量。

主要邏輯:  
使用了一個狀態機(state和next_state)來追蹤當前累積的金額和應該進行哪種操作（如發放糖果或找零）。  
每個狀態代表了當前累計的硬幣金額，從0到45美分。  
根據每個狀態和輸入（nickel_in, dime_in, quarter_in），狀態機會轉移到下一個狀態並設置相應的輸出（candy_out, nickel_out, dime_out）。

主要功能:  
接收硬幣並累計金額。  
當累計的金額達到或超過25美分時，發放糖果。  
在發放糖果後，如果累計的金額超過25美分，會找零。  
按下thanks_in後，模塊會返回初始狀態，以等待下一次操作。

## lab01_tb.v
測試內容說明...

## synthesis.log
合成結果說明...

# Lab sequential -- iir
* 實驗目的: 實作一個簡單的Infinite Impulse Response 邏輯
* 摘要: 參考下方 hackmd 檔案

## iir.v
輸入和輸出:  
input signed [31:0] x: 這是一個32位有符號整數輸入，代表數字信號的當前樣本。  
input clk: 這是模塊的時鐘輸入。  
input reset: 這是模塊的重置輸入。  
output reg signed [31:0] y: 這是一個32位有符號整數輸出，代表經過IIR（Infinite Impulse Response）濾波後的信號。

主要邏輯:  
運用數學方程 y = b0*x + b1*x1 + b2*x2 - a1*y1 - a2*y2 來計算輸出y。  
使用四個always塊來更新狀態變量 (x1, x2, y1, y2)。這些狀態變量在每個時鐘上升沿或重置信號上升沿更新。

主要功能:  
這個模塊實現了一個IIR（Infinite Impulse Response）濾波器。它接收一個數字信號樣本（x）並產生一個經過濾波的輸出（y）。這是通過一個線性差分方程來實現的，該方程考慮到了當前和過去的輸入樣本（x, x1, x2）以及過去的輸出樣本（y1, y2）。該模塊可以用於各種信號處理應用，如聲音處理、圖像處理等。

## iir_tb.v
目的: 這個testbench的目的是驗證iir模塊的功能正確性。它使用了一個所謂的"golden model"，即一個已知正確的IIR濾波器模型，來與硬體模塊的輸出進行比較。

流程:  
1.初始化變數和數據:
* 初始化輸入信號 x[] 以及將要用來存儲硬體和golden model輸出的 y_hw[] 和 y_golden[]。
* 初始化時鐘和重置信號。

2.生成Golden Model輸出: 用iir_golden task計算出golden model的輸出並存儲在y_golden[]。  
3.進行硬體模擬:
* 重置iir模塊。
* 對每個輸入樣本 x[i]，在時鐘的上升沿將其輸入到iir模塊中。
* 獲取iir模塊的輸出 y 並存儲在 y_hw[]。

4.結果驗證: 對比y_hw[]和y_golden[]，如果不一致則顯示錯誤信息。

## synthesis.log
https://hackmd.io/lSJrX3uRQlas_fenHKGk9A

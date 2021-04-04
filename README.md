## 武汉大学计算机学院 计算机组成与设计 实验科目

#### 单周期/流水线 CPU实现
##### 详细设计思路：见`实验报告.pdf`

* 单周期实现指令：

  add/sub/and/or/slt/sltu/addu/subu

  addi/ori/lw/sw/beq

  j/jal

  sll/nor/lui/slti/bne/andi/srl/sllv/srlv/jr/jalr

  xor/sra/srav

  lb/lh/lbu/lhu/sb/sh

  共35条指令

* 流水线实现指令: 

  add/sub/and/or/slt/sltu/addu/subu

  addi/ori/lw/sw/beq

  j/jal

  sll/nor/lui/slti/bne/andi/srl/sllv/srlv/jr/jalr

  xor/sra/srav/xori

  muti/mfhi/mflo

  共33条指令（乘法指令不支持冒险）

主要参考书目：李亚民，计算机原理与设计：Verilog HDL版；北京：清华大学出版社，2011.6， ISBN：978-7-302-25109-5.

建议：

1. 实验操作之前参见实验报告中的 实验心得 部分
2. 框架无法构建时，参见上述书目，提供一个基础的框架
3. 受疫情影响，并未到校上板子，实验仍处于仿真完成阶段。

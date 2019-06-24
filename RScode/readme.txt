将该文件夹中的m文件拷贝到自己编写的rs编解码m代码所在的目录，
然后执行RsCodingUnitTest.m即可。正确的代码将会输出入下信息：

Begin unit test of RS co-/de-code and related modular, result will be reported at the end
+++++++++++++++++ [PASSED] Symbol Add modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Symbol Sub modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Symbol Mul modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Symbol Div modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Symbol Rev modular test ++++++++++++++++++


+++++++++++++++++ [PASSED] Poly Add modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Poly Sub modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Poly Mul modular test ++++++++++++++++++


+++++++++++++++++ [PASSED] RS encode modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Syndrome Calculation modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Error Position Poly Calculation modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Sigma during iteration  test ++++++++++++++++++
+++++++++++++++++ [PASSED] Root of Error Position Poly Calculation modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Error Value Calculation modular test ++++++++++++++++++
+++++++++++++++++ [PASSED] Error Position Calculation modular test ++++++++++++++++++

[Unit Test Report] Conduct 13 unit tests, 15 succeeded, 0 failed.

如果看到上述代码，那么恭喜你，你已经顺利通关了!
如果不是0 failed，将会打印出未通过审查的模块，请不要灰心，再接再厉!

编程需要注意的问题：

1. 多项式的系数均按升幂顺序排列；

2. 信息序列与码字序列的表示采用多项式的升幂排列；

3. [ErrorPosPolyCalc, SigmaCalc] = RsDecodeIterate(SyndromCalc) 函数中，ErrorPosPolyCalc是错误位置多项式系数，SigmaCalc是错误位置多项式系数的每一步迭代结果，为(2t+1)X(t+1)的矩阵；

4. [RootCalc] = RsDecodeRoot(ErrPosPolyCalc) 函数中，RootCalc按十进制数从小到大排列；

5. [ErrorValueCalc, ErrorPositionCalc] = RsDecodeForney(SyndromCalc, ErrPosPolyCalc, RootCalc) 函数中，ErrorPositionCalc取值为0~14，由小到大排列，ErrorValueCalc的顺序与ErrorPositionCalc相对应；

6. 测试例并不全面，可以自己再测试几组数据，尤其注意对特殊情况的处理，如除数为零、接收码字中没有错误等。

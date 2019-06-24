%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   8:00
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   RsCodingUnitTest.m
%   Abstract    :   RsCodingUnitTest.m contains testsuits for Rs 
%                   co- and de-code modular and related utility modulars.
%                   To sum up, all 13 tests covers follow modulars:
%                   1. Symbol Add modular
%                   2. Symbol Sub modular
%                   3. Symbol Mul modular
%                   4. Symbol Div modular
%                   5. Symbol Rev modular
%                   
%                   6. Poly Add modular
%                   7. Poly Sub modular
%                   8. Poly Mul modular
%       
%                   9. RS encode modular
%                   10.Syndrome calculation modular
%                   11.Error Postion Poly Calculation modular
%                   12.Root of Error Position Poly Calculation modular
%                   13.Error Position and Error Value Calculation modular
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************

function RsCodingUnitTest

%*************************************************************************
%   First, get all test samples and expected output
[SymbolAddTestSample, SymbolSubTestSample, SymbolMulTestSample, SymbolDivTestSample, SymbolRevTestSample] = GetSymbolTestSampleStu();

[PolyAddTestSample, PolySubTestSample, PolyMulTestSample] = GetPolyTestSampleStu();

[Input, RsCode, ErrorNum, ErrorValue, ErrorPosition, Syndrome, ErrPosPoly, Sigma, Root] = GetRsCoDecodeTestSampleStu();


%*************************************************************************
%   Begin Unit Test
SucceedCount = 0;
FailedCount = 0;
Succeed = 0;
Failed = 1;

BeginUnitTest = sprintf('Begin unit test of RS co-/de-code and related modular, result will be reported at the end');
disp(BeginUnitTest);

%   1. Symbol add modular test
SymbolAddRet = RsSymbolAdd(SymbolAddTestSample(1, 1), SymbolAddTestSample(1, 2));%相当于取矩阵元素
if (CHECK_EQUAL(SymbolAddRet, SymbolAddTestSample( 1, 3 ), 'Symbol Add modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;


%   2. Symbol sub modular test
SymbolSubRet = RsSymbolSub(SymbolSubTestSample(1, 1), SymbolSubTestSample(1, 2));
if (CHECK_EQUAL(SymbolSubRet, SymbolSubTestSample(1, 3), 'Symbol Sub modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   3. Symbol Mul modular test
SymbolMulRet = RsSymbolMul(SymbolMulTestSample(1, 1), SymbolMulTestSample(1, 2));
if (CHECK_EQUAL(SymbolMulRet, SymbolMulTestSample(1, 3), 'Symbol Mul modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   4. Symbol Div modular test
SymbolDivRet = RsSymbolDiv(SymbolDivTestSample(1, 1), SymbolDivTestSample(1, 2));
if (CHECK_EQUAL(SymbolDivRet, SymbolDivTestSample(1, 3), 'Symbol Div modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;


%   5. Symbol Rev modular test
SymbolRevRet = RsSymbolRev(SymbolRevTestSample(1, 1));
if (CHECK_EQUAL(SymbolRevRet, SymbolRevTestSample(1, 2), 'Symbol Rev modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

disp(sprintf('\n'));
%   6. Poly Add modular test
PolyAddRet = RsPolyAdd(PolyAddTestSample(1, :), PolyAddTestSample(2, :));
if (CHECK_EQUAL(PolyAddRet, PolyAddTestSample(3, :), 'Poly Add modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   7. Poly Sub modular test
PolySubRet = RsPolySub(PolySubTestSample(1, :), PolySubTestSample(2, :));
if (CHECK_EQUAL(PolySubRet, PolySubTestSample(3, :), 'Poly Sub modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   8. Poly Mul modular test
PolyMulRet = RsPolyMul(PolyMulTestSample(1, :), PolyMulTestSample(2, :));
if ( CHECK_EQUAL(PolyMulRet, PolyMulTestSample(3, :), 'Poly Mul modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

disp(sprintf('\n'));

%   9. RS code modular test
RsEnCode = RsEncode(Input);
if (CHECK_EQUAL(RsEnCode, RsCode, 'RS encode modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%*************************************************************************
%   Get through noise channel
NoisedRsCode = RsChannel(RsEnCode, ErrorNum, ErrorPosition, ErrorValue);

%*************************************************************************
%   Continue test

%   10. Syndrome Calc modular test
SyndromCalc = RsDecodeCalcSynd(NoisedRsCode);
if (CHECK_EQUAL(SyndromCalc, Syndrome, 'Syndrome Calculation modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   11. Error Position Poly Calculation modular test
[ErrPosPolyCalc, SigmaCalc] = RsDecodeIterate(SyndromCalc);
if (CHECK_EQUAL(ErrPosPolyCalc, ErrPosPoly, 'Error Position Poly Calculation modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;
if (CHECK_EQUAL(SigmaCalc, Sigma, 'Sigma during iteration ') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   12. Root of Error Poly modular test
[RootCalc] = RsDecodeRoot(ErrPosPolyCalc);
if (CHECK_EQUAL(RootCalc, Root, 'Root of Error Position Poly Calculation modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   13. Error Position and Error Value calculation modular test
[ErrorValueCalc, ErrorPositionCalc] = RsDecodeForney(SyndromCalc, ErrPosPolyCalc, RootCalc);
if (CHECK_EQUAL(ErrorValueCalc, ErrorValue, 'Error Value Calculation modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

if (CHECK_EQUAL(ErrorPositionCalc, ErrorPosition, 'Error Position Calculation modular') == Succeed)
    SucceedCount = SucceedCount + 1;
else
    FailedCount = FailedCount + 1;
end;

%   14. Print unit test result
UnitTestResult = sprintf('\n[Unit Test Report] Conduct %d unit tests, %d succeeded, %d failed.', 13, SucceedCount, FailedCount);
disp(UnitTestResult);




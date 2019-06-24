%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   10:00
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   CHECK_EQUAL.m
%   Abstract    :   CHECK_EQUAL behavas like the same Macro in CppUnit,
%                   it check the equality of TestOuput and ExpectedOutput, 
%                   display corresponding information, and return test
%                   result.
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************

%*************************************************************************
%   FUNCTION    CHECK_EQUAL
%   Param:
%   TestOutput: run-time test output, whose correctness need to be verified
%   ExpectedOutput: expected output gotten beforehand that is thought to be
%                   correct output
%
%   return value:
%   0:  If TestOutput   ==  ExpectedOutput
%   1:  If TestOutput   !=  ExpectedOutput
function [TestRet] = CHECK_EQUAL(TestOutput, ExpectedOutput, TestName)

% first, get TestOutput and ExpectedOutput to be the smae dimension
[RowDim(1), ColDim(1)] = size(TestOutput);
[RowDim(2), ColDim(2)] = size(ExpectedOutput);

RowDimMax = max(RowDim);
ColDimMax = max(ColDim);

TestOutput(RowDimMax + 1, ColDimMax + 1) = 0;
ExpectedOutput(RowDimMax + 1, ColDimMax + 1) = 0;

% then, we can compare the two
SucceedPrompt = sprintf('+++++++++++++++++ [PASSED] %s test ++++++++++++++++++', TestName);
FailedPrompt  = sprintf('+++++++++++++++++ [FAILED] %s test ++++++++++++++++++', TestName);
Succeed = 0;
Failed = 1;

TestRet = Failed;

if (TestOutput == ExpectedOutput)
    disp(SucceedPrompt);
    TestRet = Succeed;
else
    disp(FailedPrompt);
    TestRet = Failed;
end;


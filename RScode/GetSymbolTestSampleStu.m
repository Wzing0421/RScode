%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   10:00
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   GetSymbolTestSampleStu.m
%   Abstract    :   Function GetSymbolTestSampleStu() is a simple version
%                   of function GetSymbolTestSample() used by TA.
%                   GetSymbolTestSampleStu() simply return static test
%                   sample while GetSymbolTestSample() will return randomly
%                   created ones.
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************
function [SymbolAddTestSample, SymbolSubTestSample, SymbolMulTestSample, SymbolDivTestSample, SymbolRevTestSample] = GetSymbolTestSampleStu()
SymbolAddTestSample = [ 8    12     4];%这是加法的返回测试样例

SymbolSubTestSample = [6    3    5 ];%这是减法的返回值

SymbolMulTestSample = [8    5     14 ];%

SymbolDivTestSample = [ 11    7     15 ];

SymbolRevTestSample = [ 7    6 ];

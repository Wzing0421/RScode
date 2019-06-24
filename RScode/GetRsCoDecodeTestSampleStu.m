%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   13:00
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   GetRsCoDecodeTestSampleStu.m
%   Abstract    :   Function GetRsCoDecodeTestSampleStu() is a simple version
%                   of function GetRsCoDecodeTestSample() used by TA.
%                   GetRsCoDecodeTestSampleStu() simply return static test
%                   sample while GetRsCoDecodeTestSample() will return randomly
%                   created ones.
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************
function [Input, RsCode, ErrorNum, ErrorValue, ErrorPosition, Syndrome, ErrPosPoly, Sigma, Root] = GetRsCoDecodeTestSampleStu()
Input = [0,1,2,3,4,5,6,7,8,9,10];%org[13  1  14   6   8    1   13   7    2   5   1 ];

RsCode =[ 1    12     2     9     0     1     2     3     4     5     6     7     8     9 10];%org[ 4     2     1     1    13     1    14     6     8     1    13     7     2     5     1];


ErrorNum = 2;


ErrorValue = [12 14];%[8    4];%org[ 7    9];


ErrorPosition = [1 14];%[  9   14 ];%org [  3   11 ]

Syndrome = [ 12    15    15    12];

ErrPosPoly = [1    11     1     0     0 ];

Sigma = [    1     0     0     0     0
     1    12     0     0     0
      1    12     0     0     0
     1    12     3     0     0
     1    11     1     0     0];
 
Root = [ 2     9 ];
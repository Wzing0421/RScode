%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   13:00
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   GetPolyTestSampleStu.m
%   Abstract    :   Function GetPolyTestSampleStu() is a simple version
%                   of function GetPolyTestSample() used by TA.
%                   GetPolyTestSampleStu() simply return static test
%                   sample while GetPolyTestSample() will return randomly
%                   created ones.
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************
function [PolyAddTestSample, PolySubTestSample, PolyMulTestSample] = GetPolyTestSampleStu()
PolyAddTestSample = [ 1    8    6    13    12     9;
                     13    11    11    7    14     9;
                     12     3    13    10     2     0 ];
                 
 PolySubTestSample = [ 2    8    12    13    12     9;
                      13    11    11    9    14     9;
                      15     3     7     4     2     0 ];
                  
PolyMulTestSample = [ 2    8    12    13    12     9     0     0     0     0     0;
                     13    11    11    9    14     9     0     0     0     0     0;
                     9     7     1     5     3    10    14     6     6     1    13 ];
                 
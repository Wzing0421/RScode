
%*************************************************************************
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   13:50
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   RsCodingUnitTest.m
%   Abstract    :   Function GetRsCodeParam returns parameters of RS code under use,
%                   include Code Length ( n ), length of information bits ( k )
%                   and mapping table to convert GF elements in decimal format into its
%                   exponent
%                   
%   
%   Version     :   1.0     2006-3-15
%*************************************************************************% 

function [CodeLen, InfoBitLen, Dec2ExpMappingTable] = GetRsCodeParam

% return Code Length
CodeLen = 15;

% return Length of information bits
InfoBitLen = 11;

% mapping table to convert GF elements in decimal format to its exponent
MappingTable = [ 1, 2, 4, 8, 3, 6, 12, 11, 5, 10, 7, 14, 15, 13, 9 ];

% return mapping table
Dec2ExpMappingTable = MappingTable;

% end function rs_GetDec2ExpMappingTable

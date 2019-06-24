%========================================================================
%   Copyright (C) 2005 Satelilte and Wireless Communication Lab of PKU
%   All Right Reserved.
%
%   Created     :   2006-3-15   13:12
%   Author      :   Bora (boraliu@pku.edu.cn)
%
%   File Name   :   RsChannel.m
%   Abstract    :   Function RsChannel( RsCode, NumberOfError,
%                                       ErrorPosition, ErrorValue )
%                   simulates a noise-added channel by adding ErrorValue
%                   noise at designated ErrorPosition.
%   
%   Version     :   1.0 2006-3-15
%==========================================================================
function [ RsCodeWithNoise ] = RsChannel( RsCode, NumberOfError, ErrorPosition, ErrorValue )

% first get parameters of RS code in use
[CodeLen, MsgLen, Exp2DecMappingTable] = GetRsCodeParam;

t = (CodeLen - MsgLen)/2;

% check the validity of input argument
if ( NumberOfError > t )
    Promote = sprintf('( %d, %d ) RS code could correct NO MORE THAN %d errors, input error number exceeds limit\nNo error added.\n', CodeLen, MsgLen );
    disp(Promote);
    RsCodeWithNoise = RsCode;
end;

if (size(ErrorPosition) ~= size(ErrorValue))
    Promote = sprintf( ' position of error matrix DOES NOT match error value matrix.\n No error added.\n ' );
    disp(Promote);
    RsCodeWithNoise = RsCode;
end;

[m, LenOfInputRsCode] = size( RsCode );
if LenOfInputRsCode ~= CodeLen
    Promote = sprintf( ' Input RS code length DOES NOT equals %d. Output a new RS code = [ 1:%d].\n ', CodeLen, CodeLen );
    disp(Promote);
    RsCodeWithNoise = [1:CodeLen];
end;

% after checking the validity of input argument, generate error on
% specified position.
for i = 1: NumberOfError
    RsCode(1, (ErrorPosition(1, i) + 1)) = RsSymbolAdd(RsCode(1, (ErrorPosition(1,i) + 1)), ErrorValue(1, i));
end;

RsCodeWithNoise = RsCode;


% end function rs_channel
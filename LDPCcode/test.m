% load v.mat;
% load H_ldpc.mat;
% check = v * H_ldpc';
% if check == zeros(1,1008)
%     disp('right')
% else
%     disp('wrong')
% end
% 
% load s.mat;
% load v.mat;
% load Hst;
% load H_ldpc;
% Input = ceil(rand(1,1008)*2)-1;
% check = Encode(Input, Hst); 
% check1 = mod(check * H_ldpc',2);
% c = zeros(1,1008);
% if check1 == c
%     disp('right')
% else
%     disp('wrong')
% end

load H_ldpc.mat;

H_var = zeros(2016,9);
H_var_len = zeros(2016,1);

for ii = 1:1:2016
    rec = 0;
    for jj = 1:1:1008
        if(H_ldpc(jj,ii)==1)
            rec = rec + 1;
            H_var(ii,rec) = jj; %表示第ii个节点参与了第jj个校验方程
        end
    end
    H_var_len(ii,1) = rec; %记录每个节点参与的校验方程的数量
end
save('H_var','H_var');
save('H_var_len','H_var_len');

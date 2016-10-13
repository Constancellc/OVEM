function total_scrap = find_scrap(new_tvs,new_per_scrap_rate)

abs_tvs = [0; new_tvs(2:end)-new_tvs(1:end-1)];
%[new_tvs abs_tvs]
new_tvs = abs_tvs;

ann_scrap = [new_per_scrap_rate(1); new_per_scrap_rate(2:end)-new_per_scrap_rate(1:end-1)];
new_per_scrap_rate = fliplr(ann_scrap);
% 
for i=1:length(new_per_scrap_rate)
    if new_per_scrap_rate(i)<0;
        new_per_scrap_rate(i)=0;
    else
    end
end

for i=1:length(new_tvs)
    if new_tvs(i)<0;
        new_tvs(i)=0;
    else
    end
end

scrap_tvs = zeros(length(new_tvs),length(new_tvs));%length(new_per_scrap_rate));
new_tvs_mat = scrap_tvs;

for i=1:length(new_tvs)
    new_tvs_mat(:,i) = new_tvs(:,1);
    
    for j=1:length(new_per_scrap_rate)
         %x(j) = (new_per_scrap_rate(end-j+1))/100;
        scrap_tvs(i,j) = new_tvs(i,1).*(new_per_scrap_rate(end-j+1))/100;
    end
end

% cumsum_scrap_tvs = cumsum(scrap_tvs,2)
total_scrap = zeros(length(new_tvs),1);
scrap_vec = total_scrap;
for i=1:length(new_tvs)
    total_scrap(i) = scrap_tvs(i,length(new_tvs)-i+1);
end

%total_scrap = fliplr(total_scrap)'

for i=1:length(new_tvs)
    scrap_vec(i,1:length(new_tvs)-i+1) = scrap_tvs(i,1:length(new_tvs)-i+1);
    
    %scrap_vec_ann(i,1:length(new_tvs)-1) = scrap_vec(i,1:length(new_tvs)-1)-scrap_vec(i,2:length(new_tvs));
%     if scrap_vec_ann(i,i)<0;
%         scrap_vec_ann(i,i)=0;
%     else
%     end
end
%a = scrap_vec;

% figure(12)
% plot(a)
% hold on
% plot(sum(a),':')
% hold off

 
%a = scrap_tvs
total_scrap = sum(scrap_vec,2)';



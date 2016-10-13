function gears = find_gear_ratio(simulate,final_drive_ratio,top_gear_ratio,...
    top_gear_number,max_w,w_range)

%% Find gear ratios
differential_ratio = final_drive_ratio;

if simulate == 1;
%Calculate gear ratio per gear based on a power fit of between the
%intial and final gears
lowest_gear_ratio = max_w/w_range;

y_top = log10(top_gear_ratio);
y_first = log10(lowest_gear_ratio);
x_first = log10(1);
x_top = log10(top_gear_number);

x = [x_top;x_first];
y = [y_top;y_first];
%Call polyfit function to return coefficient of x and constant
p = polyfit(x,y,1);
m = p(1);
c = p(2);

%Create vector of gears
gears = 10.^(m.*log10(1:1:top_gear_number+1)+c);

%Incrememnt gears by one to accommodate final drive ratio which is used to 
%pin the logarithmic curve at the other extreme from the top_gear_ratio

gears = gears(2:top_gear_number+1);%*differential_ratio; 

else
    gears = gear_ratio_vector(1:top_gear_number);%*differential_ratio;
end
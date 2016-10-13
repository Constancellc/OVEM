function [v_req,t,slope,distance_req,distance_req_alt,timestep,drive_cycle_name,...
    drive_cycle_length]=drive_cycle_3(drive_cycle_selection,number_of_drive_cycles)

%Title: drive_cycle_3
%
%Author: Reed Doucette
%
%Created: May 18, 2009
%
%Purpose: To output the drive cycle for the simulation to use.  The v here
%represents the requested velocity.
%
%List of Inputs:
%       drive_cycle_selection:
%           A positive integer that denotes which drive cycle was selected
%
%List of Outputs:
%       v_req:
%           the requested velocity of the drive cycle
%       t:
%           the time vector of the drive cycle
%       timestep: 
%           the time interval for the drive cycle
%       drive_cycle_name:
%           the string name of the drive cycle
%       drive_cycle_length:
%           the length of the drive cycle array
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Output the correct parameters based on the drive cycle selected

%NEDC
if drive_cycle_selection == 1 
    load CYC_nedc.mat
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='NEDC';
%Artemis Combined
elseif drive_cycle_selection == 2
    load CYC_artemis_combined.mat
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Artemis Combined';
%0-60 accel
elseif drive_cycle_selection==3
    %accel_time=input('Enter the 0-60 mph acceleration time in seconds: ');
    %check acceleration time entry
%     if accel_time<=0
%         error('the acceleration time needs to be greater than 0');
%     end
    %v_vector_for_accel=[0;0;5;10;15;20;25;30;35;39;43;47;51;54;57;59;60]; %mph
    v_vector_for_accel=vstart*ones(1,30);
    v_vector_for_accel(1,2:50)=vend;
    cyc_mph(:,1)=linspace(0,25,length(v_vector_for_accel));
    cyc_mph(:,2)=v_vector_for_accel;
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='0-60 acceleration';

%Bus Route
elseif drive_cycle_selection == 4
    load CYC_busrte.mat
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Bus Route';
  
    %US06 
elseif drive_cycle_selection==5
    load CYC_us06.mat
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='US06';
elseif drive_cycle_selection==6
    load CYC_hwfet
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='HWFET';
%EPA Combined City/Hwy
elseif drive_cycle_selection==7
    load CYC_epa_combined_city_hwy
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='EPA Combined City/Hwy';
%Artemis Tata -- artemis cycle but scaled so the maximum speed is 35 mph
%and the timescale is shortened so the maximum acceleration is 2.4 m/s^2
elseif drive_cycle_selection==8
    load CYC_artemis_tata
    %Extract the speed (mph) from the drive cycle array (its already in
    %m/s)
    v_req=cyc_mph(:,2);
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Artemis for Tata';
%FUDS (Federal Urban Driving Schedule)
elseif drive_cycle_selection==9
    load CYC_fuds
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='FUDS';
%NYC drive cycle
elseif drive_cycle_selection==10
    load CYC_nycc
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='NYC';
%HWFET scaled down to 25 mph max
elseif drive_cycle_selection==11
    load CYC_hwfet_scaled_to_25_mph
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='hwfet scaled to 25 mph max';
%FUDS scaled down to 25 mph max
elseif drive_cycle_selection==12
    load CYC_fuds_scaled_to_25_mph 
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='FUDS scaled to 25 mph max'; 
%EPA Combined scaled down to 25 mph max
elseif drive_cycle_selection==13
    load CYC_epa_combined_scaled_to_25_mph
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='EPA Combined scaled to 25 mph max';     
%Drive Cycle for the scooter EDF just prior to the charging event on May 21 2010
elseif drive_cycle_selection==14
    load CYC_edf_driving_before_may_21_recharge
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %convert the speed from mph to m/s
    v_req=v_req*.44704;
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Drive Cycle for the scooter EDF just prior to the charging event on May 21 2010'; 
%EPA Combined scaled down so the max speed is 30 mph
elseif drive_cycle_selection==15
    load CYC_epa_combined_scaled_to_30_mph
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Drive Cycle for the scooter EDF just prior to the charging event on May 21 2010';
elseif drive_cycle_selection==16
    load CYC_nedc_urban
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Urban component of the NEDC';    
elseif drive_cycle_selection==17
    load CYC_edf_scooter_may26pm_may27am
    %Extract the speed (mph) from the drive cycle array
    v_req=cyc_mph(:,2);
    %Extract the time (sec) entries from the drive cycle array
    time=cyc_mph(:,1);
    %Assign name
    drive_cycle_name='Dan Gorens EDF scooter on May 26 in the afternoon and May 27 in the morning'; 
    

elseif drive_cycle_selection == 18   
 cyc_kph = [1	0
2	16.66666667
3	33.33333333
4	50
5	50
6	50
7	50
8	50
9	50
10	50
11	50
12	50
13	50
14	50
15	50
16	50
17	50
18	50
19	50
20	50
21	0
22	0
23	0
24	0
25	0
26	0
27	0
28	0
29	0
30	0
31	0
32	0
33	0
34	0
35	0
36	0
37	0
38	0
39	0
40	0
41	100
42	100
43	100
44	100
45	100
46	100
47	100
48	100
49	100
50	100
51	100
52	100
53	100
54	100
55	100
56	100
57	100
58	100
59	100
60	100
61	100
62	100
63	100
64	100
65	100
66	100
67	100
68	100
69	100
70	100
71	100
72	100
73	100
74	100
75	100
76	100
77	100
78	100
79	100
80	100
81	80
82	80
83	80
84	80
85	80
86	80
87	80
88	80
89	80
90	80
91	80
92	80
93	80
94	80
95	80
96	80
97	80
98	80
99	80
100	80
101	120
102	120
103	120
104	120
105	120
106	120
107	120
108	120
109	120
110	120
111	120
112	120
113	120
114	120
115	120
116	120
117	120
118	120
119	120
120	120
121	120
122	120
123	120
124	120
125	120
126	120
127	120
128	120
129	120
130	120
131	0
132	0
133	0
134	0
135	0
136	0
137	0
138	0
139	0
140	0];

v_req= cyc_kph(:,2);
    %convert the speed from kph to m/s
    v_req = v_req*1000/3600;
    time= cyc_kph(:,1);
    %Assign name
    drive_cycle_name='Time to 100 kph';

end

%Determine the timestep
timestep=time(2)-time(1);

%Create number of repetitions of the drive cycle
v_req=repmat(v_req,number_of_drive_cycles,1);
t=zeros(length(time)*number_of_drive_cycles,1);
t(1)=time(1);
for ii=2:length(t)
    t(ii)=t(ii-1)+timestep;
end

%Establish slope pattern of the drive cycle
distance_req=zeros(length(v_req)-1,1);
distance_req(1)=trapz([t(1) t(2)],[v_req(1) v_req(2)]);
for i=2:length(v_req)-1
    distance_req(i)=trapz([t(i) t(i+1)],[v_req(i) v_req(i+1)])+distance_req(i-1);
end
    %Need to eliminate repeating values in the distance_req vector in order
    %for interpolation to work properly in the vehicle_backwards_3 block
    distance_req_alt(1)=distance_req(1);
    h_count=1;
    for i=2:length(distance_req)
        if distance_req(i)~=distance_req_alt(h_count)
            distance_req_alt(h_count+1)=distance_req(i);
            h_count=1+h_count;
        end
    end



    %Enter in slope parameter if the drive cycle does not have one (slope
    %needs to be in radians)
    slope=zeros(1,length(distance_req_alt));



%Establish the length of the drive cycle array
drive_cycle_length=length(v_req);



    
    
    
    
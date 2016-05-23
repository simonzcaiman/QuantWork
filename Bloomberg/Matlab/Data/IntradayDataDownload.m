%%Bloomberg Matlba Intraday Data Download and Store to csv file

% Log in to bloomberg terminal 

uuid=xxxxxxxx;
serverip='xxx.xxx.xx.xxx';
c=blp

disp('Start Downloading BBG intraday data from BBG')
%'ESM6 Index',
Tick_list={'UXM6 Index','JYM6 COMB Curncy','ECM6 COMB Curncy','RYM6 Curncy','IHM6 COMB Index','NIM6 COMB Index','CLM6 COMB Comdty'};
[m,n]=size(Tick_list);
for i=1:n

    S=Tick_list{i};
    fprintf('Start downloading data for %s \n',S)
    tic
    % Select the ticker
    %S = 'MSFT US Equity';
    %S='ESM6 Index'

    % Specify the start and end date
    StartDate='5/19/2013';
    EndDate='12/31/2016';

    %Download Trade, Bid and Ask
    d = timeseries(c,S,{StartDate,EndDate},1,'TRADE');
    fprintf('Finished downloading data(Trade) for %s \n',S)
    d1 = timeseries(c,S,{StartDate,EndDate},1,'BID');
    fprintf('Finished downloading data(Bid) for %s \n',S)
    d2 = timeseries(c,S,{StartDate,EndDate},1,'ASK');
    fprintf('Finished downloading data(Ask) for %s \n',S)


    % Store them into table format

    T = table;
    T.date=d(:,1);
    T.Trade_Open=d(:,2);
    T.Trade_High=d(:,3);
    T.Trade_Low=d(:,4);
    T.Trade_Closing=d(:,5);
    T.Trade_Volume=d(:,6);
    T.Trade_Number_of_Ticks=d(:,7);
    T.Trade_Tick_Value=d(:,8);

    T1 = table;
    T1.date=d1(:,1);
    T1.BID_Open=d1(:,2);
    T1.BID_High=d1(:,3);
    T1.BID_Low=d1(:,4);
    T1.BID_Closing=d1(:,5);
    T1.BID_Volume=d1(:,6);
    T1.BID_Number_of_Ticks=d1(:,7);
    T1.BID_Tick_Value=d1(:,8);

    T2 = table;
    T2.date=d2(:,1);
    T2.ASK_Open=d2(:,2);
    T2.ASK_High=d2(:,3);
    T2.ASK_Low=d2(:,4);
    T2.ASK_Closing=d2(:,5);
    T2.ASK_Volume=d2(:,6);
    T2.ASK_Number_of_Ticks=d2(:,7);
    T2.ASK_Tick_Value=d2(:,8);

    % joined the tables with date as key
    T_joined = outerjoin(T,T1,'MergeKeys',true);
    T_joined=outerjoin(T_joined,T2,'MergeKeys',true);


    %Write to txt 
    S1='.csv';
    C = strsplit(S,' ');
    target_path=strcat(C{1},S1);
    T_joined.date=datestr(T_joined.date);
    disp('Start writing to csv file')
    writetable(T_joined,target_path,'Delimiter',',');

    toc

end

disp('Congratulations ! You are done with data downloading!')







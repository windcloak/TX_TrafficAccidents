dm 'log; clear; output; clear';
*HW6.sas--Guo, Xinmei--4/1/19;
*EXST 4025 Assignment 6;
options pageno=1
	nodate
	sysprintfont=('SAS Monospace' 10)
	rightmargin=.75in
	leftmargin=.75in
	topmargin=.5in
	bottommargin=.5in;
ods listing;
ods html close;
ods graphics off;
title1 'Guo, Xinmei';
title2 'EXST 4025 Assignment 6';

libname hw6 'C:\Users\klaer\Documents\SAS\hw6';
options fmtsearch = (hw6 work sasuser); *Permanent format;

data hw6.A_recs (keep=AccNo AccDate Wkday Pop RoadClass LightCond FirstHarm 
			     AccSev Weather SurfCond TotalVeh)
	 hw6.B_recs (keep=AccNo VYr VStyle VType DrvAge DrvSex Ins DrvID 
				 DrvInj VOccs)
	 hw6.C_recs (keep=AccNo CasAge CasSex CasVeh CasInj);
	infile 'C:\Users\klaer\Documents\SAS\hw6\HW5TXAccs2001.TXT' missover;
	length AccNo $ 7 AccDate 4 WkDay 3 Pop RoadClass LightCond FirstHarm 
		   AccSev Weather SurfCond $ 1 TotalVeh 3 VYr 3 VStyle VType 
		   DrvAge $ 2 DrvSex Ins DrvID DrvInj $ 1 VOccs 3
		   CasAge $ 2 CasSex CasVeh CasInj $ 1;
	input @1 AccNo $7.
          @8 RecType $1. @;
	select (RecType);
		when ('A') do;
			input @18 Pop $1.
			      @19 RoadClass $1.
				  @20 Month 2.
				  @22 Day 2.
				  @27 LightCond $1.
				  @28 FirstHarm $1.
				  @29 AccSev $1.
				  @30 Weather $1.
				  @31 SurfCond $1.
				  @85 TotalVeh 2.;
			AccDate=mdy(Month,Day,2001);
			WkDay=weekday(AccDate);
			output hw6.A_recs;
		end; 
		when ('B') do; 
			input @10 VYrTemp1 $2.
				  @48 VYrTemp2 $2. @;
			array VehYr{2} VYrTemp1 VYrTemp2;
			do b=1 to 2;
				if b=1 then Bptr=15;
				else Bptr=53;
			
				if VehYr{b} ne ' ' then do;
					input @Bptr VStyle $2.
						  	  VType	 $2.
						  +4  DrvAge $2.
						  	  DrvSex $1.
						  +3  Ins	 $1.
						  +3  DrvID  $1.
						  	  DrvInj $1.
						  +11 VOccs  2. @;
					if VehYr{b}='++' then VYr=.;
					else if VehYr{b}>='70' then 
						VYr=input(cats('19',VehYr{b}),4.);
					else VYr=input(cats('20',VehYr{b}),4.);

					if DrvSex in ('1','3','7') then DrvSex='M';
					else if DrvSex in ('2','4','8') then DrvSex='F';
					else DrvSex='U'; *unknown sex;
					output hw6.B_recs;
				end; *if;
			end; *do;
		end; *when B;
		otherwise do; 
			input @10 (TCas1-TCas4) ($2. +9)
				  @64  TCas5 $2. @;
			array Cas {5} TCas1-TCas5;
			array Cptr{5} (10,21,32,43,64);
			do c=1 to 5;
				if Cas{c} ne ' ' then do;
					input @(Cptr{c}) CasAge $2.
						  	  	   CasSex $1.
							  	   CasVeh $1.
						  	+1     CasInj $1. @;
					if CasSex='1' then CasSex='M';
					else if CasSex='2' then CasSex='F';
					else if CasSex='+' then CasSex='U';	
					output hw6.C_recs;
				end; *if;
			end; *do;
		end; *otherwise do;
	end; *select;

	format AccDate date9.
		   AccSev DrvInj CasInj $Sev.
		   Pop 		 $Pop.
		   RoadClass $RdClass.
		   LightCond $Light.
		   FirstHarm $First.
		   Weather   $Weath.
		   SurfCond  $SurfCon.
		   WkDay	 DoW.
		   VStyle	 $VehSt.
		   VType	 $VehTy.
		   Ins		 $Ins.;
run;

title4 'Texas Traffic Accident Data Formats';

proc contents data=hw6.B_recs position;
run;

proc contents data=hw6.C_recs position;
run;

proc freq data=hw6.A_recs;
	tables Weather TotalVeh;
run;

proc freq data=hw6.B_recs;
	tables VYr VStyle;
run;

data PickupAccNos;
	set hw6.B_recs;
	where VStyle in ('30');
	keep AccNo;
	by AccNo;
	if first.AccNo;
run;

data PickupAccs;
	merge PickupAccNos(in=Pickup) hw6.A_recs;
	by AccNo;
	if Pickup;
run;

data PickupAccVehs;
	merge PickupAccNos(in=Pickup) hw6.B_recs;
	by AccNo;
	if Pickup;
run;

data PickupAccCas;
	merge PickupAccNos(in=Pickup)
		  hw6.C_recs(in=Cas);
	by AccNo;
	if Cas and Pickup;
run;

data PickupSingleRainyAccs Temp(keep=AccNo);
	set PickupAccs;
	if Weather='2' and TotalVeh=1;
run;

data RainySinglePickups;
	merge Temp(in=Rainy) PickupAccVehs;
	by AccNo;
	if Rainy;
run;

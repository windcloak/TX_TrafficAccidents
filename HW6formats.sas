dm 'log; clear; output; clear';
*HW5formats.sas--Guo, Xinmei--3/24/2019;
*EXST 4025 Assignment 5;
title1 'Guo, Xinmei';
title2 'EXST 4025 Assignment 5';
options pageno=1
	nodate
	rightmargin=.75in
	leftmargin=.75in
	topmargin=1in
	bottommargin=.5in;
ods listing;
ods html close;
ods graphics off;
libname library 'C:\Users\klaer\Documents\SAS\hw5';

proc format lib=library;
	value $Pop '0' = 'Rural'
			   '1' = 'under 2,500'
			   '3' = '2,500-4,999'
			   '4' = '5,000-9,999'
			   '5' = '10,000-24,000'
			   '6' = '25,000-49,999'
			   '7' = '50,000-99,999'
			   '8' = '100,000-249,999'
			   '9' = '250,000+';
	value $RdClass '1' = 'Interstate'
				   '2' = 'US & state hw'
				   '3' = 'Farm to Market'
				   '4' = 'County'
				   '5' = 'City st'
				   '6' = 'Tollway'
				   '7' = 'Other (alley)'
				   '8' = 'Beltway 8 toll';
	value DoW 1 = 'Sun'
			  2 = 'Mon'
			  3 = 'Tue'
			  4 = 'Wed'
			  5 = 'Thu'
			  6 = 'Fri'
			  7 = 'Sat';
	value $Light '1' = 'Daylight'
				 '2' = 'Dawn'
				 '3' = 'Dark unlit'
				 '4' = 'Dark lit'
				 '5' = 'Dusk';
	value $First '1' = 'Hit pedestrian'
				 '2' = 'Hit moving veh'
				 '3' = 'Hit train'
				 '4' = 'Hit parked veh'
				 '5' = 'Hit pedalcyclist'
				 '6' = 'Hit animal'
				 '7' = 'Hit fixed obj'
				 '8' = 'Hit other obj'
				 '0' = 'Overturned'
				 '-' = 'Other non-collision';
	value $Sev '1' = 'Incapacitating inj'
			   '2' = 'Nonincap inj'
			   '3' = 'Possible inj'
			   '4' = 'Fatal'
			   '5' = 'No injury';
	value $Weath '1' = 'Clear (cloudy)'
				 '2' = 'Raining'
				 '3' = 'Snowing'
				 '4' = 'Fog'
				 '5' = 'Blowing dust'
				 '6' = 'Smoke'
				 '7' = 'Other'
				 '8' = 'Sleeting';
	value $SurfCon '1' = 'Dry'
				   '2' = 'Wet'
				   '3' = 'Muddy'
				   '4' = 'Snowy/icy';
	value $VehSt '00' = 'see veh type'
				 '++' = 'unknown'
				 '01' = '2-door'
				 '04' = '4-door'
				 '06' = 'Station wagon'
				 '07' = 'Convertible'
				 '09' = 'Ambulance'
				 '10' = 'Hearse'
				 '11' = 'Limousine'
				 '20' = 'Beverage trk'
				 '21' = 'Bob-tail trk'
				 '22' = 'Dump trk'
				 '23' = 'Fire trk'
				 '24' = 'Flatbed trk'
				 '25' = 'Livestock trk'
				 '26' = 'Garbage trk'
				 '27' = 'Mixer trk'
				 '28' = 'Motor home/camper'
				 '29' = 'Panel/small van'
				 '30' = 'Pickup trk'
				 '31' = 'Pole (log) trk'
				 '32' = 'Refrigerator trk'
				 '33' = 'Utility veh'
				 '34' = 'Tank trk'
				 '35' = 'Travelall/Carryall'
				 '36' = 'Van (large, furn)'
				 '37' = 'Wrecker trk'
				 '38' = 'Pickup trk/camper'
				 '39' = 'Oilfield equip'
				 '40' = 'Other';
	value $VehTy '01' = 'Pass car'
				 '02' = 'Pass car & trailer'
				 '03' = 'Pass car & house trailer'
				 '04' = 'Truck'
				 '05' = 'Truck & trailer'
				 '06' = 'Truck-tractor & semi'
				 '07' = 'Truck & house trailer'
				 '08' = 'Other truck combo'
				 '09' = 'Farm tractor'
				 '10' = 'Road machinery'
				 '11' = 'Bus'
				 '12' = 'School bus'
				 '13' = 'Motorcycle'
				 '14' = 'Motorscooter/bike'
				 '15' = 'Other machinery'
				 '16' = 'Moped'
				 '17' = 'Ambulance'
				 '++' = 'unknown';
	value $Ins '1' = 'Yes'
			   '2' = 'No'
			   '3' = 'unk';
	value $Age '++' = 'unk'
			   '00' - '05' = '5 or under'
			   '06' - '10' = '6-10'
			   '11' - '15' = '11-15'
			   '16' - '20' = '16-20'
			   '21' - '25' = '21-25'
			   '26' - '30' = '26-30'
			   '31' - '35' = '31-35'
			   '36' - '40' = '36-40'
			   '41' - '45' = '41-45'
			   '46' - '50' = '46-50'
			   '51' - '55' = '51-55'
			   '56' - '60' = '56-60'
			   '61' - '65' = '61-65'
			   '66' - '70' = '66-70'
			   '70' - high = 'over 70';
run;
proc format lib=library fmtlib;
	title4 'Texas Traffic Accident Data Formats';
run;

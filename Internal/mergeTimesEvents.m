function event = mergeTimesEvents(event1,event2,time)

auxones1 = event2steps(event1,time);
auxones2 = event2steps(event2,time);

ones = ((auxones1+auxones2)>0)*1;

times = IniTerSac(ones,time);

event.startTimes = times(:,1);
event.endTimes = times(:,2);

end

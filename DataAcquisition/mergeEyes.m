function newEvent = mergeEyes(event1,event2,time,type)

ones1 = logical(event2steps(event1,time));
ones2 = logical(event2steps(event2,time));

if type == 1
    ones = ones1.*ones2;
    aux = IniTerSac(ones,time);
elseif type == 2
    ones = (~ones1).*(~ones2);
    aux = IniTerSac(~ones,time);
end

newEvent.startTimes = aux(:,1);
newEvent.endTimes = aux(:,2);

end

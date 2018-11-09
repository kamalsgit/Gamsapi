* Set of all people who are assigned cards (Emp = Members)
set Emp/
[Emp]
/;

* Set of all Trello boards - there may be more that one board on the include file (Project = Board)
set Project/
[Project]
/;

* This set defines the relationship bewteen the board, the card number, and the card member (only one)
set ProjAssign2Emp(Project,Cards,Emp)/
"Trello to GAMS API"."C1"."Kamal"
[projAssign]

/;

* This parameter defines the expected number of hours to complete the card 
* The expected number of hours is in () at the begining of card name
parameter ProjAssign2Hrs(Project,Cards)/
"Trello to GAMS API"."C1"=0.25
[projAssignHrs]
/;

* If a dependecy exists (defined by "DepCard Cn") then this tuple is set to 1, else not explicitly
* defined or 0.
parameter ProjDepend(Project,Cards,DepCards)/
"Trello to GAMS API"."C1"."C2"=1
[ProjDepend]
/;

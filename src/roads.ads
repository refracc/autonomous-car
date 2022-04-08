package roads with
   SPARK_Mode
is

   type Limit is new Integer range 0 .. 240;
   type RoadType is range 0 .. 2;

   type Road is tagged record
      lim    : Limit    := 20;
      rdtype : RoadType := 1;
   end record;

   function RoadInvariant (This : in Road) return Boolean is
     (This.rdtype >= RoadType'First and This.rdtype <= RoadType'Last);

end roads;

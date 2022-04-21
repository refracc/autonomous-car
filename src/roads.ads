package roads with
   SPARK_Mode
is

   type Limit is new Integer range 0 .. 240;
   type LightLevel is new Integer range 0 .. 16;

   type Road is tagged record
      lim   : Limit      := 20;
      light : LightLevel := 10;
   end record;

   function RoadSpeedInvariant (lim : in Limit) return Boolean is
      (lim > 0);

end roads;

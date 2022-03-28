package road with SPARK_Mode is

    type Limit is new Integer;
    type RoadType is range 0..2;

    type Road is tagged record
        lim: Limit := 20;
        rdtype: RoadType := 1;
    end record;

    

end road;
with roads; use roads;
package car with
   SPARK_Mode
is

   type Parked is new Boolean;
   type BatteryCharge is range 0 .. 100;
   type Speed is new Integer range 0 .. 240;
   type CarGear is new Integer range 0 .. 4;
   type Diagnostic is new Boolean;
   type Headlights is new Boolean;

   type Car is tagged record
      battery   : BatteryCharge := 85;
      park      : Parked        := True;
      car_speed : Speed         := 0;
      gear      : CarGear       := 0;
      running   : Diagnostic    := False;
      lights    : Headlights    := False;
   end record;

   -- Invariants
   function SpeedInvariant (sp : in Speed) return Boolean is
     (sp <= Speed'Last and sp >= Speed'First);

   function MinimumChargeInvariant
     (battery : in BatteryCharge) return Boolean is
     (battery <= BatteryCharge'Last and
      battery > (BatteryCharge'First + (BatteryCharge'Last / 10)));

   function PowerInvariant (gear : in CarGear) return Boolean is
     (gear = CarGear'First);

   -- Procedures for Functionality
   procedure RunDiagnostics (This : in out Car) with
      Pre'Class =>
      (This.battery = BatteryCharge'Last and This.park = True and
       This.car_speed = Speed'First and PowerInvariant (This.gear)),
      Post =>
      (This.battery = BatteryCharge'Last and This.park = True and
       This.car_speed = Speed'First and PowerInvariant (This.gear));

   procedure Accelerate
     (This : in out Car; rd : in Road; Probability : in Integer;
      X    : in     Integer) with
      Pre'Class =>
      (MinimumChargeInvariant (This.battery) and X > 0 and
       SpeedInvariant (This.car_speed) and
       Integer (This.car_speed) <= Integer (rd.lim) and
       This.gear = CarGear (3)),
      Post =>
      (This.car_speed <= Speed'Last and This.battery <= BatteryCharge'Last);

   procedure CheckForObstruction
     (This : in out Car; Probability : in Integer; X : in Integer) with
      Pre'Class =>
      (This.car_speed > Speed'First and SpeedInvariant (This.car_speed)),
      Post =>
      ((This.car_speed >= Speed'First) and
       This.battery <= BatteryCharge'Last and
       This.battery >= BatteryCharge'First);

   procedure DisableDiagnostics (This : in out Car) with
      Pre'Class =>
      (This.battery = BatteryCharge'Last and PowerInvariant (This.gear) and
       This.car_speed = Speed'First),
      Post =>
      (This.battery = BatteryCharge'Last and This.car_speed = Speed'First and
       PowerInvariant (This.gear));

   procedure Charge (This : in out Car) with
      Pre'Class =>
      (This.battery < BatteryCharge'Last and This.gear = CarGear'First),
      Post => (This.battery = BatteryCharge'Last);

   procedure CheckLightLevel (This : in out Car; rd : in Road) with
      Pre'Class =>
      (rd.light <= (LightLevel'Last) / 2 and
       MinimumChargeInvariant (This.battery)),
      Post => ((This.lights = True) and MinimumChargeInvariant (This.battery));

end car;

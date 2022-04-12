with roads; use roads;
package car with
   SPARK_Mode
is

   type Parked is new Boolean;
   type BatteryCharge is range 0 .. 100;
   type Speed is new Integer range 0 .. 240;
   type CarGear is new Integer range 0 .. 4;
   type Diagnostic is new Boolean;

   type Car is tagged record
      battery   : BatteryCharge := 85;
      park      : Parked        := True;
      car_speed : Speed         := 0;
      gear      : CarGear       := 0;
      running   : Diagnostic    := False;
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
       This.car_speed = Speed'First);

   procedure Accelerate
     (This : in out Car; rd : in Road; Probability : in Integer;
      X    : in     Integer) with
      Pre'Class => (MinimumChargeInvariant (This.battery) and X > 0),
      Post      => (This.car_speed <= Speed'Last);

   procedure CheckForObstruction
     (This : in out Car; Probability : in Integer; X : in Integer) with
      Pre'Class =>
      (This.car_speed > Speed'First and SpeedInvariant (This.car_speed));

   procedure DisableDiagnostics (This : in out Car) with
      Pre'Class =>
      (This.battery = BatteryCharge'Last and PowerInvariant (This.gear));

   procedure Charge (This : in out Car) with
      Pre'Class =>
      (This.battery < BatteryCharge'Last and This.gear = CarGear'First),
      Post => (This.battery = BatteryCharge'Last);
end car;

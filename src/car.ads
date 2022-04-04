with roads; use roads;
package car with SPARK_Mode is

  type Parked is new Boolean;
  type BatteryCharge is range 0..100;
  type Speed is new Integer range 0..240;
  type CarGear is range 0..3;
  type Charging is new Boolean;

  type Car is tagged record
    battery: BatteryCharge := 85;
    park: Parked := True;
    car_speed: Speed := 0;
    gear: CarGear := 0;
    charge: Charging := False;
  end record;

   -- Invariants
  function SpeedInvariant (sp : in Speed) return Boolean is
    (sp <= Speed'Last and sp >= Speed'First);

  function MinimumChargeInvariant (battery : in BatteryCharge) return Boolean is
    (battery <= BatteryCharge'Last and battery > (BatteryCharge'First + (BatteryCharge'First / 10)));

  function PowerInvariant (gear : in CarGear) return Boolean is
    (gear = CarGear'First);

  procedure ChangeGear(This : in out Car) with
    Pre'Class => (This.car_speed = 0),
    Post => (This.gear >= CarGear'First and This.gear <= CarGear'Last);

  procedure Accelerate (This : in out Car; rd: in Road) with
    Pre'Class => (This.car_speed > Speed'First and This.car_speed <= Speed'Last),
    Post => (This.car_speed <= Speed'Last);

  procedure Update (This : in out Car) with
    Pre'Class => (This.car_speed > Speed'First and This.battery > BatteryCharge'First),
    Post => (This.battery >= BatteryCharge'First and This.battery <= BatteryCharge'Last);
end car;

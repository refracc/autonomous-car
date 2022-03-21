with Ada.Text_IO; use Ada.Text_IO;
package body car with SPARK_Mode is

   procedure Accelerate(This : in out Car) is begin
      if (MinimumChargeInvariant(This.battery) and This.gear = 1 and This.car_speed < Speed'Last) then
         This.car_speed := This.car_speed + 1;
         Update(This);
      end if;
   end Accelerate;

   procedure Update (This : in out Car) is begin
      if (This.car_speed > 0) then
         This.battery := This.battery - 1;
      end if;

      if (This.car_speed = 0 and This.charge = True) then
         This.battery := This.battery + 1;
      end if;

      if (This.battery < (BatteryCharge'First + (BatteryCharge'First / 10))) then
         Put_Line("The car only has " & This.battery'Image & "% left! Pulling over for charging...");
      end if;
   end Update;
end car;

with Ada.Numerics.Discrete_Random;
with roads; use roads;
with car;   use car;
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
package body car with
   SPARK_Mode
is

   procedure Accelerate (This : in out Car; rd : in Road) is
   begin
      if
        (MinimumChargeInvariant (This.battery) and This.gear = 3 and
         Integer (This.car_speed) <= Integer (rd.lim) and
         (not Boolean (This.running)))
      then
         while (Integer (This.car_speed) < Integer (rd.lim)) loop
            if (MinimumChargeInvariant (This.battery)) then
               This.battery   := This.battery - 1;
               This.car_speed := This.car_speed + 1;
            end if;

            if (not MinimumChargeInvariant (This.battery)) then
               Put_Line
                 ("The car only has " & This.battery'Image &
                  "% left! Pulling over for charging...");
               -- Charge()
            end if;

            while
              (This.battery >
               (BatteryCharge'First + (BatteryCharge'Last / 10)))
            loop
               This.battery := This.battery - 1;
               if (not MinimumChargeInvariant (This.battery)) then
                  Put_Line
                    ("The car only has " & This.battery'Image &
                     "% left! Pulling over for charging...");
               end if;
            end loop;

            delay (Duration (2));
         end loop;
      else
         Put_Line ("Unable to move...");
      end if;
   end Accelerate;

   procedure ChangeGear (This : in out Car) is
      Gear : String := "-1";
   begin
      if (This.car_speed = 0 and (not Boolean (This.running))) then
         while Gear /= "0" or Gear /= "1" or Gear /= "2" or Gear /= "3" loop
            Put_Line ("Which gear would you like the car to go in to?");
            Put_Line ("[0] - Park");
            Put_Line ("[1] - Reverse");
            Put_Line ("[2] - Neutral");
            Put_Line ("[3] - Drive");

            declare
               Choice : String := Ada.Text_IO.Get_Line;
            begin
               Gear := Choice;

               if (Gear = "0" or Gear = "1" or Gear = "2" or Gear = "3") then
                  This.gear := CarGear (Integer'Value (Gear));
               end if;
            end;
         end loop;
      else
         Put_Line ("Unable to change gear...");
      end if;

   end ChangeGear;

   procedure RunDiagnostics (This : in out Car) is
   begin
      if (This.battery = BatteryCharge'Last) then
         if (not This.running) then
            This.running := True;
            Put_Line
              ("This vehicle is currently running diagnostics... All functionality has been disabled.");
            delay (Duration (15));
            Put_Line
              ("All functionality has been resumed. Car diagnosis complete, and has found significant faults with the system.");
            Put_Line
              ("Parts valuing £12,435.86 have been ordered from the bank account registered to this car.");
         end if;
      else
         Put_Line ("The battery must be fully charged to run diagnostics.");
      end if;

   end RunDiagnostics;

   procedure DisableDiagnostics (This : in out Car) is
   begin
      if (This.running) then
         This.running := False;
         Put_Line ("Disabling diagnostics...");
         delay (Duration (5));
         Put_Line ("Diagnostics disabled.");
      end if;
   end DisableDiagnostics;

   procedure CheckForObstruction
     (This : in out Car; Probability : in Integer; X : in Integer)
   is
   begin
      if ((Integer (X) > Probability) and (This.gear = 3 or This.gear = 1))
      then
         Put_Line ("Obstruction ahead in road... Stopping...");

         while This.car_speed > 0 loop
            if (This.battery < BatteryCharge'Last) then
               if (This.battery mod 4 = 0) then
                  This.battery := This.battery + 1;
               end if;
               This.car_speed := This.car_speed - 1;
            else
               This.car_speed := This.car_speed - 1;
            end if;
         end loop;
         ChangeGear (This);
      end if;

   end CheckForObstruction;

end car;

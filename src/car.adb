with Ada.Numerics.Discrete_Random;
with roads; use roads;
with car;   use car;
with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
package body car with
   SPARK_Mode
is

   procedure Accelerate
     (This : in out Car; rd : in Road; Probability : in Integer;
      X    : in     Integer)
   is
   begin
      if
        (MinimumChargeInvariant (This.battery) and This.gear = 3 and
         Integer (This.car_speed) <= Integer (rd.lim) and
         (not Boolean (This.running)))
      then
         Put_Line ("Moving car...");
         while (Integer (This.car_speed) < Integer (rd.lim)) loop
            if (MinimumChargeInvariant (This.battery)) then
               This.battery   := This.battery - 1;
               This.car_speed := This.car_speed + 1;
               Put_Line
                 ("Car is moving! Speed: " & This.car_speed'Image &
                  " (Battery: " & This.battery'Image & ")");
               CheckForObstruction (This, Probability, X);
            end if;
         end loop;

         if (not MinimumChargeInvariant (This.battery)) then
            Put_Line
              ("The car only has " & This.battery'Image &
               "% left! Pulling over for charging...");
            while This.car_speed > 0 and MinimumChargeInvariant (This.battery)
            loop
               if (This.battery < BatteryCharge'Last) then
                  if (This.battery mod 4 = 0) then
                     This.battery := This.battery + 1;
                  end if;
                  This.car_speed := This.car_speed - 1;
               else
                  This.car_speed := This.car_speed - 1;
               end if;
            end loop;
         end if;

         while
           (This.battery > (BatteryCharge'First + (BatteryCharge'Last / 10)))
         loop
            This.battery := This.battery - 1;
            Put_Line
              ("Car is moving! Speed: " & This.car_speed'Image &
                 " (Battery: " & This.battery'Image & ")");
            if (This.car_speed > Speed'First) then
               CheckForObstruction (This, Probability, X);
            end if;
            if (not MinimumChargeInvariant (This.battery)) then
               Put_Line
                 ("The car only has " & This.battery'Image &
                  "% left! Pulling over for charging...");
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
            end if;

            delay (Duration (2));
         end loop;
      else
         Put_Line ("Unable to move...");
      end if;
   end Accelerate;

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
      end if;

   end CheckForObstruction;

   procedure Charge (This : in out Car) is
   begin
      Put_Line ("Charging car (this may take a while)...");
      while (This.battery < BatteryCharge'Last) loop
         This.battery := This.battery + 1;
         Put_Line ("Car battery is now at " & This.battery'Image & "%.");
         delay (Duration (1));
      end loop;
      Put_Line ("Car has been fully charged.");
   end Charge;

end car;

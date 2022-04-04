with roads; use roads;
with Ada.Text_IO, Ada.Integer_Text_IO; use Ada.Text_IO, Ada.Integer_Text_IO;
package body car with SPARK_Mode is

   procedure Accelerate(This : in out Car; rd: in Road) is begin
      if (MinimumChargeInvariant(This.battery) and This.gear = 1 and Integer(This.car_speed) < Integer(rd.lim)) then
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

   procedure ChangeGear (This : in out Car) is
      Gear : Integer;
   begin
      if (This.car_speed = 0) then
         Put_Line("Which gear would you like the car to go in to?");
         Put_Line("[0] - Park");
         Put_Line("[1] - Reverse");
         Put_Line("[2] - Neutral");
         Put_Line("[3] - Drive");

         Get(Gear);

         if (Integer(Gear) >= Integer(CarGear'First) and Integer(Gear) <= Integer(CarGear'Last)) then
            This.gear := CarGear(Gear);
         end if;


         while Integer(Gear) < Integer(CarGear'First) and Integer(Gear) > Integer(CarGear'Last) loop
            Put_Line("Which gear would you like the car to go in to?");
            Put_Line("[0] - Park");
            Put_Line("[1] - Reverse");
            Put_Line("[2] - Neutral");
            Put_Line("[3] - Drive");

            Get(Gear);

            if (Integer(Gear) >= Integer(CarGear'First) and Integer(Gear) <= Integer(CarGear'Last)) then
               This.gear := CarGear(Gear);
            end if;

         end loop;
      end if;
   end ChangeGear;
end car;

with car;         use car;
with roads;       use roads;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   subtype RandomRange is Integer range 0 .. 100;

   package rand is new Ada.Numerics.Discrete_Random (RandomRange);
   use rand;
   G      : Generator;
   X      : RandomRange;
   C      : car.Car;
   R      : roads.Road;
   Choice : String := "-1";
begin

   if (C.car_speed = 0) then
      while (Choice /= "1" or Choice /= "2" or Choice /= "3" or Choice /= "4" or Choice /= "5")
      loop
         Put_Line ("What would you like to do with your car?");
         Put_Line ("");
         Put_Line ("+-----+-----------------+");
         Put_Line ("| [1] | Drive the car   |");
         Put_Line ("+-----+-----------------+");
         Put_Line ("| [2] | Reverse the car |");
         Put_Line ("+-----+-----------------+");
         Put_Line ("| [3] | Charge the car  |");
         Put_Line ("+-----+-----------------+");
         Put_Line ("| [4] | Change car gear |");
         Put_Line ("+-----+-----------------+");
         Put_Line ("| [5] | Run Diagnostics |");
         Put_Line ("+-----+-----------------+");
         Put_Line ("");

         declare
            Choice : String := Ada.Text_IO.Get_Line;
         begin

            if (Choice = "1") then
               Put_Line ("Car moving foward...");
               Accelerate (C, R);
               Reset (G);
               X := Random (G);
               CheckForObstruction (C, 80, X);
            elsif (Choice = "2") then
               C.gear := 1;
               Put_Line
                 ("Car reversing... *beep* *beep* *beep* *beep* *beep* *beep*");
               Reset (G);
               X := Random (G);
               CheckForObstruction (C, 80, X);
            elsif (Choice = "3") then
               Put_Line ("Charging the vehicle...");
               --Charge();
            elsif (Choice = "4") then
               ChangeGear (C);
            elsif (Choice = "5") then
               RunDiagnostics (C);
               DisableDiagnostics (C);
            end if;
         end;

      end loop;
   end if;
end Main;

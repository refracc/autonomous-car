with car;         use car;
with roads;       use roads;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   subtype RandomRange is Integer range 0 .. 100;

   package rand is new Ada.Numerics.Discrete_Random (RandomRange);
   use rand;
   G : Generator;
   X : RandomRange;
   C : car.Car;
   R : roads.Road;

   Choice : String := "A";
   Gear   : String := "-1";
begin
   Put_Line ("Attempting to turn on vehicle....");
   if (C.gear = CarGear (0) and Boolean (C.park)) then
      delay (Duration (5));
      Put_Line ("[engine starts]");
   end if;
   while
     (not
      (Choice = "1" or Choice = "2" or Choice = "3" or Choice = "4" or
       Choice = "5"))
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
            R.lim   := 40;
            R.light := 6;

            Reset (G);
            X := Random (G);
            CheckLightLevel (C, R);
            Accelerate (C, R, 65, X);
         elsif (Choice = "2") then
            C.gear := 1;
            Put_Line ("Car reversing... *beep* *beep*");
            Put_Line ("");

            Reset (G);
            X := Random (G);
            CheckForObstruction (C, 80, X, R);
         elsif (Choice = "3") then
            Charge (C);
         elsif (Choice = "4") then
            Put_Line ("Which gear would you like to go into?");
            Put_Line ("");
            Put_Line ("+-----+---------+");
            Put_Line ("| [0] | Park    |");
            Put_Line ("+-----+---------+");
            Put_Line ("| [1] | Reverse |");
            Put_Line ("+-----+---------+");
            Put_Line ("| [2] | Neutral |");
            Put_Line ("+-----+---------+");
            Put_Line ("| [3] | Drive   |");
            Put_Line ("+-----+---------+");
            Put_Line ("");

            declare
               ChosenGear : String := Ada.Text_IO.Get_Line;
            begin

               if
                 (ChosenGear = "0" or ChosenGear = "1" or ChosenGear = "2" or
                  ChosenGear = "3")
               then
                  C.gear := CarGear (Integer'Value (ChosenGear));
               else
                  Put_Line ("Invalid gear selected.");
                  Put_Line ("");
               end if;
            end;
         elsif (Choice = "5") then
            RunDiagnostics (C);
            DisableDiagnostics (C);
         end if;

         Choice := "A";
      end;
   end loop;
end Main;

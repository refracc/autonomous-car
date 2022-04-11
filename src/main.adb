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
   Choice : Integer := -1;
   Chosen : Integer := 0;
begin
   Reset (G);
   X := Random (G);
   CheckForObstruction (C, 80, X);

   while Integer (Choice) < 1 and Integer (Choice) > 4 loop
      Put_Line ("What would you like to do with your car?");
      Put_Line ("");
      Put_Line ("+-----+-----------------+");
      Put_Line ("| [1] | Drive the car   |");
      Put_Line ("+-----+-----------------+");
      Put_Line ("| [2] | Reverse the car |");
      Put_Line ("+-----+-----------------+");
      Put_Line ("| [3] | Charge the car  |");
      Put_Line ("+-----+-----------------+");
      Put_Line ("| [4] | Run Diagnostics |");
      Put_Line ("+-----+-----------------+");

      --Get(Choice);

      if (Choice >= 1 and Choice <= 4) then
         Chosen := Choice;
         if (Chosen = 1) then
            Accelerate (C, R);
         end if;
      end if;

   end loop;

end Main;

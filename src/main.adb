with car; use car;
with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   subtype RandomRange is Integer range 0..100;

   package r is new Ada.Numerics.Discrete_Random(RandomRange);
   use r;
   G : Generator;
   X : RandomRange;
   C : Car.Car;
begin
   Reset(G);
   X := Random(G);
   CheckForObstruction(C, 80, X);
   null;
end Main;

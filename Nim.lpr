program Nim;
uses sysutils, variants, crt;

procedure DrawDivider(len : integer); //draws a divider/line of the specified length
//draws a horizontal line divider for the specified length
var i : integer; //lcv
begin
     for i := 0 to len do
     begin
       write('-');
     end;
     writeln();
end;

procedure InttoDigits(n:integer; var digits:array of integer; var len : integer); //splits an integer into an array of it's digits
var
   i : integer; //count
   j : integer; //count
   last : integer; //the last item in the array
   d : array [0..99] of integer; //array of digits
begin
   i := 0;
   repeat
       i += 1;
       d[i] := n mod 10;
       n := n div 10;
   until n = 0;
   len := i;
   last := i-1;
   for j := last downto 0 do
   begin
       digits[j] := d[len-j];
   end;
end;

function pwr(x: integer; n: integer):integer; //Power function, calcs x^n for pwr(x,n)
var
  tmp: integer;
  i: integer; //count
begin
  tmp := x;
  if n = 0 then
  begin
       tmp := 1;
  end
  else if (n > 0) then
  begin
       for i := 2 to n do
       begin
            tmp := tmp*x;
       end;
  end
  else if (n < 0) then
  begin
       n := abs(n);
       for i := 2 to n do
       begin
            tmp := tmp*x;
       end;
       tmp := 1 div tmp;
  end;

  pwr := tmp;
end;

function GetInput(typ : string; caption : string):variant; //writes a caption, reads, validates and returns input
  var
    input : string; //the user input
    valid : boolean; //whether the input is valid for the specified type
    value : variant; //the input value that will be returned

begin
  valid := false;
  while valid = false do //keep asking for input until valid
  begin
    writeln(caption);
    readln(input);
    if typ = 'string' then //pass input straight through for strings
    begin
         valid := true;
         value := input;
    end
    else if typ = 'integer' then //validate integer
    begin
         value := StrToIntDef(input,-198); //sets an unlikely default value to test for invalid data without error
         if value <> 198 then
         begin
           valid := true;
         end else
         begin
           writeln('Input must be a valid whole number. Try again.');
         end;
    end
    else if typ = 'posinteger' then //validate postive integer
    begin
         value := StrToIntDef(input,198); //sets an unlikely default value to test for invalid data without error
         if (value <> 198) and (value > 0) then
         begin
           valid := true;
         end else
         begin
           writeln('Input must be a valid postive whole number. Try again.');
         end;
    end
    else if typ = 'boolean' then //validate boolean (yes/no input)
    begin
         if input = 'yes' then
         begin
             valid := true;
             value := true;
         end
         else if input = 'no' then
         begin
             valid := true;
             value := false;
         end else
         begin
             writeln('Please type "yes" or "no" in lowercase letters. Try again.');
         end;
    end
    else
    begin //if no type specified pass the input straight through
         valid := true;
         value := input;
    end;
  end;
  GetInput := value; //returns the input value
end;

function InttoBin(n:integer):integer; //converts an base 10 integer to a binary number
var
   bin : integer; //binary number
   rem : 0..1; //remainder
   c : integer; //count
begin
   c := 0;
   bin := 0;
   while (n > 0) do //run until the quotient is 0
   begin
     rem := n mod 2;
     bin += rem*pwr(10,c); //add the binary digit
     c+=1;
     n := n div 2;
   end;
   InttoBin := bin;
end;

function BintoInt(b:array of integer;len:integer):integer; //converts a binary number into a base 10 integer
var
   int : integer; //base 10 integer
   c : integer; //count
begin
   int:=0;
   for c := 0 to len-1 do
   begin
     int += b[c]*pwr(2,len-1-c);  //times each digit by the respective power of 2
   end;
   BintoInt := int;
end;

procedure Game(com:boolean); //runs the game
  type
     piletype = array [1..6] of integer;
     pilestype = 2..6;
     movetype = 1..2;
     winnertype = 0..2;
  var
     piles : pilestype; //number of piles
     pile : piletype; //number of matches in each pile
     winner : winnertype; //the winner of the game
     move : movetype; //which players move it is
     safe : boolean; //the game's state

  procedure StartGame(var piles : pilestype; var pile : piletype;var move : movetype; var winner : winnertype);  //initialises the game
  var
     i : integer; //count
  begin
    for i := 1 to piles do
    begin
     pile[i] := random(30)+1;
    end;
    move := 1;
    winner := 0;
  end;

  procedure InputPiles(var piles:pilestype); //input the number of piles in the game
  var
     valid:boolean; //valid input flag
     inp:integer; //input
  begin
    valid:=false;
    while valid = false do
    begin
      writeln();
      inp:=getinput('posinteger','How many piles of matches do you want?');
      if (inp <= 6) and (inp > 1) then
      begin
        valid := true;
        piles := inp;
      end else
      begin
        writeln('Number of Piles must be between 2 and 6. Please try again.');
      end;
    end;
  end;

  procedure DrawPiles(piles : pilestype; pile : piletype); //draws the piles of matches
  var
     i:integer; //counter
     match:string; //match ascii art
  begin
    match:= '===';
    writeln();
    write('  ');
    for i:= 1 to piles do
    begin
      write('Pile ':10,i:1);
    end;

    writeln();
    writeln();
    write(' ');
    for i:= 1 to piles do
    begin
      if pile[i] > 20 then
        begin
          write(match:10);
          textcolor(red);
          write(chr(149):1);
          textcolor(white);
        end else write('':11);
    end;

    writeln();
    write(' ');
    for i:= 1 to piles do
    begin
      if pile[i] > 10 then
        begin
          write(match:10);
          textcolor(red);
          write(chr(149):1);
          textcolor(white);
        end else write('':11)
    end;

    writeln();
    write(' ');
    for i:= 1 to piles do
    begin
      if pile[i] > 0 then
        begin
          write(match:10);
          textcolor(red);
          write(chr(149):1);
          textcolor(white);
        end else write('':11)
    end;

    writeln();
    for i:= 1 to piles do
    begin
      write(pile[i]:11);
    end;

    writeln();
    write('   ');
    for i:= 1 to piles do
    begin
      write('Matches':11);
    end;
    writeln();


  end;

  function CheckSafe(piles : pilestype; pile : piletype):boolean; //checks if the game is currently in a safe position
  var
     bin : integer; //amount in the pile in binary
     binsum : integer; //sum of all the piles in binary
     binlen : integer; //length of the binary sum
     bindigits : array [0..8] of integer; //digits of the binary sum
     i : integer; //count
     j: integer; //count

  begin
    binsum := 0;
    for i := 1 to piles do
    begin
        bin := InttoBin(pile[i]);;
        binsum += bin;
    end;
    inttodigits(binsum,bindigits,binlen);
    CheckSafe := True;
    for j:= 0 to (binlen-1) do
    begin
      if bindigits[j] mod 2 <> 0 then
      begin
        CheckSafe := False;
      end;
    end;
  end;

  procedure MakeMove(var piles : pilestype; var pile : piletype; move : movetype; com : boolean); //allows the player/computer to make a move
    var
       sel : integer; //selected pile
       amount : integer; //amount

    procedure InputMove(piles : pilestype; pile : piletype; var amount : integer; var sel : integer); //allows the player to input a move
    var
       inp : integer; //input
       valid : boolean; //input valid
       confirm : boolean; //confirm move
    begin
      confirm := false;
      while confirm = false do
      begin
          valid := false;
          while valid = false do
          begin
            writeln();
            inp := GetInput('posinteger','Select a pile to take matches from.');
             if inp <= piles then
             begin
                 if pile[inp] > 0 then
                 begin
                   sel := inp;
                   valid := true;
                   writeln('Selected Pile ',sel)
                 end else
                 begin
                   writeln('This pile is empty, please select another pile.');
                 end
             end else
             begin
                 writeln('Please select from the availiable piles.');
             end;
          end;
          valid := false;
          while valid = false do
          begin
             inp := GetInput('posinteger','How many matches do you want to take?');
             if inp <= pile[sel] then
             begin
                 amount := inp;
                 valid := true;
                 writeln('Taking ',inp,' matches from Pile ',sel);
             end else
             begin
                 writeln('There are not enough matches in this pile.');
             end;
          end;
          confirm:=GetInput('boolean','Confirm move? Type "yes" to confirm, "no" to cancel.');
      end;
    end;

    procedure CalculateMove(piles : pilestype; pile : piletype; var amount : integer; var sel : integer); //computer logic for calculating a safe move
    var
       bin : integer; //amount in the pile in binary
       binsum : integer; //sum of all the piles in binary
       binlen:integer; //len of the bindigits array
       bindigits : array [0..8] of integer; //digits of the binary sum
       paritydigits: array [0..8] of integer; //digits of the column parity in binary
       parity: integer; //column parity in integer form
       i : integer; //count
       nimsum: integer; //the nimsum in integer form
       am: integer; //how many matches need to be taken for a safe move
       safe : boolean; //whether the move is safe

    begin
      //caluclate the binary sum
      binsum := 0;
      for i := 1 to piles do
      begin
          bin := InttoBin(pile[i]);
          binsum += bin;
      end;
      inttodigits(binsum,bindigits,binlen);

      //calculate the parity and then convert back to integer
      for i:= 0 to (binlen-1) do
      begin
        paritydigits[i] := bindigits[i] mod 2;
      end;
      parity:=bintoint(paritydigits,binlen);

      //find a safe move
      safe:= false;
      for i := 1 to piles do
      begin
        nimsum := (pile[i] xor parity);
        am:=pile[i]-nimsum;
        if am > 0 then
        begin
          sel := i;
          amount := am;
          safe:=true
        end;
      end;

      //take one from largest pile if no safe move
      if safe = false then
      begin
        amount := 1;
        sel := 1;
        for i := 1 to piles do
        begin
          if pile[i] > pile[sel] then sel := i;
        end;
      end;

      //write the move to the screen
      writeln();
      write('.');
      delay(500);
      write('.');
      delay(500);
      writeln('.');
      delay(500);
      writeln();

      writeln('Taking ',amount,' matches from Pile ',sel);
    end;

  begin //MakeMove
    if (com = true) and (move = 2) then
    begin //com turn
      CalculateMove(piles,pile,amount,sel);
    end else
    begin //player logic
      InputMove(piles,pile,amount,sel);
    end;
    pile[sel] -= amount;
  end;

  procedure CheckWin(piles:pilestype; pile:piletype; move : movetype; var winner : winnertype; com : boolean); //check if there are no more matches left and display the winner if so
  var
     i : integer; //count
     sum: integer; //sum of all piles
  begin
     sum := 0;
     for i := 1 to piles do
     begin
         sum+=pile[i];
     end;
     if sum = 0 then
     begin
         winner := move;
     end;
     if (winner = 2) and (com = True) then
     begin
       writeln('Computer wins!')
     end else if (winner <> 0) then
     begin
       writeln('Player ',winner,' wins!');
     end;
  end;

  procedure WriteSafe(safe:boolean);
  begin
     writeln();
     if safe then
     begin
       textcolor(Green);
       writeln('SAFE MOVE');
       textcolor(White);
     end else
     begin
       textcolor(Red);
       writeln('BAD MOVE');
       textcolor(White);
     end;
  end;

begin //game
   InputPiles(piles);
   clrscr();

   //init the game
   if com then
   begin
     repeat
        startgame(piles,pile,move,winner);
        safe:=checksafe(piles,pile);
     until safe = false;  //ensures the player can always win against the pc if they play correctly
   end else
   begin
     startgame(piles,pile,move,winner);
   end;

   //play
   while (winner = 0) do
   begin
     writeln();
     if com and (move = 2) then
     begin
        writeln('Computer`s Turn');
     end else
     begin
        writeln(' Player ',move,'`s Turn');
     end;
     DrawDivider(16);

     drawpiles(piles,pile);
     makemove(piles,pile,move,com);
     safe := checksafe(piles,pile);
     writesafe(safe);


     if com and (move = 2) and safe then  //allow the user to resign from the game if the computer is winning
     begin
       writeln();
       writeln('The computer has outsmarted you! You cannot win this game.');
       if GetInput('boolean','Skip to the end of the game? (yes/no)') then
       begin
         winner := 2;
       end;
       writeln();
     end;

     checkwin(piles,pile,move,winner,com);

     if (move = 1) then move := 2 else move := 1; //switch players
   end;

   writeln();
   writeln('Press "ENTER" to continue...');
   readln();
end;

procedure Announce(); //displays the instructions
begin
  clrscr();
  writeln();
  writeln(' The Game of Nim');
  drawdivider(17);
  writeln();
  writeln('Piles of up to 30 matches will be generated.');
  writeln('On your turn you can take any number of matches from one of the pile.');
  writeln('The person to take the last match or pile of matches wins.');
  writeln();
  writeln('Press "ENTER" to continue...');
  readln();
end;

Procedure Menu(); //main menu for the game
var
   action:string; //menu command
   valid:boolean; //valid input flag
   loop:boolean; //lcv
begin
  loop := true;
  while loop do
  begin
    clrscr();
    writeln();
    writeln(' Menu');
    DrawDivider(5);
    writeln();
    writeln('Type "play vs pc" to play against the computer.');
    writeln('Type "play vs player" to play multiplayer.');
    writeln('Type "how to play" to read the instructions again.');
    writeln('Type "quit" to exit the game.');
    valid := false;
    while valid = false do
    begin
      action:=getinput('string', 'Type your command in lowercase below: ');
      if action = 'play vs pc' then
      begin
        valid := true;
        game(true);
      end else if action = 'play vs player' then
      begin
        valid := true;
        game(false);
      end else if action = 'how to play' then
      begin
        valid := true;
        announce();
      end else if action = 'quit' then
      begin
        valid := true;
        loop := false;
      end else
      begin
        writeln('Please choose one of the above commands.');
      end;
    end;
  end;

end;

begin
  announce();
  randomize();
  menu();
end.


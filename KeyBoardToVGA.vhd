----------------------------------------------------------------------


----------------------------------------------------------------------
----------------------------------------------------------------------
-------------------------//////////////////---------------------------
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  
entity KeyBoard is
  port( Input   : in  std_logic ;
        InClock : in  std_logic ;
        Output  : out std_logic_vector(0 to 7) ;
        Done    : out std_logic ) ;
end KeyBoard ;

architecture Operation of KeyBoard is

  begin
    process(InClock)
      variable DataCounter :integer :=0;
      
      constant Idle  : integer := 0;
      constant Start : integer := 1;
      constant Ended   : integer := 2;
      constant Stop  : integer := 3;
      
      variable State : integer := 0;
      variable TempDone : std_logic :='0' ;
      variable Data  : std_logic_vector(0 to 7); 
      begin
        if(InClock'Event and InClock = '0')then
          if(State = Idle)then
            if(Input = '0')then
              State := Start ;
              DataCounter := 0;
            end if;
          elsif(State = Start)then
            if(DataCounter = 7)then
              State := Ended ;
              Data(DataCounter) := Input ;
            elsif(DataCounter < 7)then
              Data(DataCounter) := Input ;
              DataCounter := DataCounter + 1;
            end if;
          elsif(State = Ended)then
            TempDone := '1';
            State := Stop;
          elsif(State = Stop)then
            State := Idle ;
            TempDone := '0';
          end if;
        end if;
        
        Done   <= TempDone ;
        Output <= Data ;
    end process;
end Operation;
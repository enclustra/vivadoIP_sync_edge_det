------------------------------------------------------------------------------
-- Libraries
------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	

------------------------------------------------------------------------------
-- Entity
------------------------------------------------------------------------------	
entity sync_edge_det is
	port
	(
		-- Control Signals
		Clk							: in std_logic;
		Rst							: in std_logic;
		-- Data Ports
		Din							: in std_logic;
		Dout						: out std_logic;
		Re 							: out std_logic;
		Fe							: out std_logic
	);

end entity sync_edge_det;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture rtl of sync_edge_det is 

	-- Two Process Method
	type tp_r is record
		-- Input Registers
		Sync				: std_logic_vector(0 to 1);
		Data				: std_logic_vector(0 to 1);
		Re					: std_logic;
		Fe					: std_logic;	
	end record;	
	signal r, r_next : tp_r;
	

begin

	--------------------------------------------------------------------------
	-- Combinatorial Process
	--------------------------------------------------------------------------
	p_comb : process(	r, Din)	
	   variable v : tp_r;
	begin
		-- hold variables stable
		v := r;
		
		-- Synchronization 
		v.Sync(0) := Din;
		v.Sync(1) := r.Sync(0);
		v.Data(0) := r.Sync(1);
		v.Data(1) := r.Data(0);
		
		-- Edge Detection
		v.Re := '0';
		if (r.Data(0) = '1') and (r.Data(1) = '0') then	
			v.Re := '1';
		end if;
		v.Fe := '0';
		if (r.Data(0) = '0') and (r.Data(1) = '1') then 
			v.Fe := '1';
		end if;		
		
		-- Apply to record
		r_next <= v;
		
	end process;
	
	Dout <= r.Data(1);
	Fe <= r.Fe;
	Re <= r.Re;
	
	--------------------------------------------------------------------------
	-- Sequential Process
	--------------------------------------------------------------------------	
	p_seq : process(Clk)
	begin	
		if rising_edge(Clk) then
			r <= r_next;
			if Rst = '1' then
				r.Sync			<= (others => '0');
				r.Data			<= (others => '0');
				r.Re			<= '0';
				r.Fe			<= '0';
			end if;
		end if;
	end process;
 
end rtl;

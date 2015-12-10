function result = sci_connect(port)
%sci_connect function connects to Scilab with installed Toolbox BackDoor  
%
%  Usage:
%  result = sci_connect(port)
%  result = sci_connect
%  
%  Inputs/outputs
%  port        - TCP/IP port number of Toolbox BackDoor, default is 28020
%  result      - result of connection (1 - successful connection, 0 - connection failed)
%  
%%*****************Octave-Scilab co-simulation package*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

  if(nargin<1)  %If not set, using default Toolbox backdoor port
    if(ispc)
      port = 27020;
    else
      port = 27020 + geteuid;
    end  
  end

  global sci_sim_client;  %Making client socket global for all functions
  sci_sim_client = socket(AF_INET, SOCK_STREAM, 0);
  sci_sim_server_info = struct("addr", "127.0.0.1", "port", port);
  try
    rc = connect(sci_sim_client, sci_sim_server_info);
  catch
    rc = 1;
  end_try_catch
    
  if(rc==0)
    result = 1;
  else
    result = 0;  
  end

end

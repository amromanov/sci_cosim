function sci_disconnect(port)
%sci_disconnect function disconnects from Scilab  
%
%  Usage:
%  sci_disconnect
%  
%%*****************Octave-Scilab co-simulation package*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

  global sci_sim_client;  %resolving client socket
  disconnect(sci_sim_client);
  if(exist('sci_vars_transfer.mat'))
    delete('sci_vars_transfer.mat');
  end
end

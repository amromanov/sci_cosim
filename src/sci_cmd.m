function sci_cmd(cmd)
%sci_cmd executes single command in Scilab  
%
%  Usage:
%  sci_cmd(cmd)
%
%  Inputs/outputs
%  cmd         - command that should be executed in Scilab
%  
%%*****************Octave-Scilab co-simulation toolbox*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

    global sci_sim_client;  %resolving client socket
    
    cmd=sprintf('\\%s\n',cmd);  %Because we never recieve results by network, 
                                %start with \ and end with return (to execute command)
    send(sci_sim_client,cmd);
    
end

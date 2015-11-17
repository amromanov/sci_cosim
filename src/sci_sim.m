function sci_sim(xcos_model_name)
%sci_sim starts xcos simulation in Scilab 
%
%  Usage:
%  sci_sim(xcos_model_name)
%
%  Inputs/outputs
%  xcos_model_name     - filename of xcos model
%  
%%*****************Octave-Scilab co-simulation toolbox*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

    global sci_sim_client;  %resolving client socket

    cmd=sprintf('\\cd %s\n',pwd);  %Changing current directory in Scilab
    send(sci_sim_client,cmd);
    cmd=sprintf('\\importXcosDiagram("%s");\n',xcos_model_name);
    send(sci_sim_client,cmd);
    cmd=sprintf('\\typeof(scs_m);\n');
    send(sci_sim_client,cmd);
    cmd=sprintf('\\xcos_simulate(scs_m,4);\n');
    send(sci_sim_client,cmd);
    
end

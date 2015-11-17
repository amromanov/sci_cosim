function sci_setvar(varlist)
%sci_setvar function transfer variables to Scilab through 
%sci_vars_transfer.mat file   
%
%  Usage:
%  sci_setvar(var0,var1, ... ,varN)
%
%  Inputs/outputs
%  var0..N     - list of variables that should be transferred into Scilab 
%  
%%*****************Octave-Scilab co-simulation toolbox*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

    global sci_sim_client;  %resolving client socket
    vars=argn;  
    arglist=[];    %Creating variable list for save function
    for i=1:size(vars,1)
      if(isempty(arglist))
        arglist=vars(i,:);
      else
        arglist=[arglist ',' vars(i,:)];
      end
    end
    estr=['save(''sci_vars_transfer.mat'',''-v7'',' arglist ');'];
    evalin("caller",estr); %Saving variables to file

    cmd=sprintf('\\cd %s\n',pwd);  %Changing current directory in Scilab
    send(sci_sim_client,cmd);
    cmd=sprintf('\\loadmatfile(''sci_vars_transfer.mat'');\n'); %Loading variable from file in Scilab
    send(sci_sim_client,cmd);
    
end

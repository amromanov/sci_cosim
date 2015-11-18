function sci_getvar(varlist)
%sci_getvar function transfer variables from Scilab through 
%sci_vars_transfer.mat file   
%
%  Usage:
%  sci_пetvar(var0,var1, ... ,varN)
%
%  Inputs/outputs
%  var0..N     - list of variables that should be transferred into Octave 
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
    
    if(exist('sci_vars_rep.dat','file'))  %sci_vars_rep.dat shouldn't exist before
       delete('sci_vars_rep.dat');        %variable transfer
    end

    cmd=sprintf('\\cd %s\n',pwd);  %Changing current directory in Scilab
    send(sci_sim_client,cmd);
    cmd=sprintf('\\savematfile(''sci_vars_transfer.mat'',%s,''-v7'');\n',arglist);
    send(sci_sim_client,cmd);
    cmd=sprintf('\\f=mopen(''sci_vars_rep.dat'',''w+'');\n');
    send(sci_sim_client,cmd);
    cmd=sprintf('\\mclose(f);\n');
    send(sci_sim_client,cmd);

     %Waiting for result
    [res,~]=unlink('sci_vars_rep.dat');
    while (res~=0)                          %Waiting till sci_vars_rep.dat will be created
      [res,~]=unlink('sci_vars_rep.dat');   %by Scilab and then removing it, because we need it
                                            %only to show Octave, that Scilab transferred data
    end                                        
    evalin("caller",'load sci_vars_transfer.mat'); %Saving variables to file
    
end

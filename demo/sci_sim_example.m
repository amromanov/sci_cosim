% Simple simulation example
%
%%*****************Octave-Scilab co-simulation package*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov A
%%
%%Distributed under the New BSD License
%%*************************************************************************

result=sci_connect;                 %Connecting Scilab

if(result)
                                    %Setting variables for xcos model
  k=1.5;                            %Gain
  stp=2;                            %Set point
  Tau=1.5;                          %Time constant
  Tf=7;                             %Simulation time (not more then maximum time defined in model configuration)

  tic
  sci_setvar('k','stp','Tau','Tf'); %Transferring variables to SciLab
  sci_sim('sci_ap_model.xcos');     %Running xcos simulation
  sci_getvar('result');             %Recieving result variable from SciLab
  toc
  
  res=result;                       %Saving simulation result to independent variable
  
  tic
  sci_cmd('k=2; Tau=0.5; Tf=3.5;'); %Setting Scilab variables by single command   
  sci_sim('sci_ap_model.xcos');     %Running xcos simulation
  sci_getvar('result','k');         %Recieving result variable from SciLab
  toc
  
  figure(1)                         %Plotting simulation results
  stairs(res.time, res.values,'-r','LineWidth',2)
  hold on
  stairs(result.time, result.values,'-b','LineWidth',2)  
  hold off
  grid  

  sci_disconnect;                   %Disconnecting Scilab
  
else
  fprintf('Scilab connection failed\n');  
end



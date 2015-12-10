% Simple simulation example
%
%%*****************Octave-Scilab co-simulation package*********************
%%Moscow, Control Problems Department MIREA, 2015
%%Authors: Romanov Alexey, Doug Stewart
%%
%%Distributed under the New BSD License
%%*************************************************************************
## modified by 

result=sci_connect;                 %Connecting Scilab

if(result)
%  Setting variables for xcos model
  k=216;                            %Gain
  stp=2;                            %Set point for step input
  Tf=10;                             %Simulation time (not more then maximum time defined in model configuration)

% PID values
  kp=2.87030 #7
  ki=2.840 # 5
  kd=0.5400 #0.8
  
  tic
  sci_setvar('k','stp','Tf','kp','ki','kd'); %Transferring variables to Xcos
  sci_sim('sci_pid_model.zcos');     %Running xcos simulation
  sci_getvar('result','cont_act','result0');             %Recieving result variable from SciLab
  toc
  
  [mx,imx]=max(result.values)
  result.time(imx)
  figure(1)                         %Plotting simulation results
  stairs(result0.time, result0.values,'-r','LineWidth',2) # original plant responce
  hold on
  stairs(result.time, result.values,'-b','LineWidth',2)  # output with pid 
  stairs(cont_act.time,cont_act.values,'-g') # control action
  hold off
  grid  

  sci_disconnect;                   %Disconnecting Scilab
  
else
  fprintf('Scilab connection failed\n');  
end

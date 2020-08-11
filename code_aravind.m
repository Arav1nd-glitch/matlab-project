%%
%       MECHANICAL VIBRATIONS PROJECT
%------------------------------------------------------------
%PROJECT DETAILS
%
%undamped Vertical oscillation of a  hydrometer
%Submitted By:Aravind Krishnan(13170106)
%Submitted To: Dr. K.V.N.Surendra
%
%PROBLEM DETAILS
% data is assumed wherever it is not given but is required

%
%%
clc ;
clear ;
m = 5; %assumed mass of hydrometer
ro = 1000; %assumed density of inviscid liquid
r = 0.05 %assumed radius of thinner part = 5 mm
g = 9.81 %accelaration due to gravity

%initial conditions 
x0 = 0.5;
v0 = 0 ;

w = sqrt(ro*pi*r*r*g/m) %angular frequency
y= sin(w)
A = sqrt((x0)^2 + (v0)^2)
phi = atan(x0*w/v0) %initial phase difference

t= 0:0.05:4; %running time


%parameteres
d = -A*sin(w*t + phi); %negative sign because diplacement is given in negative direction
d_dot = -A*w*cos(w*t+phi);
d_ddot = +A*w^2*sin(w*t + phi);


F = VideoWriter('aravind1.avi');%Recording starts 
v.Quality = 95 ;
open(F);
 
xline(0);
yline(0);
xlim([-4 ,4]);
ylim([-9,9]);
hold on
for i=1:length(t)-1
    delete(findobj('type', 'patch')); %deleting the object from previous frame
    s = line([t(1,i),t(1,i+1)],[d(1,i),d(1,i+1)],'Color','b');            %Displacement curve
    vel = line([t(1,i),t(1,i+1)],[d_dot(1,i),d_dot(1,i+1)],'Color','r');  %velocity curve
    a = line([t(1,i),t(1,i+1)],[d_ddot(1,i),d_ddot(1,i+1)],'Color','g');  %Acceleration curve
    x_co = [-2.3,-2.1,-2.1,-1.9,-1.9,-2.1,-2.3,-2.5,-2.5,-2.3]; %defining the parameteres of the hydrometer
    y_co = [4, 4, -1.2, -1.5 , -2.9, -3.3 , -3.3 ,-2.9,-1.5,-1.2];
    act_y = [y_co + d(1,i)]; %moving the y-coordinate according to the shm
    patch(x_co,act_y,'y') %creating the object for the current frame
     d1 = line([-2.2,t(1,i)],[d(1,i+1),d(1,i+1)],'Color','k','LineStyle','--');%follower line
    point1 = plot(-2.2,d(1,i+1),'k.','Markersize',20,'MarkerFaceColor','k');%point at the position A initially submerged
     legend([s vel a],'Displacement','Velocity','Acceleration','Location','Northeast','Orientation','Horizontal','Fontsize',8);
    box on
    grid on
    ylabel({'Displacement [m], Veloity [m/s],'; 'Acceleration [m/s^2]'},'Fontsize',10)
    xlabel('Time (in seconds)','Fontsize',10)
   
    set(gca,'XTick',-4:0.4:4);
    set(gca,'YTick',-8:0.8:8);
    title('Harmonic motion of Hydrometer','Fontsize',12)
    pause(0.1)
    frame = getframe(gcf);
    writeVideo(F, frame); 
    if i==length(t)-1
        break;
    else
        delete(d1)
        delete(point1)
    end
        
    end

close(F);
implay('aravind1.avi');


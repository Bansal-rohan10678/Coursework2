
function temp_monitor(a) %Defining function

%The temp_monitor function takes readings of the temperature of the
%themistor (by calculating it from voltage) every second. It then plots
%this information in a live updating graph of the recorded temperature
%against time. It then uses an if statement to decide whether the
%temperature is between 18 C and 24 C, if its below 18 C, or if it is above
%24 C. This decision then results in either the green light staying
%constantly on, the yellow light blinking twice a second, or the red light
%blinking 4 times a second, respectively. The purpose is to keep track of
%temperature.


figure; %Figure for the graph
temperatures_list = []; %Creating an array to hold the values for temperatures
time = []; %Creating a value to keep track of seconds

writeDigitalPin(a, "D3", 0); %G This ensures that the green light is off before entering the loop. Only the green needed as it is the only one that stays on without blinking. The red and yellow are turned off in their own if statements
for i = 0:inf %Infinite loop
    time(i+1) = i; %Making time an indefinitely increasing array the same size as the temperatures array and starting at 1

    temperature = (readVoltage(a, "A5")-0.5)/0.01; %Read the voltage and convert it into a temperature
    temperatures_list(i+1) = temperature; %Adding the newly aquired temperature to the list
    
    plot(time, temperatures_list); %Plotting temperature against time

    xlim([-0.01, max(time)]);
    ylim([min(temperatures_list)-2.5, max(temperatures_list)+2.5]);
    %These two functions ensure the graph shows an appropriate span

    drawnow; %Drawnow function makes the graph live

    writeDigitalPin(a, "D4", 0); %Y 
    writeDigitalPin(a, "D2", 0); %R
    %Ensuring the yellow and red LEDs are off at the start of every loop

    if temperature>18 && temperature<24 %If the temperature is between 18 and 24...
        writeDigitalPin(a, "D3", 1); %G Turn and keep green on
        pause(1); %Pause to ensure data aquisition keeps timing
    elseif temperature<18 %If the temperature is less than 18...
        writeDigitalPin(a, "D3", 0); %G Turn off green
        for x = 1:2
            writeDigitalPin(a, "D4", 1); %Y
            pause(0.25);
            writeDigitalPin(a, "D4", 0); %Y
            pause(0.25);
        end
        %The above for loop makes the yellow light blink twice whilst
        %maintaining aquisition timing
        
    else %If the temperature is above 24...
        writeDigitalPin(a, "D3", 0); %G Turn off the green light
        for x = 1:4
            writeDigitalPin(a, "D2", 1); %R
            pause(0.125);
            writeDigitalPin(a, "D2", 0); %R
            pause(0.125);
        end
        %Above for loop makes the red light blink 4 times and maintains
        %aquisition timing
    end
end

end
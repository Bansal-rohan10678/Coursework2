
function temp_prediction(a) %Defining funciton

%This function takes a reading of the temperature of the thermistor at
%every 1 second interval and then (ensuring that the 4th iteration has been
%reached), finds the average change in temperature across the previous 3
%seconds. It then turns on the yellow, red, or green LED depending on
%whether the temperature gradient is below -4C/s, above 4C/s or between
%them, respectfully. It then calculates the predicted temperature in 5
%minutes using the gradient and displays it, and displays the temperature
%gradient and the current temperature.

writeDigitalPin(a, "D3", 0);
writeDigitalPin(a, "D2", 0);
writeDigitalPin(a, "D4", 0);
%Ensuring all LEDs are turned off before starting 

for i = 1:inf %Loop indefinitely

    temperature = (readVoltage(a, "A5")-0.5)/0.01;
    temperatures_list(i) = temperature;
    %Finding temperature from voltage and then adding it to the temperature
    %array
    
    if i>=4 %Ensuring atleast 4 data points have already been stored and are available for calculations
        
        gradient = (temperature-temperatures_list(i-3))/3; %Finding the change in temperature gradient over the 4 previous data points (3 changes in temperature).

        if gradient < -(4/60) %If the change in temperature is less than -4C/m
            writeDigitalPin(a, "D3", 0);
            writeDigitalPin(a, "D2", 0);
            %Ensuring the green and red LEDs are turned off
            
            writeDigitalPin(a, "D4", 1); %YELLOW LED turned on
        elseif gradient > (4/60) %If the change in temperature is more than 4C/m
            writeDigitalPin(a, "D3", 0);
            writeDigitalPin(a, "D4", 0);
            %Ensuring the green and yellow LEDs are turned off

            writeDigitalPin(a, "D2", 1); %RED LED turned on
        else %If the temperature change is between -4C/m and 4C/m
            writeDigitalPin(a, "D4", 0);
            writeDigitalPin(a, "D2", 0);
            %Ensuring the red and yellow LEDs are turned off

            writeDigitalPin(a, "D3", 1); %GREEN LED turned on
        end
        
        futuretemp = temperature + gradient*300; %Finding temperature in 5 minutes by adding predicted change in temperature(calculated via constant gradientX300 seconds) to current temperature
        fprintf("Temperature in 5 minutes: %.2fdegC \n", futuretemp) %Displaying predicted future temperature
        fprintf("Temperature gradient over past 3 secs: %.2fdegC/s \n", gradient) %Displaying tempperature gradient in degC/s

        
    
    end
    
    fprintf("Current temperature: %.2fdegC \n", temperature) %Displaying current recorded temperature (outside if statement as it can be displayed regardless of i value)
    fprintf("\n") %Empty line for neatness

    pause(1); %Pause so each reading is taken every seconds - maintaining data aquisition timing
    
end

end
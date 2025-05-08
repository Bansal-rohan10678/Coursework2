
% Rohan Bansal
% egyrb12@nottingham.ac.uk


%% PRELIMINARY TASK - ARDUINO AND GIT INSTALLATION [10 MARKS]


for i = 1:inf %Loops forever
    writeDigitalPin(a,'D2',1) %Powering on the LED
    pause(0.5) %Pausing for half a second so the LED stays on for half a second
    writeDigitalPin(a,'D2',0) %Powering on the LED
    pause(0.5) %Pausing for half a second so the LED stays on for half a second
end

%% TASK 1 - READ TEMPERATURE DATA, PLOT, AND WRITE TO A LOG FILE [20 MARKS]

duration = 600; %Declaring the duration to 600 seconds
temperatures = zeros(1,601); %Making an empty array for temperatures
times = (0:600);

maximum = 0;
minimum = 99999;
total = 0;
%Setting the initial minimumm and maximum values to compare the recorded
%values to and setting a total to keep a running total to find the average.

for i = 1:duration+1 %Looping through 600 times
    temperatures(i) = (readVoltage(a, "A5")-0.5)/0.01; %Reading the volateg and putting it through the equaiton. Then putting it in the temperatures array
    if temperatures(i) > maximum %Comparing the value to the maximum and replacing it if its larger
        maximum = temperatures(i);
    end
    if temperatures(i) < minimum %Comparing the value to the minimum and replacing it if its smaller
        minimum = temperatures(i);
    end
    total = total + temperatures(i); %Keeping a running total
    pause(1)
end

average = total/duration; %Finding the average with the sum of all the temps over the amount of array fields

figure;
plot(times, temperatures) %Plotting the array
xlabel("Time (Seconds)")
ylabel("Temperature (Celsuis)")

temperatures_minutes = temperatures(1:60:end); %Making a new array that only contains the temperature values at each minute

location = input("Enter your location: ", "s"); %User input for the location

disp(" ") %Space for aesthetics (same for all other instances)
day = sprintf("Data logging initialised - %s", datetime('now','Format','dd/MM/yyyy')); %Using the datetime command to show current date and putting it in an sprintf string
disp(day)
place = sprintf("Location - %s", location); %Putting the user inputted location in an sprintf string
disp(place)
disp(" ")


for x = 0:10 %Looping from 0 to 10 for the different minute intervals
    minute_entry = sprintf("Minute\t          %d", x); %sprintf command for the minute (using the x index)
    temp_entry = sprintf("Temperature\t      %.2f C", temperatures_minutes(x+1)); %sprintf command for temperature at that minute (taken from temperature_minutes array)
    %I added one to x for the temperature_minutes index because indexes start at 1
    disp(minute_entry)
    disp(temp_entry)
    disp(" ")
end

max_temp = sprintf("Max temp\t      %.2f C", maximum); %sprintf command for maximum
disp(max_temp)
min_temp = sprintf("Min temp\t      %.2f C", minimum); %sprintf command for minimum
disp(min_temp)
avg_temp = sprintf("Average temp\t  %.2f C", average); %sprintf command for average
disp(avg_temp)
disp(" ")

disp("Data logging terminated") %Final message

%%%%%%%%FILE

textfile = fopen("cabin_temperature.txt", "w"); %Opens the txt file cabin_temperature.txt in write mode

fprintf(textfile, '%s\n', day); %Prints to the txt file. the \n part skips to the next line
fprintf(textfile, '%s\n', place); %Prints the place string to the txt file
fprintf(textfile, '%s\n', " "); %Leaves an empty line. Does this at every instance of this line of code


for x = 0:10 %Looping from 0 to 10 for the different minute intervals
    minute_entry = sprintf("Minute\t          %d", x); %sprintf command for the minute (using the x index)
    temp_entry = sprintf("Temperature\t      %.2f C", temperatures_minutes(x+1)); %sprintf command for temperature at that minute (taken from temperature_minutes array)
    %I added one to x for the temperature_minutes index because indexes start at 1
    fprintf(textfile, '%s\n', minute_entry); %Prints minutes to txt file
    fprintf(textfile, '%s\n', temp_entry); %Prints temperature to txt file
    fprintf(textfile, '%s\n', " ");
end

fprintf(textfile, '%s\n', max_temp); %Prints max to txt file
fprintf(textfile, '%s\n', min_temp); %Prints min to txt file
fprintf(textfile, '%s\n', avg_temp); %Prints avg to txt file
fprintf(textfile, '%s\n', " ");

fprintf(textfile, '%s\n', "Data logging terminated"); %Final message printed to txt file

fclose(textfile); %Closes the txt file
edit("cabin_temperature.txt"); %Opens the txt file in a MATLAB tab.
%In the word document it says to use fopen to open the txt file to view but
%thats not what fopen does. I instead used the edit command.

%% TASK 2 - LED TEMPERATURE MONITORING DEVICE IMPLEMENTATION [25 MARKS]

temp_monitor(a)

%% TASK 3 - ALGORITHMS – TEMPERATURE PREDICTION [25 MARKS]

temp_prediction(a)


%% TASK 4 - REFLECTIVE STATEMENT [5 MARKS]

%Challenges - 

%Overall, the challenges I faced within this coursework task include
%building the breadboard of the arduino to work with my thermistor, and
%finding a way to ensure the LEDs in task 2 could pulse without intefering 
% with the main loop. The main issue with the thermistor was finding a way
% to stop it from overheating and therefore intefering with results. I
% fixed this issue by introducing a resistor. The main challenge with the
%LEDs were allowing the loop of the blinking lights to be run without it
%distrupting the main loop. If I run the blinking lights in an infinite
%loop, the program would never return to the top of the main loop to run it
%again. This was fixed by only blinking the lights twice or 4 times so the
%main loop could be run again.

%Strengths

%My strengths mainly lay with the flowchart drawing. This is because it
%allowed me to visualise the coding and the eventual running of the
%program, and made the development process much smoother. Another strength
%was the design of the LED section of the breadboard; I understood the
%function of the LEDs and their circuits and so could neatly lay out the
%components to allow for better debugging.

%Limitations

%My codes only limitation is the blinking of the LEDs in task 2. The
%periods between the blinking of the lights isnt completely constant as the
%last loop of the for loops within the if statements result in the main
%loop being run again. This extra code means that the delay is slightly
%longer than 1 second.

%Suggested future improvements

%One improvement I could make would be making the blinking of the LEDs more
%consistent. This could have been done with the use of a function or just
% more efficient code. Another improvement would be simplifying the file 
%creation in task 1. Instead of writing the file within 24 lines of code, 
%I could havelaid it out much better to print the information much more 
%efficiently.

%% TASK 5 - COMMENTING, VERSION CONTROL AND PROFESSIONAL PRACTICE [15 MARKS]

% No need to enter any answershere, but remember to:
% - Comment the code throughout.
% - Commit the changes to your git repository as you progress in your programming tasks.
% - Hand the Arduino project kit back to the lecturer with all parts and in working order.
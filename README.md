# RStudio_Plot_Labels_Placer
A method for creating plots in R where the point labels are at user-specified positions. In particular, avoid overlapping text labels

The purpose of this code is to demonstrate an easy way to ensure that labels on R plots do not overlap, are visually appealing, and conform to user-specified selections. The only R package required is the "manipulate" package.

The process is demonstrated on a small dataset of 10 points. Input the location for R to save the accompanying CSV file (csv_save_location), along with input_start_over ('Y' to have the program use the default CSV file, 'N' for the program to use the existing CSV file from the last time the program was run). 

The program creates a manipulable graph of the ten points along with point labels. By clicking the manipulator in the upper left hand corner, there are several options:
button "Save Label Location"- clicking this will save my_deg_new and my_r_new to the CSV file 
my_deg_new- my_deg_new * pi is the angle at which to place the label in the circle around the point that the label is for
my_r_new- the radius of a circle around the point that the label is for
my_label- the label to move

#RStudio Plot Point Labels Placer
#Purpose: A method for creating plots in R where the point labels are at user-specified
#positions. In particular, avoid overlapping text labels
#Author: Julie Rudman-Melnick
#Last updated: 5/22/22

#Instructions: Input a location on your computer to put the CSV file
#(csv_save_location)
library(manipulate)

####inputs####
csv_save_location <- 'C:\\Users\\some_user\\Desktop\\R Code\\my_data.csv'
input_start_over<- 'N' #set to 'Y' to use the default CSV file, set to 'N' to use the file
#as it was as of the last time the graph was run

####Data for example#####
x_vals <- c(1,1.1,2,3, 1.5, 2.5, 2.5, 2.2, 2.9, 2)
y_vals <- c(4,4.5,5,6, 4.5, 5.5, 5, 4.5, 5.6, 5.7)
my_lab <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")

my_df_starter <- data.frame(label = my_lab, circle_radius = 0.25, circle_degree = 0)

####Make manipulable####

labels_placer <- function(start_over) {
  
  #if user wants to start over, go back to the default CSV file created above
  if (start_over =='Y') {
    write.csv(my_df_starter,csv_save_location)
  }
  
  manipulate({
    
    #Read in data from CSV file
    my_data <- read.csv(csv_save_location)
    
    #start with the r and deg that is in the CSV from last time
    my_data$my_r_default <- my_data$circle_radius
    my_data$my_deg_default <- my_data$circle_degree
    
    #prepare the data to be plotted. if the state is selected in the dropdown,
    #then we want to use the user selected new r and new deg
    my_data$my_r_final <- my_data$my_r_default
    my_data$my_deg_final <- my_data$my_deg_default
    
    for (i in c(1:10)) {
      if(my_data$label[[i]] ==my_state) {
        
        my_data$my_r_final[[i]] <- my_r_new
        my_data$my_deg_final[[i]] <- my_deg_new
      }
    }
    
    #the current state of the data to be plotted
    print(my_data)
    
    #Draw plot
    x_pos <- x_vals + my_data$my_r_final*sin(my_data$my_deg_final*pi)
    y_pos <- y_vals + my_data$my_r_final*cos(my_data$my_deg_final*pi)
    plot(x_vals, y_vals, xlim = c(0,4), ylim = c(3,7),
         xlab = "X Values",
         ylab = "Y Values",
         main = "Label Placer Demonstration")
    text(x_pos, y_pos, labels = my_lab)
    
    #whenever the CSV file is updated, it will be with this table
    my_data_save<- my_data
    my_data_save$circle_radius <- my_data_save$my_r_final
    my_data_save$circle_degree <- my_data_save$my_deg_final
    keep_cols <- c("label","circle_radius", "circle_degree")
    my_data_save <- my_data_save[keep_cols]
    
    #when user clicks the button, update the applicable entries in the CSV file
    if (savePlot) {
      write.csv(my_data_save,csv_save_location)
    }
    
  }, 
  #manipulable items
  savePlot = button("Save Label Location"),
  my_deg_new = slider(0,2, step = .25),
  my_r_new = slider(0,1, step = .25),
  my_label = picker("a", "b", "c", "d", "e", "f", "g", "h", "i", "j")
  )
}

labels_placer(input_start_over)

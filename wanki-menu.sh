#!/bin/bash

# Create base directory if doesn't exist already
BASE_DIR="$HOME/WANKI"
mkdir -p "$HOME/WANKI"



help() {
    echo "Wanki Flashcard Application"
    echo "Version: 1.0.0"
    echo "Description: This application is a text-based remake of the popular flashcard making app called Anki. Create card decks on various subjects with each card following a simple front-side back-side format and a ranking system for the difficulty that determines how often to show the card."
    echo
    echo "Usage:"
    echo "./wanki-script.sh"
    echo
    echo "Mandatory arguments: none"
    echo
    echo "INSTRUCTIONS:"
    echo "Start the application with the usage command given above."
    echo "You will find a menu display with various options, numbered from 1-n where n is the exit key"
    echo "They have the format: (k) <Option> where k is the associated key number." 
    echo "You will be prompted to enter a choice. Enter the number associated with the choice you want."
    echo "The decks are arranged as the 1-m first options to select"
    echo "The 'Add new course' option denotes the first deck modification option"
    echo "Enter the number associated with this option to add a new course to the flashcard deck"
    echo "You will be prompted to enter the name of the new course and then will be returned to the menu display where you will see this new deck as the first option"
    echo "Select the 'Remove a course' option to be redirected to a menu where you will be asked to specify a course to remove by its number" 
    echo "You will be asked to confirm using 'y' or 'n' if you want to remove this course"
    echo "The last option is the number associated with the exit option. Enter this number to exit the application entirely."

}

if [[ $1 == --help ]]
then
    help
    exit 0
fi


main_menu(){
    echo
    echo "Welcome to WANKI!"
    echo "Select a course or add a new one:"

    local i=1
    courses=()

    # List current courses
    for course_dir in "$BASE_DIR"/*/; do
        course_name=$(basename "$course_dir")
        echo "($i) $course_name"
        courses[$i]=$course_name
        ((i++))
    done

    # Option to add new course
    echo "($i) Add new course"
    echo "($((i+1))) Remove a course"
    echo "($((i+2))) Exit"
   
    ((i--))
    read -p "Enter choice: " choice


    # Call appropriate function based on user's selection
    if (( choice == i )); then
        navigate_courses
    
    elif (( choice == i + 1 )); then
        create_course
    elif (( choice == i+2)); then
        remove_course
    elif (( choice == i+3)); then
        exit 0
    elif (( choice >= 1 && choice < i )); then
        selected_course="${courses[$choice]}"
        course_menu "$selected_course"
    else
        echo "Invalid option. Returning to main menu."
    fi
}


navigate_courses() {
    ls $BASE_DIR
    ./showcards
}

# Function to create a new course
create_course() {
    read -p "Enter the new course name: " course_name
    course_dir="$BASE_DIR/$course_name"
    
    if [ -d "$course_dir" ]; then
        echo "Course '$course_name' already exists."
    else
        mkdir -p "$course_dir"
        echo "Course '$course_name' created."
    fi
}

# Function to remove course
remove_course() {
    echo "Select a course to remove:"

    local i=1
    courses=()

    for course_dir in "$BASE_DIR"/*/; do
        if [ -d "$course_dir" ]; then
            course_name=$(basename "$course_dir")
            echo "($i) $course_name"
            courses[$i]="$course_name"
            ((i++))
        fi
    done

    if (( i == 1 )); then
        echo "No courses available to remove."
        return
    fi

    read -p "Enter the number of the course to remove: " choice
    if (( choice >= 1 && choice < i )); then
        selected_course="${courses[$choice]}"
        course_dir="$BASE_DIR/$selected_course"
        
        read -p "Are you sure you want to remove '$selected_course'? (y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
            rm -rf "$course_dir"
            echo "Course '$selected_course' has been removed."
        else
            echo "Removal canceled."
        fi
    else
        echo "Invalid choice. Returning to main menu."
    fi
}

while true; do
    main_menu
done

#!/bin/bash

# Create base directory if doesn't exist already
BASE_DIR="WANKI"
mkdir -p "WANKI"
FILES=("again_flashcards.txt" "hard_flashcards.txt" "good_flashcards.txt" "easy_flashcards.txt")
DIFFICULTIES=("easy" "hard" "again" "good")

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

echo "Welcome to WANKI!"


main_menu(){
    echo
    echo "Select a course or add a new one:"

    local i=1
    courses=()
    num_courses=()

    # List current courses
    # for course_dir in "$BASE_DIR"/*/; do
    #     course_name=$(basename "$course_dir")
    #     echo "($i) $course_name"
    #     courses[$i]=$course_name
    #     ((i++))
    # done


    # Option to add new course
    echo "(1) Navigate courses"
    echo "(2) Add new course"
    echo "(3) Remove a course"
    echo "(4) Exit"
   
    read -p "Enter choice: " choice


    # Call appropriate function based on user's selection
    if (( choice == 1 )); then
        navigate_courses
    
    elif (( choice == 2 )); then
        create_course
    elif (( choice == 3)); then
        remove_course
    elif (( choice == 4)); then
        exit 0
    elif (( choice >= 1 && choice < i )); then
        selected_course="${courses[$choice]}"
        course_menu "$selected_course"
    else
        echo "Invalid option. Returning to main menu."
    fi

}

display_deck() {
    for course_dir in "$BASE_DIR"/*/; do
        course_name=$(basename "$course_dir")
        echo "($i) $course_name"
        courses[$i]=$course_name
        num_courses[$i]=$i
        ((i++))
        
    done
    i=1    
} 

navigate_courses() {
    echo
    echo "COURSES"
    display_deck
    # for course_dir in "$BASE_DIR"/*/; do
    #     course_name=$(basename "$course_dir")
    #     echo "($i) $course_name"
    #     courses[$i]=$course_name
    #     num_courses[$i]=$i
    #     ((i++))
        
    # done
    # i=1

    echo

    read -p "Enter the number of the course in which you want to test yourself: " course_num

    if [[ $course_num == q ]]
    then
        echo
        echo "Returning to main menu"
    
    elif ! [[ "$course_num" =~ ^[0-9]+$ && $((course_num)) -le ${#courses[@]} ]]
    then
        echo "Invalid entry. Try again"
    else
        course=${courses[${course_num}]}
        read -p "Do you wish to test yourself, modify a deck, or quit to menu? (t/m/q): " mode

        if [[ $mode == t ]]
        then
            ./showcards "${BASE_DIR}/${courses[$course_num]}"
            navigate_courses

        elif [[ $mode == m ]]
        then
            course=${courses[${course_num}]}
            echo

            while true
            do
                read -p "How would you like to modify deck $course ('a': add card, 'e': edit card, 'd': delete card)?: " mod_type

                if [[ $mod_type == e ]]
                then
                    edit_card "$course" #Move to edit functionality
                elif [[ $mod_type == a ]]
                then
                    add "$course"
                elif [[ $mod_type == d ]]
                then
                    remove "$course"
                elif [[ $mod_type == q ]]
                then
                    main_menu
                    break 
                else
                    echo "Invalid input. Try again."
                fi
            done                

        elif [[ $mode == q ]]
        then
            echo
            echo "Returning to main menu."
            main_menu

        else
            echo
            echo "Please enter a valid input option"
            echo "Enter 't' to enter testing mode"
            echo "Enter 'm' to enter modification mode"
            echo "Enter 'q' to return to the main menu"
            navigate_courses
        fi
    fi
}

# Function to create a new course
create_course() {
    echo
    #COURSE CANNOT HAVE A "/" OR OTHER ILLEGAL CHAR FOR A FILENAME
    read -p "Enter the new course name: " course_name
    course_dir="$BASE_DIR/$course_name"
    
    if [ -d "$course_dir" ]; then
        echo "Course '$course_name' already exists."
    else
        mkdir -p "$course_dir"
        cd $course_dir
        touch flashcards.txt
        touch easy_flashcards.txt
        touch good_flashcards.txt
        touch hard_flashcards.txt
        touch again_flashcards.txt
        cd ..
        cd ..
        echo "Course '$course_name' created."
    fi
}

# Function to remove course
remove_course() {
    echo
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

FILES=("flashcards.txt" "again_flashcards.txt" "hard_flashcards.txt" "good_flashcards.txt" "easy_flashcards.txt")
DIFFICULTIES=("easy" "hard" "again" "good")

display_cards() {
    echo '-=-=-=-=- CARD LIST -=-=-=-=-'
    local global_line=1  # Start global numbering
    cd WANKI/$1
    # Loop through each file and display the cards with global line numbers
    for file in "${FILES[@]}"; do
        if [[ -f "$file" ]]; then
            echo "Deck: $file"
            while IFS= read -r line; do
                echo "$global_line: $line"
                global_line=$((global_line + 1))  # Increment global line count
            done < "$file"
        fi
        echo ""
    done
    echo ""
}

# Function to get the file and local line for a global line number
get_file_and_local_line() {
    local target_global_line=$1
    local global_line=1

    # Check each file
    #cd WANKI
    #ls
    for file in "${FILES[@]}"; do
        if [[ -f "$file" ]]; then
            local line_count=$(wc -l < "$file")  # Count total lines in this file

            # Check if the global line is in this file
            if (( target_global_line >= global_line && target_global_line < global_line + line_count )); then
                local local_line=$((target_global_line - global_line + 1))  # Calculate local line number
                echo "$file:$local_line"
                return
            fi
            # Update global line for the next file
            global_line=$((global_line + line_count))
        fi
    done

    # If no matching line is found
    echo "ERROR: Line $target_global_line not found."
}

# Function to edit a specific flashcard
edit_flashcard() {
    local global_line=$1
    # Find the file and local line for the global line number
    local file_and_local_line
    file_and_local_line=$(get_file_and_local_line "$global_line")

    if [[ "$file_and_local_line" == ERROR* ]]; then
        echo "$file_and_local_line"
        return
    fi
    echo "File and Local Line: $file_and_local_line"

    # Extract file name and local line number
    local file=${file_and_local_line%%:*}
    local local_line=${file_and_local_line##*:}

    # Get the current content of the line
    local current_line=$(sed -n "${local_line}p" "$file")
    echo "Deck: $file"
    echo "Current Line: $current_line"

    # Prompt user for what to edit
    echo "What would you like to edit? (question/answer/both)"
    read -r edit_choice

    # Edit the question
    if [[ "$edit_choice" == "question" ]]; then
        echo "Type the new question:"
        read -r new_question
        local new_line="${new_question} | ${current_line#*| }"
        sed -i "${local_line}s/.*/${new_line}/" "$file"
        echo "Question updated successfully in $file."

    # Edit the answer
    elif [[ "$edit_choice" == "answer" ]]; then
        echo "Type the new answer:"
        read -r new_answer
        local new_line="${current_line%| *} | ${new_answer}"
        sed -i "${local_line}s/.*/${new_line}/" "$file"
        echo "Answer updated successfully in $file."

    # Edit both the question and answer
    elif [[ "$edit_choice" == "both" ]]; then
        echo "Type the new question:"
        read -r new_question
        echo "Type the new answer:"
        read -r new_answer
        local new_line="${new_question} | ${new_answer}"
        sed -i "${local_line}s/.*/${new_line}/" "$file"
        echo "Card updated successfully in $file."

    # Handle invalid input
    else
        echo "Invalid choice. No changes made."
        return
    fi

    # Prompt to change the difficulty of the card
    echo "Select the new difficulty for this card: (easy/hard/again/good)"
    read -r new_difficulty

    # Check if the input is valid
    if [[ ! " ${DIFFICULTIES[@]} " =~ " ${new_difficulty} " ]]; then
        echo "Invalid difficulty selected. No changes made."
        return
    fi

    # Remove the card from the current file
    sed -i "${local_line}d" "$file"

    # Append the card to the appropriate difficulty file
    local new_file="${new_difficulty}_flashcards.txt"
    echo "$new_line" >> "$new_file"
    echo "Card moved to $new_difficulty deck."
}

# Main loop
edit_card()
{
    #ls
    while true; do
        display_cards "$1"  # Show all cards with global numbering
        #ls
        # Prompt the user to select a card or quit
        echo "Enter the global line number to edit (or 'q' to quit):"
        read -r line_number

        if [[ "$line_number" == "q" ]]; then
            echo "Exiting..."
            break
        elif [[ "$line_number" =~ ^[0-9]+$ ]]; then
            echo $line_number
            edit_flashcard "$line_number"
        else
            echo "Invalid input. Please enter a valid global line number."
        fi
    done
}

while true; do
    main_menu
done

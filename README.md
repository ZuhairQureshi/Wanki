# the-team-assignment-team-18-lab-rats
-------------------------------------
WANKI: A Bash-Based Flashcard Utility
-------------------------------------

**Introduction**
WANKI is a command-line flashcard application written in Bash, inspired by Anki, the popular spaced repetition software. It allows users to create, edit, review, and manage flashcards efficiently, all from the terminal. WANKI organizes cards based on difficulty levels (easy, good, hard, again) and supports spaced repetition by dynamically updating card difficulty based on user feedback.

**Features**
- Dynamic Flashcard Selection
  - Cards are categorized into easy, good, hard, and again
  - Cards are randomly selected with probabilities influenced by their difficulty level (ie. there is a higher probability of seeing a hard card than an easy card)
- Course Management
  - Create and organize courses and directories
  - Add and remove courses dynamically
- Create, Edit, and Delete Flashcards
- Review Mode
  - Review questions by displaying the question (front) first
  - Mark card difficulty after viewing the answer (back)
  - Cards are moved to appropriate difficulty based on user input

**File Structure**  
WANKI creates and manages flashcards using plain text files in the WANKI directory
- Course Directories: Each course has its own course directory
- Flashcard Files: Each difficulty level has its own text file within the course directory (eg. easy.txt, hard.txt)

**Usage**
1. Run the program to access the main menu

        ./wanki

2. From the main menu you can select one of the following options by typing its corresponding number in the menu:  
   - Select course  
   - Add new course  
   - Remove a course  
   - Exit

  a) **Select course**
  If you have added at least one course, select the 'Select course' option, where a new menu   
  will be opened and you will be prompted to enter a number corresponding to the course you would 
  like to select.
  
  After selecting a course, you will be given the following options:
       - Test yourself with this deck (t)  
       - Modify this deck (m) 
       - Quit to the main menu (q)

           (i) **Test yourself**
           This option will begin displaying flashcards you have created in that deck. It will 
           first display the front of the card. Press enter to show back. You will then be 
           prompted to input difficulty of the card ('e' for easy, g for good, h for hard, and a 
           for again). The probability of seeing each difficulty of card is as follows:
             - 50% again
             - 35% hard
             - 10% good
             - 5% easy

          (ii) **Modify this deck**
          When modifying a deck, you are given the option between adding, removing, and editing 
          cards within the selected deck. You will be prompted to enter a choice. Enter the letter 
          associated with the desired action (a = add, e = edit, d = delete).


  b) **Add new course**
  Select this option to add a new course. You will be prompted to enter the name of the new course 
  and then will be returned to the menu display where you will see this new deck displayed as the 
  first option. To add cards to this new course, see option (a).

  c) **Remove a course**
  Select this option to remove a course. You will be redirected to a meny where you will be asked 
  to specify a course to remove by its corresponding number. You will be asked to confirm using 
  'y' or 'n' if you want to remove this course.

  d) **Exit**
  Select this option to exit the application entirely.

# WANKI: A Bash-Based Flashcard Utility (v3.0.3)
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

2. From the main menu, select one of the following options by typing its corresponding number:  
   - Select course  
   - Add new course  
   - Remove a course  
   - Exit  

   #### **a) Select Course**  
   If you have added at least one course, select the "Select course" option. A new menu will open, and you will be prompted to enter a number corresponding to the course you want to select.  

   After selecting a course, you will be given the following options:  
   - Test yourself with this deck (t)  
   - Modify this deck (m)  
   - Quit to the main menu (q)  

      - **Test Yourself**  
      This option will display flashcards from the selected deck. It will:  
             1. Show the front of the card first.  
             2. After pressing Enter, display the back of the card.  
             3. Prompt you to input the difficulty of the card:  
               - `e` for easy  
               - `g` for good  
               - `h` for hard  
               - `a` for again
        
         Card probability distribution:
         - 50% `Again`  
         - 35% `Hard` 
         - 10% `Good`  
         - 5% `Easy`  

      - **Modify This Deck**  
         Modify your selected deck by:  
         - Adding cards  
         - Removing cards  
         - Editing cards
         - Reset difficulty of cards in deck  

         Enter the desired action:  
         - `a` = Add  
         - `e` = Edit  
         - `d` = Delete
         - `r` = Reset Difficulty

   #### **b) Add New Course**  
   Select this option to add a new course. You will be prompted to:  
   - Enter the name of the new course.  
   - Return to the menu display, where the new deck will appear as an option.  

   To add cards to the new course, see option (a).  

   #### **c) Remove a Course**  
   Select this option to remove a course. You will be redirected to a menu where you can:  
   - Specify the course to remove by its corresponding number.  
   - Confirm the removal using `y` (yes) or `n` (no).  

   #### **d) Exit**  
   Select this option to exit the application entirely.  

**Help Flag**

To receive detailed instructions on the usage of this app via command line, simply enter the following at the command line within the working directory:

`./wanki --help`

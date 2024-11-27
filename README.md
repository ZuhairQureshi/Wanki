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
WANKI creates and manages flashcards using plain text files in the user's home directory
- Base Directory: $HOME/WANKI
- Course Directories: Each course has its own course directory
- Flashcard Files: Each difficulty level has its own text file within the course directory (eg. easy.txt, hard.txt)

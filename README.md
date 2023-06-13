# Game of Nim
A console-based Nim client written in Pascal featuring multiplayer and computer opponent.

**Author:** Rohan Khayech

## Description

The game of Nim starts with multiple piles of up to 30 matches. On your turn you can take any number of matches from one of the piles. The person to take the last match or pile of matches wins. You may play against another player or against the computer opponent.

### How the Computer Opponent Calculates a Winning Position
To calculate a safe move for the computer (if one is available) it must first do a series of checks and steps. Firstly, it converts the amounts of matches in each pile to binary, and then adds up them up into a sum. This sum is then broken up into its digits. Each digit is divided by 2 and the remainder is the column parity digit. These parity digits are then recombined and the resulting binary number is converted back to an integer form. 

Then, for each pile, an exclusive or (xor) operation is performed, comparing the number of matches in the pile to the column parity. This operation produces a nim-sum for each row, which is the number of matches that the pile must be reduced to in order to make the column parity zero and therefore perform a safe move. 

The amount that would need to be taken from the pile is calculated as the amount in the pile minus the nim-sum. If this amount is above zero, that means it is a valid move and the computer will check each of these amounts and play one that is valid.

In the case that the game was already safe, therefore the computer cannot make a safe move, it simply takes 1 match from the largest pile. 

## Usage

### Running the Game
The game can be run from source using the Lazarus IDE or via running the `.exe` file from the release page on Windows.

### How to Play

#### Starting a Game 
From the menu you can choose one of four options:
1.	Play against the computer.
2.	Play multiplayer.
3.	Read the instructions.
4.	Exit the game.

#### Playing the Game
##### Choosing a number of piles
 
Upon starting a game, you will be asked to enter the number of piles you want to play with. You can choose between 2-6 piles of matches. Enter a valid number of piles and press enter to start the game.

##### On your turn

[]()

At the start of a turn you will be presented with the above interface. At the top the current player whose turn it is displayed. Below that there is a visual representation of the different piles of matchsticks in the game. This tells you how many matches are available in each pile. You will first be asked to choose a pile to take matches from. You must enter a number corresponding to one of the non-empty piles. Then, you will be asked how many matches you want to take from that pile. You can enter take any number of matches from one pile on your turn, but you cannot take none, or more than are available in the pile. Lastly you will be asked to confirm your move. If you are happy with your move, type `yes` and press enter. If you want to cancel and make another move type `no` and press enter, and you will be able to re-enter your move.

##### Checking if your move was safe
After making your move, you will be told if your move was safe or not.
 
A safe move is one from which you can securely win the game by continuing to make safe moves until you can take the last match. If your opponent makes a safe move on the previous turn, any move you make will be a bad move, and vice-versa.

##### Playing against the computer
When playing against the computer, you get the first move, and you will always be able to win the game if you play correctly. Make safe moves, and the computer will not be able to beat you. However, if you make a bad move, the computer does not play easy on you, and will continue to make safe moves until it wins. If the computer knows it will win, it will present you with this message:

``` 
The computer has outsmarted you! You cannot win this game.
Skip to the end of the game? (yes/no)
```
 
You can type `yes` and press enter to resign from the game and let the computer win. However, if you think you can prove the computer wrong, you may continue the game to your demise by typing `no` and press enter.

##### Winning the game
The last person to take a match wins the game. When this occurs the winner will be shown on the screen and you can continue back to the main menu.
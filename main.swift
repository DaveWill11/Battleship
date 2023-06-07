
//If using replit, comment out the "exit(0)" lines in the gameOver function.

import Foundation
let sub : Character = "\u{04E8}"
let acc : Character = "\u{0428}"
let tug : Character = "\u{04DC}"
let asterisk : Character = Character(UnicodeScalar(42)!)
let shipArray : Array = ["F4", "F5", "A9", "B9", "J2", "J3", "A7", "B7", "C7", "G7","G8", "G9", "G10"]
let tug1 : Array = ["F4", "F5"]
let tug2 : Array = ["A9", "B9"]
let tug3 : Array = ["J2", "J3"]
let sub1 : Array = ["A7", "B7", "C7"]
let acc1 : Array = ["G7", "G8", "G9", "G10"]
var row : Character = "A"
var col : Int = 0
var rowUnicode : Int = 65
var guessTuples : [(row: Character, col: Int, hit: String)] = []
var guessArray : Array<String> = [""]
var tug1Count : Int = 0
var tug2Count : Int = 0
var tug3Count : Int = 0
var subCount : Int = 0
var accCount : Int = 0
var sunkCount : Int = 0
var reader : String = "";
var placeCounter : Int = 0;

func printBoardStart()
    {
        for count in 1...10
        {
            print("\t\(count)", terminator: "")
        }
        print("\n")
        for _ in 1...10
        {
            let letter : Character = Character(UnicodeScalar(rowUnicode)!)
            print(letter, terminator: "")
            for _ in 1...10
            {
                print("\t\(asterisk)", terminator: "")
            }
            print("")
            rowUnicode += 1
        }
    }
    func printBoardGuess(row1: Character, col1: Int, ship : String, guesses: Array<String>) {
        rowUnicode = 65
        for count in 1...10
        {
            print("\t\(count)", terminator: "")
        }
        print("\n")
        for _ in 1...10
        {
            let letter : Character = Character(UnicodeScalar(rowUnicode)!)
            print(letter, terminator: "")
            
            for count in 1...10
            {
                for record in guessTuples
                {
                    if(record.row == letter && record.col == count)
                    {
                        switch(record.hit)
                        {
                        case "tug1", "tug2", "tug3": print("\t\(tug)", terminator: ""); placeCounter+=1;
                        case "sub": print("\t\(sub)", terminator: "");placeCounter+=1;
                        case "acc": print("\t\(acc)", terminator: "");placeCounter+=1;
                        case "miss": print("\t", terminator: "");placeCounter+=1;
                        default: print(""); placeCounter+=1;
                            
                        }

                    }
                    
                }
              if(placeCounter != count)
              {
                print("\t\(asterisk)", terminator: "");                    placeCounter+=1;
              }
 		         
            }
            print("")
            rowUnicode += 1
            placeCounter = 0
            
        }
        switch(ship)
        {
        case "tug1": print("\nYou hit a tugboat!\n");
            if(tug1Count >= 2){print("\nYou sunk a tugboat!\n")};
            if(sunkCount >= 13){print("\nYou sunk all of the ships!"); gameOver()};break;
        case "tug2": print("\nYou hit a tugboat!\n");
            if(tug2Count >= 2){print("\nYou sunk a tugboat!\n")};
            if(sunkCount >= 13){print("\nYou sunk all of the ships!"); gameOver()};break;
        case "tug3": print("\nYou hit a tugboat!\n");
            if(tug3Count >= 2){print("\nYou sunk a tugboat!\n")};
            if(sunkCount >= 13){print("\nYou sunk all of the ships!"); gameOver()};break;
        case "sub": print("\nYou hit a submarine!\n");
            if(subCount >= 3){print("\nYou sunk a submarine!\n")};
            if(sunkCount >= 13){print("\nYou sunk all of the ships!"); gameOver()};break;
        case "acc": print("\nYou hit an air craft carrier!\n");
            if(accCount >= 4){print("\nYou sunk an air craft carrier!\n")};
            if(sunkCount >= 13){print("\nYou sunk all of the ships!"); gameOver()};break;
        default: print("\nYou missed!\n"); break;
            
        }
        row = "A"
        col = 0
        guess()
    }
    func gameOver()
    {
        print("\nGame over! Play Again? Y/N")
        let response = Character(readLine()!)
        if(response.asciiValue! == 89 || response.asciiValue! == 121)
        {
            initialize()
        }
        else if(response.asciiValue! == 78 || response.asciiValue! == 110)
        {
            exit(0)
        }
        else
        {
            print("\nInvalid entry...Exiting")
            exit(0)
        }
    }
    func initialize() {
        printBoardStart()
        guess()
        
        
    }
    func guess(){
        print("\nEnter the alpha row to target: ")
        reader = String(readLine()!)
        while(reader.count != 1)
        {
            print("\nRow cannot be more than 1 character")
            print("Enter the alpha row to target (A-J)")
            reader = String(readLine()!)
            if(reader.count == 1)
            {
                let chars = Array(reader)
                row = chars[0]
                
                while(row.asciiValue! > 74 || row.asciiValue! < 65)
                {
                    print("\nRow must be between A and J")
                    print("\nEnter the alpha row to target (A-J): ")
                    
                    reader = String(readLine()!)
                    let chars = Array(reader)
                    row = chars[0]
                    
                }
                
            }
            else{
                continue;
                
            }
            
        }
        var chars = Array(reader)
        row = chars[0]
        while(row.asciiValue! > 74 || row.asciiValue! < 65)
        {
            print("\nRow must be between A and J")
            print("\nEnter the alpha row to target (A-J): ")
            
            reader = String(readLine()!)
            let chars = Array(reader)
            row = chars[0]
            
        }
        chars = Array(reader)
        row = chars[0]
        
        while(col > 10 || col < 1)
        {
            print("\nEnter the numeric column to target: ")
            if let readint = readLine()
            {
                if let int = Int(readint)
                {
                    col = int
                    if(col > 10 || col < 1)
                    {
                        print("\nColumn must be between 1 and 10")
                        continue;
                    }
                }
                else {
                    print("\nPlease enter a number if you know what's good for you")
                    continue;
                }
            }
        }
      
        let currentGuess : String = String(row) + String(col);
        if(!guessArray.contains(currentGuess))
        {
            guessArray.append(currentGuess)
            let ship : String = whichShipNoCount(guess: currentGuess)
            guessTuples += [(row: row, col: col, hit: ship)]
            print("\nYou selected \(row)\(col)\n")
        }
        else{
            print("\nYou already guessed that. Guess again!\n")
            row = "A"
            col = 0
            guess()
        }
        
        
        
        let hit : Bool = isHit(guess: currentGuess)
        if(hit)
        {
            let ship : String = whichShip(guess: currentGuess)
            printBoardGuess(row1: row, col1: col, ship: ship, guesses: guessArray)
            
        }
        else {
            printBoardGuess(row1: row, col1: col, ship: "Miss", guesses: guessArray)
        }
        
        
    }
    
    func isHit(guess : String) -> Bool
    {
        var hit : Bool = false
        
        if(shipArray.contains(guess))
        {
            hit = true
        }
        return hit;
    }
    func whichShip(guess: String) -> String
    {
        if(tug1.contains(guess)) {
            tug1Count+=1
            sunkCount+=1
            return "tug1"
        }
        else if (tug2.contains(guess)){
            tug2Count+=1
            sunkCount+=1
            return "tug2"
        }
        else if(tug3.contains(guess)){
            tug3Count+=1
            sunkCount+=1
            return "tug3"
        }
        else if(sub1.contains(guess)){
            subCount+=1
            sunkCount+=1
            return "sub"
        }
        else if(acc1.contains(guess)){
            accCount+=1
            sunkCount+=1
            return "acc"
        }
        else{
            return "miss"
        }
    }
    func whichShipNoCount(guess: String) -> String
    {
        if(tug1.contains(guess)) {
            return "tug1"
        }
        else if (tug2.contains(guess)){
            return "tug2"
        }
        else if(tug3.contains(guess)){
            return "tug3"
        }
        else if(sub1.contains(guess)){
            return "sub"
        }
        else if(acc1.contains(guess)){
            return "acc"
        }
        else{
            return "miss"
        }
    }
initialize()


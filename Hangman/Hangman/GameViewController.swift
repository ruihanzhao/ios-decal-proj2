//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var secretWord: UILabel!
    var word: String!
    var wordArr: Array<String>!
    var num: Int = 0
    var incorrect =  [Character]()
    var counter: Int = 0
    @IBOutlet weak var startOver: UIBarButtonItem!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var incorrectGuesses: UILabel!
    @IBOutlet weak var hangmanImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        var phrase = hangmanPhrases.getRandomPhrase()
        word = phrase
        wordArr = [String]()
        loadSpaces()
        print(phrase)
        drawMarks()
//        addTarget()
        hangmanImage.image = UIImage(named: "hangman1.gif")
    }

    @IBAction func resetGame() {
        num = 0
        counter = 0
        let hangmanPhrases = HangmanPhrases()
        var phrase = hangmanPhrases.getRandomPhrase()
        word = phrase
        wordArr.removeAll()
        secretWord.text = ""
        wordArr = [String]()
        incorrectGuesses.text = ""
        loadSpaces()
        print(phrase)
        drawMarks()
        hangmanImage.image = UIImage(named: "hangman1.gif")

    }
    @IBAction func guessed() {
        displayLetters()
        guessText.text = nil
    }
    func loadSpaces() {
        if (num > 0) {
            return
        }
        
        for (var i = 0; i < word.characters.count; i++) {
            num+=1
            let index = word.startIndex.advancedBy(i)
            if (word[index] == " ") {
                wordArr.append(" ")
            }
            else {
                wordArr.append("-")
            }
        }
    }
    /** Draws what is in wordArr over to screen. */
    func drawMarks() {
        print("text: \(secretWord.text)")
        for (var i = 0; i < wordArr.count; i++) {
            secretWord.text = secretWord.text!.stringByAppendingString(wordArr[i])
        }
        
        
        
    }
    @IBAction func reloadStartScreenViewController(segue : UIStoryboardSegue) {
        
    }
    
    func win() {
        for (var i = 0; i < wordArr.count; i++) {
            if wordArr[i] == "-" {
                return
            }
        }
        let alert = UIAlertController(title: "Congratulations!", message: "Yay! You win!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    func displayLetters() {

        if (guessText.text == "") {
            return
        }
        else if (guessText.text!.characters.count > 1) {
            print("too many")
            
        }
        else {
            var found = false
            for (var i = 0; i < word.characters.count; i++){
                let index = word.startIndex.advancedBy(i)
                print("word: \(word[index])")
                guessText.text = guessText.text!.uppercaseString
                if (word[index] == guessText.text![guessText.text!.startIndex]) {
                    found = true
                    print("hi")
                    wordArr[i] = guessText.text!
                    secretWord.text = ""
                    drawMarks()
                    win()
                }
            }
            if (found == false) {
                incorrectGuesses.text = incorrectGuesses.text?.stringByAppendingString(guessText.text!)
                counter+=1
                reloadView()
                
            }
        }
    }
    func reloadView() {
        if counter == 1 {
            hangmanImage.image = UIImage(named: "hangman2.gif")
        }
        else if counter == 2 {
            hangmanImage.image = UIImage(named: "hangman3.gif")
        }
        else if counter == 3 {
            hangmanImage.image = UIImage(named: "hangman4.gif")
        }
        else if counter == 4 {
            hangmanImage.image = UIImage(named: "hangman5.gif")
        }
        else if counter == 5 {
            hangmanImage.image = UIImage(named: "hangman6.gif")
        }
        else if counter == 6 {
            hangmanImage.image = UIImage(named: "hangman7.gif")
            let alert = UIAlertController(title: "You Lose", message: "Better luck next time!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

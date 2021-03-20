//
//  ViewController.swift
//  My Flashcards
//
//  Created by Nicholas Oduma on 2/26/21.
//

import UIKit


struct Flashcard {
    var question: String
    var answer: String
}
class ViewController: UIViewController {
    
    var flashcardsController: ViewController!
    var hide:Bool = false;

    @IBOutlet weak var frontLabel:UILabel!
    @IBOutlet weak var backLabel: UILabel!
   
    
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        readSavedFlashcards()
       
        updateFlashcard(question: "How tall is the eiffel tower?", answer: "1063 feet")
    
          updateLabels()
    updateNextPrevButtons()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self;
    }
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
         updateLabels()
        
        updateNextPrevButtons()
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        
       updateLabels()
        
        updateNextPrevButtons()
        
    }
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(hide==false){
            frontLabel.isHidden=false
            backLabel.isHidden = true
            hide=true
        } else if(hide==true){
            frontLabel.isHidden=true
            backLabel.isHidden=false
            hide=false
        }
    }
    func updateLabels()
    {
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        
        //update Labels
 frontLabel.text = currentFlashcard.question
 backLabel.text = currentFlashcard.answer
    }
    func updateFlashcard(question: String, answer: String) {
        
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        
        frontLabel.text = flashcard.question;
        backLabel.text = flashcard.answer;
    
    
        print(":) Added new flashcard")
        
        print("We now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        
        print("Our current index is \(currentIndex)")
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
}
        func updateNextPrevButtons() {
            
            if currentIndex == flashcards.count - 1 {
                nextButton.isEnabled = false
            } else
            
       {
                nextButton.isEnabled = true
       }
                if currentIndex == 0 {
                    prevButton.isEnabled = false
                } else {
                    prevButton.isEnabled = true
                   
                }
            }
    func saveAllFlashcardsToDisk() {
     
        let dictionaryArray = flashcards.map { (card) -> [String : String] in
            return ["question": card.question, "answer":card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
       
        print("Flashcards saved to UserDefaults")
}
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:
        String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer:dictionary["answer"]!)
                            
        }
            flashcards.append(contentsOf: savedCards)
    }
        func readSavedFlashcards(){
            if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
                
                let savedCards = dictionaryArray.map{ dictionary -> Flashcard in
                    return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
                flashcards.append(contentsOf: savedCards)
        }


    


}
}
}


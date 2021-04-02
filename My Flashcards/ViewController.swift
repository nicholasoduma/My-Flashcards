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
   
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        
         updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        currentIndex = currentIndex + 1
        
       updateLabels()
        
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard() }
    
        
        
        func flipFlashcard() {
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
                                if(self.hide==false){
                                    self.frontLabel.isHidden=false
                                    self.backLabel.isHidden = true
                                    self.hide=true
                                } else if(self.hide==true){
                                    self.frontLabel.isHidden=true
                                    self.backLabel.isHidden=false
                                    self.hide=false
                
            }
        }
        )    }
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
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: { self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: { finished in
         
    
            // Update labels
            self.updateLabels()
            
            // Run other animation
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        
        // Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
            
            self.updateLabels()
            
            
            
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

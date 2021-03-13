//
//  ViewController.swift
//  My Flashcards
//
//  Created by Nicholas Oduma on 2/26/21.
//

import UIKit

class ViewController: UIViewController {
    
    var flashcardsController: ViewController!
    var hide:Bool = false;

    @IBOutlet weak var frontLabel:UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self;
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
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question;
        backLabel.text = answer;
        
    }
    
    
}


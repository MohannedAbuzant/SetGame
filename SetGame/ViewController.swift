//
//  ViewController.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 22/07/2021.
//

import UIKit


class ViewController: UIViewController {
    var game = Game()
    @IBOutlet var buttons:[UIButton]!
    @IBOutlet weak var ScoreLabel:UILabel!
    @IBOutlet weak var  Deal3More:UIButton!
    @IBAction func RestartGame(){
        game = Game()
        updateView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    @IBAction func Deal3MoreCards(button:UIButton){
        game.DealMore()
        if game.deck.count == 0  {
            button.isHidden = true
        }
        
        updateView()
        
    }
    @IBAction func chooseCard(button:UIButton){
        if let index = buttons.firstIndex(of: button){
            if !game.deck[index].isSelected {
                game.deck[index].isSelected = true
                game.selectedCards.append(game.deck[index])
                
                
            }
            else{
                
                let indexOfSelectedCards =  game.selectedCards.findCard(card: game.deck[index])!
                game.selectedCards.remove(at: indexOfSelectedCards)
                game.deck[index].isSelected = false
            }
        }
        
        
        else{
            return
        }
        
        if game.selectedCards.count == 3 {
            let result = game.checkIfMatch()
            if result {
                game.addCardsToMatchedCardArray()
                game.score+=30
            }
            else{
                game.score-=10
            }
           updateView()
           game.clearSelectedCards()
            return
        }
        updateView()
        
    }
   
    
    func hideDealButtonController(){
        if  !game.matchedCards.isEmpty || game.numOfCardsOnBoard<24 {
            Deal3More.isHidden=false
        }else{
            Deal3More.isHidden = true
        }
        
    }
    
    func hideButtonsController(hiddenCounter:Int)  {
        if hiddenCounter == buttons.count-1 {
            let alert =  UIAlertController(title: "Game Over", message: "Wohoo! you scored \(game.score)", preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Restart Game", style: UIAlertAction.Style.default, handler: {
                UIAlertAction in self.RestartGame()
            } )
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }

    func updateView(){
        ScoreLabel.text="Score:\(game.score)"
        var hiddenCounter = 0
        for index in 0..<buttons.count{
            let button = buttons[index]
            if index < game.deck.count  && index < game.numOfCardsOnBoard  {
                let card = game.deck[index]
                hideDealButtonController()
                buttonConfiguration(button: button, card: card,game:game)
            }
            else{
                button.isHidden=true
                hiddenCounter+=1
            }
            
            hideButtonsController(hiddenCounter: hiddenCounter)
        }
        
    }
    
}




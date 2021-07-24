//
//  ViewController.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 22/07/2021.
//

import UIKit
enum Shapes:String,CaseIterable {
    case circle = "●"
    case triangle = "▲"
    case square = "■"
}
enum Fillness:CaseIterable{
    case filled
    case empty
    case stripped
    func returnValue(color:()->UIColor) -> [NSAttributedString.Key:Any]{
        switch self {
        case .filled:
            return [.foregroundColor: color().withAlphaComponent(1),.strokeWidth: -3.0,]
        case .empty:
            return [.foregroundColor: color().withAlphaComponent(1),.strokeWidth: 3.0,]
        case .stripped:
            return [.foregroundColor: color().withAlphaComponent(0.15),.strokeWidth: -3.0,]
            
        }
    }
}
enum Color:CaseIterable {
    case red
    case green
    case blue
}
extension Array where Element == Card{
    func findCard (card :Card) -> Int?{
        for index in 0..<self.count{
            if card.id == self[index].id {
                return index
            }
        }
        return nil
    }
}

class ViewController: UIViewController {
    @IBOutlet var buttons:[UIButton]!
    var game = Game()
    @IBOutlet weak var ScoreLabel:UILabel!
    @IBOutlet weak var  Deal3More:UIButton!
    @IBAction func RestartGame(){
        print("NewGame")
        game.restartGame()
        updateView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
    }
    @IBAction func Deal3MoreCards(button:UIButton){
        if !game.matchedCards.isEmpty {
            for card in game.matchedCards{
                game.deck.remove(at:game.deck.findCard(card: card)! )
            }
            game.matchedCards.removeAll()
        }
        else if game.numOfCardsOnBoard < 24 {
            game.numOfCardsOnBoard+=3
            
        }
    
        updateView()
        
    }
    @IBAction func chooseCard(button:UIButton){
        if game.selectedCards.count == 3 {
            for card in game.selectedCards {
                if let index = game.deck.findCard(card: card){
                    game.deck[index].isSelected = false
                }
                
                
            }
            game.selectedCards.removeAll()
        }
        
        if let index = buttons.firstIndex(of: button){
            if !game.deck[index].isSelected {
                game.deck[index].isSelected = true
                game.selectedCards.append(game.deck[index])
                
                
            }
            else{
                
                let indexOfSelectedCards =  game.selectedCards.firstIndex(of: game.deck[index])!
                game.selectedCards.remove(at: indexOfSelectedCards)
                game.deck[index].isSelected = false
            }
        }
        
        
        else{
            return
        }
        
        if game.selectedCards.count == 3 {
            let result = game.CheckIfMatch()
            
            
            
            if result == true {
                for  index in 0..<game.selectedCards.count {
                    
                    game.deck[game.deck.firstIndex(of: game.selectedCards[index])!].isMatched=true
                    game.selectedCards[index].isMatched = true
                    game.matchedCards.append(game.selectedCards[index])
                    game.score+=10
                }
            }
            else{
                game.score-=10
            }
            
        }
        
        updateView()
        
        
    }
    
   
    func updateView(){
        ScoreLabel.text="Score:\(game.score)"
        
        for index in 0..<buttons.count{
            
            if index < game.numOfCardsOnBoard {
                
            
            if !game.matchedCards.isEmpty || game.numOfCardsOnBoard<24 {
                Deal3More.isHidden=false
            }else{
                Deal3More.isHidden = true
            }
                let SelectedColor = { (color:Color) -> ()->UIColor in
                    switch color {
                    case .red:
                        return {UIColor.red}
                    case .green:
                        return {UIColor.green}
                    case .blue:
                        return {UIColor.blue}
                        
                    }
                }
            
            buttons[index].isHidden = false
            let m:NSAttributedString = NSAttributedString(string:String(repeating: game.deck[index].shape.rawValue , count: game.deck[index].num) ,attributes :game.deck[index].fillness.returnValue(color: SelectedColor(game.deck[index].color)) )
            if game.deck[index].isMatched == true {
                buttons[index].isEnabled = false
                buttons[index].layer.borderWidth = 5
                buttons[index].layer.borderColor = UIColor.systemGreen.cgColor
            }
            else if(game.selectedCards.count==3 && game.deck[index].isSelected==true){
                buttons[index].layer.borderWidth = 5
                buttons[index].layer.borderColor = UIColor.systemRed.cgColor
            }
            else if (game.selectedCards.count != 3 && game.deck[index].isSelected==true) {
                buttons[index].layer.borderWidth = 5
                buttons[index].layer.borderColor = UIColor.systemTeal.cgColor
            }
            else{
                buttons[index].isEnabled = true
                buttons[index].layer.borderWidth = 0
                buttons[index].layer.borderColor = UIColor.systemTeal.cgColor
            }
            buttons[index].setAttributedTitle(m, for:   UIControl.State.normal)
            }
            else{
                buttons[index].isHidden=true
            }
            
        }
        
    }
    
}


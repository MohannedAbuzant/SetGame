//
//  Game.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 23/07/2021.
//

import Foundation
class Game {
    var deck:[Card] = []
    var score:Int = 0
    var selectedCards:[Card] = []
    var numOfCardsOnBoard:Int
    var matchedCards:[Card] = []
    
    init() {
        
        var index = 0
        for num in 1...3{
            for shape in Shapes.allCases {
                for color in Color.allCases {
                    for fillness in Fillness.allCases {
                        deck.append(Card(num: num, shape: shape, color: color, fillness: fillness, isSelected: false, isMatched: false, id: index))
                        index+=1
                    }
                }
            }
        }
        
        numOfCardsOnBoard = 12
        score = 0
        deck.shuffle()
        
    }
    
    func checkIfMatch() -> Bool  {
        
        return checkIfPropertyMatch(property: "number")&&checkIfPropertyMatch(property: "shape")&&checkIfPropertyMatch(property: "color")&&checkIfPropertyMatch(property: "fillness")
        
    }
    func checkPropertySetRuleMatch<T>(property1:T,property2:T,property3:T)->Bool where T:Equatable{
        if(property1 == property2 && property2 == property3 && property1 == property3){
            return true
        }
        if  ( property1 != property2 && property2 != property3 && property1 != property3 ) {
            return true
        }
        return false
    }
    
    func checkIfPropertyMatch(property:String) -> Bool  {
        let cardNo1 =  selectedCards[0]
        let cardNo2 = selectedCards[1]
        let cardNo3 = selectedCards[2]
        
        switch property {
        case "number":
            return checkPropertySetRuleMatch(property1: cardNo1.num, property2: cardNo2.num, property3: cardNo3.num)
        case "shape":
            return checkPropertySetRuleMatch(property1: cardNo1.shape, property2: cardNo2.shape, property3: cardNo3.shape)
        case "fillness":
            return checkPropertySetRuleMatch(property1: cardNo1.fillness, property2: cardNo2.fillness, property3: cardNo3.fillness)
        case "color":
            return checkPropertySetRuleMatch(property1: cardNo1.color, property2: cardNo2.color, property3: cardNo3.color)
        default:
            print("property is unknown!")
            return false
        }
        
    }
    func DealMore(){
        if !matchedCards.isEmpty {
            for card in matchedCards{
                
                
                if let index = deck.findCard(card: card){
                    if index < deck.count-1 {
                        deck[index] = deck.popLast()!
                    }
                    else {
                        deck.remove(at:deck.findCard(card: card)! )
                    }
                    
                }
                
                
                
            }
            matchedCards.removeAll()
        }
        else if numOfCardsOnBoard < 24 {
            numOfCardsOnBoard+=3
            
        }
    }
    func clearSelectedCards()  {
        for card in self.selectedCards {
            if let index = self.deck.findCard(card: card){
                self.deck[index].isSelected = false
            }
        }
        self.selectedCards.removeAll()
    }
    func addCardsToMatchedCardArray(){
        for  index in 0..<selectedCards.count {
            deck[deck.findCard(card: selectedCards[index])!].isMatched=true
            selectedCards[index].isMatched = true
            matchedCards.append(selectedCards[index])
            
        }
    }
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

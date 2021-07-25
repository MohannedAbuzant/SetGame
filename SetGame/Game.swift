//
//  Game.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 23/07/2021.
//

import Foundation
struct Game {
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
        deck.shuffle()
        
    }
    mutating func restartGame()   {
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
    func CheckIfMatch() -> Bool  {
//        if !((selectedCards[0].num == selectedCards[1].num && selectedCards[1].num == selectedCards[2].num && selectedCards[0].num == selectedCards[2].num) || (selectedCards[0].num != selectedCards[1].num && selectedCards[1].num != selectedCards[2].num && selectedCards[0].num != selectedCards[2].num) )   {
//            return false
//        }
//        if !((selectedCards[0].shape == selectedCards[1].shape && selectedCards[1].shape == selectedCards[2].shape && selectedCards[0].shape == selectedCards[2].shape) || (selectedCards[0].shape != selectedCards[1].shape && selectedCards[1].shape != selectedCards[2].shape && selectedCards[0].shape != selectedCards[2].shape))    {
//            return false
//        }
//        if !((selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color && selectedCards[0].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[0].color != selectedCards[2].color))   {
//          
//            return false
//        }
//        if !((selectedCards[0].fillness == selectedCards[1].fillness && selectedCards[1].fillness == selectedCards[2].fillness && selectedCards[0].fillness == selectedCards[2].fillness) || (selectedCards[0].fillness != selectedCards[1].fillness && selectedCards[1].fillness != selectedCards[2].fillness && selectedCards[0].fillness != selectedCards[2].fillness) )   {
//            return false
//        }
        return true

    }
}



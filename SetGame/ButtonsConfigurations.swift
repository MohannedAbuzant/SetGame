//
//  ButtonsConfigurations.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 28/07/2021.
//

import UIKit

func buttonConfiguration(button:UIButton,card:Card,game:Game){
    button.isHidden = false
    button.layer.borderWidth = 5
    switch true {
    case card.isMatched:
        button.isEnabled = false
        button.layer.borderColor = UIColor.systemGreen.cgColor
    case (game.selectedCards.count == 3 && card.isSelected):

        button.layer.borderColor = UIColor.systemRed.cgColor
        
    case  (game.selectedCards.count != 3 && card.isSelected ):
        button.layer.borderColor = UIColor.systemTeal.cgColor
    default:
        button.isEnabled = true
        button.layer.borderWidth = 0
    }
    let innerCardText:NSAttributedString = NSAttributedString(string:String(repeating: card.shape.rawValue , count: card.num) ,attributes :card.fillness.returnValue(color: SelectedColor(card.color)) )
    button.setAttributedTitle(innerCardText, for: .normal)
}


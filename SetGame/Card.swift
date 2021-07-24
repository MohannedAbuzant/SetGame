//
//  Card.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 22/07/2021.
//

import Foundation
 struct Card:Equatable {
    let num:Int
    let shape:Shapes
    let color:Color
    let fillness:Fillness
    var isSelected:Bool
    var isMatched:Bool
    let id :Int
 
    
}

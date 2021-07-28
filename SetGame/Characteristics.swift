//
//  Characteristics.swift
//  SetGame
//
//  Created by Asal MacBook Pro on 27/07/2021.
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

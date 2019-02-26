//
//  Class.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 20/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    
    /// Присваивает уникальный идентификатор
    ///
    /// - Returns: идентификатиор
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return identifierFactory
    }
    
    
    init(identifier: Int) {
        self.identifier = Card.getUniqueIdentifier()
        
        
    }
    
}

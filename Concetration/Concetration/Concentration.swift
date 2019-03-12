//
//  Concentration.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 25/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in self.cards.indices {
                if self.cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else  {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in self.cards.indices {
                self.cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        
        assert(self.cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): выбранный индекс не совпадает с картами")
        
        //Если уже не совпавшие
        if !self.cards[index].isMatched {
            
            //Если есть предыдущи индекс и он не равен новому
            if let matchIndex = self.indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //Если индексы перевернутой и текущей совпадают, матчим их
                if self.cards[matchIndex].identifier == self.cards[index].identifier {
                    self.cards[matchIndex].isMatched = true
                    self.cards[index].isMatched = true
                    
                    //TODO: Score +2
                    self.score += 2
                } else {
                    if (self.cards[index].hasBeenFliped) {
                        //TODO: Score -1
                        self.score -= 1
                    }
                }
                //Текущую переварачиваем
                self.cards[index].isFaceUp = true
                
                if (!self.cards[index].hasBeenFliped) {
                    self.cards[index].hasBeenFliped = true
                }
                
            } else {
                self.indexOfOneAndOnlyFaceUpCard = index
            }
            
        }

    }
    
    init(numberOfPairsCard: Int) {
        
        assert(numberOfPairsCard > 0, "Количество пар карт, должно быть больше 0")
        
        for _ in 0..<numberOfPairsCard {
            let card = Card()
            self.cards += [card, card]
        }
        
        self.cards.shuffle()
    }
    
}

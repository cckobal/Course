//
//  ViewController.swift
//  Concetration
//
//  Created by Кирилл Смирнов on 12/02/2019.
//  Copyright © 2019 asu. All rights reserved.
//

import UIKit
/*
enum Emoji: String, CaseIterable {
    case smile = "😀"
    case cry = "😭"
    case scream = "😱"
    case angel = "😇"
    case tease = "😛"
    case love = "😍"
    case cool = "😎"
    case botan = "🤓"
}
*/
class ViewController: UIViewController {
    
    private let countLabelText = "Счет:"
    
    private let themes: [String: [String] ] = [
        "winter": [ "⛄️", "❄️", "🌬", "💨", "🌨", "🌩"],
        "halloween": [ "🌚", "🕷", "🧟‍♂️", "🧙‍♂️", "🧟‍♀️", "🧛‍♀️"],
        "homeAnimals": ["😺", "🐹", "🐶", "🦉", "🐴", "🐌"],
        "wildAnimals": ["🦊", "🐻", "🐼", "🦁", "🐯", "🐵"],
        "kindaFlying": ["🐥", "🦆", "🦅", "🦉", "🦇", "🕊"],
        "seaBoys": ["🦐", "🦀", "🐡", "🐠", "🦈", "🐬"],
        //"halloween": [ Emoji.smile, Emoji.cry ]
    ]
    
    private(set) var count = 0 {
        didSet {
            self.countLabel.text = "\(countLabelText) \(self.count)"
        }
    }
    
    private lazy var game = Concentration(numberOfPairsCard: self.numberOfPairsCard)
    
    var numberOfPairsCard: Int {
        return (self.cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    //private lazy var emojiArray: [Emoji] = themes["winter"]!
    private lazy var emojiArray: [String] = Array(themes.values).randomElement()!
    private var emoji: [Int: String] = [:]
    
    //private lazy var test: [Emoji] = themes["winter"]!
    
    @IBOutlet private weak var countLabel: UILabel!
    
    @IBAction private func emojiButtonAction(_ sender: UIButton) {
        
        if let index = self.cardButtons.firstIndex(of: sender) {
            self.game.chooseCard(at: index)
            self.updateViewModel()
        } else {
            print("Unhandled Error!!!")
        }
        
    }
    
    @IBAction func newGameButtonAction(_ sender: Any) {
        self.emojiArray = Array(themes.values).randomElement()!
        self.game = Concentration(numberOfPairsCard: self.numberOfPairsCard)
        self.updateViewModel()
    }
    
    
    private func updateViewModel() {
        for index in self.cardButtons.indices {
            let button = self.cardButtons[index]
            let card = self.game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(self.emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.6910475492, blue: 0, alpha: 1)
            }
        }
        
        self.count = self.game.score
    }
    
    private func emoji(for card: Card) -> String {
        if self.emoji[card.identifier] == nil, self.emojiArray.count > 0 {
            self.emoji[card.identifier] = self.emojiArray.remove(at: self.emojiArray.count.arc4random)
        }
        
        return self.emoji[card.identifier] ?? "?"
    }
    
}

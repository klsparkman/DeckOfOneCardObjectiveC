//
//  CardViewController.swift
//  DeckOfOneCardObjectiveC
//
//  Created by Kelsey Sparkman on 3/24/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var drawCardButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "felt")
         //Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "felt.5")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        drawCardButton.layer.cornerRadius = drawCardButton.frame.height/2
        self.fetchCards()
    }
    
    @IBAction func drawCardButtonTapped(_ sender: Any) {
        self.fetchCards()
    }
    
    func fetchCards() {
        CardModelController.drawNewCard(1) { (cards) in
            if let cards = cards {
                CardModelController.fetchCardImage(cards[0]) { (cardImage) in
                    DispatchQueue.main.async {
                        if let cardImage = cardImage {
                            self.updateViews(card: cards[0], image: cardImage)
                        }
                    }
                }
            }
        }
    }
    
    func updateViews(card: Card, image: UIImage) {
        self.cardImageView.image = image
        self.suitLabel.text = card.suit
//        switch card.suit {
//        case "DIAMONDS":
//            //self.drawCardButton.backgroundColor = .systemRed
//            self.suitLabel.textColor = .systemRed
//        case "HEARTS":
//           // self.drawCardButton.backgroundColor = .systemRed
//            self.suitLabel.textColor = .systemRed
//        case "SPADES":
//           // self.drawCardButton.backgroundColor = .black
//            self.suitLabel.textColor = .black
//        case "CLUBS":
//            //self.drawCardButton.backgroundColor = .black
//            self.suitLabel.textColor = .black
//        default:
//            break
//        }
  }
}//End of class


//
//  ViewController.swift
//  EsteeLauder
//
//  Created by Kang on 2022/06/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView0: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    @IBOutlet weak var imageView5: UIImageView!
    @IBOutlet weak var imageView6: UIImageView!
    @IBOutlet weak var imageView7: UIImageView!
    @IBOutlet weak var imageView8: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var proceedButton: UIButton!

    var allImageViews: [UIImageView] {
        return [imageView0, imageView1, imageView2,
                imageView3, imageView4, imageView5,
                imageView6, imageView7, imageView8
        ]
    }
    var matchedCardSet: Int = 0

    var cardIds: [Int] = Array(0..<9)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // TODO
        // put random images in image view
        // show the images for n seconds, then flip the images and change the text in the bottom label
        shuffleCardsAndShowImage()
        flipCardsAndStartGame()
    }

    private func shuffleCardsAndShowImage() {
        cardIds.shuffle()

        imageView0.image = UIImage(named: "Frame 17")

        for (idx, cardId) in cardIds.enumerated() {
            if cardId == 0 {
                allImageViews[idx].image = UIImage(named: "cards_solo")
            }
            else {
                allImageViews[idx].image = UIImage(named: "cards_\(cardId % 4)")
            }
        }
    }

    private func flipCardsAndStartGame() {
        // 암것도 안함
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for (idx, imageView) in self.allImageViews.enumerated() {
                if self.cardIds[idx] == 0 { // if its solo
                    imageView.isUserInteractionEnabled = false
                    continue
                }
                UIView.transition(with: imageView, duration: 1, options: .transitionFlipFromLeft) {
                    imageView.image = UIImage(named: "cards_back")
                } completion: { _ in
                    self.label.text = "TAP CARD PAIRS"
                }
            }

        }

    }

    var selectedCard: Int? =  nil

    @IBAction func imageVIewTap(_ sender: UITapGestureRecognizer) {
        print(sender.view?.tag)
        let chosenCard = sender.view?.tag
        // TODO
        // 3 possible cases
        // None of the cards are selected: CLick on a card
        // One of the cards are selected:
        // Click on the same card again: Return to state where none of the cards are selected
        // Click on a different card: Flip the two cards to check if they are a pair

        if selectedCard == nil {
            //Click on a card
            selectedCard = sender.view?.tag
            let imageView = sender.view as? UIImageView
            imageView?.layer.borderColor = UIColor(named: "HighlightColor")?.cgColor
            imageView?.layer.borderWidth = 4
        }
        else {
            // TODO
            if selectedCard == chosenCard {
                selectedCard = nil
                let imageView = sender.view as? UIImageView
                imageView?.layer.borderColor = UIColor.clear.cgColor
            }
            else {
                // flip selected card
                let selectedCardImageView = allImageViews[selectedCard!]
                print("cards_\(self.cardIds[self.selectedCard!] % 4)")
                UIView.transition(with: selectedCardImageView, duration: 1, options: .transitionFlipFromLeft) {
                    selectedCardImageView.image = UIImage(named: "cards_\(self.cardIds[self.selectedCard!] % 4)")
                }
                // flip chosen card
                let chosenCardImageView = allImageViews[chosenCard!]
                print("cards_\(self.cardIds[chosenCard!] % 4)")
                UIView.transition(with: chosenCardImageView, duration: 1, options: .transitionFlipFromLeft) {
                    chosenCardImageView.image = UIImage(named: "cards_\(self.cardIds[chosenCard!] % 4)")
                }

                //Check if the cards are a pair
                let isCorrect = self.cardIds[self.selectedCard!] % 4 == self.cardIds[chosenCard!] % 4
                //If they are a pair, show the pop-up
                if isCorrect {
                    self.matchedCardSet += 1

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Congrats") as! CongratsViewController
                        vc.viewController = self
                        vc.cardId = self.cardIds[chosenCard!] % 4
                        self.navigationController?.present(vc, animated: true)
                    }
                }
                else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        //If they are not a pair, flip over the cards again
                        UIView.transition(with: selectedCardImageView, duration: 1, options: .transitionFlipFromLeft) {
                            selectedCardImageView.image = UIImage(named: "cards_back")
                        }
                        UIView.transition(with: chosenCardImageView, duration: 1, options: .transitionFlipFromLeft) {
                            chosenCardImageView.image = UIImage(named: "cards_back")
                        }
                    }
                }
                self.selectedCard = nil
                selectedCardImageView.layer.borderColor = UIColor.clear.cgColor

            }
        }
    }

    func showProceedButton() {
        if self.matchedCardSet == 4 {
            self.proceedButton.isHidden = false
            self.label.isHidden = true
        }
    }
}


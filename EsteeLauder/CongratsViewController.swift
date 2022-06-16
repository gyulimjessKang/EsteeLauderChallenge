//
//  CongratsViewController.swift
//  EsteeLauder
//
//  Created by Kang on 2022/06/15.
//

import Foundation
import UIKit

class CongratsViewController: UIViewController {

    @IBAction func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            // 다 끝나고 하고 싶은 일
            self.viewController?.showProceedButton()
        })
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    var cardId: Int!
    var viewController: ViewController?

    let titles: [String] = [
        "FORMULA FACTS", //
        "BENEFITS",
        "IDEAL FOR",
        "SKIN TYPE",
    ]
    let descriptions: [String] = [
        """
• Oil-free
• Recyclable glass bottle
• Dermatologist-tested
• Ophthalmologist-tested
• Non-acnegenic; won't clog pores
• Free of synthetic fragrance
• Free of parabens, phthalates, sulfites, sulfates and mineral oil
• Face serum with Hyaluronic Acid and anti-oxidants
""",
        "The #1 serum in the U.S.\nFight the look of multiple signs of aging.",
        """
• Multiple signs of aging\n• Visible age prevention
• Loss of firmness, tone
• Lines and wrinkles
• Dryness, dehydration
• Dullness, loss of radiance
• Uneven skintone
• Anti-oxidants
""",
        "The perfect serum for all skin types.",
    ]
    let images: [UIImage?] = [
        UIImage(named: "cards_0_big"),
        UIImage(named: "cards_1_big"),
        UIImage(named: "cards_2_big"),
        UIImage(named: "cards_3_big"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.cardId)
        self.imageView.image = images[cardId]
        self.titleLabel.text = titles[cardId]
        self.descriptionLabel.text = descriptions[cardId]
    }
}

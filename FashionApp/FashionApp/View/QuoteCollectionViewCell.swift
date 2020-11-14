//
//  QuoteCollectionViewCell.swift
//  FashionApp
//
//  Created by Gleb on 14.11.2020.
//

import UIKit

class QuoteCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var detailLabel:UILabel!
    @IBOutlet weak var exploreButton:UIButton!

    //MARK: - Public var
    weak var delegate: QuoteCollectionViewCellDelegate?
    
    //MARK: - Public func
    func configurModel(with item:OnboardigItems) {
        titleLabel.text  = item.title
        detailLabel.text = item.details
    }
    
    func showExploreButton(shouldShow: Bool) {
        exploreButton.isHidden = !shouldShow
    }
    
    
    //MARK: - Actions
    @IBAction func exploreButtonActions(_ sender: Any) {
        delegate?.didTapExploreButton()
    }

}

//MARK: - Protocols
protocol QuoteCollectionViewCellDelegate: class  {
    func didTapExploreButton()
}

//
//  OnboardigViewController.swift
//  FashionApp
//
//  Created by Gleb on 14.11.2020.
//

import UIKit

class OnboardigViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var nextButton: UIStackView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var conteinerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Privet var
    private let idCell = "cellId"
    private var items: [OnboardigItems] = []
    private var imageViews = [UIImageView]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOnboardigItems()
        setupImageViews()
        setupCollectionView()
        setupPageControl()
        
    }

    //MARK: - Private func
    private func setupOnboardigItems() {
        items = OnboardigItems.items
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
    
   
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    private func getCurrentIndex() -> Int {
        return Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    private func showItem(at index: Int) {
        pageControl.currentPage = index
        
        let shouldHide = index == items.count - 1
        nextButton.isHidden = shouldHide
    }
    
    private func setupImageViews() {
        items.forEach { item in
            let imageView = UIImageView(image: item.image)
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            
            ///Add image view on conteiner view
            conteinerView.addSubview(imageView)
         
            ///Setup constraints for imageView
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: conteinerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor)
            ])
            imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        conteinerView.bringSubviewToFront(collectionView)
    }
    
    //MARK: - Actions
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let row = getCurrentIndex() + 1
        let nextIndexPath = IndexPath(row: row, section: 0)
        collectionView.scrollToItem(at: nextIndexPath, at: .left, animated: true)
        
        showItem(at: row)
    }
    
    //MARK: - Scroll view func
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = getCurrentIndex()
        showItem(at: index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let index = getCurrentIndex()
        let fadeInAlpha = (x - collectionView.frame.size.width * CGFloat(index)) / collectionView.frame.size.width
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
    
        ///hande error out of range
        let canShow = (index < items.count - 1)
        guard canShow else {
            return
        }
       
        imageViews[index].alpha = fadeOutAlpha
        imageViews[index + 1].alpha = fadeInAlpha
    }
}

//MARK: - Extension
extension OnboardigViewController: UICollectionViewDataSource, UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idCell , for: indexPath) as? QuoteCollectionViewCell

        let item = items[indexPath.item]
        cell?.configurModel(with: item)
        cell?.delegate = self
        
        ///should show explore button
        let shouldShow = indexPath.item == items.count - 1
        cell?.showExploreButton(shouldShow: shouldShow)

        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension OnboardigViewController: QuoteCollectionViewCellDelegate {
    func didTapExploreButton() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainAppViewController")
        
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = mainViewController
            
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}

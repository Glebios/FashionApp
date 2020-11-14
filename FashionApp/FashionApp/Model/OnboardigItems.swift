//
//  OnboardigItems.swift
//  FashionApp
//
//  Created by Gleb on 14.11.2020.
//

import Foundation
import UIKit


struct OnboardigItems {
    let title:String?
    let details:String?
    let image: UIImage?
    
    static let items: [OnboardigItems] = [
        .init(title: "Diana Vreeland", details: "Fashion is part of the daily air and it changes all the time, with all the events. You can even see the approaching of a revolution in clothes. You can see and feel everything in clothes.",image: #imageLiteral(resourceName: "imFashion2")),
        .init(title: "Gianni Versace", details: "Don't be into trends. Don't make fashion own you, but you decide what you are, what you want to express by the way you dress and the way to live.",image: #imageLiteral(resourceName: "imFashion3")),
        .init(title: "Karl Lagerfeld", details: "One is never over-dressed or under-dressed with a Little Black Dress.",image: #imageLiteral(resourceName: "imFashion5")),
        .init(title: "Miuccia Prada", details: "What you wear is how you present yourself to the world, especially today, when human contacts are so quick. Fashion is instant language.",image: #imageLiteral(resourceName: "imFashion1")),
        .init(title: "Bette Midler", details: "I firmly believe that with the right footwear one can rule the world.",image: #imageLiteral(resourceName: "imFashion4"))
    ]
    
    
}


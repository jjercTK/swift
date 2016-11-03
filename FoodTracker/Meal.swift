//
//  Meal.swift
//  FoodTracker
//
//  Created by Juanjo on 10/31/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import UIKit //this also includes Foundation

class Meal {
    
    // MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        self.name = name
        self.photo = photo
        self.rating = rating
        
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
}

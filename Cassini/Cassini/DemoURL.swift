//
//  DemoURL.swift
//  Cassini
//
//  Created by Juanjo on 10/21/16.
//  Copyright © 2016 Tektonlabs. All rights reserved.
//

import Foundation

struct DemoURL {
    
    static let Stanford = "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Stanford_plain_block_%22S%22_logo.svg/2000px-Stanford_plain_block_%22S%22_logo.svg.png"
    
    static let NASA = [
        "Cassini" : "https://upload.wikimedia.org/wikipedia/commons/b/b2/Cassini_Saturn_Orbit_Insertion.jpg",
        "Earth": "http://www.nasa.gov/centers/goddard/images/content/638831main_globe_east_2048.jpg",
        "Saturn": "http://dduningswikithing.pbworks.com/f/1255400802/Saturn_naturalcolor_opt600x406_NASA.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> URL? {
        if let urlstring = NASA[imageName ?? ""] {
            return URL(string: urlstring)
        } else {
            return nil
        }
    }
    
}

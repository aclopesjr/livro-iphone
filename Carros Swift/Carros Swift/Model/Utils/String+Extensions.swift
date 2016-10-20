//
//  String+Extensions.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 10/20/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import Foundation

extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func url() -> URL {
        return URL(string:self)!
    }
}

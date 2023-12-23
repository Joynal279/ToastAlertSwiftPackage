//
//  File.swift
//  
//
//  Created by Joynal Abedin on 23/12/23.
//

import SwiftUI

extension CGFloat{
    init(width: CGFloat, for height: CGFloat = 0){
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.init(width)
        }else{
            if height > 0{
                self.init(.init(height: height) * width / height)
            }else{
                self.init(width / 414 * UIScreen.main.bounds.size.width)
            }
        }
    }
    
    init(height: CGFloat, for width: CGFloat = 0){
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.init(height)
        }else{
            if width > 0{
                self.init(.init(width: width) * height / width)
            }else{
                self.init(height / 896 * UIScreen.main.bounds.size.height)
            }
        }
    }
}

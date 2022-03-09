//
//  SkinData.swift
//  the-seed-game
//
//  Created by Gustavo Kumasawa on 07/03/22.
//

import UIKit

class SkinData {
    let id: String
    let branchImage: UIImage
    let littleBranchImage: UIImage
    let introBranchImage: UIImage
    
    init(id: String, branchImage: UIImage, littleBranchImage: UIImage, introBranchImage: UIImage) {
        self.id = id
        self.branchImage = branchImage
        self.littleBranchImage = littleBranchImage
        self.introBranchImage = introBranchImage
        
    }
}

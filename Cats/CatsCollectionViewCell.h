//
//  CatsCollectionViewCell.h
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "NetworkManager.h"

@interface CatsCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *photoLabel;
@property (strong, nonatomic) IBOutlet UIImageView *catImageView;

@property (strong, nonatomic) Photo *photo;

@end

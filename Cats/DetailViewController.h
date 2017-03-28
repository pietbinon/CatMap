//
//  DetailViewController.h
//  Cats
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"
#import "NetworkManager.h"



@interface DetailViewController : UIViewController

@property (nonatomic, strong) Photo *photo;

@end

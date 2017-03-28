//
//  NetworkManager.h
//  Cats
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Photo.h"



@interface NetworkManager : NSObject

@property (nonatomic) NSURLSessionDataTask *dataTask;

- (void)getPicturesWithCompletion:(void (^)(NSMutableArray *))completion;
- (void)downloadImagesFromURL:(NSURL *)url completion:(void (^)(UIImage *))completion;
- (void)getGeoLocation:(Photo *)photo completion:(void (^)(CLLocationCoordinate2D))completion;

@end

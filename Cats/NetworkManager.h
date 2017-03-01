//
//  NetworkManager.h
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-28.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Photo.h"

@interface NetworkManager : NSObject

@property (nonatomic) NSURLSessionDataTask *dataTask;

- (void)getPicturesWithCompletion:(void (^)(NSMutableArray *))completion;
- (void)downloadImagesFromURL:(NSURL *)url completion:(void (^)(UIImage *))completion;

@end

//
//  Photo.h
//  Cats
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>



@interface Photo : NSObject <MKAnnotation>

@property (nonatomic) NSString *photoServer;
@property (nonatomic) NSString *photoFarm;
@property (nonatomic) NSString *photoID;
@property (nonatomic) NSString *photoSecret;
@property (nonatomic) NSString *photoTitle;
@property (nonatomic) NSURL *photoURL;
@property(nonatomic) CLLocationCoordinate2D coordinate;

- (instancetype)initWithServer :(NSString *)server initWithFarm:(NSString *)farm initWithID:(NSString *)pID initWithSecret:(NSString *)secret initWithTitle:(NSString *)title initWithURL:(NSURL *)pURL;

@end



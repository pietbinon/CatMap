//
//  NetworkManager.m
//  Cats
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import "NetworkManager.h"



@interface NetworkManager () {
    
}

@end




@implementation NetworkManager

// Completion Handler
//-------------------
- (void) getPicturesWithCompletion: (void (^)(NSMutableArray *)) completion {
    
    //Go fetch the data
    NSURL * url = [self provideNSURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL: url];
    NSURLSessionConfiguration *configure = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *configureSession = [NSURLSession sessionWithConfiguration: configure];
    
    self.dataTask = [configureSession dataTaskWithRequest: urlRequest completionHandler:^
                                      (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
                                        
        if (error) {
                                              
            NSLog(@"error: %@", error.localizedDescription);
            return;
        }
                
        NSError *jsonError = nil;
        NSDictionary *tempDictionary = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &jsonError];
                                          
        if(jsonError) {
            
            //Handle the error
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return ;
        }
                                          
        NSDictionary *photos = [[tempDictionary objectForKey: @"photos"] objectForKey: @"photo"];
        NSMutableArray *storeAllImages = [NSMutableArray array];

        for(NSDictionary *tempPhotoDictionary in photos) {
            
            Photo *newPhoto = [[Photo alloc] initWithServer: [tempPhotoDictionary objectForKey: @"server"] initWithFarm: [tempPhotoDictionary objectForKey: @"farm"] initWithID: [tempPhotoDictionary objectForKey: @"id"] initWithSecret: [tempPhotoDictionary objectForKey: @"secret"] initWithTitle: [tempPhotoDictionary objectForKey: @"title"] initWithURL: url];
            
            [storeAllImages addObject:newPhoto];
            
            NSLog(@"%@",storeAllImages);
        }
                                          
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //This will run on the main queue
            completion(storeAllImages);
            }];
        }];
    
    [self.dataTask resume];
}


//Download the images from URL
//----------------------------
- (void) downloadImagesFromURL:(NSURL *) url completion: (void (^)(UIImage *))completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL: url completionHandler: ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog (@"error: %@", error.localizedDescription);
            return;
        }
        
        NSData *data = [NSData dataWithContentsOfURL: location];
        
        UIImage *imageToBeDisplayed = [UIImage imageWithData: data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(imageToBeDisplayed);
        }];
        
    }];
    
    [downloadTask resume];
}


- (NSURL *)provideNSURL {
    
    NSDictionary *appendURLComponents = @{@"method" : @"flickr.photos.search",
                                          @"api_key" : @"d2cd499934f147a27c8f3bfa94b2d999",
                                          @"tags" : @"cat",
                                          @"has_geo" : @"1",
                                          @"extras" : @"url_m",
                                          @"format" : @"json",
                                          @"nojsoncallback" : @"1"};
    
    NSMutableArray *queries = [NSMutableArray new];
    
    for (NSString *key in appendURLComponents) {
        
        [queries addObject:[NSURLQueryItem queryItemWithName: key value:appendURLComponents[key]]];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc] init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    components.queryItems = queries;
    
    NSLog(@"Print URL: %@", components.URL);
    return components.URL;
}


- (void) getGeoLocation: (Photo *)photo completion: (void (^)(CLLocationCoordinate2D))completion {
    
    NSString *urlString = [NSString stringWithFormat: @"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=d2cd499934f147a27c8f3bfa94b2d999&photo_id=%@&format=json&nojsoncallback=1", photo.photoID];
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL: url];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration: configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest: urlRequest completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog (@"%@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *tempDictionary = [NSJSONSerialization JSONObjectWithData: data options: 0 error: &jsonError];
        NSDictionary *photoDictionary = tempDictionary[@"photo"];
        NSDictionary *locationDictionary = photoDictionary[@"location"];
        
        CLLocationCoordinate2D coordinates = CLLocationCoordinate2DMake([locationDictionary[@"latitude"] doubleValue], [locationDictionary[@"longitude"] doubleValue]);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            completion(coordinates);
        }];
    }];
    
    [dataTask resume];
}

@end

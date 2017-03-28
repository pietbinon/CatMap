//
//  DetailViewController.m
//  Cats
//
//  Created by Pierre Binon on 2017-03-27.
//  Copyright © 2017 Pierre Binon. All rights reserved.
//

#import "DetailViewController.h"



@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NetworkManager *networkManager;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longtitudeLabel;

@end




@implementation DetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self getCoordinates];
    self.navigationItem.title = self.photo.photoTitle;
}


- (void) getCoordinates {
    
    self.networkManager = [[NetworkManager alloc] init];
    [self.networkManager getGeoLocation:self.photo completion:^(CLLocationCoordinate2D coordinates){
        self.photo.coordinate = coordinates;
        [self setUpMapView];
        [self setUpImageView];
    }];
}


- (void) setUpMapView {
    
    MKCoordinateSpan span = MKCoordinateSpanMake (0.5f, 0.5f);
    self.mapView.region = MKCoordinateRegionMake (self.photo.coordinate, span);
    self.latitudeLabel.text = [NSString stringWithFormat: @"%f", self.photo.coordinate.latitude];
    self.longtitudeLabel.text = [NSString stringWithFormat: @"%f", self.photo.coordinate.longitude];
    
    //Use the Photo object to set the mapView's annotation property.
    //Because the Photo object conforms to MKAnnotation its coordinate property and title will be used by the annotation.
    //Call addAnnotation: on the mapView and pass it the photo object passed to the
    //DetailViewController instance
    [self.mapView addAnnotation: self.photo];
}


- (void) setUpImageView {
    
    [self.networkManager downloadImagesFromURL:self.photo.photoURL completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    
}

@end

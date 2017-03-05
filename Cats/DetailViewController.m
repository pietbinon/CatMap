//
//  DetailViewController.m
//  Cats
//
//  Created by Hyung Jip Moon on 2017-03-05.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NetworkManager *networkManager;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.photo.photoTitle;
    [self getCoordinates];
}

- (void)getCoordinates {
    self.networkManager = [[NetworkManager alloc] init];
    [self.networkManager getGeoLocation:self.photo completion:^(CLLocationCoordinate2D coordinates){
        self.photo.coordinate = coordinates;
        [self setUpMapView];
    }];
}

- (void)setUpMapView {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.5f, 0.5f);
    self.mapView.region = MKCoordinateRegionMake(self.photo.coordinate, span);
    [self.mapView addAnnotation:self.photo];
}


@end

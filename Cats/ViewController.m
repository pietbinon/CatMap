//
//  ViewController.m
//  Cats
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate> {
    
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property NSMutableArray  *storeAllPhotos;
@property (nonatomic, strong) NetworkManager *networkManager;
@property (nonatomic, strong) CatsCollectionViewCell *catsCollectionViewCell;
@property (nonatomic, strong) Photo *testPhoto;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.storeAllPhotos = [NSMutableArray array];
    self.networkManager = [[NetworkManager alloc]init];
    
    self.testPhoto = [[Photo alloc] init];
    
    [self.networkManager getPicturesWithCompletion:^(NSMutableArray *photos) {
        self.storeAllPhotos = photos;
        
        [self.collectionView reloadData];
    }];
        

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.storeAllPhotos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CatsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.photo = self.storeAllPhotos[indexPath.item];
    return cell;
    
}



@end

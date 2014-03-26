//
//  ADTViewController.m
//  Screenshots
//
//  Created by AndrewTremblay on 3/25/14.
//  Copyright (c) 2014 Andrew David Tremblay. All rights reserved.
//

#import "ADTViewController.h"

@interface ADTViewController ()
@end

@implementation ADTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.screenshotPhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *screenshotImageView = (UIImageView *)[cell viewWithTag:100];
    screenshotImageView.image = [UIImage imageNamed:[self.screenshotPhotos objectAtIndex:indexPath.row]];
    
    return cell;
}


@end

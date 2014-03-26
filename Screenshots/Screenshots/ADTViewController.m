//
//  ADTViewController.m
//  Screenshots
//
//  Created by AndrewTremblay on 3/25/14.
//  Copyright (c) 2014 Andrew David Tremblay. All rights reserved.
//

#import "ADTViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface ADTViewController ()
@end

@implementation ADTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Get the assets library
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                           usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         
         // Within the group enumeration block, filter to enumerate just photos.
         [group setAssetsFilter:[ALAssetsFilter allPhotos]];
         
         // For this example, we're only interested in the first item.
         [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0]
                                 options:0
                              usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop)
          {
              
              // The end of the enumeration is signaled by asset == nil.
              if (alAsset) {
                  ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                  NSDictionary *imageMetadata = [representation metadata];
                  // Do something interesting with the metadata.
                  NSLog(@"Image Metadata! %@", imageMetadata);
              }
          }];
     }
                         failureBlock: ^(NSError *error)
     {
         // Typically you should handle an error more gracefully than this.
         NSLog(@"No groups");
     }];

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

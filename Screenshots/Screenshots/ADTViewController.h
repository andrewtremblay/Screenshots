//
//  ADTViewController.h
//  Screenshots
//
//  Created by AndrewTremblay on 3/25/14.
//  Copyright (c) 2014 Andrew David Tremblay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ADTViewController : UICollectionViewController
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *screenshotPhotoAssets;

@end

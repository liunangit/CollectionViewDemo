//
//  StackLayoutViewController.h
//  CollectionViewDemo
//
//  Created by liunan on 13-7-14.
//
//

#import <UIKit/UIKit.h>
#import "APLCollectionViewController.h"

@interface StackLayoutViewController : APLCollectionViewController

@end

@interface APLStackLayout : UICollectionViewLayout { 
    NSMutableArray *_angles;
    NSMutableArray *_attributesArray;
}

@property (nonatomic, readwrite) NSInteger stackCount;
@property (nonatomic, readwrite) CGSize itemSize;

@end
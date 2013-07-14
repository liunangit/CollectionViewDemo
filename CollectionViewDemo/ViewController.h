//
//  ViewController.h
//  CollectionViewDemo
//
//  Created by liunan on 12-10-28.
//
//

#import <UIKit/UIKit.h>
#import "APLTransitionController.h"

@interface ViewController : UITableViewController <UINavigationControllerDelegate,APLTransitionControllerDelegate>

@property (nonatomic, strong) APLTransitionController *transitionController;
@end

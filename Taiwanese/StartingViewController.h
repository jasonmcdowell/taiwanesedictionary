//
//  StartingViewController.h
//  Taiwanese
//
//  Created by Jason McDowell on 3/17/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMEIdeasPullDownControl.h"

@interface StartingViewController : UIViewController <UISearchBarDelegate, UISearchDisplayDelegate, RMEIdeasPullDownControlProtocol, RMEIdeasPullDownControlDataSource>
@property (strong, nonatomic) NSArray *dictionaryArray;
@property (strong, nonatomic) NSMutableArray *history;
@property (strong, nonatomic) NSMutableArray *favorites;
@end

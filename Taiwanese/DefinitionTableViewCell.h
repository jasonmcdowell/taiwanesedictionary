//
//  DefinitionTableViewCell.h
//  Table View Practice
//
//  Created by Jason McDowell on 3/10/14.
//  Copyright (c) 2014 Jason McDowell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefinitionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *taiwaneseLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UILabel *examplesLabel;
@end

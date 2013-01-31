//
//  PlayingCard.h
//  Matchismo
//
//  Created by Joey Smith on 1/29/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *rankString;

/// Public methods.
+ (NSArray*) validSuits;
+ (NSUInteger) maxRank;

@end

//
//  Card.m
//  Matchismo
//
//  Created by Joey Smith on 1/28/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "Card.h"

@implementation Card
- (NSString *) contents {
    return @"MT";
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents])
            score = 1;
    }
    
    return score;
}
@end

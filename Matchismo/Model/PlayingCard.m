//
//  PlayingCard.m
//  Matchismo
//
//  Created by Joey Smith on 1/29/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *) contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings [self.rank] stringByAppendingString:self.suit];
}

/// We have defined the setter and getter ourselves so we have to synthesis
/// as we did in iOS 5.
@synthesize suit = _suit;

/// Define a class method using the + token instead of instance method defined by -
/// Used as a utility method of the class rto return the array of valid suit strings.
+ (NSArray *) validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

/// Provide setter for suit
- (void)setSuit:(NSString *)suit {
    /// Call the class method instead of an instance using PlayingCard
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
        
}

/// Provide getter for suit
- (NSString *) suit {
    return _suit ? _suit : @"?";
}

/// Provide getter for rankString
- (NSString *) rankString {
    _rankString = [PlayingCard rankStrings][self.rank];
    return _rankString;
}


+ (NSArray *) rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger) maxRank { return [self rankStrings].count-1; }

/// Use setter to ensure a valid rank 
- (void) setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

/// Override the description method.
-(NSString *) description {
    return [NSString stringWithFormat:@"%@%@",  self.rankString, self.suit];
}
@end

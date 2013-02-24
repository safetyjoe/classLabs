//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Joey Smith on 2/1/13.
//  Copyright (c) 2013 Joey Smith. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame ()

// Private API has ability to set and get. (readwrite)
@property (readwrite,nonatomic) int score;
@property (readwrite,nonatomic) NSString *resultString;
@property (strong, nonatomic) NSMutableArray *cards;

@end


@implementation CardMatchingGame

- (NSUInteger) matchLevel {
    _matchLevel = (_matchLevel <= 1) ? 1 : 2;
    return _matchLevel;
}

- (NSString *) resultString {
    if(!_resultString) _resultString = @"Result: New Game";
    return _resultString;
}

- (NSMutableArray *) cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (Card *)cardatIndex:(NSUInteger)index {
    return(index < [self.cards count]) ? self.cards[index] : nil;
}

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MATCH_PENALTY 2

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardatIndex:index];

    // If the card just selected is playable.
    if(!card.isUnplayable) {
        self.resultString = [NSString stringWithFormat:@"Result: Flipped %@", card.contents];

        // If the card selected is not face up
        if(!card.isFaceUp) {
            // Make local storage for our other cards. Gets celaned up automatically.
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            // Loop thru the other cards finding a faceup playable one.
            for( Card *otherCard in self.cards ) {
                if(otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    NSLog(@"otherCards: %@  MatchLevel is %d", otherCards, self.matchLevel);
                    // We now have enough cards to test for a match.
                    if(otherCards.count == self.matchLevel) {
                        // Create a local string to hold all the card contents for display.
                        NSMutableArray *cardList = [[NSMutableArray alloc] init];
                        [cardList addObject:card];
                        int matchScore = [card match:otherCards matchLevel:self.matchLevel];

                        // If it is a match, all cards become unplayable.
                        if(matchScore) {
                            for( Card *otherCard in otherCards ) {
                                [cardList addObject:otherCard];
                                otherCard.unPlayable = YES;
                            }
                            card.unPlayable = YES;
                            // scale the successful match.
                            self.score += matchScore * MATCH_BONUS;
                            self.resultString = [NSString stringWithFormat:@"Result: Matched %@ for %d points",
                                                [cardList componentsJoinedByString:@"&"], (matchScore * MATCH_BONUS)];
                        } else {
                            for( Card *otherCard in otherCards ) {
                                [cardList addObject:otherCard];
                                otherCard.faceUp = NO;
                            }
                            // if we select 2 and fail, charge a penalty
                            self.score -= MATCH_PENALTY;
                            self.resultString = [NSString stringWithFormat:@"Result: %@ don't match, %d point penalty",
                                                 [cardList componentsJoinedByString:@"&"], MATCH_PENALTY];
                        }
                    }
                    NSLog(@"Test for components %@", [otherCards componentsJoinedByString:@"&"]);
                }
            } // for loop
            // charge a penalty to turn the card over.
            self.score -= FLIP_COST;
        } // not face up.
        card.faceUp = !card.isFaceUp;
    }
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *) deck{
    self = [super init];
    if (self) {
        for( int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if( card )
                self.cards[i] = card;
            else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

@end

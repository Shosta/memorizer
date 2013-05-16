//
//  Card.m
//  Memorizer
//
//  Created by Rémi LAVEDRINE on 14/05/13.
//  Copyright (c) 2013 Rémi Lavedrine. All rights reserved.
//

#import "Card.h"
#import "NSDate+Comparisons.h"

@implementation Card


#pragma mark - Helper

- (id)randomElementFromArray:(NSArray *)anArray
{
    id obj;
    @try {
        // http://stackoverflow.com/questions/3318902/picking-a-random-object-in-an-nsarray
        obj = [anArray objectAtIndex:(arc4random() % [anArray count])];
    }
    @catch (NSException *e) {
        obj = nil;
    }
    
    return obj;
}


#pragma mark - Birth

- (id)init{
    self = [super init];
    if (self) {
        self.userLastMemorizationLevel = NoMemorizationLevel; // Dernière note attribué a la carte.
        self.easiness = 2.5;
        self.lastNumberOfDaysAdded = 0;
        /*self.acq_reps = 0; // Le nombre de répétition dans la phase "Apprentissage"
        self.acq_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Apprentissage" depuis un échec.
        self.ret_reps = 0; // Le nombre de répétition dans la phase "Révision"
        self.ret_reps_since_lapse = 0; // Le nombre de répétition dans la phase "Révision" depuis un échec.
        self.lapses = 0; // Le nombre d'échecs alors que l'on connaissait auparavant la réponse de la carte.*/
        self.scheduled_interval = 0; // C'est l'intervalle qui prend en compte l'heure à laquelle tu as fait la carte, par exemple si tu as fait la carte après 18h ça te rajoute un jour car si tu lance l'application à 8h tu n'auras pas eu l'intervalle réel à avoir.
      self.timing = [self presentationTiming];
      self.numberOfRepetition = 0;
    }
    
    return self;
}


#pragma mark - Algo

/**
 @brief Méthode qui va calculer l'intervalle en fonction de la note
 @author : Rémi Lavedrine
 @date : 16/05/2013
 @remarks : 
 Pour note de 0 ou 1 en fond de paquet.
 Pour un 2 dans 1 jour.
 Pour un 3 dans 3 jours.
 Pour un 4 dans 4 jours.
 Pour un 5 dans 7 jours.
 */
- (int)initialDaysToAdd:(MemorizationLevel)newMemorizationLevel{
  int initialDaysToAdd = 0;
  switch (newMemorizationLevel) {
    case NoMemorizationLevel:
      initialDaysToAdd = 0;
      break;
      
    case MemorizationLevel1:
      initialDaysToAdd = 0;
      break;
      
    case MemorizationLevel2:
      initialDaysToAdd = 1;
      break;
      
    case MemorizationLevel3:
      initialDaysToAdd = 3;
      break;
      
    case MemorizationLevel4:
      initialDaysToAdd = 4;
      break;
      
    case MemorizationLevel5:
      initialDaysToAdd = 7;
      break;
      
    default:
      initialDaysToAdd = 0;
      break;
  }
  
    return initialDaysToAdd;
}

/**
 @brief Ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
 @author : Rémi Lavedrine
 @date : 16/05/2013
 @remarks : <#(optional)#>
 */
- (int)noiseToAddToDaysToAdd:(int)daysToAdd{
  int noise = 0;
  
  if (daysToAdd == 0) {
    noise = 0;
  }
  else {
    daysToAdd = [[self randomElementFromArray:@[[NSNumber numberWithInt:0], [NSNumber numberWithInt:1]]] intValue] * DAY;
  }
  
  return noise;
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (int)addDaysToNewCard:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    self.easiness = 2.5; // On place la "facilité" de la carte à la moitié (2.5 sur 5, la meilleure note).
    self.acq_reps = 1; // Le nombre de répétitions de la carte est à 1 vu que c'est une nouvelle carte.
    self.acq_reps_since_lapse = 1; // Le nombre de répétitions de la carte depuis le dernier echec est à 1 vu que c'est une nouvelle carte.
  
    daysToAdd = [self initialDaysToAdd:newMemorizationLevel];
    
    return daysToAdd;
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (int)addDaysToFailedCard{
    int daysToAdd = 0;
    
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    daysToAdd = 0; // On met la carte en fond de paquet. Elle doit être revu dans cette session.
    
    return daysToAdd;
}

/**
 @brief c
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
int DAY = 1;
- (int)addDaysToCardFromAquisitionToRetention:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    self.acq_reps += 1;
    self.acq_reps_since_lapse += 1;
    
    switch (newMemorizationLevel) {
        case MemorizationLevel2:
            daysToAdd = DAY;
            break;
            
        case MemorizationLevel3:
            // L'intervalle est donnée aléatoirement entre 1 et 2 jours (le 1 a un poids plus important que le 2)
            daysToAdd = [(NSNumber *)[self randomElementFromArray:@[[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:2]]] intValue] * DAY;
            break;
            
        case MemorizationLevel4:
            // L'intervalle est donnée aléatoirement entre 1 et 2 jours (le 2 a un poids plus important que le 1)
            daysToAdd = [[self randomElementFromArray:@[[NSNumber numberWithInt:1], [NSNumber numberWithInt:2], [NSNumber numberWithInt:2]]] intValue] * DAY;
            break;
            
        case MemorizationLevel5:
            daysToAdd = 2 * DAY;
            break;
            
        default:
            break;
    }

    return daysToAdd;
}

/**
 @brief <#Describe the function purpose#>
 @author : Rémi Lavedrine
 @date : <#current date#>
 @remarks : <#(optional)#>
 */
- (int)addDaysToCardFromRetentionToRetention:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    int actual_interval = self.new_interval;
    
    self.ret_reps += 1;
    self.ret_reps_since_lapse += 1;

    if (self.timing == Later || self.timing == OnTime){
        switch (newMemorizationLevel) {
            case MemorizationLevel2:
                self.easiness -= 0.16;
                break;
                
            case MemorizationLevel3:
                self.easiness -= 0.14;
                break;
                
            case MemorizationLevel5:
                self.easiness += 0.10;
                break;
                
            default:
                break;
    }
        // Easiness can't be less than 1.3.
        if (self.easiness < 1.3){
            self.easiness = 1.3;
        }
        
        if (self.ret_reps_since_lapse == 1){ // Si on a eu un echec dans la phase "Révision", on ajoute 6 jours.
            daysToAdd = 6 * DAY;
        }else{
            switch (self.userLastMemorizationLevel) {
                case MemorizationLevel2:
                    if (self.timing == OnTime || self.timing == Earlier){
                        daysToAdd = actual_interval * self.easiness;
                    }else{
                        // Learning late and interval was too long, so don't increase the interval and use scheduled_interval again as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.lastNumberOfDaysAdded;
                    }
                    break;
                    
                case MemorizationLevel3:
                    if (self.timing == OnTime || self.timing == Earlier){
                        daysToAdd = actual_interval * self.easiness;
                    }else{
                        // Learning late and interval was too long, so don't increase the interval and use scheduled_interval again as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.lastNumberOfDaysAdded;
                    }
                    break;
                    
                case MemorizationLevel4:
                    daysToAdd = actual_interval * self.easiness;
                    break;
                    
                case MemorizationLevel5:
                    if (self.timing == Earlier){
                        // Learning ahead and interval was too short. To avoid that the intervals increase explosively when learning ahead, take scheduled_interval as opposed to the much larger actual_interval * card.easiness.
                        daysToAdd = self.lastNumberOfDaysAdded;
                    }
                    else{
                        daysToAdd = actual_interval * self.easiness;
                    }
                    break;
                    
                default:
                    // Une nouvelle intervalle ne peut pas être en dessous de 1
                    daysToAdd = DAY;
                    break;
            }
        }
    }
    
  // On ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
  daysToAdd += [self noiseToAddToDaysToAdd:newMemorizationLevel];
    
    return daysToAdd;
}

- (int)daysToAddAccordingTo:(MemorizationLevel)newMemorizationLevel{
    int daysToAdd = 0;
    
    //  Si c'est une nouvelle carte
    if (self.userLastMemorizationLevel == -1){
        daysToAdd = [self addDaysToNewCard:newMemorizationLevel];
        
    }else if ([self isMemorizationLevelInAcquisitionPhase:self.userLastMemorizationLevel] &&
              [self isMemorizationLevelInAcquisitionPhase:newMemorizationLevel]){ // Si l'ancienne note était de 0 ou 1 et la nouvelle de 0 ou 1 on met la carte en fond de paquet (new_interval = 0)
      // In the acquisition phase and staying there.
        daysToAdd = [self addDaysToFailedCard];
      
    }else if ([self isMemorizationLevelInRetentionPhase:self.userLastMemorizationLevel] &&
               [self isMemorizationLevelInAcquisitionPhase:newMemorizationLevel]){ // Si l'ancienne note était entre 2 et 5 et la nouvelle de 0 ou 1 on met la carte en fond de paquet (new_interval = 0)
        // In the retention phase and moving to the acquisition one.
        daysToAdd = [self addDaysToFailedCard];
      
    }else if ([self isMemorizationLevelInAcquisitionPhase:self.userLastMemorizationLevel] &&
              [self isMemorizationLevelInRetentionPhase:newMemorizationLevel]){
        // In the acquisition phase and moving to the retention phase.
        daysToAdd = [self addDaysToCardFromAquisitionToRetention:newMemorizationLevel];
        
    }else if ([self isMemorizationLevelInRetentionPhase:self.userLastMemorizationLevel] &&
              [self isMemorizationLevelInRetentionPhase:newMemorizationLevel]){
        // In the retention phase and staying there.
        daysToAdd = [self addDaysToCardFromRetentionToRetention:newMemorizationLevel];
        
    }
    
  // On ajoute ou retire des jours aléatoirement en fonction quand même de l'intervalle calculé pour je pense ne pas toujours avoir la même série
  daysToAdd += [self noiseToAddToDaysToAdd:daysToAdd];
    
    return daysToAdd;
}


#pragma mark - Algo Helper

- (BOOL)isMemorizationLevelInAcquisitionPhase:(MemorizationLevel)memorizationLevel{
  BOOL result = (memorizationLevel == NoMemorizationLevel || memorizationLevel == MemorizationLevel1);
  
  return result;
}

- (BOOL)isMemorizationLevelInRetentionPhase:(MemorizationLevel)memorizationLevel{
  BOOL result = (memorizationLevel == MemorizationLevel2 || memorizationLevel == MemorizationLevel3 || memorizationLevel == MemorizationLevel4 || memorizationLevel == MemorizationLevel5);
  
  return result;
}

- (PresentationTime)presentationTiming{
  PresentationTime datePresented = OnTime;
  
  BOOL nextPresentationDateEarlierThanCurrentDate = [[NSDate date] isEarlierThan:self.nextPresentationDate];
  if (nextPresentationDateEarlierThanCurrentDate) {
    datePresented = Earlier;
  }
  
  BOOL nextPresentationDateEqualThanCurrentDate = [[NSDate date] isSameDayAs:self.nextPresentationDate];
  if (nextPresentationDateEqualThanCurrentDate) {
    datePresented = OnTime;
  }
  
  BOOL nextPresentationDateLaterThanCurrentDate = [[NSDate date] isLaterThan:self.nextPresentationDate];
  if (nextPresentationDateLaterThanCurrentDate) {
    datePresented = Later;
  }
  
  return datePresented;
}


/*
- (float)easinessFromResponseQuality:(MemorizationLevel)newMemorizationLevel{
  float currentEasiness = self.easiness;
  float newEasiness = currentEasiness - 0.8 + 0.28 * newMemorizationLevel - 0.02 * newMemorizationLevel * newMemorizationLevel;
  
  if (newEasiness < 1.3){
    newEasiness = 1.3;
  }
  
  return newEasiness;
}

- (int)daysToAddForRepetition:(int)numberOfRepetition{
  int daysToAdd = 1;
  
  if (numberOfRepetition == 1) {
    daysToAdd = 1;
  }
  else if (numberOfRepetition == 2) {
    daysToAdd = 6;
  }
  else{
    daysToAdd = [self daysToAddForRepetition:numberOfRepetition - 1] * self.easiness;
  }
  
  return round(daysToAdd);
}

- (int)daysToAddAccordingToSM2:(MemorizationLevel)newMemorizationLevel{
  self.easiness = [self easinessFromResponseQuality:newMemorizationLevel];
  
  int daysToAdd = [self daysToAddForRepetition:self.numberOfRepetition];
  
  return round(daysToAdd);
}*/



@end

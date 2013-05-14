//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : Memorizer
// File        : Card.h
// Created     : $ 14/05/13 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright Rémi Lavedrine 2004-2013, All Rights Reserved
//
// This software is the confidential and proprietary
// information of France Telecom.
// You shall not disclose such Confidential Information
// and shall use it only in accordance with the terms
// of the license agreement you entered into with
// France Telecom.
//--------------------------------------------------------
// 
// @brief
// 

#import <Foundation/Foundation.h>

//! @brief Describes a Card object.
//! @class Card
//! @ingroup CustomObjects
//! @author Rémi Lavedrine
@interface Card : NSObject
@property (nonatomic) float easiness; // Facteur EF comme l'algo SM-2
@property (nonatomic) int acq_reps; // Le nombre de répétition dans la phase "Apprentissage"
@property (nonatomic) int acq_reps_since_lapse; // Le nombre de répétition dans la phase "Apprentissage" depuis un échec.
@property (nonatomic) int ret_reps; // Le nombre de répétition dans la phase "Révision"
@property (nonatomic) int ret_reps_since_lapse; // Le nombre de répétition dans la phase "Révision" depuis un échec.
@property (nonatomic) int new_interval; // L'intervalle de jours ou la carte doit apparaître (en jours)
@property (nonatomic) int lapses; // Le nombre d'échecs alors que l'on connaissait auparavant la réponse de la carte.
// @property (nonatomic) int grade; // Dernière note attribué a la carte.
@property (nonatomic) MemorizationLevel userLastMemorizationLevel;
@property (nonatomic) int scheduled_interval; // C'est l'intervalle qui prend en compte l'heure à laquelle tu as fait la carte, par exemple si tu as fait la carte après 18h ça te rajoute un jour car si tu lance l'application à 8h tu n'auras pas eu l'intervalle réel à avoir.
@property (nonatomic, retain) NSString *timing;
@end

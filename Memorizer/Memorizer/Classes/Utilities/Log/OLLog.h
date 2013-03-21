//--------------------------------------------------------
// FT/IMG/RD/MAPS/DVC/HOD
//--------------------------------------------------------
// Project     : MobinilAndMe
// File        : OLLog.h
// Created     : $ 20/04/2012 $
// Maintainer  : $ Rémi LAVEDRINE $
//
// Copyright France Telecom 2004-2012, All Rights Reserved
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
// This class defines several level of logs that can be used in the app.
// . Generic level
// . Error level
// . Warning level
// . Info level
// . Debug level
// This class is imported in all project's classes through the "MobinilAndMe-Prefix.pch" file.
// 


// LIST OF LOG LEVELS
#define LOG_LVL_ERR 4
#define LOG_LVL_WRN 3
#define LOG_LVL_INF 2
#define LOG_LVL_DBG	1

#import "OLLogSetter.h"

// GENERIC
#if (defined(LOGGING_ENABLED) && LOGGING_ENABLED)
#define __OL_LOG_FORMAT(value, ...) NSLog(@"%s %@ - %@", __PRETTY_FUNCTION__, value, [NSString stringWithFormat:__VA_ARGS__])
#else
#define __OL_LOG_FORMAT(...)
#endif

// ERROR
#if (defined(LOGGING_LEVEL) && (LOGGING_LEVEL <= LOG_LVL_ERR))
#define OLLogError(...) __OL_LOG_FORMAT(@"ERR", __VA_ARGS__)
#else
#define OLLogError(...)
#endif

// WARNING
#if (defined(LOGGING_LEVEL) && (LOGGING_LEVEL <= LOG_LVL_WRN))
#define OLLogWarning(...) __OL_LOG_FORMAT(@"WRN",__VA_ARGS__)
#else
#define OLLogWarning(...)
#endif

// INFO
#if (defined(LOGGING_LEVEL) && (LOGGING_LEVEL <= LOG_LVL_INF))
#define OLLogInfo(...) __OL_LOG_FORMAT(@"INF",__VA_ARGS__)
#else
#define OLLogInfo(...)
#endif

// DEBUG
#if (defined(LOGGING_LEVEL) && (LOGGING_LEVEL <= LOG_LVL_DBG))
#define OLLogDebug(...) __OL_LOG_FORMAT(@"DBG", __VA_ARGS__)
#else
#define OLLogDebug(...)
#endif


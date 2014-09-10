
// BBFormValidator is heavily based on BBFormValidator but integrated into BBForm rather than
// using the original method of subclassing UITextFIeld
// so most of the basic conditions and validators are lifted straight out of US2FormValidator

// copywrite from original US2 form validator

//  Copyright (C) 2012 ustwo™
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


// Conditions
#import "BBCondition.h"
#import "BBConditionAlphabetic.h"
#import "BBConditionAlphanumeric.h"
#import "BBConditionCollection.h"
#import "BBConditionEmail.h"
#import "BBConditionNumeric.h"
#import "BBConditionRange.h"
#import "BBConditionPresent.h"
#import "BBConditionOr.h"
#import "BBConditionAnd.h"
#import "BBConditionNot.h"
#import "BBConditionMatchElement.h"
#import "BBConditionAccept.h"

// Validators
#import "BBValidator.h"
#import "BBValidatorAlphabetic.h"
#import "BBValidatorAlphanumeric.h"
#import "BBValidatorEmail.h"
#import "BBValidatorNumeric.h"
#import "BBValidatorRange.h"
#import "BBValidatorComposite.h"
#import "BBValidatorPresent.h"
#import "BBValidatorMatchElement.h"
#import "BBValidatorAccept.h"
